#lang scribble/manual

@(require (for-label brevo))

@title{Sendinblue API Client (deprecated)}
@author[(author+email "Sorin Muntean" "hello@sorinmuntean.ro")]

@defmodule[sendinblue]

Sendinblue is now @link["https://www.brevo.com/"]{Brevo}, and this package has been
renamed to @racketmodname[brevo]. The @racketmodname[sendinblue] module re-exports
@racketmodname[brevo] under the old names (@tt{sendinblue-send-email} for
@tt{brevo-send-email}, and so on), so existing code keeps working.

New code should depend on @tt{brevo} instead.
