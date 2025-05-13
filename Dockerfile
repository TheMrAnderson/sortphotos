FROM python:3.13-alpine

RUN useradd --system --group --home /bin/bash appuser

WORKDIR /home/appuser

COPY ./requirements.txt requirements.txt
RUN pip install --no-cache-dir -r requirements.txt
USER appuser
COPY . .

# Give execution rights on the cron script
RUN chmod 0644 /home/appuser/src/sortphotos.sh

# Intall cron
RUN apt-get update && apt-get install -y cron

VOLUME ["/messyPhotos"]
VOLUME ["/cleanPhotos"]

# Add the cron job
RUN crontab -l | { cat; echo "1/10 * * * * /home/appuser/src/sortphotos.sh /messyPhotos /cleanPhotos /home/appuser/src/ >> /var/log/cron.log 2>&1"; } | crontab -

CMD ["cron", "-f"]