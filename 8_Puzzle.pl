left([A,0,C,D,E,F,G,H,I],[0,A,C,D,E,F,G,H,I]).
left([A,B,0,D,E,F,G,H,I],[A,0,B,D,E,F,G,H,I]).
left([A,B,C,D,0,F,G,H,I],[A,B,C,0,D,F,G,H,I]).
left([A,B,C,D,E,0,G,H,I],[A,B,C,D,0,E,G,H,I]).
left([A,B,C,D,E,F,G,0,I],[A,B,C,D,E,F,0,G,I]).
left([A,B,C,D,E,F,G,H,0],[A,B,C,D,E,F,G,0,H]).

rigth([0,B,C,D,E,F,G,H,I],[B,0,C,D,E,F,G,H,I]).
rigth([A,0,C,D,E,F,G,H,I],[A,C,0,D,E,F,G,H,I]).
rigth([A,B,C,0,E,F,G,H,I],[A,B,C,E,0,F,G,H,I]).
rigth([A,B,C,D,0,F,G,H,I],[A,B,C,D,F,0,G,H,I]).
rigth([A,B,C,D,E,F,0,H,I],[A,B,C,D,E,F,H,0,I]).
rigth([A,B,C,D,E,F,G,0,I],[A,B,C,D,E,F,G,I,0]).

up([A,B,C,0,E,F,G,H,I],[0,B,C,A,E,F,G,H,I]).
up([A,B,C,D,0,F,G,H,I],[A,0,C,D,B,F,G,H,I]).
up([A,B,C,D,E,0,G,H,I],[A,B,0,D,E,C,G,H,I]).
up([A,B,C,D,E,F,0,H,I],[A,B,C,0,E,F,D,H,I]).
up([A,B,C,D,E,F,G,0,I],[A,B,C,D,0,F,G,E,I]).
up([A,B,C,D,E,F,G,H,0],[A,B,C,D,E,0,G,H,F]).

down([0,B,C,D,E,F,G,H,I],[D,B,C,0,E,F,G,H,I]).
down([A,0,C,D,E,F,G,H,I],[A,E,C,D,0,F,G,H,I]).
down([A,B,0,D,E,F,G,H,I],[A,B,F,D,E,0,G,H,I]).
down([A,B,C,0,E,F,G,H,I],[A,B,C,G,E,F,0,H,I]).
down([A,B,C,D,0,F,G,H,I],[A,B,C,D,H,F,G,0,I]).
down([A,B,C,D,E,0,G,H,I],[A,B,C,D,E,I,G,H,0]).

mover(TableroIn,TableroOut):-left(TableroIn,TableroOut);
                             rigth(TableroIn,TableroOut);
                             up(TableroIn,TableroOut);
                             down(TableroIn,TableroOut).
%objetivo([3,6,0,2,5,8,1,4,7]).
%objetivo(1,4,0,2,5,8,3,6,7).
objetivo(0,8,7,6,5,4,3,2,1).
mismatch([A,B,C,D,E,F,G,H,I],Mis):-
    objetivo(A1,B1,C1,D1,E1,F1,G1,H1,I1),
    mismatchA(A,A1,MisA),
    mismatchB(B,B1,MisB),
    mismatchC(C,C1,MisC),
    mismatchD(D,D1,MisD),
    mismatchE(E,E1,MisE),
    mismatchF(F,F1,MisF),
    mismatchG(G,G1,MisG),
    mismatchH(H,H1,MisH),
    mismatchI(I,I1,MisI),
    Mis is MisA+MisB+MisC+MisD+MisE+MisF+MisG+MisH+MisI,!.

mismatchA(A,A1,MA):- A \= A1,MA is 1,!; MA is 0.
mismatchB(B,B1,MB):- B \= B1,MB is 1,!; MB is 0.
mismatchC(C,C1,MC):- C \= C1,MC is 1,!; MC is 0.
mismatchD(D,D1,MD):- D \= D1,MD is 1,!; MD is 0.
mismatchE(E,E1,ME):- E \= E1,ME is 1,!; ME is 0.
mismatchF(F,F1,MF):- F \= F1,MF is 1,!; MF is 0.
mismatchG(G,G1,MG):- G \= G1,MG is 1,!; MG is 0.
mismatchH(H,H1,MH):- H \= H1,MH is 1,!; MH is 0.
mismatchI(I,I1,MI):- I \= I1,MI is 1,!; MI is 0.

columna(Indice,Col):-Modulo is Indice mod 3,
                     Modulo =:= 0,
                     Col is 3,!;
                     Modulo is Indice mod 3,
                     Col is Modulo.

fila(Indice,Fil):-Indice > 0,
                  Resta is Indice - 3,
                  fila(Resta,Fil1), Fil is Fil1 + 1,!.
fila(_,0):-!.

%              Actual        , Objetivo
manhattan2([A,B,C,D,E,F,G,H,I],Actual,Objetivo,Man):-
    indiceEnTab(A,Actual,FilA,ColA),indiceEnTab(A,Objetivo,FilA1,ColA1),
    ManA is abs(FilA-FilA1) + abs(ColA-ColA1),
    indiceEnTab(B,Actual,FilB,ColB),indiceEnTab(B,Objetivo,FilB1,ColB1),
    ManB is abs(FilB-FilB1) + abs(ColB-ColB1),
    indiceEnTab(C,Actual,FilC,ColC),indiceEnTab(C,Objetivo,FilC1,ColC1),
    ManC is abs(FilC-FilC1) + abs(ColC-ColC1),
    indiceEnTab(D,Actual,FilD,ColD),indiceEnTab(D,Objetivo,FilD1,ColD1),
    ManD is abs(FilD-FilD1) + abs(ColD-ColD1),
    indiceEnTab(E,Actual,FilE,ColE),indiceEnTab(E,Objetivo,FilE1,ColE1),
    ManE is abs(FilE-FilE1) + abs(ColE-ColE1),
    indiceEnTab(F,Actual,FilF,ColF),indiceEnTab(F,Objetivo,FilF1,ColF1),
    ManF is abs(FilF-FilF1) + abs(ColF-ColF1),
    indiceEnTab(G,Actual,FilG,ColG),indiceEnTab(G,Objetivo,FilG1,ColG1),
    ManG is abs(FilG-FilG1) + abs(ColG-ColG1),
    indiceEnTab(H,Actual,FilH,ColH),indiceEnTab(H,Objetivo,FilH1,ColH1),
    ManH is abs(FilH-FilH1) + abs(ColH-ColH1),
    indiceEnTab(I,Actual,FilI,ColI),indiceEnTab(I,Objetivo,FilI1,ColI1),
    ManI is abs(FilI-FilI1) + abs(ColI-ColI1),
    Man is ManA + ManB + ManC + ManD + ManE + ManF + ManG + ManH + ManI,!.

indiceEnTab(Ficha,Tablero,Fil,Col):-
    nth1(Indice,Tablero,Ficha),fila(Indice,Fil),columna(Indice,Col).

manhattan(Tablero,Objetivo,Man):-manhattan2(Tablero,Tablero,Objetivo,Man).

heuristica(Tablero,Hue):-
    mismatch(Tablero,Mis),manhattan(Tablero,[0,8,7,6,5,4,3,2,1],Man),
    Hue is Man + 2 * Mis.
