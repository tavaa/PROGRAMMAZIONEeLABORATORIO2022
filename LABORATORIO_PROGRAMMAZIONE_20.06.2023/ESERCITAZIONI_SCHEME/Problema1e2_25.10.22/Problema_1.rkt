;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Problema_1) (read-case-sensitive #t) (teachpacks ((lib "drawings.ss" "installed-teachpacks"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "drawings.ss" "installed-teachpacks")) #f)))
; UniUd - 154255 Tavano Matteo
; Laboratorio di Programmazione 2022-23
; Problema 1

;------------------------------------------------------------------

; Code

;frase unisce predicato, soggetto e compl.ogg
(define frase       ; val:     stringa
  (lambda (s p c)   ; s, p, c: stringhe
    (string-append
     (sogg s) " "
     (pred p s) " "
     (compl c)
     )
    )
  )

; sogg = dato un soggetto, attribuisce articolo determinativo
(define sogg    ; val: stringa
  (lambda (s)   ; s:   stringa
    (let
        (
          (l (string-length s)) ; l = sia l la lunghezza del soggetto
          )
      (let
          (
           (suffisso (substring s (- l 1)))           ) ; suffisso = fa il subsring partendo da ultima posizione.
       (cond ((string=? suffisso "o") (string-append "il " s))
             ((string=? suffisso "i") (string-append "i "  s))
             ((string=? suffisso "a") (string-append "la " s))
             ((string=? suffisso "e") (string-append "le " s))
           )
        )
      )
    )
  )

; pred = dati un verbo e un soggetto, attribuisce la giusta coniugazione
(define pred   ; val: stringa
  (lambda (p s)  ; p:   stringa
    (let
        (
         (l (string-length p))
         )
      (let
          (
           (suffisso (substring p (- l 3))) ; sia suffisso il substring di p prendendo le ultime tre lettere
           )
       (cond ((and      (string=? suffisso "are")       (singolare? s))  (string-append (substring p 0 (- l 3)) "a"  ))
             ((and (not (string=? suffisso "are"))      (singolare? s))  (string-append (substring p 0 (- l 3)) "e"  ))
             ((and      (string=? suffisso "are")  (not (singolare? s))) (string-append (substring p 0 (- l 3)) "ano"))
             ((and (not (string=? suffisso "are")) (not (singolare? s))) (string-append (substring p 0 (- l 3)) "ono"))
          )
        )
      )
    )
  )


;(define pred-sing   ; val: stringa
;  (lambda (p)  ; p:   stringa
;    (let
;        (
;         (l (string-length p)
;            )
;         )
;      (let
;          (
;           (suffisso (substring p (- l 3)
;                                )
;                     )
;           )
;        (let
;            (
;             (coniugazione (string-append (substring p 0 (- l 3)
;                                                     )
;                                          )
;                           )
;             )
;    (cond ((string=? suffisso "are") (coniugazione "a"))
;          ((string=? suffisso "ere") (coniugazione "e"))
;          ((string=? suffisso "ire") (coniugazione "e"))
;          )
;        )
;      )
;    )
;  )
; )


;(define pred-plu   ; val: stringa
;  (lambda (p)  ; p:   stringa
;    (let
;        (
;         (l (string-length p)
;            )
;         )
;      (let
;          (
;           (suffisso (substring p (- l 3)
;                                )
;                     )
;           )
;        (let
;            (
;             (coniugazione (string-append (substring p 0 (- l 3)
;                                                     )
;                                          )
;                           )
;             )
;    (cond ((string=? suffisso "are") (coniugazione "ano"))
;          ((string=? suffisso "ere") (coniugazione "ono"))
;          ((string=? suffisso "ire") (coniugazione "ono"))
;          )
;        )
;      )
;    )
;  )
; )

; restituisce valore di verità vero se la stringa termina con "a" o "o", altrimenti è falso
(define singolare? ; val:  booleano
  (lambda (sing)   ; sing: stringa
    (let
        (
         (suffisso (substring sing (- (string-length sing) 1)))
         )
    (cond ((string=? suffisso "o") #true)
          ((string=? suffisso "a") #true)
          (else #false)
          )
      )
    )
  )

;; aggiunge articolo determinativo al complemento oggetto ricevuto
(define compl    ; val: stringa
  (lambda (c)   ; s:   stringa
    (let
        (
         (l (string-length c)
            )
         )
      (let
          (
           (suffisso (substring c (- l 1)))
           )
       (cond ((string=? suffisso "o") (string-append "il " c))
             ((string=? suffisso "i") (string-append "i "  c))
             ((string=? suffisso "a") (string-append "la " c))
             ((string=? suffisso "e") (string-append "le " c))
          )
        )
      )
    )
  )

;--------------------------------------------------------------------

; Test:

;(frase "gatto" "cacciare" "topi"); → "il gatto caccia i topi"
;(frase "mucca" "mangiare" "fieno"); → "la mucca mangia il fieno"
;(frase "sorelle" "leggere" "novella"); → "le sorelle leggono la novella"
;(frase "bambini" "amare" "favole"); → "i bambini amano le favole"
;(frase "musicisti" "suonare" "pianoforti"); → "i musicisti suonano i pianoforti"
