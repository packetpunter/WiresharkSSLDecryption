# A capture tool for TLS Traffic Analysis in Wireshark
This tool sets an SSLKEYLOG file for Firefox to consume for storing temporary SSL/TLS keys for HTTPS sessions in Firefox.
The file is relevant for wireshark to decrypt the TLS transactions, so we may run performance analysis on the HTTP streams.
This tool will setup the key log file, start the capture for 60 seconds, and open firefox developer edition to the URL the specified website for analysis. It assumes the directory will be ~/investigations and makes directories based off Date and URL that is being investigated.

## Run on MacOS
The script will run as follows in the newly default ZSH shell:
```bash
----------------------------------------------------------------------------------------------------------------------------------
~/code/Wireshark-SSLDecrypt-MacOS(main*) » ./start-capture-macos.zsh                                                 blue@mjolnir
1. en0 (Ethernet)
2. llw0
3. utun0
4. ap1
5. utun1
6. utun2
7. utun3
8. utun4
9. lo0 (Loopback)
10. anpi0
11. bridge0 (Thunderbolt Bridge)
12. anpi1
13. en1 (Wi-Fi)
14. en2 (Thunderbolt 1)
15. en3 (Thunderbolt 2)
16. en5 (Ethernet Adaptor (en5))
17. en6 (Ethernet Adaptor (en6))
18. en7 (USB 10/100/1000 LAN)
19. gif0
20. stf0
21. awdl0
22. ciscodump (Cisco remote capture)
23. randpkt (Random packet generator)
24. sshdump (SSH remote capture)
25. udpdump (UDP Listener remote capture)
Enter interface id# above to capture SSL traffic on: 1

NOTE: this program will capture traffic over TCP 80,444 and QUIC.
NOTE: the capture will capture traffic for this domain (and corresponding IP) ONLY.

Enter URL to monitor: www.reddit.com
************************** Investigation Project **************************
                               Initialized
*      Current Subject:				www.reddit.com
*      Project Directory:			/Users/blue/investigations/July_13_2021/www.reddit.com
*      Setting SSLKEYLOGFILE			/Users/blue/investigations/July_13_2021/www.reddit.com/key.log
*      Capture Interface ID is Set To		1
*      Starting and saving Tshark Capture to	/Users/blue/investigations/July_13_2021/www.reddit.com/www.reddit.com.pcapng
*
*      WARNING: THE TSHARK WILL END IN 60 SECONDS
***************************************************************************
Project initalized, starting capture, opening Firefox Developer Edition..
Capturing on 'Ethernet: en0'
2554
***************************  CAPTURE COMPLETE *****************************
      HTTP analysis saved into http_analysis.txt in Project Dir
***************************************************************************
```

## Output Files
An example from MacOS:
```bash
~/investigations/July_13_2021 » ll                                                                                                                                                                                           blue@mjolnir
total 51760
-rw-r--r--  1 blue  staff   7.2K Jul 13 08:59 http_analysis.txt
-rw-r--r--@ 1 blue  staff    43K Jul 13 09:08 key.log
-rw-r--r--  1 blue  staff    23M Jul 13 08:59 ssl_wireshark_debug.txt
-rw-------  1 blue  staff   1.9M Jul 13 08:59 www.reddit.com.pcapng
```
