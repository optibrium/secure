from com.optibrium.secure.message import Message
import uuid


class ObjectBackend:

    def __init__(self):

        self._messages = {}

    def save(self, message: Message):

        id = uuid.uuid4()
        self._messages[str(id)] = message
        return {'id': str(id)}

    def get(self, id) -> Message:

        message = self._messages[id]

        if message.burnable:
            del self._messages[id]
        if message.expired:
            del self._messages[id]
            raise KeyError()

        return message
