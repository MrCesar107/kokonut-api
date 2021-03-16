# Kokonut API rest
## Prueba técnica para la empresa Kokonut Games

Para esta prueba, se crea un API rest que permite registrar usuarios, gestionar sus sesiones, y también que puedan subir distintas fotografías con su respectiva geolocalización.

### Tecnologías utilizadas
A continuación se mencionan las distintas tecnologías y herramientas que se utilizaron para el desarrollo de esta prueba.

- **Ruby 2.7.1**
- **Ruby on Rails 6.1.3**
- **PostgreSQL 12 (también se puede utilizar MySQL, aunque se deben cambiar algunas coas del código)**
- **OAuth 2.0**
- **JWT**
- **RSpec**
- **Postman**
- **Heroku**
- **Cloudinary**

### Correr este API en tu máquina local
Para poder utilizar este proyecto en tu computadora, primero debes asegurarte de tener instalados **Ruby** y **Ruby on Rails** respectivamente.

***En este enlace se encuentra una guía muy sencilla (en inglés) de como instalar Ruby on Rails en tu computadora***

[Guía para instalar Ruby on Rails en Linux](https://www.digitalocean.com/community/tutorials/how-to-install-ruby-on-rails-with-rvm-on-ubuntu-18-04)
[Guía para instalar Ruby on Rails en macOS](https://gorails.com/setup/osx/11.0-big-sur)
****
**NOTA: En el caso de Windows, puedes utilizar [Linux Subsystem for Windows](https://docs.microsoft.com/en-us/windows/wsl/install-win10) y seguir la guía para Linux sin ningún problema.**
****
Una vez instalado Ruby on Rails, debes clonar este respositorio en tu computadora. Depués ubícate en la carpeta donde se descargó este proyecto y escribe el siguiente comando

``$ bundle install``

Este comando instalará todas las dependencias que este proyecto necesita para poder funcionar correctamente. Una vez terminada la instalación de las dependencias, de nuevo escribimos el siguiente comando en nuestra terminal.

``$ rails db:create && rails db:migrate``

Estos dos comandos le dicen a Rails que inicialize nuestra base de datos y también que corra todas las migraciones que tiene el proyecto.
****
**NOTA IMPORTANTE: Para realizar este último paso, es indispensable tener instalado el gestor de base de datos PostgreSQL para poder crear y usar las bases de datos. En las guías de instalación de Rail, se incluye un apartado para poder instalar el gestor de base de datos deseado y como configurar Rails para que utilize ese mismo gestor.**
****
Una vez creada nuestras bases de datos, ya podemos iniciar nuestro proyecto usando el siguiente comando

`` $ rails s``

Este comando inicializa nuestro servidor y que esté listo para escuchar peticiones provenientes de varios clientes (para este caso, utilizaremos **Postman** o algun software similar para realizar las peticiones).

### Usar esta API en producción
Si no desea probar este proyecto en su computadora, puede hacerlo utilizando
la siguiente URL en lugar de ``localhost:3000``

**URL de producción:** ``https://kokonut-api.herokuapp.com/``

### Lista de endpoints
Para poder usar nuestros endpoints, debemos usar el siguiente dominio
**localhost:3000**
*******
**NOTA IMPORTANTE: TODOS LOS ENDPOINTS A EXCEPCIÓN de los marcados con (~) necesitan del siguiente Authorization header (Token=AUTH_TOKEN). AUTH_TOKEN se encuentra siempre en el atributo ``auth_token`` del usuario o moderador logueado cuando es registrado o inicia sesión**
****
- **(~)** **POST** /v1/users (Registro de usuarios. **Necesita un JSON body con los siguientes parámetros {user: {name, nickname, email, password, password_confirmation}}**)
- **(~)** **POST** /v1/authentications/ (Login de usuarios y moderadores. **Necesita un JSON body con los siguientes parámetros [email, password]**)
- **GET** /v1/users/:id/ (Muestra los datos del usuario logueado. **El atributo :id es necesario**)
- **PUT** /v1/users/:id (Actualiza la información de un usuario. **Necesita un JSON body con los siguientes atributos {user: {name, nickname}}**. Estos atributos pueden ir juntos o separados)
- **PUT** /v1/password (Actualiza la contraseña del usuario logueado. **Necesita un JSON body con los siguientes atributos {user: {password, new_password}}**)
- **(~)** **POST** /v1/sessions/facebook/ (Inicia sesión o registra a un usuario usando una cuenta de Facebook. **Necesita un JSON body con los siguientes parámetros {user: {facebook_auth_token}}**)
- **(~)** **POST** /v1/moderators/ (Registra un nuevo moderador. **Necesita un JSON body con los siguientes attributos {moderator: {name, enamil, password, password_confirmation}}**)
- **POST** /v1/users/:user_id/photos/ (Sube una nueva foto relacionada con un usuario. **Nesecita un MULTI-PART body con los siguientes atributos [name, latitude, longitude, description, image (la imagen a subir)]**)
- **DELETE /v1/users/:user_id/photos/:id** (Hace un soft delete de una foto de un usuario)

