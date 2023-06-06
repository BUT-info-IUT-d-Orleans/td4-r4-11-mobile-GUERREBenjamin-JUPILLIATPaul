from flask import Flask
from flask_cors import CORS
app = Flask(__name__)
cors = CORS(app)

import os

def mkpath(p):
    """
    renvoie repertoire courant
    """
    return os.path.normpath(
            os.path.join(
                os.path.dirname(__file__),p)
            )

from flask_sqlalchemy import SQLAlchemy
app.config['SQLALCHEMY_DATABASE_URI'] = ('sqlite:///'
+mkpath('../quiz.db'))

app.config["SQLALCHEMY_ECHO"] = True
db = SQLAlchemy(app)
