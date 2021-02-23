(defmodule controllo-scena(export ?ALL) (import funzioni-globali ?ALL)
(import prevenzione-inquinamento ?ALL) )
;;template per definire in maniera coerente i pericoli possibili prima dell'effettivo ingresso sulla scena del crimine
(deftemplate pericolo 
	(slot tipologia (allowed-symbols tossicita ambientale strutturale) (default ?NONE))
	(slot presente (allowed-symbols si no))
	(slot help (type STRING) (default ?NONE))
	(slot soluzione (type STRING) (default ?NONE)))
	
;;possibili pericoli, e spiegazioni eventualmente richiedibili dall'utente
(deffacts pericoli-possibili
	(pericolo (tipologia tossicita) (presente) (help "Se si ritiene che nell'aria possano essere presenti sostanze nocive e respirabili (gas infiammabili
	rientrano nei rischi ambientali), digitare si") (soluzione "indossare il respiratore"))
	(pericolo (tipologia ambientale) (presente) (help "Se si ritiene che ci possano essere pericoli che riguardano l'ambiente (non integrita' delle strutture) come fuoco, gas infiammabili,
	mal tempo tale da mettere a repentaglio la vita dell'operatore, digitare 'si'") (soluzione "chiamare gli esperti per arginare il problema"))
	(pericolo (tipologia strutturale) (presente) (help "Se si ritiene che la struttura interessata possa in qualche modo danneggiare la scena del crimine e, soprattutto,
	mettere in pericolo la vita dell'operatore, digitare 'si'") (soluzione "chimare gli esperti per mettere in sicurezza la struttura"))) 
	

;;//////////////////////	CONTROLLO AMBIENTE PRELIMINARE	//////////////////
;;la priorità è assicurarsi che non ci siano feriti
(defrule cerca-feriti
	(finito no)
	(indumenti)
	(curiosi no)
	(not(feriti))
	(osservare si)
	=>
	(printout t "E' fonamentale assicurarsi che non ci siano feriti." crlf "Ce ne sono? [si/no]")
	(assert (feriti (funzioni-globali::monitora-si-no(read)))))
;;in presenza di feriti, è necessario coinvolgere gli operatori sanitari, così che mettano in sicurezza i feriti
(defrule soccorso-feriti
	(finito no)
	(indumenti)
	(curiosi no)
	?feriti<-(feriti si)
	=>
	(printout t "E' necessario chiamare gli addetti ai soccorsi" crlf "I feriti sono stati soccorsi? [si/no]")
	(retract ?feriti)
	(if (eq (funzioni-globali::monitora-si-no(read)) si) then (assert (feriti no)) else (assert(feriti si))))
	
;;ora è necessario capire quali pericoli ci siano nell'ambiente per gli operatori, la cui sicurezza ora è al primo posto
(defrule pericolo
	(finito no)
	(indumenti)
	(curiosi no)																						;;separare in più regole, priorità alla tossicità
	(feriti no)
	(pericolo (tipologia ?pericolo &~ strutturale ) (presente) (help)
	=>
	(printout t "C'è rischio di tossicita'? [si/no]")													;;INSERIRE DELLE VOCI DI HELP!!
	(assert (tossico (funzioni-globali::monitora-si-no(read))))
	(printout t "Ci sono rischi ambientali? (incendio, fughe di gas, etc.) [si/no]")
	(assert (rischio-ambientale (funzioni-globali::monitora-si-no(read))))
	(printout t "La scena del crimine è al chiuso? [si/no]")
	(assert (al-chiuso (funzioni-globali::monitora-si-no(read)))))
	