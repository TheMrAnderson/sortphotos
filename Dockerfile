FROM python:3.13-alpine

RUN apk add --no-cache shadow bash cronie perl

RUN adduser -S -h /home/appuser -s /bin/bash appuser

WORKDIR /home/appuser

COPY ./requirements.txt requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

RUN chmod 0755 /home/appuser/src/sortphotos.sh

RUN touch /var/log/cron.log && chmod 666 /var/log/cron.log
RUN touch /tmp/crond.pid && chmod 666 /tmp/crond.pid

RUN mkdir -p /run && chmod 777 /run

RUN printf 'MAILTO=""\n* * * * * echo "cron test $(date)" >> /proc/1/fd/1 2>&1\n' | crontab -u appuser -
RUN printf 'MAILTO=""\n*/10 * * * * /home/appuser/src/sortphotos.sh /messyPhotos /cleanPhotos /home/appuser/src/ >> /proc/1/fd/1 2>&1\n' | crontab -u appuser -

VOLUME ["/messyPhotos"]
VOLUME ["/cleanPhotos"]

CMD ["/usr/sbin/crond", "-f"]