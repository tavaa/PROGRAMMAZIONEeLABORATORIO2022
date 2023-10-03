;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Problema_2) (read-case-sensitive #t) (teachpacks ((lib "drawings.ss" "installed-teachpacks"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "drawings.ss" "installed-teachpacks")) #f)))
; UniUd - 154255 Tavano Matteo
; Laboratorio di Programmazione 2022-23
; Problema 2

;--------------------------------------------------------------

; Code - necessita installazione drawings nel teachpack

(set-puzzle-shift-step!)

;; smaller 
; disegno piazza unendo tasselli
(define drawing-slanting-square
  (lambda (tile1 tile2)
    (glue-tiles ; glue ==> unisce tasselli
     (half-turn ; half turn==> ruota 90
      (glue-tiles
       tile2
       (shift-down tile1 4) ;shift-down ==> sposta in basso di n unità
       )
      )
     (shift-down
      (shift-right
       (glue-tiles
        tile2
        (shift-down tile1 4)
        )
       2
       )
     1
     )
    )
    ))

; disegno croce unendo i tasselli
(define croce
  (lambda (tile1 tile2)
    (glue-tiles
     (shift-right
      (half-turn
       (glue-tiles
         (shift-right tile1 4)
         (shift-right tile2 2)
         )
        )
      2)
     (glue-tiles
      (shift-right tile1 2)
      (shift-down tile2 -1)
      )
     )
    )
  )
     
;------------------------------------------------------------------------

; Test

(drawing-slanting-square smaller-tile larger-tile)

(croce smaller-tile larger-tile)

