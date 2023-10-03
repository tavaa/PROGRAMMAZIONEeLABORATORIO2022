;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Problema_3) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; UniUd - 154255 Tavano Matteo
; Laboratorio di Programmazione 2022-2023
; Problema 3

;-----------------------------------------------------------------

; 1) VALORE NUMERICO SEGNO RAPRESENTAZIONE

; Si osserva solo il caso in cui il primo carattere della stringa fosse '-'.
; Gli altri casi sono gestiti dalle prossime funzioni:
; '.' → stringa è un numero decimale
; '+' → stringa rappresenta numero positivo


;; rep sign --> segne moltiplicatore in base al primo segno della sequenza
(define rep-sign ;rep stringa, rep-sign 1 o -1.
  (lambda (rep)
    ; CASO: se il primo carattere è '-'
    (if (char=? (string-ref rep 0) #\-)
        ; VERO → valore -1 : moltiplicatore negativo
        -1
        ; FALSO → valore 1 : moltiplicatore positivo
        1
        )
    )
  )

; ----------------------------------------------------------------

; 2) RAPPRESENTAZIONE DELLA PARTE INTERA

; La funzione ricorsiva accorcia da destra la stringa data fino all'eventuale punto incluso.
; Nel caso in cui il punto non fosse presente la funzione continua ad accorciarla fino a finire,
; di conseguenza restituisce la stringa originale.

;;rep-int data una stringa in rap.ternaria bilanciata restituisce solo la parte antecedente al '.'
(define rep-int
  (lambda (rep)
    ; memorizzo la stringa originale da mantenere per tutte le ricorsioni
    (rep-int-rec rep rep) 
    )
  )

; FUNZIONE RICORSIVA
(define rep-int-rec
  (lambda (rep int)    ; rep: stringa originale, int: stringa con solo parte intera
    ; CASO BASE: stringa vuota = se non si trova il carattere "."
    ; se int è uguale alla stringa vuota mi restituisce rep
    (if (string=? int "")
        ; VERO → stringa originale (è già intera da prima)
        rep
        ; FALSO → accorcio la stringa da destra fino al punto
        
        ; CASO RIC.: primo carattere a destra è '.'
        ; se il primo carattere da destra è già il punto allora restituisco la stringa stessa senza il punto
        (if (char=? (string-ref int (- (string-length int) 1)) #\.)
            ; VERO → stringa senza il punto a destra
            (substring int 0 (- (string-length int) 1))
            ; FALSO → funz. ric. con stringa senza primo carattere a destra
            ; se l'ultimo carattere non è '.' allora compio il processo ricorsivo sul resto della stringa
            (rep-int-rec rep (substring int 0 (- (string-length int) 1))) 
            )
        )
    )
  )

; ----------------------------------------------------------------

; 3) RAPPRESENTAZIONE PARTE RAZIONALE (DECIMALE)

; La funzione ricorsiva accorcia da sinistra la stringa data fino all'eventuale punto incluso.
; Nel caso in cui il punto non fosse presente la funzione continua ad accorciarla fino a finire, restituendola

;;rep-rat restituisce la parte decimale della stringa
(define rep-rat
  (lambda (rep)
    ; CASO BASE: stringa vuota = se non si trova il carattere "."
    (if (string=? rep "")
        ; VERO → stringa vuota (non ha parte razionale)
        ""
        ; FALSO → accorcio la stringa da sinistra fino al punto
        
        ; CASO RIC.: primo carattere a sinistra è '.'
        (if (char=? (string-ref rep 0) #\.)
            ; VERO → stringa senza il punto a sinistra
            (substring rep 1 (string-length rep))
            ; FALSO → funz. ric. con stringa senza primo carattere a sinistra
            (rep-rat (substring rep 1 (string-length rep)))
            )
        )
    )
  )

; ----------------------------------------------------------------

; 4) CORRISPONDENZA CARATTERE IN SEQUENZA RAPPRESENTAZIONE

; La funzione ricorsiva trova la posizione del carattere dato nella sequenza data partendo da sinistra.
; Se il primo carattere della sequenza non corrisponde al carattere dato, lo si trova alla
; posizione successiva richiamando la funzione con la parte di sequenza dopo il primo carattere, e così via.

; Se alla fine si ottiene una stringa vuota al posto della sequenza, vuol dire che il carattere
; non è presente nella sequenza. Utile per ignorare anche i caratteri segno.

; 0-> non c'è , 1-> appare almeno una volta
(define chr-dec
  (lambda (chr seq)   ; chr: carattere, seq: sequenza di riferimento (base della rappresentazione)
    ; memorizzo la lunghezza della sequenza da mantenere per tutte le ricorsioni
    (chr-dec-rec chr seq (string-length seq))
    )
  )

; FUNZIONE RICORSIVA
; ricerco chr in seq

(define chr-dec-rec
  (lambda (chr seq sql)   ; chr: carattere, seq: sequenza di ricerca, sql: lunghezza sequenza
    ; CASO BASE: stringa vuota = se il carattere non è nella sequenza
    (if (string=? seq "")
        ; VERO → non ha valore, restituisce 0
        0
        ; FALSO → posizione del carattere nella sequenza
        
        ; CASO RIC.: primo carattere della sequenza = carattere
        (if (char=? chr (string-ref seq 0))
            ; VERO → Lunghezza seq. - Lunghezza seq. ricerca
            (- sql (string-length seq))
            ; FALSO → funz. ric. con seq. ricerca senza primo carattere
            ; ripeto ricorsione partendo dalla posizione 2
            (chr-dec-rec chr (substring seq 1) sql) 
        )
        )
    )
  )

; ----------------------------------------------------------------

; 5) VALORE NUMERICO RAPPRESENTAZIONE INTERA

; La funzione calcola il valore numerico della parte intera riferendosi alla sequenza di riferimento
; Calcolo ogni carattere in base alla sua posizione nella stringa. La somma di questi è il risultato finale.

; int-dec -> valore parte intera
(define int-dec
  (lambda (rep seq)     ; rep: stringa parte intera, ; seq: sequenza di riferimento
    ; CASO BASE: stringa vuota = ho finito le cifre, la parte intera è nulla
    (if (string=? rep "")
        ; VERO → non sommo più niente
        0
        ; FALSO → valore del carattere in base alla sua posizione
        ; (valore carattere * base ^ (posizione - 1)) + iterazione al carattere successivo + ... + 0 = parte intera del numero (tramite somma complessiva)
        (+ (* (expt (string-length seq) (- (string-length rep) 1)) ;elevo la lunghezza di seq alla lunghezza-1 di rep
              (chr-dec (string-ref rep 0) seq) ;moltiplico ciò che ho trovato per 0 o per 1 a seconda che il carattere alla pos.0 di rep appartenga a rec.
              )
           (int-dec (substring rep 1) seq) ; ricorsione => ripeto lo stesso passaggio, levando una cifra da sx a rep. Sommo poi i risultati e ottengo la parte intera 
           )
        )
    )
  )

; ----------------------------------------------------------------

; 6) VALORE NUMERICO RAPPRESENTAZIONE DECIMALE

; Simile alla funzione precedente ma con queste differenze:

; - Funziona per la parte decimale della rappresentazione
; - Inverto la sequenza dei caratteri per riottenere la corrispondenza posizione-esponente
; - L'esponente della base (posizione) è negativa per calcolare il valore razionale dei caratteri

(define rat-dec
  (lambda (rep seq)    ; rep: stringa parte intera, seq: sequenza di riferimento
    ; inverto la stringa della parte intera
    ; attraverso questo trucco posso invertire la rappresentazione passando attraverso la conversione in una stringa
    (rat-dec-rec (list->string (reverse (string->list rep))) seq)
    )
  )

; FUNZIONE RICORSIVA
(define rat-dec-rec
  (lambda (rep seq)     ; rep: stringa parte intera, seq: sequenza di riferimento
    ; CASO BASE: stringa vuota = ho finito le cifre
    (if (string=? rep "")
        ; VERO → non sommo più niente
        0
        ; FALSO → valore del carattere in base alla sua posizione
        ; (valore carattere * base ^ -posizione) + iterazione al carattere successivo + ... + 0
        (+ (* (expt (string-length seq) (- (string-length rep)))
              (chr-dec (string-ref rep 0) seq)
              )
           (rat-dec-rec (substring rep 1) seq)
           )
        )
    )
  )

; ----------------------------------------------------------------

; 7) CONVERSIONE RAPPRESENTAZIONI BINARIE

; Utilizzo la funzione per convertire gli altri tipi di rappresentazione
; Preparo già in anticipo la sequenza di riferimento per i numeri binari: "01"

; bin.rep dato un numero decimale binario restituisce il suo valore
; "01" == definizione alfabeto decimale
(define bin-rep->number
  (lambda (rep)
    (rep->number "01" rep)
    )
  )

; ----------------------------------------------------------------

; 8) CONVERSIONE ALTRE RAPPRESENTAZIONI

; Utilizzo tutte le funzioni precedenti per ottenere finalmente il valore numerico:
; valore segno * ( valore parte intera + valore parte decimale )

(define rep->number
  (lambda (seq rep)
    (* (rep-sign rep);rep-sign = motiplicatore (1 o -1)
       (+ (int-dec (rep-int rep) seq) ;int-dec = parte intera, rep-int= parte prima del.
          (rat-dec (rep-rat rep) seq) ;rat-dec = parte decimale rep-rat
          )
       )
    )
  )

; ----------------------------------------------------------------

; Esempi dal testo dell'esercizio

(define hex "0123456789ABCDEF") ; definisco alfabeto esadecimale

(bin-rep->number "+1101") ; →  13
(bin-rep->number "0") ; →  0
(bin-rep->number "10110.011") ; →  22.375
(bin-rep->number "-0.1101001") ; →  -0.8203125

(rep->number "zu" "-uuzz") ; →  -12
(rep->number "0123" "+21.1") ; →  9.25
(rep->number "01234" "-10.02") ; →  -5.08
(rep->number hex "0.A") ; →  0.625
(rep->number hex "1CF.0") ; →  463