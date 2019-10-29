FROM optibrium/wsgi AS server

RUN pip3 install -i https://pypi.infra.optibrium.com/simple secureclip

COPY app.py /var/www/app.wsgi
