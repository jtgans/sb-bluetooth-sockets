("sys/socket.h"
 "bluetooth/bluetooth.h"
 "bluetooth/hci.h"
 "bluetooth/hci_lib.h"
 "bluetooth/rfcomm.h"
 "bluetooth/l2cap.h"
 "bluetooth/sdp.h"
 "bluetooth/sdp_lib.h")

(;;(:integer ireq-cache-flush "IREQ_CACHE_FLUSH" "Inquery Request Flush Cache flag")
 (:integer af-bluetooth   "AF_BLUETOOTH"   "Bluetooth Address Family")
 (:integer btproto-rfcomm "BTPROTO_RFCOMM" "Bluetooth RFCOMM connection protocol")
 ;;(:integer btproto-l2cap  "BTPROTO_L2CAP"  "Bluetooth L2CAP connection protocol")
 ;;(:integer sock-seqpacket "SOCK_SEQPACKET" "Sequential packet type")

 ;; HCI-related stuff for discovery of remote devices
 ;; (:structure inquiry-info ("inquiry_info"))
 ;; (:function hci-get-route (integer (something c-string)))
 ;; (:function hci-open-dev (integer (device-id integer)))
 ;; (:function hci-inquiry (integer (dev-id integer)
 ;;                                 (len integer)
 ;;                                 (max-rsp integer)
 ;;                                 (something c-string)
 ;;                                 (array inquiry-info)
 ;;                                 (flags integer)))
 ;; (:function hci-read-remote-name (integer (sock integer)
 ;;                                          (bdaddr bdaddr_t)
 ;;                                          (size size-t)
 ;;                                          (name c-string :out)
 ;;                                          (flags integer)))

 ;; BlueZ-specific sockaddr struct for L2CAP.
 ;; (:structure sockaddr-l2 ("struct sockaddr_l2"
 ;;                          (integer family "sa_family_t" "rc_family")
 ;;                          ((array (unsigned 8) 6) bdaddr "bdaddr_t" "rc_bdaddr")
 ;;                          ((unsigned 8) channel "uint8_t" "rc_channel")))

 ;; BlueZ-specific sockaddr struct for RFCOMM.
 (:structure sockaddr-rc ("struct sockaddr_rc"
                          (integer family "sa_family_t" "rc_family")
                          ((array (unsigned 8) 6) bdaddr "bdaddr_t" "rc_bdaddr")
                          ((unsigned 8) channel "uint8_t" "rc_channel")))

 (:function host-to-bt-short ("htobs" unsigned-short (num unsigned-short)))
 (:function bt-to-host-short ("btohs" unsigned-short (num unsigned-short)))
 (:function host-to-bt-int ("htobl" unsigned-int (num unsigned-int)))
 (:function bt-to-host-int ("btohl" unsigned-int (num unsigned-int)))
 (:function string-to-bdaddr-int ("str2ba" integer
                                           (str c-string)
                                           (ba (array unsigned-char 6) :out)))
 ;; (:function bdaddr-to-string-int ("ba2str" integer
 ;;                                           (ba (array unsigned-char 6))
 ;;                                           (str c-string :out)))
 

 ;; (:function sdp-connect ("sdp_connect" "sdp_session_t"
 ;;                                       (bdaddr c-string)
 ;;                                       (target (array unsigned-char 6))
 ;;                                       ()))
 )
