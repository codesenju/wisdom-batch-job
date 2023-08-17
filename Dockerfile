FROM python:3.11.2-bullseye
WORKDIR /app

RUN apt update && \
    apt install samba smbclient cifs-utils -y

COPY requirements.txt .
RUN pip install -r requirements.txt && \
    useradd -m python-user && \
    mkdir -p /log && \
    chown python-user:python-user /log -R && \
    chown python-user:python-user /app -R

COPY app.py .

USER python-user
EXPOSE 5000
ENTRYPOINT python app.py
# ENTRYPOINT  uwsgi --http 0.0.0.0:5000 --wsgi-file app.py --callable app
# CMD ["gunicorn", "--bind", "0.0.0.0:5000", "app:app"]