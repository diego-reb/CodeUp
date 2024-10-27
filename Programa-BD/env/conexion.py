from flask import Flask, render_templates, request, jsonify
import datetime
from flask_sqlalchemy import SQLAlchemy
from flask_bcrypt import Bcrypt
from sqlalchemy import Enum


app = Flask (__name__)
app.config['SQLALCHEMY_DATABASE_URI'] = 'mysql://root:@localhost/CodeUp'
app.config['SQLALCHEMY_TRACK_MODIFICATIONS']=False
db= SQLAlchemy (app)
Bcrypt = Bcrypt (app)

class Usuarios(db.Model):
    id_usuario=db.Column(db.Integer, primary_key=True)
    nombre=db.Column(db.String(100), nullable=False)
    contraseña=db.Column(db.String(100), unique=True, nullable=False)
    tipo_usuario=db.Column(db.String(50), nullable=False)

class Cursos(db.Model):
    id_curso=db.Column(db.Integer, primary_key=True)
    nombre=db.Column(db.String(100), nullabel=False)
    descripcion=db.Column(db.String(100), nullable=False)
    nivel = db.Column(Enum('básico', 'intermedio', 'avanzado'), nullable=False) 
    precio = db.Column(db.Float, nullable=False)


@app.route("/Registro")
def Registro():
    return "¡Has llegado a otra vista!"

app = Flask (__name__)
@app.route("/")
def hola():
    return ""