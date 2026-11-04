#lang info

(define license 'BSD-3-Clause)

(define version "1.0")
(define collection "sendinblue")
(define scribblings '(("sendinblue.scrbl")))

(define deps '("base" "brevo"))
(define build-deps '("racket-doc"
                     "scribble-lib"))
