# arenation_app

Es un proyecto pensando en las posibilidades de encontrar todos los escenarios deportivos en un solo lugar. Arenation te permitirá reservar, ver, comentar y calificar las diferentes arenas que allí podrás encontrar.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

Para ejecutar la aplicación debes selecionar un dispositivo donde ejecutar la app y ejecutar desde la consola de comandos.

Arenation cuenta con diferentes librerías por lo que es importante hacer:
 * flutter pub get
antes de comenzar la ejecución.

Esta versión de Arenation te permmite:
 * Registrarte: si no estás registrado puedes hacerlo directamente desde la app. Si tu correo está registrado la app te lo señalará.
 * Iniciar sesión: si estás registrado la aplicación te llevará al home o pantalla principal. Si no estás registrado un modal apareceré indicandolo.
 * Home: una vez iniciado sesión encontrarás un lista de arenas que puedes seleccionar para tu reserva (en esta versión no se ha aplicado la reserva).
 * Arena: puedes seleccionar del listado de arenas, la que llame más tu atención y ver los detalles que pueden llevarte a ser la mejor opción.
 * * Esta cuenta con un carrusel de imagenes al incio de la pantalla, el cual puedes ir deslizando para tener un mejor acercamiento con la arena.
 * * Una descripción detallada de la arena.
 * * Una sección de comentarios, que han dejado los usuarios quienes han tenido experiencia con la arena. Igual que las imagenes para observar los diferentes comentarios deberás deslizar.

Arenation tiene una API-BACK es propia de ARENATION:
Esta api está desplegada en la aplicación de heroku y está en NodeJs.
- [Heroku: Api back ARENATION](https://arenationfull.herokuapp.com/).

Por favor no hacer mal uso de la api, es una primera versión de lo que podría ser arenation.
