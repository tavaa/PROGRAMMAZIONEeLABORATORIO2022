;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Problema_9) (read-case-sensitive #t) (teachpacks ((lib "drawings.ss" "installed-teachpacks"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "drawings.ss" "installed-teachpacks")) #f)))
; UniUd - 154255 Tavano Matteo
; Laboratorio di Programmazione 2022-23
; Problema 9

;------------------------------------------------------------------

; Code

; Parte 1

;; definisco un alfabeto latino inserendo tutti i simboli latini (lista di caratteri)
(define latin-alphabet '(#\A #\B #\C #\D #\E #\F #\G #\H #\I #\L #\M #\N #\O #\P #\Q #\R #\S #\T #\V #\X #\A #\B #\C #\D #\E #\F #\G #\H #\I #\L #\M #\N #\O #\P #\Q #\R #\S #\T #\V #\X))

(define position                 ; int
  (lambda (carattere i)          ; char
    
    ;; se il carattere è uguale alla posizione i dell'alfabeto latino
    (if (char=? carattere (list-ref latin-alphabet i))
        i
        (position carattere (+ i 1))
        )
    ))


(define crittazione-cesare
  (lambda (carattere)

    (lambda (k)
    (list-ref latin-alphabet (+ (position carattere 0) k))
      )

    ))


; Parte 2

(define H
  (lambda (f g)

    (lambda (m n)
      (if (= n 0)
          (f m)
          (g m ((H f g) m (- n 1))))
      )

    ))

(define i (lambda (x) x))
(define s2 (lambda (u v) (+ v 1)))
(define z (lambda (x) 0))
(define u (lambda (x) 1))

;; addizione
(define add
  (H i s2)
    )

;; moltiplicazione
(define mul
  (H z add)
    )

;; potenza
(define pow
  (H u mul)
    )

;------------------------------------------------------------------

; Test

 (add 5 0); → ;5 
 (add 5 6); → ;11

 (mul 5 0) ;→ 0
 (mul 5 6) ;→ 30

 (pow 5 0 ) ;→ 1
 (pow 5 6) ;→ 15625

 (pow (add 5 6) 2); →  121
 (mul (pow (add 7 8) 3) 2); → 6750
 (add (mul (pow 7 3) 5) 286); → 2001