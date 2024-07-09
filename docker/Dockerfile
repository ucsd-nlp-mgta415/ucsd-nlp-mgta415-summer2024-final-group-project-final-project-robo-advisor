FROM ubuntu:22.04
# Copy the dependency files
COPY pyproject.toml poetry.lock* /build/

#ADD requirements.txt /build/requirements.txt
WORKDIR /build/

RUN apt-get update && apt-get install -y build-essential pkg-config python3-dev curl

# Install Poetry
RUN curl -sSL https://install.python-poetry.org | python3 - --yes
ENV PATH="${PATH}:/root/.local/bin"

## Install dependencies
RUN poetry config virtualenvs.create false && poetry install --no-dev

# RUN pip install -r requirements.txt
WORKDIR /mnt/