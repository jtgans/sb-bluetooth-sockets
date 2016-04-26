;;; -*- lisp -*-

(defsystem :sb-bluez
  :version "0.2"
  :defsystem-depends-on (sb-grovel sb-bsd-sockets)
  :components
  ((:file "package")
   (:sb-grovel-constants-file "grovel-constants" :depends-on ("package") :package :sb-bluez)
   (:file "constants" :depends-on ("package"))
   (:file "rfcomm"    :depends-on ("grovel-constants" "constants")))
  :perform (load-op :after (o c) (provide 'sb-bluez)))
