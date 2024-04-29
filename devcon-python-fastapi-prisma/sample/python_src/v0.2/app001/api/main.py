import uuid
import uvicorn
from typing import List
from fastapi import FastAPI
from fastapi.responses import JSONResponse
from pydantic import BaseModel


class CreateTaskItem(BaseModel):
    """タスクアイテム新規作成用オブジェクトを表すクラス"""

    title: str
    description: str = None
    completed: bool = False


class TaskItem(BaseModel):
    """タスクアイテムを表すクラス"""

    id: str
    title: str
    description: str = None
    completed: bool = False


class TaskList:
    """タスクリストを管理するクラス"""

    def __init__(self):
        """コンストラクタ"""
        self.tasks = []

    def add_task(self, id, title, description, completed):
        """タスクを追加

        Args:
          id (str): タスクID
          title (str): タスクのタイトル
          description (str): タスクの説明
          completed (bool): タスク完了フラグ

        Returns:
          True: タスクを追加した場合
          False: タスクを追加しなかった場合
        """
        for task in self.tasks:
            if task.id == id:
                return False
        new_task = TaskItem(
            id=id, title=title, description=description, completed=completed
        )
        self.tasks.append(new_task)
        return True

    def get_all_tasks(self):
        """すべてのタスクを取得

        Returns:
          list[TaskItem]: タスクリスト
        """
        return self.tasks

    def get_task_by_id(self, id):
        """タスクID でタスクを取得

        Args:
          id (str): タスクID

        Returns:
          TaskItem: タスクアイテム
          taskNone: タスクが見つからない場合
        """
        for task in self.tasks:
            if task.id == id:
                return task
        return taskNone

    def update_task(self, id, title, description, completed):
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
        ret = False
        for task in self.tasks:
            if task.id == id:
                task.title = title
                task.description = description
                task.completed = completed
                ret = True
                break
        return ret

    def delete_task(self, id):
        """タスクを削除する

        Args:
          id (str): タスクID

        Returns:
          True: タスクが見つかって削除した場合
          False: タスクが見つからない場合
        """
        ret = False
        for task in self.tasks:
            if task.id == id:
                self.tasks.remove(task)
                ret = True
                break
        return ret


app = FastAPI()
taskNone = TaskItem(id="", title="", description="", completed=False)
task_list = TaskList()


@app.get("/")
async def api_root():
    return {"message": "OK"}


@app.post("/tasks/", response_model=TaskItem)
async def create_taskitem(task: CreateTaskItem):
    id = str(uuid.uuid4())
    values = task.model_dump()
    new_task = {"id": id, **values}
    ret = task_list.add_task(**new_task)
    if ret:
        return JSONResponse(content=new_task, status_code=201)
    else:
        return JSONResponse(content=taskNone, status_code=400)


@app.get("/tasks/", response_model=List[TaskItem])
async def read_task_list(skip: int = 0, limit: int = 100):
    # skip, limit については未対応
    return task_list.get_all_tasks()


@app.get("/tasks/{id}", response_model=TaskItem)
async def read_task(id: str):
    taskitem = task_list.get_task_by_id(id)
    content = taskitem.model_dump()
    if taskitem.id is not taskNone.id:
        return JSONResponse(content=content, status_code=200)
    else:
        return JSONResponse(content=content, status_code=404)


@app.put("/tasks/{id}", response_model=TaskItem)
async def update_task(id: str, task: TaskItem):
    values = task.model_dump()
    new_task = {**values}
    new_task["id"] = id
    ret = task_list.update_task(**new_task)
    if ret:
        return JSONResponse(content=new_task, status_code=200)
    else:
        return JSONResponse(content=taskNone.model_dump(), status_code=400)


@app.delete("/tasks/{id}")
async def delete_task(id: str):
    ret = task_list.delete_task(id)
    content = taskNone.model_dump()
    if ret:
        return JSONResponse(content=content, status_code=200)
    else:
        return JSONResponse(content=content, status_code=400)


if __name__ == "__main__":
    uvicorn.run(app, host="0.0.0.0", port=18000)
