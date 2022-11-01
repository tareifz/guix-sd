(use-modules (shepherd service))

(define emacs
  (make <service>
    #:provides '(emacs)
    #:docstring "Run `emacs' daemon"
    #:start (make-system-constructor "emacs --daemon")
    #:stop (make-system-destructor "emacsclient -e '(kill-emacs)'")))

(register-services emacs)

(define gpg-agent
  (make <service>
    #:provides '(gpg-agent)
    #:docstring "Run `gpg-agent' daemon"
    #:start (make-forkexec-constructor '("gpg-agent" "--options" "/home/tareifz/.config/gnupg/gpg-agent.conf" "--daemon"))
    #:stop (make-kill-destructor
            '("gpgconf" "--kill" "gpg-agent"))
    #:respawn? #t))

(register-services gpg-agent)

;; (define pulseaudio
;;   (make <service>
;;     #:provides '(pulseaudio)
;;     #:docstring "Run `pulseaudio' server"
;;     #:start (make-forkexec-constructor '("pulseaudio" "-D" "--exit-idle-time=-1"))
;;     #:stop (make-kill-destructor)
;;     #:respawn? #t))

;; (register-services pulseaudio)

;; (start pulseaudio)
(start gpg-agent)
(start emacs)

;; Send shepherd into the background
(action 'shepherd 'daemonize)
