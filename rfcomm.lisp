(in-package :sb-bluez)

(defclass rfcomm-socket (sb-bsd-sockets:socket)
  ((family :initform af-bluetooth))
  (:documentation "Class representing RFCOMM bluetooth sockets (AF_BLUETOOTH)."))

(defmethod socket-namestring ((socket rfcomm-socket))
  (ignore-errors (socket-name socket)))

(defmethod socket-peerstring ((socket rfcomm-socket))
  (ignore-errors (socket-peername socket)))

(defun string-to-bdaddr (bdaddrstr)
  (multiple-value-bind (retval bdaddr) (string-to-bdaddr-int bdaddrstr)
    bdaddr))

(defmethod make-sockaddr-for ((socket rfcomm-socket) &optional sockaddr &rest address)
  (let ((address (first address))
        (channel (second address))
        (sockaddr (or sockaddr (allocate-sockaddr-rc))))
    (setf (sockaddr-rc-family sockaddr) af-bluetooth)
    (when (and address channel)
      (setf (sockaddr-rc-channel sockaddr) channel)
      (setf (sockaddr-rc-bdaddr sockaddr) (string-to-bdaddr address)))
    sockaddr))

(defmethod free-sockaddr-for ((socket rfcomm-socket) sockaddr)
  (free-sockaddr-rc sockaddr))

(defmethod size-of-sockaddr ((socket rfcomm-socket))
  size-of-sockaddr-rc)

(defmethod bits-of-sockaddr ((socket rfcomm-socket) sockaddr)
  "Return the address of the RFCOMM socket."
  (let ((name (sockaddr-rc-bdaddr sockaddr)))
    (unless (zerop (length name))
      name)))
