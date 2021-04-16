(define-module (packages fonts)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (guix packages)
  #:use-module (guix download)
  #:use-module (guix build-system trivial)
  #:use-module (gnu packages base)
  #:use-module (gnu packages compression))

(define-public font-gohu-otb
  (package
   (name "font-gohu-otb")
   (version "2.1")
   (source (origin
            (method url-fetch)
            (uri (string-append "https://font.gohu.org/gohufont-"
                                version
                                "-otb.tar.gz"))
            (sha256
             (base32
              "05ppmkcjwiqg8kssc8f30ham9lw222f2i112fh1ij1pvimvv7xi3"))))
   (build-system trivial-build-system)
   (arguments
    `(#:modules ((guix build utils))
      #:builder
      (begin
        (use-modules (guix build utils))
        (let ((PATH (string-append (assoc-ref %build-inputs "tar")  "/bin:"
                                   (assoc-ref %build-inputs "gzip") "/bin"))
              (font-dir (string-append (assoc-ref %outputs "out")
                                       "/share/fonts/opentype/")))
          (setenv "PATH" PATH)
          (mkdir-p font-dir)
          (system* "tar" "xvf" (assoc-ref %build-inputs "source"))
          (chdir (string-append "gohufont-" ,version "-otb"))
          (copy-file "gohufont.otb"
                     (string-append font-dir "gohufont.otb"))
          (copy-file "gohufont-bold.otb"
                     (string-append font-dir "gohufont-bold.otb"))))))
   (native-inputs
    `(("gzip" ,gzip)
      ("tar" ,tar)))
   (home-page "https://font.gohu.org/")
   (synopsis "Gohufont, a Monospace font")
   (description "Gohufont is a monospace bitmap font well suited for programming and terminal use.
It is intended to be very legible and offers very discernable glyphs for all characters, including signs and symbols.")
   (license license:wtfpl2)))

(define-public font-gohu-pcf
  (package
   (name "font-gohu-pcf")
   (version "2.1")
   (source (origin
            (method url-fetch)
            (uri (string-append "https://font.gohu.org/gohufont-"
                                version
                                ".tar.gz"))
            (sha256
             (base32
              "10dsl7insnw95hinkcgmp9rx39lyzb7bpx5g70vswl8d6p4n53bm"))))
   (build-system trivial-build-system)
   (arguments
    `(#:modules ((guix build utils))
      #:builder
      (begin
        (use-modules (guix build utils))
        (let ((PATH (string-append (assoc-ref %build-inputs "tar")  "/bin:"
                                   (assoc-ref %build-inputs "gzip") "/bin"))
              (font-dir (string-append (assoc-ref %outputs "out")
                                       "/share/fonts/misc")))
          (setenv "PATH" PATH)
          (mkdir-p font-dir)
          (system* "tar" "xvf" (assoc-ref %build-inputs "source"))
          (chdir (string-append "gohufont-" ,version))
          (for-each (lambda (pcf)
                      (install-file pcf font-dir))
                    (find-files "." "\\.pcf.gz$"))))))
   (native-inputs
    `(("gzip" ,gzip)
      ("tar" ,tar)))
   (home-page "https://font.gohu.org/")
   (synopsis "Gohufont, a Monospace font")
   (description "Gohufont is a monospace bitmap font well suited for programming and terminal use.
It is intended to be very legible and offers very discernable glyphs for all characters, including signs and symbols.")
   (license license:wtfpl2)))
