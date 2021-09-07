(define pulseaudio
  (make <service>
    #:provides '(pulseaudio)
    #:docstring "Run `pulseaudio' server"
    #:start (make-forkexec-constructor '("pulseaudio" "-D" "--exit-idle-time=-1"))
    #:stop (make-kill-destructor)
    #:respawn? #t))

(register-services pulseaudio)

(start pulseaudio)
