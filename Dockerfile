FROM optibrium/wsgi AS server
ARG PIP_EXTRA_INDEX_URL

RUN pip3 install -i $PIP_EXTRA_INDEX_URL secureclip

COPY app.py /var/www/app.wsgi
