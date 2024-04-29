FROM python:3.10.14-bookworm

ENV PYTHONUNBUFFERED=1

# poetry
RUN curl -sSL https://install.python-poetry.org | python -

# nodejs
RUN curl -fsSL https://deb.nodesource.com/setup_21.x | bash - && apt-get install -y nodejs

# starship
COPY install_starship.sh /workspace/install_starship.sh
RUN sh /workspace/install_starship.sh

ENV PATH /root/.local/bin:$PATH

# app001
COPY app001 /workspace/app001

WORKDIR /workspace/app001
RUN /root/.local/bin/poetry config virtualenvs.in-project true
RUN if [ -f /workspace/app001/pyproject.toml ]; then /root/.local/bin/poetry install --no-root; fi

# prisma
RUN if [ -f /workspace/app001/prisma/schema.prisma ]; then /root/.local/bin/poetry run prisma migrate dev; fi

# SQLite3
RUN apt-get update \
    && apt-get -y upgrade \
    && apt-get -y install --no-install-recommends \
        sqlite3 \
    && apt-get autoremove -y \
    && rm -rf /var/cache/apt /var/lib/apt/lists

# uvicorn 起動
ENTRYPOINT ["/root/.local/bin/poetry", "run", "uvicorn", "api.main:app", "--host", "0.0.0.0", "--reload"]
