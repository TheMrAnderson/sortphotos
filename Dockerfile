FROM python:3.13-alpine

RUN apk add --no-cache shadow bash cronie

RUN adduser -S -h /home/appuser -s /bin/bash appuser

WORKDIR /home/appuser

COPY ./requirements.txt requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

RUN chmod 0755 /home/appuser/src/sortphotos.sh

RUN touch /var/log/cron.log && chmod 666 /var/log/cron.log
RUN touch /tmp/crond.pid && chmod 666 /tmp/crond.pid

RUN mkdir -p /run && chmod 777 /run

RUN echo "*/10 * * * * /home/appuser/src/sortphotos.sh /messyPhotos /cleanPhotos /home/appuser/src/ >> /var/log/cron.log 2>&1" | crontab -u appuser -

USER appuser

VOLUME ["/messyPhotos"]
VOLUME ["/cleanPhotos"]

CMD ["/usr/sbin/crond", "-f", "-p", "/tmp/crond.pid"]