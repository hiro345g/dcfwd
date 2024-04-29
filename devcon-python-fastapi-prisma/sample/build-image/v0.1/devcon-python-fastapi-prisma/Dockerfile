FROM python:3.10.14-bookworm

ENV PYTHONUNBUFFERED=1

# poetry
RUN curl -sSL https://install.python-poetry.org | python -

ENV PATH /root/.local/bin:$PATH

COPY app001 /workspace/app001

WORKDIR /workspace/app001
RUN /root/.local/bin/poetry config virtualenvs.in-project true
RUN if [ -f /workspace/app001/pyproject.toml ]; then /root/.local/bin/poetry install --no-root; fi

# uvicorn 起動
ENTRYPOINT ["/root/.local/bin/poetry", "run", "uvicorn", "api.main:app", "--host", "0.0.0.0", "--reload"]
