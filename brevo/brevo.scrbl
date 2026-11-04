#lang scribble/manual

@(require (for-label json racket/base racket/contract brevo))

@title{Brevo API Client}
@author[(author+email "Sorin Muntean" "hello@sorinmuntean.ro")]

@defmodule[brevo]


@;; Introduction ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

@section[#:tag "intro"]{Introduction}

This library lets you send emails with @link["https://www.brevo.com/"]{Brevo}
from Racket. To use it, you'll need to have a valid @link["https://app.brevo.com/settings/keys/api"]{API key}.

Brevo was formerly called Sendinblue, and this package was formerly called
@tt{sendinblue}. That package still exists as a deprecated wrapper that
re-exports this one under the old names, so existing code keeps working.

@;; Reference ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

@;; Usage ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

@section[#:tag "usage"]{Usage}

Create a client with your API key, then send an email:

@racketblock[
(require brevo)

(define client (brevo (getenv "BREVO_API_KEY")))

(brevo-send-email client
                  #:sender "Jane Doe <jane@example.com>"
                  #:to (list "john@example.com")
                  #:subject "Hello"
                  #:text-content "Hi John!")
]

On success, this returns Brevo's response, which looks like
@racket[(hasheq 'messageId "<...@smtp-relay.mailin.fr>")].

The sender must be a verified sender (or on an authenticated domain) in your
Brevo account. Otherwise Brevo accepts the request but doesn't deliver the
email, and the reason only shows up in Brevo's logs.

@;; Reference ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

@section[#:tag "reference"]{Reference}

@defstruct*[brevo ([api-key string?])]{
  A Brevo API client. Create an API key in
  @link["https://app.brevo.com/settings/keys/api"]{your Brevo account}; it
  needs access to transactional emails.
}

@defproc[(brevo-send-email [client brevo?]
                           [#:sender sender string?]
                           [#:to to (listof string?)]
                           [#:cc cc (listof string?) '()]
                           [#:bcc bcc (listof string?) '()]
                           [#:subject subject (or/c #f string?) #f]
                           [#:html-content html-content (or/c #f string?) #f]
                           [#:text-content text-content (or/c #f string?) #f]
                           [#:reply-to reply-to (or/c #f string?) #f]
                           [#:headers headers (or/c #f (hash/c symbol? string?)) #f]
                           [#:template-id template-id (or/c #f exact-nonnegative-integer?) #f]
                           [#:params params (or/c #f (hash/c symbol? string?)) #f]
                           [#:tags tags (or/c #f (listof string?)) #f])
         jsexpr?]{
  Sends a transactional email and returns Brevo's response.

  Addresses can be plain (@racket["jane@example.com"]) or include a name
  (@racket["Jane Doe <jane@example.com>"]). If @racket[reply-to] isn't given,
  replies go to @racket[sender].

  At least one of @racket[html-content] or @racket[text-content] is required;
  otherwise @racket[exn:fail:user] is raised. If Brevo rejects the request
  (for example, because of an invalid API key), @racket[exn:fail] is raised
  with Brevo's error response as its message.

  The other arguments map directly to the fields of Brevo's
  @link["https://developers.brevo.com/reference/sendtransacemail"]{send a transactional email}
  endpoint.
}

@deftogether[(
  @defparam[brevo-host host string? #:value "api.brevo.com"]
  @defparam[brevo-port port exact-positive-integer? #:value 443]
  @defboolparam[brevo-ssl? ssl? #:value #t]
)]{
  Where requests are sent. You won't normally need to change these, but they
  are useful for pointing the client at a local server in tests.
}
