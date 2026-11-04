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

## License

    racket-brevo is licensed under the 3-Clause BSD license.

[brevo]: https://www.brevo.com/
