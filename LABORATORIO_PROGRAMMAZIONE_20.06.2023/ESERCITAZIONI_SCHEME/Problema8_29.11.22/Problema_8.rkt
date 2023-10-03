;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Problema_8) (read-case-sensitive #t) (teachpacks ((lib "drawings.ss" "installed-teachpacks") (lib "hanoi.ss" "installed-teachpacks"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "drawings.ss" "installed-teachpacks") (lib "hanoi.ss" "installed-teachpacks")) #f)))
; UniUd - 154255 Tavano Matteoo
; Laboratorio di Programmazione 2022-2023
; Problema 8

;------------------------------------------------------------------------

(define hanoi-moves     ;val: lista di coppie
  (lambda (n)           ;n > 0 intero: dischi
    (hanoi-rec n 1 2 3)
    ))

(define hanoi-rec       ;val: lista di coppie
  (lambda (n s d t)     ;n intero: dischi, s, d, t: posizioni
    (if (= n 1)
        (list (list s d))
        (let ((m1 (hanoi-rec (- n 1) s t d))
              (m2 (hanoi-rec (- n 1) t d s))
              )
          (append m1 (cons (list s d) m2))
          ))
    ))

(hanoi-moves 3); → '((1 2) (1 3) (2 3) (1 2) (3 1) (3 2) (1 2))

;------------------------------------------------------------------------

(define hanoi-disks     ;val: lista di coppie
  (lambda(n k)          ;n > 0 intero: dischi, 0 ≤ k ≤ 2n–1: mosse
    (hanoi-disks-rec n k 1 2 3 0 0 0)
 ))

(define hanoi-disks-rec           ;val: lista di coppie
  (lambda (n k s t d a b c)       ;n > 0 intero: dischi, 0 ≤ k ≤ 2n–1: mosse, s, d, t: posizioni, a, b, c: dischi in ogni posizione
    (let((m(expt 2 (- n 1))))
      (if(= n 0)
         (list(list s a)(list t b)(list d c))
         (if(< k m)
            (hanoi-disks-rec (- n 1) k s d t (+ a 1) c b)
            (hanoi-disks-rec (- n 1) (- k m) d t s c (+ b 1) a)
            )
         )
      )
    ))

(hanoi-disks 3 0); → '((1 3) (3 0) (2 0)) 
(hanoi-disks 3 1); → '((3 0) (2 1) (1 2))
(hanoi-disks 3 2); → '((2 1) (1 1) (3 1)) 
(hanoi-disks 3 3); → '((1 1) (3 2) (2 0)) 
(hanoi-disks 3 4); → '((3 2) (2 1) (1 0))
(hanoi-disks 3 5); → '((2 1) (1 1) (3 1)) 
(hanoi-disks 3 6); → '((1 1) (3 0) (2 2)) 
(hanoi-disks 3 7); → '((3 0) (2 3) (1 0))
(hanoi-disks 5 13); → '((3 2) (2 1) (1 2))
(hanoi-disks 15 19705); → '((3 4) (2 9) (1 2))
(hanoi-disks 15 32767); → '((3 0) (2 15) (1 0))

;------------------------------------------------------------------------

(define hanoi-picture   ;val: immagine
  (lambda (n k)         ;n > 0 intero: dischi, 0 ≤ k ≤ 2n–1: mosse
    (hanoi-picture-rec n k 1 2 3 0 0 0 (towers-background n))
    ))

(define hanoi-picture-rec         ;val: immagine
  (lambda (n k s d t a b c pic)   ;n > 0 intero: dischi, 0 ≤ k ≤ 2n–1: mosse, s, d, t: posizioni, a, b, c: dischi in ogni posizione, pic: immagine
    (if (= n 0)
        pic
        (let ((m (- n 1))
              (all (+ a (+ b (+ c n)))))
          (if (< k (expt 2 m))
              (hanoi-picture-rec m k s t d (+ a 1) c b
                                 (above (disk-image n all s a) pic))
              (hanoi-picture-rec m (- k (expt 2 m)) t d s c (+ b 1) a
                                 (above (disk-image n all d b) pic)))))
    ))

(hanoi-picture 5 0)
(hanoi-picture 5 13)
(hanoi-picture 5 22)
(hanoi-picture 5 31)
(hanoi-picture 15 19705)