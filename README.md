# Guía de usuario
Para utilizar este proyecto hay que seguir los siguientes pasos:

1. Comenzamos por conectarnos a Remix IDE, donde deberemos añadir los archivos que se adjuntan
a esta memoria. Habrá que meter el archivo “Rental.sol” en la carpeta contracts y el archivo
“main.zok” en la raı́z del proyecto.
2. Una vez hecho esto, entraremos en la sección plugin manager de Remix, y descargaremos el
plugin Zokrates.
3. Tras esto, entraremos en el plugin que se añadirá en la barra izquierda y seguimos los pasos que
se muestran. Comenzamos compilando el archivo “main.zok”, tras lo que añadimos un ejemplo
de valores, donde age es la edad del usuario (el valor privado) y legal age la edad a la que se
permite alquilar el coche (en nuestro caso debe ser 18). Después generamos el setup, la prueba,
y exportamos el verifier. Cabe recalcar, que las siguientes veces que queramos generar pruebas,
solo habrá que cambiar los valores en la sección Compute y darle a la opción Generate proof ; los
pasos de generar el setup y exportar el verificador solo se realizarán la primera vez.
14. Con esto hemos terminado con el plugin Zokrates (a no ser que queramos generar pruebas para
otros usuarios). Ahora moveremos el archivo “verifier.sol” generado por el plugin a la carpeta
contracts. A continuación compilamos tanto ese archivo como el “Rental.sol”.
5. Por último desplegamos los contratos. Primero debemos desplegar el contrato del verificador, ya
que para el otro necesitamos pasarle la dirección por el constructor.


Una vez realizados todos estos pasos, podremos usar el contrato Rental, que nos permitirá realizar
cuatro funciones.


* BicycleRent. Podremos alquilar una bicicleta a cambio de cierta cantidad gwei, en concreto
6000. Esta función tiene como únicos requisitos que hayas enviado al menos el ether correspon-
diente y que queden bicicletas en la tienda.

* CarRent. Esta función es muy similar a la de alquiler de bicicletas, con la diferencia de que se
necesita la mayorı́a de edad para poder hacer uso de esta función. Para esto se usan pruebas de
conocimiento cero, ya que la tienda no necesita conocer tu edad concreta, simplemente si tienes
más de 18 años. Para ello hay que pasarle por parámetro los datos de la prueba generada con
el plugin de Zokrates, al realizar la función de la sección Generate proof (bastará con copiar
la prueba que se genera debajo del botón generate y pegarla en la entrada). Es importante no
generar otro setup, ya que en caso de hacerlo, la prueba generado no sirve con el verificador
desplegado. En este caso, el alquiler de un coche vale 60 000 gwei.

* ReturnBicycle. Simplemente devuelve la bicicleta, en el caso de que el usuario que utiliza la
función tenga al menos una alquilada.

* ReturnCar. Igual que en el caso anterior. En este caso no comprobamos la mayorı́a de edad
debido a que para utilizar esta función la dirección debe haber realizado el alquiler del coche,
donde ya se comprueba.
