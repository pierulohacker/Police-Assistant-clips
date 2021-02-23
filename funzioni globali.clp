(defmodule funzioni-globali (export ?ALL))
;;funzione atta a forzare l'utente a digitare le risposte previste
(deffunction funzioni-globali::monitora-si-no (?risposta)
	(bind ?risposta (lowcase ?risposta))
	(while (and(neq ?risposta si)(neq ?risposta no)) do 
	(printout t "La risposta inserita non è valida, è possibile digitare 'si' o 'no': ")
	(bind ?risposta (read)))
	(return ?risposta))
	
;(deffunction suggerimenti