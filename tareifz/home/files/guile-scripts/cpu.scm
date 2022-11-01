(define-module (cpu)
  #:use-module (rnrs io ports)
  #:use-module (ice-9 popen)
  #:export (cpu-percentage))

(define cpu-percentage
  (let* ((port (open-input-pipe "vmstat 1 2 -w | awk 'NR==4 {print 100-$15}'"))
         (str  (get-datum port))) ; from (ice-9 rdelim)
    (close-pipe port)
    str))
