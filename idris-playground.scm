
;; Defining basic packages to get a clean environment
;; Ref : https://github.com/trivialfis/guixpkgs/blob/master/programming-trivialfis.scm


(define-module (idris-playground)
  #:use-module (guix build-system trivial)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (guix packages)
  #:use-module (gnu packages base)
  #:use-module (gnu packages bash)
  #:use-module (gnu packages build-tools)
  #:use-module (gnu packages code)
  #:use-module (gnu packages commencement)
  #:use-module (gnu packages cmake)
  #:use-module (gnu packages gcc)
  #:use-module (gnu packages gdb)
  #:use-module (gnu packages gnome)
  #:use-module (gnu packages ncurses)
  #:use-module (gnu packages linux)
  #:use-module (gnu packages ninja)
  #:use-module (gnu packages python)
  #:use-module (gnu packages python-xyz)
  #:use-module (gnu packages less)
  ;;#:use-module (emacs)
  ;;#:use-module (code)
  )

(define idris-playground-home-page "https://github.com/asmodehn/idris-playground")

#!(define-public bashInteractive
  (package
    (name "bashInteractive")
    (version "0.0.0")
    (source #f)
    (build-system trivial-build-system)
    (arguments
     `(#:modules
       ((guix build utils))
       #:builder
       (begin
         (use-modules (guix build utils))
         (let* ([sh (string-append (assoc-ref %build-inputs "bash-minimal")
                                   "/bin/sh")]
		[clear (string-append (assoc-ref %build-inputs "ncurses") "/bin/clear")]
                [out (assoc-ref %outputs "out")]
                [bin (string-append out "/bin")]
                [exe (string-append bin "/cs")])
           (mkdir-p bin)
           (call-with-output-file exe
             (lambda (port)
               (format
                port
                "#!~a
~a && printf '\\033[3J'"
                sh clear)
               (chmod exe #o555)))))))
    (inputs
     `(("bash-minimal" ,bash-minimal)
       ("coreutils" ,coreutils)
       ("ncurses" ,ncurses)))
    (home-page "None")
    (synopsis "A clean bash envrionment. useful for when pure breaks your user's bashrc.")
    (description "An bash alias for cleaning up the terminal, packaged here so
that I don't have to define it when in pure environment.")
    (license license:gpl3+)))
!#
#!
(define-public trivialfis/basic
  (package
    (name "basic-programming")
    (version "0.0.0")
    (source #f)
    (build-system trivial-build-system)
    (arguments
     '(#:modules
       ((guix build union))
       #:builder (begin
                   (use-modules (ice-9 match)
                                (guix build union))
                   (let ((out (assoc-ref %outputs "out")))
                     (match %build-inputs
                       (((names . directories) ...)
                        (union-build out directories)))))))
    (inputs
     `(("clean-screen" ,clean-screen)
       ("coreutils" ,coreutils)
       ("findutils" ,findutils)
       ("glibc-locales" ,glibc-locales)
       ("grep" ,grep)
       ("procps" ,procps)
       ("sed" ,sed)
       ("which" ,which)))
    (native-search-paths (list (search-path-specification
                                (variable "GUIX_LOCPATH")
                                (files '("lib/locale")))))
    (home-page (string-append
                fis-home-page
                "/linux/2018/06/10/Using-guix-for-development.html"))
    (synopsis "Basic collection for programming.")
    (description "This package provides basic collection for programming,
suitable for pure environment.")
    (license license:gpl3+)))

(define-public trivialfis/basic-gui
  (package
    (name "basic-programming-gui")
    (version "0.0.0")
    (source #f)
    (build-system trivial-build-system)
    (arguments
     '(#:modules
       ((guix build union))
       #:builder (begin
                   (use-modules (ice-9 match)
                                (guix build union))
                   (let ((out (assoc-ref %outputs "out")))
                     (match %build-inputs
                       (((names . directories) ...)
                        (union-build out directories)))))))
    (inputs
     `(("emacs-trivialfis" ,emacs-trivialfis)
       ("nautilus" ,nautilus)))
    (native-search-paths (list (search-path-specification
                                (variable "GUIX_LOCPATH")
                                (files '("lib/locale")))))
    (home-page (string-append
                fis-home-page
                "/linux/2018/06/10/Using-guix-for-development.html"))
    (synopsis "Basic collection for programming.")
    (description "This package provides basic collection for programming,
suitable for pure environment.")
    (license license:gpl3+)))

(define-public trivialfis/python
  (package
    (name "python-programming")
    (version "0.0.0")
    (source #f)
    (build-system trivial-build-system)
    (arguments
     '(#:modules
       ((guix build union))
       #:builder (begin
                   (use-modules (ice-9 match)
                                (guix build union))
                   (let ((out (assoc-ref %outputs "out")))
                     (match %build-inputs
                       (((names . directories) ...)
                        (union-build out directories)))))))
    (inputs
     `(("python" ,python)
       ("python-autopep8" ,python-autopep8)
       ("python-flake8" ,python-flake8)
       ("python-jedi" ,python-jedi)
       ("python-yapf" ,python-yapf)

       ("basic-programming" ,trivialfis/basic)))
    (native-search-paths
     (append (package-native-search-paths python)
             (package-native-search-paths trivialfis/basic)))
    (home-page (string-append
                fis-home-page
                "/linux/2018/06/10/Using-guix-for-development.html"))
    (synopsis "Basic programming tools for python")
    (description "This package provides helper tools collection for programming
in Python.")
    (license license:gpl3+)))

(define-public trivialfis/c++
  (package
    (name "cxx-programming")
    (version "0.0.0")
    (source #f)
    (build-system trivial-build-system)
    (arguments
     '(#:modules
       ((guix build union))
       #:builder (begin
                   (use-modules (ice-9 match)
                                (guix build union))
                   (let ((out (assoc-ref %outputs "out")))
                     (match %build-inputs
                       (((names . directories) ...)
                        (union-build out directories)))))))
    (inputs
     `(("gcc-toolchain" ,gcc-toolchain-8)
       ("cmake" ,cmake)
       ("make" ,gnu-make)
       ("global" ,global)
       ("meson" ,meson)
       ("ninja" ,ninja)
       ("cquery" ,cquery)
       ("gdb" ,gdb)
       ("less" ,less)

       ("basic-programming" ,trivialfis/basic)))
    (native-search-paths
     (append (package-native-search-paths gcc-toolchain)
             (package-native-search-paths trivialfis/basic)))
    (home-page (string-append
                fis-home-page
                "/linux/2018/06/10/Using-guix-for-development.html"))
    (synopsis "Basic programming tools for C/C++")
    (description "This package provides helper tools for programming tools for
C/C++.")
    (license license:gpl3+)))
!#
