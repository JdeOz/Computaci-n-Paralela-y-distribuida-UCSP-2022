# Test Cache
Curso de Computación Paralela y Distribuida UCSP 2022

Como podemos ver en la tabla, gracias al principio de localidad temporal, el caché carga la matriz fila por fila; esto hace que, por ejemplo, toda la fila de índice 0 esté junta en la primera línea del caché, la fila 1 en la línea 1 y así sucesivamente. Por lo tanto, al analizar los dos ejemplos podemos notar que:

- En el **primer caso** el bucle exterior recorre nuestra matriz fila por fila, y el interior recorre estas filas elemento por elemento; esto quiere decir que se recorre por completo cada fila correspondiente en orden antes de pasar a la siguiente fila lo que significa que solo se presentarían “cache miss” cada vez que se termine de revisar una o cuando la cantidad de datos sea tan grande como para entrar en el primer nivel del caché y tengan que ser almacenados en el siguiente nivel.

- En el **segundo caso** el bucle exterior recorre nuestra matriz columna por columna, y el interior recorre estas columnas elemento por elemento, esto generar muchos “cache miss” ya que las columnas no se guardan juntas en el caché así que cada vez que el bucle interior haga una iteración se generaría un “cache miss”.

Esto lo pudimos comprobar realizando este ejemplo en C++ con matrices de 1000x1000; al medir el tiempo que demora cada caso tuvimos como resultado que en promedio el primero es aproximadamente un **19%** más rápido que el segundo.

