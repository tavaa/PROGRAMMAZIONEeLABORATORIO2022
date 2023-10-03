;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Problema_5) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; UniUd - 154255 Tavano Matteo
; Laboratorio di Programmazione 2022-2023
; Problema 5

;------------------------------------------------------------------

;formule in 2D
;casi base:
;A e B sono nella stessa riga = paths(0,j)
;A e B sono nella stessa colonna = paths(i,0)
;percorsi da A' a B = paths(i-1,j)
;percorsi da A" a B = paths(i,j-1)
;paths(i,j)=paths(i,j-1)+paths(i-1,j)

;------------------------------------------------------------------

;caso 2D - i coordinata di riga, j coordinata di colonna
(define manhattan-2d
  (lambda (i j)
    ;controllo se una delle due variabili sia diversa da zero
    (cond
      ;caso in cui tutto sia zero
      ((and(= i 0)(= j 0))0) ; un solo percorso disponibile
      ;caso in cui sia solo una riga
      ((= i 0) 1)
      ;caso in cui sia solo una colonna
      ((= j 0) 1)
      ;caso in cui le due varbili siano diverse da zero
      (else
       (+(manhattan-2d (- i 1) j)(manhattan-2d i (- j 1)))
        ;; caso ricorsivo ==> ripeto 2 esecuzioni sottraendo posizione 1 da entrambe le coordinate
       )
      )
   )
  )

;-------------------------------------------------------------

;caso 3D
;; i coordinata riga, j coordinata di colonna, k coordinata per 3a dimensione
(define manhattan-3d
  (lambda (i j k)
    ;controllo se una delle due variabili sia diversa da zero
    (cond
      ;caso in cui tutto sia zero
      ((and(= i 0)(= j 0)(= k 0)) 0)

      ;; ripeto percorso 2d fatto in precedenza se è nulla una delle tre coordinate
      ;caso in cui sia solo una riga
      ((= i 0)(manhattan-2d j k)) 
      ;caso in cui sia solo una colonna
      ((= j 0)(manhattan-2d i k))
      ;caso in cui k = 0 
      ((= k 0)(manhattan-2d i j))

      ;caso in cui le due varbili siano diverse da zero
      (else
       (+(manhattan-3d (- i 1) j k)(manhattan-3d i (- j 1) k)(manhattan-3d i j (- k 1)))
       )
      )
   )
  )

;----------------------------------------------------------------

; Test

(manhattan-2d 0 0); → 0
(manhattan-2d 1 0) ;→ 1
(manhattan-2d 0 1) ;→ 1
(manhattan-2d 1 0) ;→ 1
(manhattan-2d 1 1) ;→ 2 
(manhattan-2d 2 2 ) ;→ 6

(manhattan-3d 0 0 7) ;→ 1
(manhattan-3d 2 0 2) ;→ 6
(manhattan-3d 1 1 1) ;→ 6
(manhattan-3d 1 1 5) ;→ 42
(manhattan-3d 2 3 1) ;→ 60
(manhattan-3d 2 3 3) ;→ 560