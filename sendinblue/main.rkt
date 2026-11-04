#lang racket/base

;; Deprecated: Sendinblue is now Brevo. This module re-exports the `brevo`
;; package under the old names so existing code keeps working.

(require brevo)

(provide (rename-out [brevo sendinblue]
                     [brevo? sendinblue?]
                     [brevo-api-key sendinblue-api-key]
                     [brevo-send-email sendinblue-send-email]
                     [brevo-host sendinblue-host]
                     [brevo-port sendinblue-port]
                     [brevo-ssl? sendinblue-ssl?]))
