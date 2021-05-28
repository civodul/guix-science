;;;
;;; Copyright © 2016, 2017, 2018, 2019, 2020, 2021 Roel Janssen <roel@gnu.org>
;;;
;;; This program is free software; you can redistribute it and/or modify it
;;; under the terms of the GNU General Public License as published by
;;; the Free Software Foundation; either version 3 of the License, or (at
;;; your option) any later version.
;;;
;;; This program is distributed in the hope that it will be useful, but
;;; WITHOUT ANY WARRANTY; without even the implied warranty of
;;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;;; GNU General Public License for more details.
;;;
;;; You should have received a copy of the GNU General Public License
;;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define-module (guix-science packages python)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (gnu packages bioinformatics)
  #:use-module (gnu packages python)
  #:use-module (gnu packages python-xyz)
  #:use-module (gnu packages python-science)
  #:use-module (gnu packages python-web)
  #:use-module (gnu packages python-crypto)
  #:use-module (gnu packages python-check)
  #:use-module (gnu packages compression)
  #:use-module (gnu packages statistics)
  #:use-module (gnu packages pdf)
  #:use-module (gnu packages check)
  #:use-module (gnu packages)
  #:use-module (guix build-system python)
  #:use-module (guix download)
  #:use-module (guix git-download)
  #:use-module (guix packages))

(define-public python-pytest-rerunfailures
  (package
    (name "python-pytest-rerunfailures")
    (version "10.0")
    (source (origin
              (method url-fetch)
              (uri (pypi-uri "pytest-rerunfailures" version))
              (sha256
               (base32
                "14dksvc8mxmci3m3083xzwz70anis95a5s01apqvvqv2z48yc1ir"))))
    (build-system python-build-system)
    (propagated-inputs
     `(("python-pytest" ,python-pytest)
       ("python-setuptools" ,python-setuptools)))
    (home-page
     "https://github.com/pytest-dev/pytest-rerunfailures")
    (synopsis "Plugin for pytest to re-run tests to eliminate flaky failures")
    (description "This package provides a @code{pytest} plugin to re-run tests
to eliminate flaky failures.")
    (license license:mpl2.0)))

(define-public python-parameterizedtestcase
  (package
    (name "python-parameterizedtestcase")
    (version "0.1.0")
    (source (origin
              (method url-fetch)
              (uri (pypi-uri "parameterizedtestcase" version))
              (sha256
               (base32
                "0zhjmsd16xacg4vd7zb75kw8q9khn52wvad634v1bvz7swaivk2c"))))
    (build-system python-build-system)
    (home-page
     "https://github.com/msabramo/python_unittest_parameterized_test_case")
    (synopsis "Parameterized tests for Python's unittest module")
    (description
     "Parameterized tests for Python's unittest module")
    (license license:expat)))

(define-public python-google-cloud-storage
  (package
    (name "python-google-cloud-storage")
    (version "1.38.0")
    (source (origin
              (method url-fetch)
              (uri (pypi-uri "google-cloud-storage" version))
              (sha256
               (base32
                "1i26jiasa9n10bm6lm1i299cqrh0mxfrlq1ng5fxrf34dzb1280n"))))
    (build-system python-build-system)
    (arguments
     `(#:tests? #f))
    (home-page "https://github.com/googleapis/python-storage")
    (synopsis "Google Cloud Storage API client library")
    (description "Google Cloud Storage allows you to store data on Google
infrastructure with very high reliability, performance and availability,
and can be used to distribute large data objects to users via direct
download.")
    (license license:asl2.0)))

;; We might be missing a few Azure dependencies.
(define-public python-smart-open
  (package
   (name "python-smart-open")
   (version "5.1.0")
   (source (origin
            (method url-fetch)
            (uri (pypi-uri "smart_open" version))
            (sha256
             (base32
              "0bp9a832903zx5k9hqdjgd3ybm5zc7ry5r23wdchgvs0n9817p74"))))
   (build-system python-build-system)
   (arguments
    `(#:tests? #f
      #:phases
      (modify-phases %standard-phases
        (add-before 'check 'relax-moto-requirement
          (lambda* (#:key outputs inputs #:allow-other-keys)
            (substitute* (list "setup.py" "smart_open.egg-info/requires.txt")
              (("moto\\[server\\]==1.3.14") "moto")))))))
   (inputs
    `(("python-boto3" ,python-boto3)
      ("python-google-cloud-storage" ,python-google-cloud-storage)
      ("python-moto" ,python-moto)
      ("python-parameterizedtestcase" ,python-parameterizedtestcase)
      ("python-paramiko" ,python-paramiko)
      ("python-pathlib2" ,python-pathlib2)
      ("python-pytest" ,python-pytest)
      ("python-pytest-rerunfailures" ,python-pytest-rerunfailures)
      ("python-requests" ,python-requests)
      ("python-responses" ,python-responses)))
   (home-page "https://github.com/piskvorky/smart_open")
   (synopsis "Utilities for streaming large files")
   (description "This package provides a library for efficient streaming of
very large files from/to storages such as S3, GCS, HDFS, WebHDFS, HTTP, HTTPS,
SFTP, or local filesystem. It supports transparent, on-the-fly (de-)compression
for a variety of different formats.  This package is a drop-in replacement for
 Python's built-in @code{open()}: it can do anything @code{open()} can plus
lots of nifty extra stuff on top.")
   (license license:expat)))

(define-public python-morfessor
  (package
    (name "python-morfessor")
    (version "2.0.6")
    (source (origin
              (method url-fetch)
              (uri (pypi-uri "Morfessor" version))
              (sha256
               (base32
                "1cmsxyd7ymlqlgam9a6va0x3fqhz0w1mixj0yv2j85rl6k1flfxv"))))
    (build-system python-build-system)
    (home-page "http://morpho.aalto.fi")
    (synopsis "Morfessor")
    (description "Morfessor")
    (license license:bsd-3)))

(define-public python-torchfile
  (package
    (name "python-torchfile")
    (version "0.1.0")
    (source (origin
              (method url-fetch)
              (uri (pypi-uri "torchfile" version))
              (sha256
               (base32
                "0vhklj6krl9r0kdynb4kcpwp8y1ihl2zw96byallay3k9c9zwgd5"))))
    (build-system python-build-system)
    (home-page "https://github.com/bshillingford/python-torchfile")
    (synopsis "Torch7 binary serialized file parser")
    (description "Torch7 binary serialized file parser")
    (license license:bsd-3)))

(define-public pybind11-2.6.1
  (package (inherit pybind11)
    (name "pybind11")
    (version "2.6.1")
    (source (origin
              (method git-fetch)
              (uri (git-reference
                    (url "https://github.com/pybind/pybind11")
                    (commit (string-append "v" version))))
              (sha256
               (base32
                "1wh5b1xnywzxwxkyac2wvyqwzmy1qxs341jjk820r7b825wn6yad"))
              (file-name (git-file-name name version))))))

(define-public python-nmslib
  (package
  (name "python-nmslib")
  (version "2.1.1")
  (source (origin
            (method url-fetch)
            (uri (pypi-uri "nmslib" version))
            (sha256
             (base32
              "084wl5kl2grr2yi3bibc6i2ak5s7vanwi21wssbwd4bgfskr84lp"))))
  (build-system python-build-system)
  (propagated-inputs
   `(("python-numpy" ,python-numpy)
     ("python-psutil" ,python-psutil)
     ("pybind11" ,pybind11-2.6.1)))
  (home-page "https://github.com/nmslib/nmslib")
  (synopsis "Non-Metric Space Library (NMSLIB)")
  (description "Non-Metric Space Library (NMSLIB)")
  (license license:asl2.0)))

(define-public python-pyemd
  (package
    (name "python-pyemd")
    (version "0.5.1")
    (source (origin
              (method url-fetch)
              (uri (pypi-uri "pyemd" version))
              (sha256
               (base32
                "0w3yw014760ncm09ymbh0wnw4wwz7ph773dvvxcyaww5dw8w50gw"))))
    (build-system python-build-system)
    (propagated-inputs
     `(("python-numpy" ,python-numpy)))
    (home-page "http://github.com/wmayner/pyemd")
    (synopsis
     "Wrapper for Pele and Werman's implementation of the Earth Mover's Distance")
    (description
     "This package provides a Python wrapper for Ofir Pele and Michael Werman's
implementation of the Earth Mover's Distance.")
    (license license:expat)))

(define-public python-visdom
  (package
  (name "python-visdom")
  (version "0.1.8.9")
  (source (origin
            (method url-fetch)
            (uri (pypi-uri "visdom" version))
            (sha256
             (base32
              "09kiczx2i5asqsv214fz7sx8wlyldgbqvxwrd0alhjn24cvx4fn7"))))
  (build-system python-build-system)
  (propagated-inputs
   `(("python-jsonpatch" ,python-jsonpatch)
     ("python-numpy" ,python-numpy)
     ("python-pillow" ,python-pillow)
     ("python-pyzmq" ,python-pyzmq)
     ("python-requests" ,python-requests)
     ("python-scipy" ,python-scipy)
     ("python-six" ,python-six)
     ("python-torchfile" ,python-torchfile)
     ("python-tornado" ,python-tornado)
     ("python-websocket-client" ,python-websocket-client)))
  (home-page "https://github.com/facebookresearch/visdom")
  (synopsis "Visualize live, rich data for Torch and Numpy")
  (description "This package provides tools for visualizing live, rich data
for @code{Torch} and @code{Numpy}.")
  (license license:asl2.0)))

;; This package bundles 'multibuild'.
(define-public python-gensim
  (package
    (name "python-gensim")
    (version "4.0.1")
    (source (origin
              (method url-fetch)
              (uri (pypi-uri "gensim" version))
              (sha256
               (base32
                "1r5617m58xv6s5zha69pngzkkzvs1xg661lf0a28d5ln4xbbkl5l"))))
    (build-system python-build-system)
    (arguments
     `(#:tests? #f)) ; Tests need an outdated version of Morfessor.
    (propagated-inputs
     `(("python-numpy" ,python-numpy)
       ("python-scipy" ,python-scipy)
       ("python-smart-open" ,python-smart-open)))
    (native-inputs
     `(("python-cython" ,python-cython)
       ("python-levenshtein" ,python-levenshtein)
       ("python-mock" ,python-mock)
       ;("python-morfessor" ,python-morfessor)
       ("python-nmslib" ,python-nmslib)
       ("python-pyemd" ,python-pyemd)
       ("python-pytest" ,python-pytest)
       ("python-testfixtures" ,python-testfixtures)
       ("python-visdom" ,python-visdom)))
    (home-page "https://radimrehurek.com/gensim/")
    (synopsis "Topic modelling for humans")
    (description "This package provides a Python library for topic modelling,
document indexing and similarity retrieval with large corpora.  The target
audience is the natural language processing and information retrieval
community.")
    (license license:lgpl2.1)))

(define-public python-parabam
  (package
    (name "python-parabam")
    (version "2.3.1")
    (source (origin
              (method url-fetch)
              (uri (pypi-uri "parabam" version))
              (sha256
               (base32
                "1iacm5vdk5xhra6xv4hzf9p9rjxc0w1mxw3ffi4g30n9wkfl6dkn"))))
    (build-system python-build-system)
    ;; Tests need 'argparse', but that's in the standard library.
    (arguments
     `(#:tests? #f))
    (propagated-inputs
     `(("python-numpy" ,python-numpy)
       ("python-pysam" ,python-pysam)))
    (home-page "")
    (synopsis "Parallel BAM File Analysis")
    (description "Parallel BAM File Analysis")
    (license license:gpl3)))

(define-public python-telomerecat
  (package
    (name "python-telomerecat")
    (version "3.4.0")
    (source (origin
              (method url-fetch)
              (uri (pypi-uri "telomerecat" version))
              (sha256
               (base32
                "1i59jdflc0m5kyq4b1brvvcyq6iid39pv3yw39w264i007yqgg0d"))))
    (build-system python-build-system)
    ;; Tests need 'argparse', but that's in the standard library.
    (arguments
     `(#:tests? #f))
    (propagated-inputs
     `(("python-numpy" ,python-numpy)
       ("python-pandas" ,python-pandas)
       ("python-parabam" ,python-parabam)
       ("python-pysam" ,python-pysam)))
    (home-page "https://pypi.org/project/telomerecat/")
    (synopsis "Telomere Computational Analysis Tool")
    (description "Telomerecat is a tool for estimating the average
telomere length for a paired end, whole genome sequencing sample.")
    (license license:gpl3)))

;; This package seems to only work with Python 2.
(define-public telomerehunter
  (package
    (name "telomerehunter")
    (version "1.1.0")
    (source (origin
              (method url-fetch)
              ;; There is no tarball or zip file.
              (uri (string-append
                    "https://files.pythonhosted.org/packages/e5/67/"
                    "ce6ac292a88a078a733dc3d9adb3f153834692effbf0851"
                    "b93a6f3e49b7a/telomerehunter-1.1.0-py2-none-any.whl"))
              (sha256
               (base32
                "1055z4hs2hhsfwqnjm0kffkhh6ag041mp6l13i2gs5454xk02nwi"))))
    (build-system python-build-system)
    (arguments
     `(#:tests? #f
       #:phases
       (modify-phases %standard-phases
         (replace 'unpack
           (lambda* (#:key inputs #:allow-other-keys)
             (let ((unzip (string-append (assoc-ref inputs "unzip")
                                         "/bin/unzip")))
               (system* unzip (assoc-ref %build-inputs "source")))))
         (replace 'build
           (lambda* (#:key inputs outputs #:allow-other-keys)
             (let* ((out            (assoc-ref outputs "out"))
                    (python-version (python-version
                                     (assoc-ref inputs "python")))
                    (python-libdir  (string-append
                                     (assoc-ref outputs "out")
                                     "/lib/python" python-version
                                     "/site-packages"))
                    (site-dir (string-append python-libdir "/telomerehunter"))
                    (bindir   (string-append out "/bin")))
               (substitute* "telomerehunter/run_plot.sh"
                 (("R --no-save") (string-append (assoc-ref inputs "r") "/bin/R --no-save")))
               (substitute* (list "telomerehunter/filter_telomere_reads.py"
                                  "telomerehunter/normalize_TVR_counts.R")
                 (("samtools ") (string-append (assoc-ref inputs "samtools") "/bin/samtools ")))
               (mkdir-p python-libdir)
               (copy-recursively "telomerehunter" site-dir)
               (mkdir-p bindir)
               (mkdir-p (string-append (assoc-ref outputs "out") "/site-library"))
               (substitute* "telomerehunter-1.1.0.data/scripts/telomerehunter"
                 (("#!python") (string-append
                                "#!" (assoc-ref inputs "python") "/bin/python3")))
               (install-file "telomerehunter-1.1.0.data/scripts/telomerehunter" bindir)
               (wrap-program (string-append bindir "/telomerehunter")
                 `("PYTHONPATH" ":" prefix (,bindir ,(getenv "PYTHONPATH")
                                                    ,site-dir))))))
         (delete 'install))))
    (inputs
     `(("unzip" ,unzip)
       ("samtools" ,samtools)
       ("python" ,python)))
    (propagated-inputs
     `(("r" ,r)
       ("python-pypdf2", python2-pypdf2)
       ("python-numpy", python2-numpy)
       ("python-pysam", python2-pysam)
       ("r-ggplot2", r-ggplot2)
       ("r-reshape2", r-reshape2)
       ("r-gridextra", r-gridextra)
       ("r-rcolorbrewer" ,r-rcolorbrewer)
       ("r-cowplot", r-cowplot)
       ("r-svglite", r-svglite)
       ("r-dplyr", r-dplyr)))
    (native-search-paths
     (list (search-path-specification
            (variable "R_LIBS_SITE")
            (files (list "site-library/")))))
    (home-page "http://pypi.python.org/pypi/telomerehunter/")
    (synopsis "Estimation of Telomere Content from WGS Data")
    (description "TelomereHunter extracts, sorts and analyses telomeric reads
from WGS Data. It is designed to take BAM files from a tumor and/or a control
sample as input. The tool was developed at the German Cancer Research Center.")
    (license license:gpl3+)))
