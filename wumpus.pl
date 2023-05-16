celda(0,0).
celda(0,1).
celda(0,2).
celda(0,3).
celda(0,4).

celda(1,0).
celda(1,1).
celda(1,2).
celda(1,3).
celda(1,4).

celda(2,0).
celda(2,1).
celda(2,2).
celda(2,3).
celda(2,4).

celda(3,0).
celda(3,1).
celda(3,2).
celda(3,3).
celda(3,4).

:- dynamic persona/2.
persona(3,0).

oro(1,4).

wumpus(1,2).

peste(0,2).
peste(2,2).
peste(1,1).
peste(1,3).

hoyo(3,2).
hoyo(3,4).
hoyo(2,0).
hoyo(1,3).
hoyo(0,1).

brisa(3,1).
brisa(2,2).
brisa(3,3).

brisa(2,4).
brisa(3,3).

brisa(1,0).
brisa(2,1).
brisa(3,0).

brisa(0,3).
brisa(2,3).
brisa(1,2).
brisa(1,4).

brisa(0,0).
brisa(1,1).
brisa(0,2).



imprimir_posicion(X,Y) :-
write(' posicion actual: '),write(X),write('-'),write(Y).

imprimir_mensaje_posicion(Mensaje,X,Y) :- 
write(Mensaje), imprimir_posicion(X,Y).

hay_oro(X,Y) :-
oro(X,Y),imprimir_mensaje_posicion(' hay oro en ',X,Y).

hay_hoyo(X,Y) :-
hoyo(X,Y),imprimir_mensaje_posicion(' hay hoyo en ',X,Y).

hay_wumpus(X,Y) :-
wumpus(X,Y),imprimir_mensaje_posicion(' hay wumpus en ',X,Y).

hay_peste(X,Y) :-
peste(X,Y),imprimir_mensaje_posicion(' hay peste en ',X,Y).

hay_brisa(X,Y) :-
brisa(X,Y),imprimir_mensaje_posicion(' hay brisa en ',X,Y).



verificar_brisa_peste(X,Y) :-
hay_brisa(X,Y),hay_peste(X,Y).

actualizar_persona(AnteriorX, AnteriorY, NuevoX, NuevoY) :-
retract(persona(AnteriorX,AnteriorY)), assert(persona(NuevoX,NuevoY)).

reestablecer_persona :-
persona(X,Y),
actualizar_persona(X,Y,3,0).

comprobar_estado(X,Y) :-
(hay_wumpus(X,Y);hay_hoyo(X,Y))
-> (write(' gameover :( '), reestablecer_persona)
; (hay_oro(X,Y) 
    -> (write(' enhorabuena! encontraste el lingote de oro. Que vas a hacer con tu parte patricio?'), reestablecer_persona)
    ; verificar_brisa_peste(X,Y)).

comprobar_estado_persona :-
persona(X,Y), comprobar_estado(X,Y).

actual :- 
persona(X,Y),
(hay_brisa(X,Y),
hay_peste(X,Y));
imprimir_posicion(X,Y).

es_tablero(X,Y) :-
celda(X,Y).


der :- 
persona(X,Y),
SiguienteY is Y+1,
es_tablero(X,SiguienteY)
-> (actualizar_persona(X,Y,X,SiguienteY), comprobar_estado_persona)
; imprimir_mensaje_posicion('no es tablero ',X,Y).

izq :- 
persona(X,Y),
SiguienteY is Y-1,
es_tablero(X,SiguienteY)
-> (actualizar_persona(X,Y,X,SiguienteY), comprobar_estado_persona)
; imprimir_mensaje_posicion('no es tablero ',X,SiguienteY).


arr :- 
persona(X,Y),
SiguienteX is X-1,
es_tablero(SiguienteX,Y)
-> (actualizar_persona(X,Y,SiguienteX,Y), comprobar_estado_persona)
; imprimir_mensaje_posicion('no es tablero ',SiguienteX,Y).

aba :- 
persona(X,Y),
SiguienteX is X+1,
es_tablero(SiguienteX,Y)
-> (actualizar_persona(X,Y,SiguienteX,Y), comprobar_estado_persona)
; imprimir_mensaje_posicion('no es tablero ',SiguienteX,Y).