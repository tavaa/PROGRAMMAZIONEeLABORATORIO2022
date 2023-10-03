;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Problema_7) (read-case-sensitive #t) (teachpacks ((lib "drawings.ss" "installed-teachpacks"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "drawings.ss" "installed-teachpacks")) #f)))
; UniUd - 154255 Tavano Matteo
; Laboratorio di Programmazione 2022-23
; Problema 7

;Per operare sulle liste utilizza esclusivamente la costante null e le primitive di base: null?, car, cdr, cons.

;---------------------------------------------------------------------------------------------------------------------------

; 1) Appartenenza elemento alla lista

;definisci in Scheme una procedura belong? che, dati un intero x e una lista ordinata S, verifica se x è un elemento di S.
(define belong?
  (lambda (x S) ;x = intero
                ;S = lista ordinata
      ;controllo se la lista e' vuota
      (cond
         ((null? S) #f) ; se la lista è vuota, restituisco false
         ;controllo se x appartiene alla lista
         ((= x (car S)) #t) ; se x è il primo el. della lista ==> vero
         (else
          ;trammite la ricorsione cerco l'elemento che m'interessa
          (belong? x (cdr S)) ;; cdr S ==> resto della lista escludendo il car
          )
         )
      ) 
  )

;---------------------------------------------------------------------------------------------------------------------------

; 2) Posizione di x in S
;definisci in Scheme una procedura position che, dati un intero x e una lista ordinata e senza ripetizioni S,

;restituisce la posizione (indice) di x in S.

(define position
  (lambda(x S) ;x = intero
               ;S = lista ordinata
    ;controllo se l'elemento appartiene alla lista
    (if (belong? x S)
       ;se vero
       ;se trovo l'elemento aggiungo zero se no uno
       (if(= x (car S))
          ;se vero
          0 ;; x è alla posizione 0 della lista
          ;se falso
          (+ 1 (position x (cdr S)));; ripeto processo e aggiungo 1, in modo da avere un conteggio effettivo sulla posizione
        )
       ; el. non appartiene alla lista ==> non ha un indice
       "Elemento non in lista"
       )
    )
  )

;---------------------------------------------------------------------------------------------------------------------------

; 3) INSERIMENTO di Un elemento  x alla lista S

;Definisci quindi una procedura sorted-ins che, dati un intero x e una lista ordinata e senza ripetizioni S, restituisce

;la lista ordinata e senza ripetizioni che contine x e tutti gli elementi di S.

(define sorted-ins
  (lambda(x S) ;x = intero
               ;S = lista
    (cond
      ;caso in cui la lista sia vuota
      ((null? S) (list x)) ;; creo lista contente solo x
      
      ;caso in cui x è uguale al primo el.della lista
      ((= x (car S)) (sorted-ins (car S) (cdr S)))
      
      ;caso in cui x e' minore
      ;aggiungo semplicemente x alla lista
      ((< x (car S)) (cons x S))
      
      ;caso in cui x e' maggiore
      (else
       ;unisco x con la lista e confronto con il prossimo numero
       (cons (car S) (sorted-ins x (cdr S)))
       )
      )
    )
  )

;---------------------------------------------------------------------------------------------------------------------------

; 4) ORDINAMENTO LISTE
;definire una procedura sorted-list che, data una lista senza ripetizioni S, restituisce la lista ordinata e senza ripetizioni S' che contine tutti e soli gli elementi di S.

(define sorted-list
  (lambda (S) ;S = lista
    (cond
      ;caso in cui la lista e' vuota
      ((null? S) "Lista Vuota")
      
      ;caso di un elemento, la lista contiene un solo elemento, perciò è già ordinata
      ((null? (cdr S)) S)
      
      (else
       ;riordinamento lista trammite sorted-ins e ricorsione
       (sorted-ins (car S) (sorted-list (cdr S)))
       )
    )
  )
 )

;---------------------------------------------------------------------------------------------------------------------------

;test
(belong? 18 '()) ;falso
(belong? 18 '(5 7 10 18 23)) ;vero
(belong? 18 '(5 7 10 12 23)) ;falso
 
(position 5 '(7 8 24 35 41)) ;0 
(position 35 '(7 8 24 35 41)) ;3
(position 41 '(7 8 24 35 41)) ;4

(sorted-ins 24 '()) ;'(24)
(sorted-ins 5 '(7 8 24 35 41)) ;'(5 7 8 24 35 41)
(sorted-ins 24 '(7 8 24 35 41)) ;'(7 8 24 35 41)
(sorted-ins 27 '(7 8 24 35 41)) ;'(7 8 24 27 35 41)

(sorted-list '())
(sorted-list '(7))
(sorted-list '(24 7))
(sorted-list '(35 8 41 24 7)) ;'(7 8 24 35 41)