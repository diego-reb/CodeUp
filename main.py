from flask import Flask, render_template, request, redirect, url_for
from Registro import Registro
app = Flask(__name__)
app.secret_key = 'tu_clave_es_tuya'


@app.route("/")
def inicio():
    return "¡Regístrate!"

@app.route("/Registro/", methods=["GET", "POST"])   
def registro_form():
    form = Registro()
    if form.validate_on_submit():
        name = form.name.data
        email = form.email.data
        password = form.password.data
        next_page = request.args.get('next', None)
        
        print(email)
        print(name)
        print(password)

        if next_page:
            return redirect(next_page)
        return redirect(url_for('inicio'))                     
    
    return render_template("Registro.html", form=form)
