(define emacs
  (make <service>
    #:provides '(emacs)
    #:docstring "Run `emacs' daemon"
    #:start (make-forkexec-constructor '("emacs" "--daemon"))
    #:stop (make-kill-destructor
            '("emacsclient" "--eval" "(let (kill-emacs-hook) (kill-emacs))"))
    #:respawn? #t))

(register-services emacs)

(start emacs)
