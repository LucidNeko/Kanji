from .base import db

class Kanj(db.Model):
    entr = db.Column(db.Integer, nullable=False, primary_key=True)
    kanj = db.Column(db.SmallInteger, nullable=False, primary_key=True)
    txt = db.Column(db.UnicodeText(length=2048), nullable=False)

    __table_args__ = (
        db.UniqueConstraint('entr', 'txt', name='kanj_entr_txt_idx'),
    )

    def as_dict(self):
       return {c.name: getattr(self, c.name) for c in self.__table__.columns}
