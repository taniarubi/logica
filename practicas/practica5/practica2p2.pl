/**
 * |1| Regla getnth. Recibe tres parámetros: E, N y L.
 * La regla se satisface si el elemento E está en el índice N de la lista L.
 *
 * Descripción.
 * (a) Si el elemento E se encuentra en la posición cero de la lista, la 
 * regla es cierta.
 * (b) Regla recursiva: El elemento E está en el índice N de la lista L si y 
 * sólo el elemento E se encuentra en algún índice de la cola de la lista L.
 * 
 * 
 * Ejemplos de entrada:
 * ?- getnth('o', 1, ['t','o','n','i','g','h','t']).
   true ;
   false.

 * ?- getnth(E, 3, ['t','o','n','i','g','h','t']).
   E = i ;
   false.

 * ?- getnth(5, 4, [4,2,0,5,1,1]).
   false.

 */
getnth(X, 0, [X|_]).
getnth(E, N, [_|XS]) :- N>0, M is N-1, getnth(E, M, XS).

/**
 * |2| Regla getIndex. Recibe tres parámetros: E, L y N.
 * La regla se satisface si el elemento E está en el índice N de la lista L.
 *
 * Descripción.
 * Es la misma idea que en la regla anterior --getnth--, sólo que cambiamos 
 * el órden de los parámetros. Por ende, utilizamos la regla getnth en 
 * nuestra regla getIndex, y como mencionamos, únicamente le acomodamos 
 * los parámetros a nuestra conveniencia.
 *
 * Ejemplos de entrada:
 * ?- getIndex('o', ['t','o','n','i','g','h','t'], 1).
   true ;
   false.

 * ?- getIndex(E, ['t','o','n','i','g','h','t'], 3).
   E = i ;
   false.

 * ?- getIndex(5, [4,2,0,5,1,1], 4).
   false.

 */
getIndex(E, L, N) :- getnth(E, N, L).

/**
 * |3| Regla num_ocurr. Recibe tres parámetros: E, L y R.
 * La regla se satisface si el elemento E ocurre R veces en la lista L.
 *
 * Descripción: 
 * Si la lista esta vacia, entonces se regresa un cero.
 * Si la cabeza de una lista es igual al elemtno, se incrementa el
 * contador por 1 en el recursion. En otro caso, solo se hace recursion
 * sin incrementar.
 * Ejemplos:
 * ?- num_ocurr(a,[a,b,a],R).
      R = 2.
 
 * ?- num_ocurr(A, [a,b,a], 2).
      A = a.
 */
num_ocurr(_,[],0).
num_ocurr(X,[X|XS],N) :- num_ocurr(X,XS,M), N is M + 1.
num_ocurr(X,[Y|XS],N) :- X \= Y, num_ocurr(X,XS,N).


/**
 * |4| Regla concatena. Recibe tres parámetros: L1, L2 y LF.
 * La regla se satisface si L1 se concatena con L2, obteniendo la lista LF.
 *
 * Descripción.
 * (a) Si L1 es la lista vacía, entonces la concatenación de L1 y L2 es L2.
 * (b) Regla recursiva: La concatenación de L1 y L2 es la lista LF, cuyo 
 * primer elemento es la cabeza de L1 y cuya cola es la concatenación de
 * la cola de L1 y L2.
 * 
 * Ejemplos de entrada:
 * ?- concatena([3,1,5], B, [3,1,5,1,2,1,7,1,9]).
   B = [1, 2, 1, 7, 1, 9].

 * ?- concatena([3,2,9], [4,0,6], LF).
   LF = [3, 2, 9, 4, 0, 6].

 * ?- concatena(['A','s','t','a'], ['r','o','t','h'], LF).
   LF = ['A', s, t, a, r, o, t, h].
 
 */
concatena([], L2, L2).
concatena([X|XS], L2, [X|YS]) :- concatena(XS, L2, YS).

/**
 * |5| Regla deleteL. Recibe tres parámetros: I, L y R.
 * La regla se satisface si el elemento de la I-ésima posición es eliminado de
 * la lista L. La lista resultante será guardada en la variable R.
 *
 * Descripcion.
 * (a) Si I es cero, siginifica que llegamos al elemento a eliminar en la lista L,
 * entonces solamente regresamos la lista, excluiendo la cabeza.
 * (b)Regla Recursiva: Recorimos la lista hasta que I es cero.
 * 
 * Ejemplos de entrada:
 * ?- deleteL(5, [a,b,c,d,e,f], R).
   R = [a,b,c,d,e] 

 * ?- deleteL(I, [a,b,c], [b,c]).
   I = 0.

 * ?- deleteL(2, R, [a,b,c,d,e]).
   R = [a,b,_,c,d,e].
 */
deleteL(0,[_|XS], XS).
deleteL(N,[X|XS], [X|YS]) :- N>0, M is N-1, deleteL(M,XS,YS).

/**
 * |6| Regla sumaLista. Recibe dos parámetros: L y R.
 * La regla se satisface si R contiene el resultado de sumar los elementos de 
 * la lista L.
 *
 * Descripción.
 * (a) Si la lista L es vacía, entonces la suma de sus elementos es cero.
 * (b) Regla recursiva: La suma de los elementos de la lista L es la suma de 
 * la cabeza de L más la cola de la lista L. 
 *
 * Ejemplos de entrada:
 * ?- sumaLista([3,1,5,1,2,1,7,1,9], R).
   R = 30.

 * ?- sumaLista([1,7,2,7], R).
   R = 17.

 * ?- sumaLista([0,-6,-1,0,-1,-9,-9,8], R).
   R = -18.

 */
sumaLista([], 0).
sumaLista([X|XS], R) :- sumaLista(XS, R1), R is X + R1.

/**
 * |7| Regla acumulador. Recibe dos parámetros: L y K.
 * La regla se satisface si K contiene el resultado de sumar los elementos
 * anteriores al i-ésimo índice.
 *
 * Descripcion: Si hacemos reversa sobre la lista, entonces podemos
 * usar el funcion auxiliar sum para ver que la suma de la lista
 * L1 es igual al cabeza de la lista reversa de L2.
 *
*/
acumulador(L,K) :- acumulador_aux(L,0,K).

/**
 * |8| Regla update. Recibe cuatro parámetros: N, E, XS y R.
 * La regla se satisface si actualiza el índíce N de la lista XS con el
 * elemento E. El resultado se guarda en la variable R.
 *
 * Descripción.
 * (a) Si el índice ingresado es cero, entonces R es la lista XS con una 
 * nueva cabeza, la cual es el elemento E.
 * (b) Regla recursiva: Actualiza el índice N de la lista XS con el elemento
 * E si y sólo si el índice N es válido dentro de la lista.
 *
 * Para mi YO del futuro: Originalmente teníamos a R como R, y devolvía sólo 
 * la lista ya actualizada pero a partir de donde estaba el índice 
 * del elemento cambiado. Es MUY necesario poner que R es de la forma 
 * [X|YS] y hacer recursión sobre su colita, ya que así nos garantiza que 
 * R devuelve toda la lista original con la actualización correspondiente,
 * y no sólo una parte de la lista.
 * 
 * Ejemplos de entrada:
 * ?- update(8, 'e', ['r','e','a','l'], R).
   false.

 * ?- update(1, i, [T,e,a,m,o], Io).
   Io = [T, i, a, m, o] ;
   false.

 * ?- update(3, a, [h,o,l,i], R).
   R = [h, o, l, a] ;
   false.

 */
update(_,_, [], []).
update(0, E, [_|XS], [E|XS]).
update(N, E, [X|XS], [X|YS]) :- N>0, M is N-1, update(M, E, XS, YS).

/**
 * |9| Regla subset. Recibe dos parámetros: L y K.
 * La regla se satisface si K es subconjunto de L.
 *
 * Descripción:
 * Si la segunda lista es vacia, entonces no hay elementos para compara
 * y por lo tanto es un subset.
 * 
 * En otro caso, buscamos si:
 * (a) La cabeza de las listas son diferentes, si son diferentes,
 *     solamente hacemos recursion con el resto de la lista del
 *     primero, y la lista con cabeza del segundo.
 * (b) Si son iguales, entonces simplemente hacemos recursion sobre
 *     el resto de la lista.
 * Ejemplos de entrada:
 * ?- subset([1,2,3,4,5,6,7,8,9], [2,4,6,8]).
   true.

 * ?- subset([1,2,3], [3,2,1]).
   no.

 * ?- subset([1,2,3],R).
   R = [];
   R = [1];
   R = [1,2];
   R = [1,2,3];
   R = [1,3];
   R = [2];
   R = [2,3];
   R = [3].
 */
subset([X|XS],[X|YS]) :- subset(XS,YS).
subset([_|XS],[Y|YS]) :- subset(XS,[Y|YS]).

/**
 * |10| Regla union. Recibe tres parámetros: A, B y C.
 * La regla se satisface si C es el resultado de unir A con B. En otras
 * palabras, se debe cumplir que C = A + B.
 *
 * Descripción:
 * Es la misma idea que en la regla --concatena--. Por ende, utilizamos 
 * ésta regla para nuestra implementación de union.
 * 
 * Ejemplos de entrada:
 * ?- union(['a','l','w'], ['a','y','s'], C).
   C = [a, l, w, a, y, s].

 * ?- union([5,5,6,7], [4,2,9,7,7], D).
   D = [5, 5, 6, 7, 4, 2, 9, 7, 7].

 * ?- union(A, [4,2,9,7,7], [5,4,2,9,7,7]).
   A = [5] ;
   false.

 */
union(A, B, C) :- concatena(A, B ,C).

/**
 * |11| Regla splitL. Recibe cuatro parámetros: L, N, L1 y L2.
 * La regla se satisface si la lista L fue dividida en dos listas (L1 y L2),
 * partiéndola en el índice N.
 *
 * Descripción:
 * En una manera similar a concatena, tendremos que si N es cero, llegamos al
 * punto donde se van a separar, entonces solo regresamos la cabeza de la lista
 * en L1 y el resto en L2.
 *
 * En otro caso, hacemos recursion pasando la cabeza de la lista a L1 hasta que
 * se llega a N = 0.
 * ésta regla para nuestra implementación de union.
 * 
 */

splitL([],_,[],[]).
splitL([X|XS],X,[X],XS).
splitL([Y|XS],X,[],[Y|XS]) :- X < Y.
splitL([Y|XS],X,[Y|LS],RS) :- X > Y, splitL(XS,X,LS,RS).

/*
 * |12| Regla drop. Recibe tres parámetros: N, L y R.
 * La regla se satisface si se cumple la propiedad de que se eliminó cada
 * N-ésimo elemento de la lista L. La lista resultante se guarda en la
 * variable R.
 *
 */
drop(N,L,R):- drop_aux(L,N,1,R).

/* Reglas auxiliares. */

/*
 * |1| Auxiliar drop. Recibe cuatro parámetros: L, N, M, R.
 * Ignora al elemento en la posición N para que ya no aparezca en la lista
 * resultante.
 *
 */
drop_aux([], _, _, []).
drop_aux([_|XS], N, N, R) :- drop_aux(XS, N, 1, R).
drop_aux([X|XS], N, M, [X|R]) :- M < N, M1 is M + 1, drop_aux(XS, N, M1, R).

/*
 * |2| Auxiliar acumulador. Recibe tres parámetros: L, N, M, R.
 * Acumula la suma de los elementos anteriores en la i-ésima posición.
 * 
 */
acumulador_aux([],_,[]).
acumulador_aux([X|XS],S,[Y|YS]) :- Y is X + S, acumulador_aux(XS,Y,YS).