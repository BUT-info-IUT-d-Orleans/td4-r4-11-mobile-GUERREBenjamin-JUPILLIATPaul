from .app import app,db

@app.cli.command()
def syncdb():
    '''
     Création de toutes les tables de la BD
     à partir des models.
    '''
    db.create_all()
