'''
material 
    https://flask-session.readthedocs.io/en/latest/
    https://www.codestudyblog.com/cnb11/1123235958.html
'''

from app import app 

import os
import pymongo
from flask_session import Session
from flask import session
from datetime import timedelta



# TODO: mogodb not connecting
# https://www.mongodb.com/compatibility/docker
mdb = os.environ.get('MONGODB_CONNSTRING')

print(mdb)


try:
    mongoconnect = pymongo.MongoClient(
        mdb
        )
    mongoconnect.server_info()
    client = mongoconnect
    db = client['db']
    fd_db = db["fd_db"]
    # app.debug = True

    app.secret_key = "userid" + ':' + "pwd"
    SESSION_TYPE = 'mongodb'

    SESSION_MONGODB = mongoconnect
    # cluster
    SESSION_MONGODB_DB = "db"
    SESSION_MONGODB_COLLECT = 'session'
    # If it is set to True, the browser session will be invalid if it is closed.
    SESSION_PERMANENT = True
    # Whether to encrypt the cookie value sent to the session on the browser
    SESSION_USE_SIGNER = False
    # SESSION_KEY_PREFIX ='session:' # Prefix of the value saved in the session

    app.config.from_object(__name__)

    Session(app)

    print(f'app {app}')
except pymongo.errors.ServerSelectionTimeoutError as e:
    print(e)



# every session will be deleted after 24 hours of its creation
@app.before_request
def make_session_permanent():
    session.permanent = True
    app.permanent_session_lifetime = timedelta(hours=24)

