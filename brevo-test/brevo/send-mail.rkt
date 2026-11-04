#lang racket/base

(require rackunit
         rackunit/text-ui
         brevo
         "common.rkt")

(define brevo-tests
  (test-suite
   "brevo-send-email"
   #:before start-server
   #:after stop-server
   (test-case "neither `text-content` nor `html-content` being passed raises a user exception"
     (check-exn
      exn:fail:user?
      (lambda ()
        (brevo-send-email (brevo "supersecret")
                               #:sender "hello@sorinmuntean.ro"
                               #:subject "hi!"
                               #:to (list "hello@sorinmuntean.ro")))))
   (test-case "filters out falsy parameters before sending the request"
     (check-equal?
      (brevo-send-email (brevo "supersecret")
                             #:bcc '()
                             #:cc '()
                             #:headers #f
                             #:html-content #f
                             #:params #f
                             #:sender "hello@sorinmuntean.ro"
                             #:subject "hi!"
                             #:template-id #f
                             #:text-content "bar"
                             #:to (list "hello@sorinmuntean.ro"))
      (hasheq 'replyTo (hasheq 'email "hello@sorinmuntean.ro")
              'sender (hasheq 'email "hello@sorinmuntean.ro")
              'subject "hi!"
              'textContent "bar"
              'to (list (hasheq 'email "hello@sorinmuntean.ro")))))
   (test-case "extracts names and emails and formats them correctly before sending the request"
     (check-equal?
      (brevo-send-email (brevo "supersecret")
                             #:bcc '()
                             #:cc '()
                             #:headers #f
                             #:html-content "<div>bar</div>"
                             #:params #f
                             #:reply-to "hello@sorinmuntean.ro (Noreply)"
                             #:sender "Sorin <hello@sorinmuntean.ro>"
                             #:subject "hi!"
                             #:template-id #f
                             #:text-content "bar"
                             #:to (list "hello@sorinmuntean.ro"))
      (hasheq 'htmlContent "<div>bar</div>"
              'replyTo (hasheq 'email "hello@sorinmuntean.ro"
                               'name "Noreply")
              'sender (hasheq 'email "hello@sorinmuntean.ro"
                              'name "Sorin")
              'subject "hi!"
              'textContent "bar"
              'to (list (hasheq 'email "hello@sorinmuntean.ro")))))))

(module+ test (run-tests brevo-tests))
