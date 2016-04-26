(in-package :sb-bsd-sockets)

(declaim (debug 2))

(eval-when (:compile-toplevel :load-toplevel :execute)
  (defclass rfcomm-socket (socket)
    ((family :initform sockint::af-bluetooth))
    (:documentation
     "Class representing RFCOMM bluetooth sockets (AF_BLUETOOTH).")))

(defmethod socket-namestring ((socket rfcomm-socket))
  (ignore-errors (socket-name socket)))

(defmethod socket-peerstring ((socket rfcomm-socket))
  (ignore-errors (socket-peername socket)))

(defun string-to-bdaddr (bdaddrstr)
  (multiple-value-bind (retval bdaddr) (sockint::string-to-bdaddr-int bdaddrstr)
    bdaddr))

(defconstant bdaddr-any "00:00:00:00:00:00")

(defmethod make-sockaddr-for ((socket rfcomm-socket) &optional sockaddr &rest address)
  (let ((address (first address))
        (channel (second address))
        (sockaddr (or sockaddr (sockint::allocate-sockaddr-rc))))
    (setf (sockint::sockaddr-rc-family sockaddr) sockint::af-bluetooth)
    (when (and address channel)
      (setf (sockint::sockaddr-rc-channel sockaddr) channel)
      (setf (sockint::sockaddr-rc-bdaddr sockaddr) (string-to-bdaddr address)))
    sockaddr))

(defmethod free-sockaddr-for ((socket rfcomm-socket) sockaddr)
  (sockint::free-sockaddr-rc sockaddr))

(defmethod size-of-sockaddr ((socket rfcomm-socket))
  sockint::size-of-sockaddr-rc)

(defmethod bits-of-sockaddr ((socket rfcomm-socket) sockaddr)
  "Return the address of the RFCOMM socket."
  (let ((name (sockint::sockaddr-rc-bdaddr sockaddr)))
    (unless (zerop (length name))
      name)))

(eval-when (:compile-toplevel :load-toplevel :execute)
  (sb-alien:load-shared-object "libbluetooth.so"))

(eval-when (:compile-toplevel :load-toplevel)
  (export (find-symbol "RFCOMM-SOCKET" 'sb-bsd-sockets))
  (export (find-symbol "BDADDR-ANY" 'sb-bsd-sockets)))
