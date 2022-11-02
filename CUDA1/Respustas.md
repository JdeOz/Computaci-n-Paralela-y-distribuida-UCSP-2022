
# Pregunta 3
Respuesta C.

Escogeria usar 512 threads por bloque ya que con 3 bloques llegamos exactamente al limite de threads que son 1536 estando dentro del límite de bloques. 


# Pregunta 4
Respuesta C.

Tendriamos que usar 4 bloques de 512 threads lo que daria un total de 2048 threads en el grid.


# Pregunta 5
Respuesta A.

1 warp no usaría los 32 threads ya que nuestro vector es de 2000 elementos y se asignan 2048.

# Pregunta 6
Si usamos bloques cuadrados con la cantidad máxima de subprocesos (1024) esto significa
que nuestras dimenciones serain de 32x32.
- Al dividir 400/32 nos resulta 12.5 osea 13.
- Al dividir 900/32 nos resulta 28.125 osea 29.
Esto nos resulta una cuadrícula de 13x29 lo que nos daria 416x928 threads.

# Pregunta 7
416x928 - 400x900 = 26048 threads inactivos.

# Pregunta 8
- Thread 1; ejecución = 2.0, espera = 1.0
- Thread 2; ejecución = 2.3, espera = 0.7
- Thread 3; ejecución = 3.0, espera = 0.0
- Thread 4; ejecución = 2.8, espera = 0.2
- Thread 5; ejecución = 2.4, espera = 0.6
- Thread 6; ejecución = 1.9, espera = 1.1
- Thread 7; ejecución = 2.6, espera = 0.4
- Thread 8; ejecución = 2.9, espera = 0.1
El tiempo total es 24, el tiempo total de ejecución es 19.9 y el tiempo total de
espera es 4.1, eso significa que 4.1 representa 17.08%.

# Pregunta 9


# Pregunta 10
Si podría ser factible esta afirmación puesto que al tener exactamente 32 threads
por bloque significa que cada bloque tendría solo un warp y sabemos que todas las
instrucciones en un warp se ejecutan al mismo tiempo asi que se podría pensar que
siempre irían sincronizadas.

# Pregunta 11
Si nos dice que su dispositivo permite hasta 512 threads por bloque entonces no es
posible usar bloques de 32x32 ya que expeden al límite.
