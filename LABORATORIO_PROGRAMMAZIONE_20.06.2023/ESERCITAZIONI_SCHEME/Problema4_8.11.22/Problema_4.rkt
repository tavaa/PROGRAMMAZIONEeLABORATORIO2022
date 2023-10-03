;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Problema_4) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; UniUd - 154255 Tavano Matteo
; Laboratorio di Programmazione 2022-2023
; Problema 4

;------------------------------------------------------------------

;; Somma di tre cifre nel sistema ternario bilanciato (caratteri):
;; - u, v rappresentano le cifre "incolonnate",
;; - c rappresenta il riporto "in entrata";
;; - la cifra restituita rappresenta la cifra "incolonnata"
;;   con u, v nel risultato.
;;
;; Il riporto va considerato a parte,
;; definendo una procedura "carry" con analoga struttura per casi.

;-------------------------------------------------------------------------------------------------

;procedura che restituisce la rappresentazione non vuota equivalente in cui le eventuali cifre zero (#\.) in testa, ininfluenti, sono rimosse

(define normalized-btr
  (lambda (btr) ;btr = stringa
    (cond ;nel caso la stringa sia vuota ritorno il carattere punto
          ((=(string-length btr)0) #\.)
          ;tolgo l'ultima cifra e richiamo la procedura per eventuali #\.
          ((string=? (substring btr 0 1) (string #\.)) (normalized-btr (substring btr 1 (string-length btr))))
          ;caso in cui la stringa non ha ulteriori #\. allora stampo la stringa
          (else btr)
          
     )
   )
  )

;-------------------------------------------------------------------------------------------------

;procedura che restituisce la cifra meno significativa (ultima di destra)(carattere) oppure zero (#\.) se l'argomento e' la stringa vuota

(define lsd
  (lambda (btr) ;btr =  stringa
    ;controllo se la stringa sia vuota
    (if(= (string-length btr) 0)
       ;se vero
       #\.
       ;se falso
       ;restituisco la cifra meno significativa (string-ref restituisce il carattere alla posizione idx, della stringa str)
       (string-ref btr (-(string-length btr)1) ) 
       )
      )
  )

;-------------------------------------------------------------------------------------------------

;procedura che restituisce la parte che precede l'ultima cifra (stringa) oppure la stringa vuota ("") se l'argomento e' la stringa vuota

(define head
  (lambda (btr) ;btr = stringa
    ;controllo che la stringa sia vuota
    (if(= (string-length btr) 0)
       ;se vero
       ;quindi la stringa e' vuota
       "" 
       ;se falso
       ;restituisco la penultima cifra
       (substring btr 0 (-(string-length btr)1))
       )
    )
  )

;-------------------------------------------------------------------------------------------------

;procedura che calcola la cifra BTR corrispondente (carattere) della rappresentazione della somma

(define btr-digit-sum                    ; val:     carattere +/./-
  (lambda (u v c)                        ; u, v, c: caratteri +/./-
    (cond ((char=? u #\-)                ; u v c
           (cond ((char=? v #\-)
                  (cond ((char=? c #\-)  ; - - -
                         #\.)
                        ((char=? c #\.)  ; - - .
                         #\+)
                        ((char=? c #\+)  ; - - +
                         #\-)))
                 ((char=? v #\.)
                  (cond ((char=? c #\-)  ; - . -
                         #\+)
                        ((char=? c #\.)  ; - . .
                         #\-)
                        ((char=? c #\+)  ; - . +
                         #\.)))
                 ((char=? v #\+)         ; - + c
                  c)))
          ((char=? u #\.)
           (cond ((char=? v #\-)
                  (cond ((char=? c #\-)  ; . - -
                         #\+)
                        ((char=? c #\.)  ; . - .
                         #\-)
                        ((char=? c #\+)  ; . - +
                         #\.)))
                 ((char=? v #\.)         ; . . c
                  c)
                 ((char=? v #\+)
                  (cond ((char=? c #\-)  ; . + -
                         #\.)
                        ((char=? c #\.)  ; . + .
                         #\+)
                        ((char=? c #\+)  ; . + +
                         #\-)))))
          ((char=? u #\+)
           (cond ((char=? v #\-)         ; + - c
                  c)
                 ((char=? v #\.)
                  (cond ((char=? c #\-)  ; + . -
                         #\.)
                        ((char=? c #\.)  ; + . .
                         #\+)
                        ((char=? c #\+)  ; + . +
                         #\-)))
                 ((char=? v #\+)
                  (cond ((char=? c #\-)  ; + + -
                         #\+)
                        ((char=? c #\.)  ; + + .
                         #\-)
                        ((char=? c #\+)  ; + + +
                         #\.)))))
          )))
 
;-------------------------------------------------------------------------------------------------

;procedura che restituisce il riporto BTR in uscita (carattere) conseguente alla somma delle cifre

(define btr-carry-cond
  (lambda (u v rip) ;u,v,rip = caratteri
                    ;rip = riporto
    (cond                                                    ; sumrip
      ((and(char=? u #\-)(char=? v #\+)(char=? rip #\.)) #\.) ; . -  = - -> - +  .
      ((and(char=? u #\-)(char=? v #\+)(char=? rip #\-)) #\+) ; - -  = + -> + +  +
      ((and(char=? u #\-)(char=? v #\+)(char=? rip #\+)) #\.) ; + -  = . -> . +  .
       
      ((and(char=? u #\-)(char=? v #\-)(char=? rip #\.)) #\-) ; . -  = - -> - -  -
      ((and(char=? u #\-)(char=? v #\-)(char=? rip #\-)) #\.) ; - -  = + -> + -  .
      ((and(char=? u #\-)(char=? v #\-)(char=? rip #\+)) #\.) ; + -  = . -> . -  .
      
      ((and(char=? u #\+)(char=? v #\+)(char=? rip #\.)) #\+) ; . +  = + -> + +  +
      ((and(char=? u #\+)(char=? v #\+)(char=? rip #\-)) #\.) ; - +  = . -> . +  .
      ((and(char=? u #\+)(char=? v #\+)(char=? rip #\+)) #\.) ; + +  = - -> - +  .
       
      ((and(char=? u #\+)(char=? v #\-)(char=? rip #\.)) #\.) ; . +  = + -> + -  .
      ((and(char=? u #\+)(char=? v #\-)(char=? rip #\-)) #\.) ; - +  = . -> . -  .
      ((and(char=? u #\+)(char=? v #\-)(char=? rip #\+)) #\-) ; + +  = - -> - -  -

      ((and(char=? u #\+)(char=? v #\.)(char=? rip #\.)) #\.) ; . +  = + -> + .  .
      ((and(char=? u #\+)(char=? v #\.)(char=? rip #\-)) #\.) ; - +  = . -> . .  .
      ((and(char=? u #\+)(char=? v #\.)(char=? rip #\+)) #\.) ; + +  = - -> - .  .

      ((and(char=? u #\-)(char=? v #\.)(char=? rip #\.)) #\.) ; . -  = - -> - .  .
      ((and(char=? u #\-)(char=? v #\.)(char=? rip #\-)) #\-) ; - -  = + -> + .  .
      ((and(char=? u #\-)(char=? v #\.)(char=? rip #\+)) #\.) ; + -  = . -> . .  .

      ((and(char=? u #\.)(char=? v #\.)(char=? rip #\.)) #\.) ; . .  = . -> . .  . 
      ((and(char=? u #\.)(char=? v #\.)(char=? rip #\-)) #\.) ; . .  = . -> . .  .
      ((and(char=? u #\.)(char=? v #\.)(char=? rip #\+)) #\.) ; . .  = . -> . .  .

      ((and(char=? u #\.)(char=? v #\-)(char=? rip #\.)) #\.) ; . .  = . -> . -  .
      ((and(char=? u #\.)(char=? v #\-)(char=? rip #\-)) #\-) ; - .  = - -> - -  -
      ((and(char=? u #\.)(char=? v #\-)(char=? rip #\+)) #\.) ; + .  = + -> + -  .

      ((and(char=? u #\.)(char=? v #\+)(char=? rip #\.)) #\.) ; . .  = . -> . +  .
      ((and(char=? u #\.)(char=? v #\+)(char=? rip #\-)) #\.) ; - .  = - -> - +  .
      ((and(char=? u #\.)(char=? v #\+)(char=? rip #\+)) #\+) ; + .  = + -> + +  +
      (else #\.)
      )
    )  
  )

(define btr-carry                    ; val:     carattere +/./-
  (lambda (u v c)                        ; u, v, c: caratteri +/./-
    (cond ((char=? c #\-)                ; u v c
           (cond ((char=? u #\-)
                  (cond ((char=? v #\-)  ; - - -
                         #\.)
                        ((char=? v #\.)  ; - - .
                         #\-)
                        ((char=? v #\+)  ; - - +
                         #\+)))
                 ((char=? u #\.)
                  (cond ((char=? v #\-)  ; - . -
                         #\-) 
                        ((char=? v #\.)  ; - . .
                         #\.)
                        ((char=? v #\+)  ; - . +
                         #\.)))
                 ((char=? u #\+)         ; - + c 
                  (cond ((char=? v #\-)  ; - . -
                         #\.)
                        ((char=? v #\.)  ; - . .
                         #\.)
                        ((char=? v #\+)  ; - . +
                         #\.)))))
           
          ((char=? c #\.)
           (cond ((char=? u #\-)
                  (cond ((char=? v #\-)  ; . - - 
                         #\-)
                        ((char=? v #\.)  ; . - .
                         #\.)
                        ((char=? v #\+)  ; . - +
                         #\.)))
                 ((char=? u #\.)         ; . . c
                  (cond ((char=? v #\-)  ; - . -
                         #\.)
                        ((char=? v #\.)  ; - . .
                         #\.)
                        ((char=? v #\+)  ; - . +
                         #\.)))
                 ((char=? u #\+)
                  (cond ((char=? v #\-)  ; . + -
                         #\.)
                        ((char=? v #\.)  ; . + .
                         #\.)
                        ((char=? v #\+)  ; . + +
                         #\+)))))
          
          ((char=? c #\+)
           (cond ((char=? u #\-)         ; + - c
                  (cond ((char=? v #\-)  ; - . -
                         #\.)
                        ((char=? v #\.)  ; - . .
                         #\.)
                        ((char=? v #\+)  ; - . +
                         #\.)))
                 ((char=? u #\.) 
                  (cond ((char=? v #\-)  ; + . -
                         #\.)
                        ((char=? v #\.)  ; + . .
                         #\.)
                        ((char=? v #\+)  ; + . +
                         #\+)))
                 ((char=? u #\+)
                  (cond ((char=? v #\-)  ; + + -
                         #\-)
                        ((char=? v #\.)  ; + + .
                         #\.)
                        ((char=? v #\+)  ; + + +
                         #\.)))))
          )))

;------------------------------------------------------------------------------------------------- 

;procedura che restituisce la rappresentazione BTR della somma inclusiva del riporto

(define btr-carry-sum 
  (lambda (btr1 btr2 r) ;btr1, btr2 = stringa
                        ;r = carattere
    (cond ((and(=(string-length btr1)0) (=(string-length btr2)0)) (string r)) ; se la lunghezza delle due stringhe è nulla ritorna carattere r
          ((and(=(string-length btr1)0) (>(string-length btr2)0)) ; se btr1 == 0, e br2 > 0
               ; ricorsione
              (string-append (btr-carry-sum "" (head btr2) (btr-carry (lsd btr1) (lsd btr2) r)) (string(btr-digit-sum (lsd btr1) (lsd btr2) r))))
          ((and(>(string-length btr1)0) (=(string-length btr2)0))
               (string-append (btr-carry-sum (head btr1) "" (btr-carry (lsd btr1) (lsd btr2) r)) (string(btr-digit-sum (lsd btr1) (lsd btr2) r))))
          (else (string-append (btr-carry-sum (head btr1) (head btr2) (btr-carry (lsd btr1) (lsd btr2) r)) (string (btr-digit-sum (lsd btr1) (lsd btr2) r))))
     )
   )
  )

;-------------------------------------------------------------------------------------------------

;procedura che normalizza la stringa e richiama btr-carry per sommare le due stringhe

(define btr-sum
  (lambda (btr1 btr2)
    (normalized-btr (btr-carry-sum btr1 btr2 #\.))
  )
)

;-------------------------------------------------------------------------------------------------

;prove

;(btr-digit-sum #\- #\+ #\.)
;(btr-digit-sum #\- #\- #\.)
;(btr-digit-sum #\- #\. #\.)
;(btr-carry #\+ #\- #\.)
;(btr-carry #\- #\+ #\.) 
;(btr-carry #\+ #\- #\+)
;(btr-carry #\- #\+ #\-)
;(btr-carry #\- #\- #\+) 
;(btr-carry #\+ #\+ #\-)
;(btr-carry #\+ #\+ #\+) 
;(btr-carry #\- #\- #\-) 
;(normalized-btr ".+-+-")
;(normalized-btr "")
;(normalized-btr "..+.-+-")
;(lsd "")
;(lsd "-+.+")
;(head "")
;(head "-+-")

;-------------------------------------------------------------------------------------------------

; Test

(btr-sum "-+--" "+") ;-+-.
(btr-sum "-+--" "-") ;-.++
(btr-sum "+-.+" "-+.-") ;. 
(btr-sum "-+--+" "-.--") ;--++.
(btr-sum "-+-+." "-.-+") ;-.-.+
(btr-sum "+-+-." "+.+-") ;+.+.-