# January 2020 Mistakes, Improvements, Learning and Stuff

First month at Storypark!!

## Finding computers local IP address

<https://en.wikipedia.org/wiki/Ifconfig>

```bash
ifconfig
# got a long list of things

ifconfig | grep inet
# used to narrow it down

>
  inet 127.0.0.1 netmask 0xff000000
  inet6 ::1 prefixlen 128
  inet6 fe80::1%lo0 prefixlen 64 scopeid 0x1
  inet6 fe80::aede:48ff:fe00:1122%en5 prefixlen 64 scopeid 0x4
  inet6 fe80::c13:e5d9:2903:b57d%en0 prefixlen 64 secured scopeid 0x6
  inet 192.168.1.19 netmask 0xffffff00 broadcast 192.168.1.255
  inet6 fe80::fcf5:8aff:fe13:4d08%awdl0 prefixlen 64 scopeid 0x8
  inet6 fe80::fcf5:8aff:fe13:4d08%llw0 prefixlen 64 scopeid 0x9
  inet6 fe80::7e58:d1c6:e4f3:f22f%utun0 prefixlen 64 scopeid 0xf
  inet6 fe80::7379:be3d:3948:ddff%utun1 prefixlen 64 scopeid 0x10
  inet6 fe80::298d:1af6:fab:75be%utun2 prefixlen 64 scopeid 0x11
  inet6 fe80::be35:c94d:bb71:e422%utun3 prefixlen 64 scopeid 0x12
```

This line `inet 192.168.1.19 netmask 0xffffff00 broadcast 192.168.1.255` is where we can find it - `192.168.1.19`.

Also can be found under `Systems Preferences -> Network -> Advanced -> TCP/IP -> IPv4 Address`
