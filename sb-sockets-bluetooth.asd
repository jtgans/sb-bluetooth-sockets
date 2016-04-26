;;; -*- lisp -*-

(defsystem :sb-sockets-bluetooth
    :version "0.1"
    :defsystem-depends-on (sb-grovel sb-bsd-sockets)
    :components
    ((:sb-grovel-constants-file "grovel-constants"
                                :package :sockint)
     (:file "rfcomm" :depends-on ("grovel-constants")))
    :perform (load-op :after (o c) (provide 'sb-sockets-bluetooth)))
