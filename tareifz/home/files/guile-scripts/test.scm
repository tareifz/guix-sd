(define-module (test)
  #:use-module (ice-9 format)
  #:use-module (srfi srfi-1)
  #:use-module (battery)
  #:use-module (cpu))

(define $FONT "Terminus:size=8")
(define $HEIGHT 30)
(define $fg "#FFFFFF")
(define $fg-darker "#AAAAAA")
(define $bg "#000000")
(define $indicator "▒") ;; ▒ ▮

(define $load-colors '("#CD323F"
                          "#FF1100"
                          "#FF7000"
                          "#FFA400"
                          "#FFD500"
                          "#EDFF00"
                          "#BDFF00"
                          "#68FF00"
                          "#00FF10"
                          "#2CD347"))

(define (make-colorful-indicators n symbol colors)
  (fold (lambda (cpair acc)
          (format #f
                  "~a^fg(~a)~a^fn()"
                  acc
                  (first cpair)
                  (second cpair)))
      ""
      (zip colors (make-list n symbol))))

(define* (battery-remaining #:optional (indicator $indicator))
  (make-colorful-indicators (quotient (battery-percentage) 10)
                            indicator
                            $load-colors))

(define* (empty-fill percentage-fn #:optional (indicator $indicator))
  (format #f (string-append "^fg(~a)~V,,,'" indicator "@A^fg()")
          $fg-darker
          (- 10 (quotient (percentage-fn) 10))
          ""))

(define battery-string (format #f
                               "echo \" BAT: ~A~A ~A% \" | dzen2 -p -h ~A -expand left -fn ~A -fg ~S -bg ~S"
                               (battery-remaining)
                               (empty-fill battery-percentage)
                               (battery-percentage)
                               $HEIGHT
                               $FONT
                               $fg
                               $bg))

(define cpu-load-string (format #f
                               "echo \" CPU: ~A~A ~A% \" | dzen2 -p -h ~A -expand left -fn ~A -fg ~S -bg ~S"
                               (make-colorful-indicators (quotient cpu-percentage 10)
                                                         $indicator
                                                         (reverse $load-colors))
                               (empty-fill (const cpu-percentage))
                               cpu-percentage
                               $HEIGHT
                               $FONT
                               $fg
                               $bg))
