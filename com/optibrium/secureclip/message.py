import json
import re
from flask import escape
from time import time


class Message:

    def __init__(self, content: dict):

        '''
        We assume that the frontend is going to supply a
        b64 armoured, ideally encrypted, string
        '''
        if re.search("[^0-9a-zA-Z-=+/]", content['text']):
            raise ValueError('Invalid text')
        else:
            self.text = str(escape(content['text']))

        if int(content['ttl']) < 1 or int(content['ttl']) > 604800:
            raise ValueError('invalid ttl')
        else:
            self.ttl = int(content['ttl'])
            self.expires = int(time()) + self.ttl

        self.burn_after_reading = bool(content['burn_after_reading'])
        self.double_encrypted = bool(content['double_encrypted'])

    @property
    def expired(self):
        return int(time()) > self.expires

    @property
    def json(self):
        return json.dumps(self.__dict__)

    @staticmethod
    def from_json(string):
        return Message(json.loads(string))
