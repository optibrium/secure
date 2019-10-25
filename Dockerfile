FROM optibrium/wsgi AS server

RUN pip3 install -i https://pypi.infra.optibrium.com/simple secureclip

COPY app.wsgi /var/www/app.wsgi
