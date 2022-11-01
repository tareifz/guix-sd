(define-module (battery)
  #:use-module (rnrs io ports)
  #:export (battery-percentage
            battery-level
            battery-status))

(define battery "BAT0") ;; default?

;; Values: 0 - 100 (%)
(define* (battery-percentage #:optional (supply_source battery))
  (call-with-input-file (string-append "/sys/class/power_supply/"
                                       supply_source
                                       "/capacity") get-datum))

;; Values: "Unknown", "Critical", "Low", "Normal", "High", "Full"
(define* (battery-level #:optional (supply_source battery))
  (call-with-input-file (string-append "/sys/class/power_supply/"
                                       supply_source
                                       "/capacity_level") get-line))

;; Values: "Unknown", "Charging", "Discharging", "Not charging", "Full"
(define* (battery-status #:optional (supply_source battery))
  (call-with-input-file (string-append "/sys/class/power_supply/"
                                       supply_source
                                       "/status") get-line))
