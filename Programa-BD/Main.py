from flask import Flask
from flask import render_template, request, redirect, url_for
import psycopg2
from Registro import Registro
from Registro import login


app = Flask(__name__)



@app.route('/submit', methods=['POST'])
def submit_data():
   nombre_usuario = request.form.get('nombre_usuario')
   contraseña_usuario=request.form.get('contraseña_usuario')
   correo_usuario=request.form.get('correo_usuario')
   print(nombre_usuario, contraseña_usuario, correo_usuario, )  
   cur = conn.cursor()
   cur.execute(
    "INSERT INTO Usuario (nombre_usuario, contraseña_usuario, correo_usuario) VALUES (%s, %s, %s)",
    (nombre_usuario, contraseña_usuario, correo_usuario)
)
   conn.commit()
   cur.close()
   return "Datos guardados exitosamente."

app.secret_key = 'tu_clave_es_tuya'
@app.route("/")
def hello():
    return "Hello, World!"


@app.route("/Registro/", methods=["GET", "POST"])   
def Registro1():
    form = Registro()
    if form.validate_on_submit():
        name = form.name.data
        email = form.email.data
        password = form.password.data
        next = request.args.get('next', None)
        print(email)
        print(name)
        print(password)
        if next:
         return redirect(next)
        return redirect (url_for('Registro'))                     
    return render_template("Registro.html",form=form)


@app.route("/login/", methods=["GET", "POST"])
def login1():
   form = login()
   if form.validate_on_submit():
      name = form.name.data
      email = form.name.data
      password = form.password.data
      next= request.args.get('next', None)
      print(email)
      print(name)
      print(password)
      if next:
         return redirect(next)
      return redirect (url_for('hello'))
   return render_template("login.html", form=form)

if __name__ == '__main__':
    app.run(debug=True)
