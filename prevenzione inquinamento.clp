;;///////////////////////	PREVENZIONE INQUINAMENTO PROVE	//////////////////////////////////////////////////

(defmodule prevenzione-inquinamento (export ?ALL) (import funzioni-globali ?ALL))


(defrule prevenzione-inquinamento::chiedere-vestire
	(declare (salience 100))
	(finito no)
	?indumenti<-(indumenti ?primo $?restanti)
	=>
	(printout t "Hai indossato " ?primo " ? (si/no): ")
	(bind ?risposta (funzioni-globali::monitora-si-no (read)))
	(assert (indumento-messo ?risposta))
	(retract ?indumenti);ritrattare per poter tornare sulla stessa regola 
	(if (eq ?risposta si) then (assert(indumenti $?restanti)) else (printout t "cosa stai aspettando?!") (assert (indumenti ?primo $?restanti))))
	
(defrule prevenzione-inquinamento::cerca-curiosi
	(finito no)
	(indumenti)
	(not(curiosi))
	=>
	(printout t "Guardati intorno; ci sono persone  non autorizzate (curiosi, giornalisiti, etc.) che potrebbero inquinare le prove? [si/no]" crlf)
	(assert (curiosi (funzioni-globali::monitora-si-no (read)))))
(defrule prevenzione-inquinamento::curiosi-presenti
	(finito no)
	(indumenti)
	?curiosi<-(curiosi si)
	(not (curiosi-allontanati))
	=>
	(printout t "Li hai allontanati? [si/no]")
	(retract ?curiosi)
	(if (eq (funzioni-globali::monitora-si-no(read)) si) then (assert (curiosi no)) else (assert(curiosi si))))
	;(assert(curiosi-allontanati (funzioni-globali::monitora-si-no (read)))))

(defrule prevenzione-inquinamento::ammonizione-allontana-curiosi
	(finito no)
	(indumenti)
	?curiosi<-(curiosi si)
	?allontanati<-(curiosi-allontanati no)
	=>
	(printout t "Non possiamo rischiare che la scena sia compromessa!" crlf)
	(retract ?allontanati ?curiosi)
	(assert (curiosi si)))

(defrule prevenzione-inquinamento::possibile-osservare
	(finito no)
	(indumenti)
	(curiosi no)
	=>
	(printout t "Ossarva l'ambiente circostante...")
	(assert (osservare si)))