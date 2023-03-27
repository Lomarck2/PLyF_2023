from swiplserver import PrologMQI, PrologThread

#TableroIni = "[1,2,3,4,5,6,7,8,0]"
#TableroObj = "[1,4,0,2,5,8,3,6,7]"
TableroIni = "[6,5,8,3,0,7,2,1,4]"
TableroObj = "[0,8,7,6,5,4,3,2,1]"

Actual = TableroIni
ListaVisitados = []
continuar = True
with PrologMQI() as mqi:
    with mqi.create_thread() as prolog_thread:        
        #Se abre el buffer prolog, para usarse en python
        buffer=prolog_thread.query("consult(\"8Puzzle.pl\").")
        #se define la consulta de heristica al buffer
        query="heuristica("+TableroIni+",H)."
        #Se ejecuta la consulta en prolog
        hue = prolog_thread.query(query)
        #Se crea el elemento combinado para la lista de vecinos
        elemento = [ TableroIni , hue[0]["H"] ]
        #se agrega el elemento a la lista
        ListaVisitados.append(elemento)
        ListaVecinos = []
        while(continuar):
            print(Actual)
            #Se define la consulta a prolog para obtener los vencinos
            query="mover("+Actual+",Tabs)."
            ListaVecs=prolog_thread.query(query)
            
            #Se calculan las heurísticas de cada vecino
            for indice in range(len(ListaVecs)):
                tab = str(ListaVecs[indice]['Tabs'])
                query="heuristica("+ tab +",H)."
                hue = prolog_thread.query(query)
                elemento = [ tab , hue[0]["H"] ]
                ListaVecinos.append(elemento)
            
            #Se ordena la lista de vecinos con respecto a la heurística
            ListaVecinos = sorted(ListaVecinos,key=lambda x: x[1])
            continuar2 = True
            while(continuar2):
                vec = ListaVecinos.pop(0)
                #Si no hya un vecino disponible no hay forma de continuar
                if vec[0] == "[]":
                    continuar = False
                    errorMSG = "Sin vecinos disponibles"
                try:
                    #Se busca el vecino en Visitados
                    #Si esta, entonces se debe sacar otro.
                    indiceVec=ListaVisitados.index(vec)
                    continuar2 = True                    
                except ValueError:
                    #El vecino no esta en visitados y se debe convetir en actual
                    continuar2 = False
                    Actual = vec[0]
            #Si Actual es igual a Objetivo, entonces se detiene las iteraciones
            if(Actual == TableroObj):
                continuar = False
                errorMSG = "Fin con exito"
            else:
                continuar = True
                ListaVisitados.append(vec)
                ListaVecinos.clear()
