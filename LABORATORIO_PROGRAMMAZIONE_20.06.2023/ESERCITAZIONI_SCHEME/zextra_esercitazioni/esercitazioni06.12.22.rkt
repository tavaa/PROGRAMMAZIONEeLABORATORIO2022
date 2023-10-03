;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname esercitazioni06.12.22) (read-case-sensitive #t) (teachpacks ((lib "drawings.ss" "installed-teachpacks"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "drawings.ss" "installed-teachpacks")) #f)))
; UniUd - 154255 Tavano Matteo
; Laboratorio di Programmazione 2022-2023
; Esercitazioni sui temi d'esame
; 06/20-12-22


;; 1 - MATCH
;;Date due stringhe di lettere u e v, restituisce la stringa delle corrispondenze w così definita:
;;w ha la lunghezza della stringa più corta (fra u e v);
;; se in una certa posizione u e v contengono la stessa lettera, allora anche w contiene quella lettera nella posizione corrispondente;
;; se invece u e v contengono lettere diverse, w contiene il simbolo “asterisco” nella posizione corrispondente. 

(define match
  (lambda (u v)
    (if (or (string=? u "") (string=? v ""))
        ""
        (let* ((uh (string-ref u 0))
               (vh (string-ref v 0))
               (s (match (substring u 1) (substring v 1))))
          (if (char=? uh vh)
              (string-append (string uh) s)
              (string-append "*" s))))
    ))

(match "astrazione" "estremi") ; Output: "*str**i"
;-----------------------------------------------------------------

;; 2 - INCREMENT
;;Calcola l’incremento di un numero naturale rappresentato come stringa di cifre in una base compresa fra 2 e 10.
;;Gli argomenti sono num, la stringa numerica, e base, di tipo intero; il valore restituito è una stringa numerica.

(define offset (char->integer #\0))

(define last-digit
  (lambda (base)
    (integer->char (+ (- base 1) offset))
    ))

(define next-digit
  (lambda (dgt)
    (integer->char (+ (char->integer dgt) 1))
    ))

(define increment
  (lambda (num base)
    ; 2 <= base <= 10
    (let ((digits (string-length num)))
      (if (= digits 0)
          "1"
          (let* ((dgt (string-ref num (- digits 1))))
            (if (char=? dgt (last-digit base))
                (string-append (increment (substring num 0 (- digits 1)) base) "0")
                (string-append (substring num 0 (- digits 1)) (string (next-digit dgt)))))))
    ))

 (increment "1011" 2) ; Output: "1100"

;-----------------------------------------------------------------

;; 3 - LCS
;; Date le stringhe u, v, la procedura lcs calcola una soluzione del problema della sottosequenza comune più lunga.
;;Il risultato è rappresentato da una lista di terne, ciascuna delle quali contiene le posizioni in u e in v di un carattere comune che fa parte della sottosequenza più lunga,
;;numerate a partire da 1, e la stringa costituita dal solo carattere comune.

(define lcs
  (lambda (u v)
    (lcs-rec 1 u 1 v)
    ))

(define lcs-rec
  (lambda (i u j v)
    (cond ((or (string=? u "") (string=? v ""))
           '())
          ((char=? (string-ref u 0) (string-ref v 0))
           (cons (list i j (string (string-ref u 0)))
                 (lcs-rec (+ i 1) (substring u 1) (+ j 1) (substring v 1))))
           (else
            (better (lcs-rec (+ i 1) (substring u 1) j v)
             (lcs-rec i u (+ j 1) (substring v 1)))))
     ))

(define better
  (lambda (x y)
    (if (< (length x) (length y))
        y
        x)
    ))

 (lcs "pino" "pino")     ; Output: ((1 1 "p") (2 2 "i") (3 3 "n") (4 4 "o"))
 (lcs "pelo" "peso")    ; Output: ((1 1 "p") (2 2 "e") (4 4 "o"))
 (lcs "ala" "palato")   ; Output: ((1 2 "a") (2 3 "l") (3 4 "a"))
 (lcs "arto" "atrio")   ; Output: ((1 1 "a") (3 2 "t") (4 5 "o"))

;-----------------------------------------------------------------

;; 4 - CYCLIC STRING
;;Definisci formalmente una procedura cyclic-string in Scheme che, dati come argomenti una stringa pattern e un numero naturale length,
;;assuma come valore la stringa di lunghezza length risultante dalla ripetizione ciclica di pattern, eventualmente troncata a destra.

(define cyclic-string
  (lambda (pattern length)
    (let* ((pattern-length (string-length pattern))
           (repetitions (quotient length pattern-length))
           (remainder (modulo length pattern-length))
           (cyclic-pattern (string-append (make-cyclic-string repetitions pattern) (substring pattern 0 remainder))))
      cyclic-pattern)))

(define make-cyclic-string
  (lambda (repetitions pattern)
    (if (= repetitions 0)
        ""
        (string-append pattern (make-cyclic-string (- repetitions 1) pattern)))))

 (cyclic-string "abcd" 0)    ; Output: ""
 (cyclic-string "abcd" 1)    ; Output: "a"
 (cyclic-string "abcd" 2)    ; Output: "ab"
 (cyclic-string "abcd" 4)    ; Output: "abcd"
 (cyclic-string "abcd" 5)    ; Output: "abcda"
 (cyclic-string "abcd" 11)   ; Output: "abcdabcdabc"



;-----------------------------------------------------------------

;; 5 - AV

;;Definisci una procedura av in Scheme che, data una lista non vuota (x1 x2 ... xn) i cui n elementi xi appartengono all’insieme {–1, 0, 1},
;;restituisca la lista (y1 y2 ... yn–1) di n–1 elementi dello stesso insieme tale che yi = –1 se xi + xi+1 < 0, yi = 0 se xi + xi+1 = 0 e yi = 1 se xi + xi+1 > 0.

(define av
  (lambda (lst)
    (cond ((null? (cdr lst)) '()) ; Caso base: se la lista ha un solo elemento, restituiamo una lista vuota
          (else
           (cons (av-helper (car lst) (cadr lst)) (av (cdr lst)))))))

(define av-helper
  (lambda (x y)
    (cond ((< (+ x y) 0) -1) ; xi + xi+1 < 0
          ((= (+ x y) 0) 0)  ; xi + xi+1 = 0
          ((> (+ x y) 0) 1)))) ; xi + xi+1 > 0

(av '(0 0 -1 -1 1 0 0 1 0)) ; Output: (0 -1 -1 0 1 0 1 1)

;-----------------------------------------------------------------

;; 6 - r-Val

;;Valori numerici nell’intervallo [0,1) possono essere rappresentati in forma binaria da una stringa di cifre "0" e "1"
;;precedute dal carattere "." (punto), dove i singoli bit sono pesati da potenze negative di due.
;;Per esempio, le stringhe ".1" e ".011" corrispondono ai numeri 0.5 e 0.375, rispettivamente, nella consueta notazione in base dieci.



(define r-val
  (lambda (str)
    (let ((binary-str (substring str 1)))
      (+ (r-val-helper binary-str 0 -1) 0.0))))

(define r-val-helper
  (lambda (binary-str result exponent)
    (if (string=? binary-str "")
        result
        (r-val-helper (substring binary-str 1)
                      (+ result (* (char->integer (string-ref binary-str 0))
                                   (expt 2 exponent)))
                      (- exponent 1)))))


;-----------------------------------------------------------------

;; 7 - SHARED LIST

;;Definisci una procedura shared in Scheme che, date due liste u, v (strettamente) ordinate di numeri interi positivi,
;;restituisca la lista ordinata degli elementi comuni a u e v.

(define shared
  (lambda (u v)
    (cond ((or (null? u) (null? v))
           '())
          ((< (car u) (car v))
           (shared (cdr u) v))
          ((< (car v) (car u))
           (shared u (cdr v)))
          (else
           (cons (car u) (shared (cdr u) (cdr v)))))
    ))




(shared '(1 3 5 6 7 8 9 10) '(0 1 2 3 4 5 7 9)) ;→ (1 3 5 7 9)

;-----------------------------------------------------------------




