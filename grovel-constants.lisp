("sys/socket.h"
 #+linux "bluetooth/bluetooth.h"
 #+linux "bluetooth/rfcomm.h")

(#+linux (:integer af-bluetooth "AF_BLUETOOTH" "Bluetooth Address Family")
 #+linux (:integer btproto-rfcomm "BTPROTO_RFCOMM" "Bluetooth RFCOMM Connection Type")
 
 #+linux (:structure sockaddr-rc ("struct sockaddr_rc"
                                  (integer family "sa_family_t" "rc_family")
                                  ((array (unsigned 8) 6) bdaddr "bdaddr_t" "rc_bdaddr")
                                  ((unsigned 8) channel "uint8_t" "rc_channel")))

 #+linux (:function host-to-bt-short ("htobs" unsigned-short (num unsigned-short)))
 #+linux (:function bt-to-host-short ("btohs" unsigned-short (num unsigned-short)))
 #+linux (:function host-to-bt-int ("htobl" unsigned-int (num unsigned-int)))
 #+linux (:function bt-to-host-int ("btohl" unsigned-int (num unsigned-int)))
 #+linux (:function string-to-bdaddr-int ("str2ba" integer
                                               (str c-string)
                                               (ba (array unsigned-char 6) :out))))
