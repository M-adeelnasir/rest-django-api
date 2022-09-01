FROM python:3.9-alpine3.13

LABEL maintainer="adeelnasir"
ENV PYTHONUNBUFFERED=1

COPY ./requirements.txt ./tmp/requirements.txt

COPY ./app /app

WORKDIR /app

EXPOSE 8000

# 1-cmd:will create the virtual env. 2-cmd:used to upgrade the pip. 3-cmd:install all dependencies of project. 4-cmd:removes extras like tmp. 5-cmd: add user (optional)
RUN python3 -m venv /py && \
    /py/bin/pip install --upgrade pip && \
    /py/bin/pip install -r /tmp/requirements.txt && \
    rm -rf /tmp && \
    adduser \
        --disabled-password \
        --no-create-home \
        adeel-user

# add the path(like system variables in windows) so we can run any python cmd inside our virtual_env 
ENV PATH="py/bin:$PATH"          

USER adeel-user