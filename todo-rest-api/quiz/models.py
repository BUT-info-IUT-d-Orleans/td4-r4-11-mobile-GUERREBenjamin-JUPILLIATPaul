from quiz.app import db


class Task(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    title = db.Column(db.String(100), nullable=False)
    tags = db.Column(db.String(100))
    nbhours = db.Column(db.Integer)
    difficulty = db.Column(db.Integer)
    description = db.Column(db.String(200))

    def to_dict(self):
        return {
            'id': self.id,
            'title': self.title,
            'tags': self.tags.split(',') if self.tags else [],
            'nbhours': self.nbhours,
            'difficulty': self.difficulty,
            'description': self.description
        }
