from flask import Flask, render_template, request, session, redirect, url_for
from flask_mysqldb import MySQL
from werkzeug.security import generate_password_hash, check_password_hash
import MySQLdb.cursors
from openpyxl import Workbook
from flask import send_file
import io


# ======================================
# Crear aplicación Flask
# ======================================

app = Flask(__name__)

app.secret_key = "gustos_sabor_clave_segura"


# ======================================
# Configuración MySQL para bd local
# ======================================

#app.config["MYSQL_HOST"] = "localhost"
#app.config["MYSQL_USER"] = "root"
#app.config["MYSQL_PASSWORD"] = ""
#app.config["MYSQL_DB"] = "restaurante_gustos_sabor"

#mysql = MySQL(app)

# ======================================
# Configuración MySQL para bd en aivent
# ======================================
app.config['MYSQL_HOST'] = os.environ.get('MYSQL_HOST')
app.config['MYSQL_USER'] = os.environ.get('MYSQL_USER')
app.config['MYSQL_PASSWORD'] = os.environ.get('MYSQL_PASSWORD')
app.config['MYSQL_DB'] = os.environ.get('MYSQL_DB')
app.config['MYSQL_PORT'] = int(os.environ.get('MYSQL_PORT', 3306))
 
UPLOAD_FOLDER = os.path.join('static', 'videos')
app.config['UPLOAD_FOLDER'] = UPLOAD_FOLDER
 
mysql = MySQL(app)


# ======================================
# Página principal
# ======================================

@app.route("/")
def inicio():

    return render_template("index.html")



# ======================================
# Nosotros
# ======================================

@app.route("/nosotros")
def nosotros():

    return render_template("quienessomos.html")



# ======================================
# Misión y Visión
# ======================================

@app.route("/mision")
def mision():

    return render_template("misionyvision.html")



# ======================================
# Registro usuarios
# ======================================

@app.route("/registro", methods=["GET","POST"])
def registro():

    if request.method == "POST":

        nombre = request.form["nombre"]
        correo = request.form["correo"]
        telefono = request.form["telefono"]
        usuario = request.form["usuario"]
        password = request.form["password"]


        password_hash = generate_password_hash(password)


        cursor = mysql.connection.cursor()


        cursor.execute(
            """
            SELECT id_usuario 
            FROM gestion_usuarios
            WHERE nombre_usuario=%s
            """,
            (usuario,)
        )


        existe = cursor.fetchone()


        if existe:

            cursor.close()

            return """
            <script>
            alert("El usuario ya existe");
            window.location.href="/registro";
            </script>
            """



        cursor.execute(
            """
            INSERT INTO gestion_usuarios
            (
            nombre,
            correo,
            telefono,
            nombre_usuario,
            contrasena,
            rol
            )
            VALUES(%s,%s,%s,%s,%s,%s)
            """,
            (
            nombre,
            correo,
            telefono,
            usuario,
            password_hash,
            "Cliente"
            )
        )


        mysql.connection.commit()

        cursor.close()


        return """
        <script>
        alert("Usuario registrado correctamente");
        window.location.href="/login";
        </script>
        """


    return render_template("registrousuario.html")



# ======================================
# Login
# ======================================

@app.route("/login", methods=["GET","POST"])
def login():

    if request.method == "POST":


        usuario = request.form["usuario"]
        password = request.form["password"]


        cursor = mysql.connection.cursor()


        cursor.execute(
            """
            SELECT 
            id_usuario,
            nombre,
            contrasena
            FROM gestion_usuarios
            WHERE nombre_usuario=%s
            """,
            (usuario,)
        )


        usuario_db = cursor.fetchone()

        cursor.close()



        if usuario_db is None:

            return """
            <script>
            alert("Usuario no encontrado");
            window.location.href="/login";
            </script>
            """



        id_usuario = usuario_db[0]
        nombre = usuario_db[1]
        password_hash = usuario_db[2]



        if not check_password_hash(password_hash,password):

            return """
            <script>
            alert("Contraseña incorrecta");
            window.location.href="/login";
            </script>
            """



        session["id_usuario"] = id_usuario
        session["nombre"] = nombre



        return redirect(url_for("inicio_usuario"))



    return render_template("login.html")



# ======================================
# Inicio usuario
# ======================================

@app.route("/inicio_usuario")
def inicio_usuario():


    if "id_usuario" not in session:

        return redirect(url_for("login"))



    return render_template(
        "inicio_usuario.html",
        nombre=session["nombre"],
        id_usuario=session["id_usuario"]
    )



# ======================================
# Cerrar sesión
# ======================================

@app.route("/logout")
def logout():

    session.clear()

    return redirect(url_for("login"))




# ======================================
# Consultar usuarios
# ======================================

@app.route("/consultar_usuarios")
def consultar_usuarios():


    if "id_usuario" not in session:

        return redirect(url_for("login"))



    cursor = mysql.connection.cursor(
        MySQLdb.cursors.DictCursor
    )


    cursor.execute(
        """
        SELECT
        id_usuario,
        nombre,
        correo,
        telefono,
        nombre_usuario,
        rol
        FROM gestion_usuarios
        """
    )


    usuarios = cursor.fetchall()


    cursor.close()


    return render_template(
        "consultar_usuarios.html",
        usuarios=usuarios
    )



# ======================================
# Editar usuario
# ======================================

@app.route("/editar_usuario/<int:id>", methods=["GET","POST"])
def editar_usuario(id):


    if "id_usuario" not in session:

        return redirect(url_for("login"))



    cursor = mysql.connection.cursor(
        MySQLdb.cursors.DictCursor
    )



    if request.method == "POST":


        nombre = request.form["nombre"]
        correo = request.form["correo"]
        telefono = request.form["telefono"]
        nombre_usuario = request.form["nombre_usuario"]
        rol = request.form["rol"]



        cursor.execute(
            """
            UPDATE gestion_usuarios
            SET
            nombre=%s,
            correo=%s,
            telefono=%s,
            nombre_usuario=%s,
            rol=%s
            WHERE id_usuario=%s
            """,
            (
            nombre,
            correo,
            telefono,
            nombre_usuario,
            rol,
            id
            )
        )


        mysql.connection.commit()

        cursor.close()


        return redirect(
            url_for("consultar_usuarios")
        )



    cursor.execute(
        """
        SELECT *
        FROM gestion_usuarios
        WHERE id_usuario=%s
        """,
        (id,)
    )


    usuario = cursor.fetchone()


    cursor.close()



    return render_template(
        "editar_usuario.html",
        usuario=usuario
    )
# ======================================
# Módulo independiente eliminar usuarios
# ======================================

@app.route("/eliminar_usuarios")
def eliminar_usuarios():

    if "id_usuario" not in session:
        return redirect(url_for("login"))


    cursor = mysql.connection.cursor(
        MySQLdb.cursors.DictCursor
    )


    cursor.execute(
        """
        SELECT
        id_usuario,
        nombre,
        correo,
        telefono,
        nombre_usuario,
        rol
        FROM gestion_usuarios
        """
    )


    usuarios = cursor.fetchall()


    cursor.close()


    return render_template(
        "eliminar_usuarios.html",
        usuarios=usuarios
    )
# ======================================
# Eliminar usuario seleccionado
# ======================================

@app.route("/eliminar_usuario/<int:id>", methods=["POST"])
def eliminar_usuario(id):


    if "id_usuario" not in session:
        return redirect(url_for("login"))


    cursor = mysql.connection.cursor()


    cursor.execute(
        """
        DELETE FROM gestion_usuarios
        WHERE id_usuario=%s
        """,
        (id,)
    )


    mysql.connection.commit()


    cursor.close()


    return redirect(
        url_for("eliminar_usuarios")
    )


# ======================================
# Reporte de reservas
# ======================================

@app.route("/reporte")
def reporte():

    if "id_usuario" not in session:
        return redirect(url_for("login"))

    fecha = request.args.get("fecha")

    cursor = mysql.connection.cursor(
        MySQLdb.cursors.DictCursor
    )

    if fecha:

        cursor.execute("""
            SELECT
                r.id_reserva,
                u.id_usuario,
                u.nombre,
                u.correo,
                r.fecha_reserva,
                r.hora_reserva,
                r.cantidad_personas,
                r.estado,
                r.observaciones
            FROM reservas r
            INNER JOIN gestion_usuarios u
                ON r.id_usuario = u.id_usuario
            WHERE r.fecha_reserva = %s
            ORDER BY r.fecha_reserva DESC, r.hora_reserva DESC
        """, (fecha,))

    else:

        cursor.execute("""
            SELECT
                r.id_reserva,
                u.id_usuario,
                u.nombre,
                u.correo,
                r.fecha_reserva,
                r.hora_reserva,
                r.cantidad_personas,
                r.estado,
                r.observaciones
            FROM reservas r
            INNER JOIN gestion_usuarios u
                ON r.id_usuario = u.id_usuario
            ORDER BY r.fecha_reserva DESC, r.hora_reserva DESC
        """)

    reservas = cursor.fetchall()

    cursor.close()

    return render_template(
        "reporte.html",
        reservas=reservas,
        fecha=fecha
    )

# ======================================
# Exportar reporte a Excel
# ======================================

@app.route("/reporte_excel")
def reporte_excel():

    if "id_usuario" not in session:
        return redirect(url_for("login"))

    fecha = request.args.get("fecha")

    cursor = mysql.connection.cursor(
        MySQLdb.cursors.DictCursor
    )

    if fecha:

        cursor.execute("""
            SELECT
                r.id_reserva,
                u.id_usuario,
                u.nombre,
                u.correo,
                r.fecha_reserva,
                r.hora_reserva,
                r.cantidad_personas,
                r.estado,
                r.observaciones
            FROM reservas r
            INNER JOIN gestion_usuarios u
                ON r.id_usuario = u.id_usuario
            WHERE r.fecha_reserva = %s
            ORDER BY r.fecha_reserva DESC
        """, (fecha,))

    else:

        cursor.execute("""
            SELECT
                r.id_reserva,
                u.id_usuario,
                u.nombre,
                u.correo,
                r.fecha_reserva,
                r.hora_reserva,
                r.cantidad_personas,
                r.estado,
                r.observaciones
            FROM reservas r
            INNER JOIN gestion_usuarios u
                ON r.id_usuario = u.id_usuario
            ORDER BY r.fecha_reserva DESC
        """)

    datos = cursor.fetchall()

    cursor.close()

    libro = Workbook()
    hoja = libro.active
    hoja.title = "Reporte Reservas"

    hoja.append([
        "ID Reserva",
        "ID Usuario",
        "Nombre",
        "Correo",
        "Fecha Reserva",
        "Hora Reserva",
        "Cantidad Personas",
        "Estado",
        "Observaciones"
    ])

    for fila in datos:

        hoja.append([
            fila["id_reserva"],
            fila["id_usuario"],
            fila["nombre"],
            fila["correo"],
            fila["fecha_reserva"],
            fila["hora_reserva"],
            fila["cantidad_personas"],
            fila["estado"],
            fila["observaciones"]
        ])

    archivo = io.BytesIO()

    libro.save(archivo)
    archivo.seek(0)

    return send_file(
        archivo,
        download_name="reporte_reservas.xlsx",
        as_attachment=True
    )

# ======================================
# Ejecutar
# ======================================

if __name__=="__main__":

    app.run(debug=True)
