<p>
    <a target="_blank" rel="noopener noreferrer" href="https://github.com/sxn/racket-brevo/actions?query=workflow%3ACI">
        <img src="https://github.com/sxn/racket-brevo/workflows/CI/badge.svg" alt="CI" style="max-width:100%;">
    </a>
</p>

# racket-brevo

A Racket client for the [Brevo][brevo] transactional email API.

Brevo was formerly called Sendinblue. The `sendinblue` package is now a thin,
deprecated wrapper around `brevo` that keeps the old names working. New code
should use `brevo`:

    raco pkg install brevo

## Usage

You'll need a Brevo [API key][api-key] with access to transactional emails.
Create a client with it, then send an email:

```racket
#lang racket/base
(require brevo)

(define client (brevo (getenv "BREVO_API_KEY")))

(brevo-send-email client
                  #:sender "Jane Doe <jane@example.com>"
                  #:to (list "john@example.com")
                  #:subject "Hello"
                  #:text-content "Hi John!")
```

On success, this returns Brevo's response, which looks like
`(hasheq 'messageId "<...@smtp-relay.mailin.fr>")`.

At least one of `#:text-content` or `#:html-content` is required. Optional
keywords are `#:cc`, `#:bcc`, `#:reply-to`, `#:headers`, `#:template-id`,
`#:params`, and `#:tags`.

The sender must be a verified sender (or on an authenticated domain) in your
Brevo account. Otherwise Brevo accepts the request but doesn't deliver the
email, and the reason only shows up in Brevo's logs.

See the [full documentation][docs] for the complete reference.

## License

    racket-brevo is licensed under the 3-Clause BSD license.

[brevo]: https://www.brevo.com/
[api-key]: https://app.brevo.com/settings/keys/api
[docs]: https://docs.racket-lang.org/brevo/
