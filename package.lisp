(defpackage "SB-BLUEZ"
  (:use "COMMON-LISP" "SB-ALIEN" "SB-EXT" "SB-BSD-SOCKETS")
  (:documentation
   "A thinly-disguised BlueZ API for SBCL. Ideas blatantly stolen from the
SBCL sb-bsd-socket API.

Sockets for RFCOMM and L2CAP are represented as sb-bsd-socket inheriting
CLOS objects, while the SDP API is exposed to carefully control the amount
of memory allocation done to expose new services.

Bluetooth addresses are accepted as strings and internally converted to
their native bdaddr_t form.")
  (:export rfcomm-socket
           bdaddr-any)
  (:import-from sb-bsd-sockets
                socket-namestring
                socket-peerstring
                make-sockaddr-for
                free-sockaddr-for
                size-of-sockaddr
                bits-of-sockaddr))

;; Force load libbluetooth.so, otherwise we don't get our C native functions.
(eval-when (:compile-toplevel :load-toplevel :execute)
  (sb-alien:load-shared-object "libbluetooth.so"))
