FROM python:3.6-jessie
ENV PYTHONUNBUFFERED 1
ENV APP_DIR=/app/
RUN mkdir -p $APP_DIR &&\
	pip install -U pip &&\
	pip install pipenv &&\
	groupadd -r django_user &&\
	useradd -r -g django_user -d $APP_DIR -s /sbin/nologin -c "Docker image user" django_user
WORKDIR $APP_DIR
ADD Pipfile $APP_DIR
ADD Pipfile.lock $APP_DIR
RUN pipenv install --system --verbose
COPY . $APP_DIR
RUN chown -R django_user:django_user $APP_DIR
USER django_user
VOLUME $APP_DIR