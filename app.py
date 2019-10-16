from flask import Flask, request, render_template
from com.optibrium.secure.message import Message
from com.optibrium.secure.objectbackend import ObjectBackend
import traceback


server_address = 'http://localhost:8080'


application = Flask(__name__)
application.backend = ObjectBackend()


@application.route('/', methods=['GET'])
def index():
    if not len(list(request.args)):
        return render_template('index.tpl', server_address=server_address)
    else:
        message_id = list(request.args)[0]
        message = application.backend.get(message_id)
        return render_template('message.tpl', message=message)


@application.route('/', methods=['POST'])
def post():
    return application.backend.save(Message(request.json)), 201


@application.errorhandler(Exception)
def handle_error(error):

    traceback.print_exc()
    return render_template('notfound.tpl'), 404


if __name__ == '__main__':
    application.run(debug=True, port=8080)
