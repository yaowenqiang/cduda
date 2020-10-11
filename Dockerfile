# For more information, please refer to https://aka.ms/vscode-docker-python
FROM python:3.6-slim-buster

EXPOSE 8000

# Keeps Python from generating .pyc files in the container
ENV PYTHONDONTWRITEBYTECODE 1

# Turns off buffering for easier container logging
ENV PYTHONUNBUFFERED 1

# Install pip requirements
ADD requirements.txt .
RUN python -m pip install -i  https://pypi.doubanio.com/simple/  --trusted-host pypi.doubanio.com  -r requirements.txt
RUN python -m pip install -i  https://pypi.doubanio.com/simple/  --trusted-host pypi.doubanio.com  httpie

WORKDIR /app
ADD . /app

# Switching to a non-root user, please refer to https://aka.ms/vscode-docker-python-user-rights
RUN useradd appuser && chown -R appuser /app
USER appuser

# During debugging, this entry point will be overridden. For more information, please refer to https://aka.ms/vscode-docker-python-debug
# File wsgi.py was not found in subfolder: 'cduda'. Please enter the Python path to wsgi file.
# CMD ["gunicorn", "--bind", "0.0.0.0:8000", "pythonPath.to.wsgi"]
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
