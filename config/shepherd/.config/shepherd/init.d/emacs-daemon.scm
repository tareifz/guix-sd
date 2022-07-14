(define emacs
  (make <service>
    #:provides '(emacs)
    #:docstring "Run `emacs' daemon"
    #:start (make-system-constructor "emacs --daemon")
    #:stop (make-system-destructor "emacsclient -e '(kill-emacs)'")))

(register-services emacs)

(start emacs)
