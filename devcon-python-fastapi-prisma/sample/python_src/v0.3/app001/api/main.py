import uuid
import uvicorn
from contextlib import asynccontextmanager
from typing import List
from fastapi import FastAPI
from fastapi.responses import JSONResponse
from prisma import Prisma
from pydantic import BaseModel

prisma = Prisma()


@asynccontextmanager
async def lifespan(app: FastAPI):
    await prisma.connect()
    yield
    await prisma.disconnect()


app = FastAPI(lifespan=lifespan)


class ApiTaskItemBase(BaseModel):
    """タスクアイテム新規作成用オブジェクトを表すクラス"""

    title: str
    description: str = ""
    completed: bool = False


class ApiTaskItem(ApiTaskItemBase):
    """タスクアイテムを表すクラス"""

    id: str


class TaskList:
    """タスクリストを管理するクラス"""

    def __init__(self):
        """コンストラクタ"""
        self.prisma = prisma

    async def add_task(self, taskitem: ApiTaskItem):
        """タスクを追加

        Args:
          taskitem (ApiTaskItem):

        Returns:
          True: タスクを追加した場合
          False: タスクを追加しなかった場合
        """
        task = await prisma.taskitem.create(data=taskitem)
        if task is not None:
            return True
        else:
            return False

    async def get_tasks(self, offset: int = 0, limit: int = 10):
        """タスクリストを取得

        Returns:
          List[TaskItem]: タスクリスト
        """
        tasks = await prisma.taskitem.find_many(
            take=limit, skip=offset, order={"createdAt": "desc"}
        )
        new_tasks = list(
            map(
                lambda task: ApiTaskItem(
                    id=task.id,
                    title=task.title,
                    description=task.description,
                    completed=task.completed,
                ),
                tasks,
            )
        )
        return new_tasks

    async def get_task_by_id(self, id: str):
        """タスクID でタスクを取得

        Args:
          id (str): タスクID

        Returns:
          TaskItem: タスクアイテム
          task_none: タスクが見つからない場合
        """
        task = await prisma.taskitem.find_unique(where={"id": id})
        if task is not None:
            new_task = ApiTaskItem(
                id=task.id,
                title=task.title,
                description=task.description,
                completed=task.completed,
            )
            return new_task
        else:
            return task_none

    async def update_task(self, id: str, title: str, description: str, completed: bool):
        """タスクを更新

        Args:
          id (str): タスクID
          title (str): タスクのタイトル
          description (str): タスクの説明
          completed (bool): タスク完了フラグ

        Returns:
          True: タスクが見つかって更新した場合
          False: タスクが見つからない場合
        """
        task = prisma.taskitem.update(
            where={
                "id": id,
            },
            data={"title": title, "description": description, "completed": completed},
        )
        if task is not None:
            return True
        else:
            return False

    async def delete_task(self, id: str):
        """タスクを削除する

        Args:
          id (str): タスクID

        Returns:
          True: タスクが見つかって削除した場合
          False: タスクが見つからない場合
        """
        task = await prisma.taskitem.delete(
            where={
                "id": id,
            }
        )
        if task is not None:
            return True
        else:
            return False


task_none = ApiTaskItem(id="", title="", description="", completed=False)
task_list = TaskList()


@app.get("/")
async def api_root():
    return {"message": "OK"}


@app.post("/tasks/", response_model=ApiTaskItem)
async def create_taskitem(task: ApiTaskItemBase):
    id = str(uuid.uuid4())
    values = task.model_dump()
    new_task = {"id": id, **values}
    ret = await task_list.add_task(new_task)
    if ret:
        return JSONResponse(content=new_task, status_code=201)
    else:
        return JSONResponse(content=task_none, status_code=400)


@app.get("/tasks/", response_model=List[ApiTaskItem])
async def read_task_list(offset: int = 0, limit: int = 10):
    tasks = await task_list.get_tasks(offset, limit)
    return tasks


@app.get("/tasks/{id}", response_model=ApiTaskItem)
async def read_task(id: str):
    task = await task_list.get_task_by_id(id)
    if task.id is not task_none.id:
        content = ApiTaskItem(
            id=task.id,
            title=task.title,
            description=task.description,
            completed=task.completed,
        ).model_dump()
        return JSONResponse(content=content, status_code=200)
    else:
        return JSONResponse(content=task_none.model_dump(), status_code=404)


@app.put("/tasks/{id}", response_model=ApiTaskItem)
async def update_task(id: str, task: ApiTaskItemBase):
    values = task.model_dump()
    new_task = {"id": id, **values}
    ret = await task_list.update_task(**new_task)
    if ret:
        return JSONResponse(content=new_task, status_code=200)
    else:
        return JSONResponse(content=task_none.model_dump(), status_code=400)


@app.delete("/tasks/{id}")
async def delete_task(id: str):
    ret = await task_list.delete_task(id)
    content = task_none.model_dump()
    if ret:
        return JSONResponse(content=content, status_code=200)
    else:
        return JSONResponse(content=content, status_code=400)


if __name__ == "__main__":
    uvicorn.run(app, host="0.0.0.0", port=18000)
