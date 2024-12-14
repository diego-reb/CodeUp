from flask import Flask, render_template, request, jsonify
import datetime
from flask_sqlalchemy import SQLAlchemy
from flask_bcrypt import Bcrypt
from sqlalchemy import Enum
import psycopg2

app = Flask(__name__)

conn = psycopg2.connect(
    dbname="CodeUp",
    user="postgres",
    password="postgresql",
    host="localhost",
    port="5432"
)

db = SQLAlchemy(app)
bcrypt = Bcrypt(app)

class Usuario(db.Model):
    id_usuario = db.Column(db.Integer, primary_key=True)
    nombre_usuario = db.Column(db.String(100), nullable=False)
    contraseña_usuario = db.Column(db.String(100), unique=True, nullable=False)
    id_tipo_de_usuario = db.Column(db.String(50), nullable=False)

class Cursos(db.Model):
    id_curso = db.Column(db.Integer, primary_key=True)
    nombre = db.Column(db.String(100), nullable=False)  
    descripcion = db.Column(db.String(100), nullable=False)
    nivel = db.Column(Enum('básico', 'intermedio', 'avanzado'), nullable=False)
    precio = db.Column(db.Float, nullable=False)


@app.route("/Registro")
def Registro1():
    return render_template('Registro.html') 

@app.route("/")
def hola():
    return "¡Bienvenido a la aplicación!"

if __name__ == '__main__':
    app.run(debug=True)
