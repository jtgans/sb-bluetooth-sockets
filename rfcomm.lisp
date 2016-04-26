(in-package :sb-bluez)

(defclass rfcomm-socket (sb-bsd-sockets:socket)
  ((sb-bsd-sockets::family :initform af-bluetooth))
  (:documentation "Class representing RFCOMM bluetooth sockets (AF_BLUETOOTH)."))

(defmethod sb-bsd-sockets::socket-namestring ((socket rfcomm-socket))
  (ignore-errors (socket-name socket)))

(defmethod sb-bsd-sockets::socket-peerstring ((socket rfcomm-socket))
  (ignore-errors (socket-peername socket)))

(defun string-to-bdaddr (bdaddrstr)
  (multiple-value-bind (retval bdaddr) (string-to-bdaddr-int bdaddrstr)
    bdaddr))

(defmethod sb-bsd-sockets::make-sockaddr-for ((socket rfcomm-socket) &optional sockaddr &rest address)
  (let ((address (first address))
        (channel (second address))
        (sockaddr (or sockaddr (allocate-sockaddr-rc))))
    (setf (sockaddr-rc-family sockaddr) af-bluetooth)
    (when (and address channel)
      (setf (sockaddr-rc-channel sockaddr) channel)
      (setf (sockaddr-rc-bdaddr sockaddr) (string-to-bdaddr address)))
    sockaddr))

(defmethod sb-bsd-sockets::free-sockaddr-for ((socket rfcomm-socket) sockaddr)
  (free-sockaddr-rc sockaddr))

(defmethod sb-bsd-sockets::size-of-sockaddr ((socket rfcomm-socket))
  size-of-sockaddr-rc)

(defmethod sb-bsd-sockets::bits-of-sockaddr ((socket rfcomm-socket) sockaddr)
  "Return the address of the RFCOMM socket."
  (let ((name (sockaddr-rc-bdaddr sockaddr)))
    (unless (zerop (length name))
      name)))
