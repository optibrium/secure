from com.optibrium.secureclip.message import Message
from com.optibrium.secureclip.backend import ObjectBackend
from com.optibrium.secureclip.backend import RedisBackend
from flask import Flask, request, render_template
from flask_limiter import Limiter
from flask_limiter.errors import RateLimitExceeded
from flask_limiter.util import get_remote_address
import logging
from os import environ
import traceback

application = Flask(__name__)
limiter = Limiter(application, key_func=get_remote_address)

if 'DEBUG' not in environ:
    application.logger.disabled = True
    log = logging.getLogger('werkzeug')
    log.disabled = True

if 'REDIS' in environ:
    application.backend = RedisBackend(environ.get('REDIS'))
else:
    application.backend = ObjectBackend()


@application.route('/', methods=['GET'])
@limiter.limit('10/minute')
def index():
    if not len(list(request.args)):
        return render_template('index.tpl')
    else:
        message_id = list(request.args)[0]
        message = application.backend.get(message_id)
        return render_template('message.tpl', message=message)


@application.route('/', methods=['POST'])
@limiter.limit('10/minute')
def post():
    return application.backend.save(Message(request.json)), 201


@application.errorhandler(Exception)
def handle_error(error):

    if 'DEBUG' in environ:
        traceback.print_exc()

    if isinstance(error, RateLimitExceeded):
        return 'RATE LIMITED', 429

    return render_template('notfound.tpl'), 404
