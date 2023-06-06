from .app import app, db
from .models import Task
from flask import jsonify, abort, request, make_response


@app.route('/todo/api/v1.0/tasks', methods=['GET'])
def get_tasks():
    tasks = Task.query.all()
    return jsonify({'tasks': [task.to_json() for task in tasks]})


@app.route('/todo/api/v1.0/tasks/<int:task_id>', methods=['GET'])
def get_task(task_id):
    task = Task.query.get_or_404(task_id)
    return jsonify(task.to_json())


@app.route('/todo/api/v1.0/tasks', methods=['POST'])
def create_task():
    if not request.json or not 'title' in request.json:
        abort(400)
    task = Task(title=request.json['title'],
                tags=request.json.get('tags', []),
                nbhours=request.json.get('nbhours', 0),
                difficulty=request.json.get('difficulty', 0),
                description=request.json.get('description', ''))
    db.session.add(task)
    db.session.commit()
    return jsonify(task.to_json()), 201


@app.route('/todo/api/v1.0/tasks/<int:task_id>', methods=['PUT'])
def update_task(task_id):
    task = Task.query.get_or_404(task_id)
    if not request.json:
        abort(400)
    task.title = request.json.get('title', task.title)
    task.tags = request.json.get('tags', task.tags)
    task.nbhours = request.json.get('nbhours', task.nbhours)
    task.difficulty = request.json.get('difficulty', task.difficulty)
    task.description = request.json.get('description', task.description)
    db.session.commit()
    return jsonify(task.to_json())


@app.route('/todo/api/v1.0/tasks/<int:task_id>', methods=['DELETE'])
def delete_task(task_id):
    task = Task.query.get_or_404(task_id)
    db.session.delete(task)
    db.session.commit()
    return jsonify({'result': True})
