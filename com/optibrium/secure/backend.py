from com.optibrium.secure.message import Message
from redis import Redis
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

        if message.burn_after_reading:
            del self._messages[id]
        if message.expired:
            del self._messages[id]
            raise KeyError()

        return message


class RedisBackend:

    def __init__(self, redis_host):

        self._redis = Redis(host=redis_host)

    def save(self, message: Message):

        id = str(uuid.uuid4())
        self._redis.set(id, message.json)
        self._redis.expire(id, message.ttl)
        return {'id': str(id)}

    def get(self, id) -> Message:

        message = Message.from_json(self._redis.get(id))

        if message.burn_after_reading:
            self._redis.delete(id)

        return message
