#lang scribble/manual

@(require (for-label json racket brevo))

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
