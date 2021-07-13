#!/bin/zsh
date_cmd="date +"%B_%d_%Y""

tshark -D

read "interface?Enter interface id# above to capture SSL traffic on: "
echo ""
echo "NOTE: this program will capture traffic over TCP 80,444 and QUIC."
echo "NOTE: the capture will capture traffic for this domain (and corresponding IP) ONLY."
echo ""
read "domain?Enter URL to monitor: "

fulldir=~/investigations/$(eval $date_cmd)/$subject

pcap=$fulldir/$domain.pcapng

mkdir -p $fulldir

keyfile=$fulldir/key.log

export SSLKEYLOGFILE=$fulldir/key.log

echo "************************** Investigation Project **************************"
echo "                               Initialized                                 "
echo "*      Current Subject:				$domain"
echo "*      Project Directory:			$fulldir"
echo "*      Setting SSLKEYLOGFILE			$keyfile"
echo "*      Capture Interface ID is Set To		$interface"
echo "*      Starting and saving Tshark Capture to	$pcap"
echo "*"
echo "*      WARNING: THE TSHARK WILL END IN 60 SECONDS"
echo "***************************************************************************"
echo "Project initalized, starting capture, opening Firefox Developer Edition.."

open -n /Applications/Firefox\ Developer\ Edition.app --args $domain

tshark -i $interface -a duration:60 -o tls.keylog_file:$keyfile -w $pcap tcp port 80 or tcp port 443 or udp port 443 and \(dst $domain or src $domain\)

tshark -r $pcap -q -o "tls.debug_file:$fulldir/ssl_wireshark_debug.txt" -o "tls.keylog_file:$keyfile" -o "tls.desegment_ssl_records: TRUE" -o "tls.desegment_ssl_application_data: TRUE" -z conv,ip -z expert -z http,stat -z http_req,tree -z http_srv,tree -z http,tree -z http2,tree > $fulldir/http_analysis.txt

echo "***************************  CAPTURE COMPLETE *****************************"
echo "      HTTP analysis saved into "http_analysis.txt" in Project Dir"
echo "***************************************************************************" 
