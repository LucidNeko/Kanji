import flask
import json
from .. import model as m

class Kanji(flask.Flask):
    pass

app = Kanji(__name__)

app.config.update(
    SQLALCHEMY_DATABASE_URI='postgresql://jmdictdb:jmdictdb@db:5432/jmdict', #TODO: settings.py
    SQLALCHEMY_TRACK_MODIFICATIONS=False,
    SQLALCHEMY_ECHO=False,
    JSONIFY_PRETTYPRINT_REGULAR=False,
)

m.db.init_app(app)

api1 = flask.Blueprint('api1', __name__)

@api1.route('/kanj')
def kanj():
    entries = list(map(lambda x: x.as_dict(), m.Kanj.query.limit(5).all()))
    return json.dumps(entries)

app.register_blueprint(api1, url_prefix='/api/v1')
