(define gpg-agent
  (make <service>
    #:provides '(gpg-agent)
    #:docstring "Run `gpg-agent' daemon"
    #:start (make-forkexec-constructor '("gpg-agent" "--options" "/home/tareifz/.config/gnupg/gpg-agent.conf" "--daemon"))
    #:stop (make-kill-destructor
            '("gpgconf" "--kill" "gpg-agent"))
    #:respawn? #t))

(register-services gpg-agent)

(start gpg-agent)
