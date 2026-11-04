#lang info

(define license 'BSD-3-Clause)

(define collection "tests")

(define deps '("base" "brevo"))
(define build-deps '("rackunit-lib"
                     "web-server-lib"))

(define update-implies '("brevo"))
