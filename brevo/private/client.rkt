#lang racket/base

(require json
         net/http-client)

(provide (struct-out brevo)
         send-post-request
         brevo-host
         brevo-port
         brevo-ssl?) 

(define-logger brevo)

(define USER-AGENT
  (format "brevo Client for Racket ~a" (version)))

(define brevo-host
  (make-parameter "api.brevo.com"))

(define brevo-port
  (make-parameter 443))

(define brevo-ssl?
  (make-parameter #t))

(struct brevo (api-key))

(define (call-with-connection fun)
  (fun (http-conn-open (brevo-host)
                       #:port (brevo-port)
                       #:ssl? (brevo-ssl?)))) 

(define (send-post-request client #:uri uri #:json json)
  (define data (jsexpr->string json))
  (define headers
    (list "Accept: application/json"
          "Content-Type: application/json; charset=utf-8"
          (format "User-Agent: ~a" USER-AGENT)
          (format "api-key: ~a" (brevo-api-key client))))

  (log-brevo-info "POST ~a" uri)
  (log-brevo-info "Data: ~a" data)

  (call-with-connection
   (lambda (conn)
     (define-values (status-line _ in)
       (http-conn-sendrecv! conn uri #:method "POST" #:headers headers #:data data)) 

     (define response (read-json in))
     (when (hash-ref response 'code #f)
       (error 'send-post-request (jsexpr->string response)))
     response)))
