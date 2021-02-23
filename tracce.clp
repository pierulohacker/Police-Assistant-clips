(defmodule tracce (export ?ALL) (import funzioni-globali ?ALL))

;descriviamo la tipologia di tracce che possono essere rinvenute
(deftemplate tracce::papillare
	(slot tipologia (allowed-symbols evidente latente) (default ?NONE))
	(slot numero-reperto (default ?NONE)))
	
(deftemplate tracce::biologica
	(slot tipologia (allowed-symbols liquida solida) (default ?NONE))
	(slot nome (default "sostanza sconosciuta"))
	(slot numero-reperto (default ?NONE)))
	
(deftemplate tracce::merceologica
	(slot tipologia (default ?NONE))
	(slot nome (default "oggetto sconosciuto"))
	(multislot tracce)
	(slot numero-reperto (default ?NONE)))