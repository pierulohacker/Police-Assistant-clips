;;(batch* "D:\\UNIVERSITY\\anno 3\\I.C.S.E\\Lab\\progetto\\codice progetto.clp")
;;instruzione che permette di leggere il codice presente in un file .clp, diverso dal load, che carica solo i costrutti e non esegue tutti i comandi
;;////////////////////////////////////////////////////////////////////////
(load "D:\\UNIVERSITY\\anno 3\\I.C.S.E\\Lab\\progetto\\funzioni globali.clp")
(load "D:\\UNIVERSITY\\anno 3\\I.C.S.E\\Lab\\progetto\\prevenzione inquinamento.clp")
(load "D:\\UNIVERSITY\\anno 3\\I.C.S.E\\Lab\\progetto\\controllo scena.clp")
(load "D:\\UNIVERSITY\\anno 3\\I.C.S.E\\Lab\\progetto\\tracce.clp")
(load "D:\\UNIVERSITY\\anno 3\\I.C.S.E\\Lab\\progetto\\ricerca tracce.clp")
(defmodule MAIN 
(import funzioni-globali ?ALL) 
(import prevenzione-inquinamento ?ALL)
(import controllo-scena ?ALL)
(export ?ALL))


;(deffunction rimuovi-da-lista (?lista ?elemento)
	;(printout t "Rimozione di " ?elemento "da " ?lista)
	;(bind ?posizione (member$ ?elemento ?lista))
	;(delete$ ?lista ?posizione ?posizione)
	;(printout t "Rimozione effettuata"))
	
(defrule MAIN::stato-iniziale
	(not(indumenti $?))
	(not(finito ?))
	=>
	(printout t "Benvenuto operatore!" crlf)
	(load-facts "D:\\UNIVERSITY\\anno 3\\I.C.S.E\\Lab\\progetto\\fatti iniziali.clp")
	(focus prevenzione-inquinamento controllo-scena ricerca-tracce))





;(defrule tutto-in-sicurezza
	
