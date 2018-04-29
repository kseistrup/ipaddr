# ipaddr

Exposes Python's IP address API to the CLI

## Examples

The **`ip.x`** scripts take one or more IP addresses as arguments and prints the result to standard output.

```sh
$ ip.compressed fd54:0032:0000:0000:0000:0000:0000:0001
fd54:32::1
$ ip.exploded fd54:32::1
fd54:0032:0000:0000:0000:0000:0000:0001
$ ip.max_prefixlen 127.0.0.1
32
$ ip.max_prefixlen ::1
128
$ ip.rptr 1.2.3.4
4.3.2.1.in-addr.arpa
$ ip.rptr 2620:0:ccd::2
2.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.d.c.c.0.0.0.0.0.0.2.6.2.ip6.arpa
$ ip.version 1.1.1.1
4
$ ip.version fe80::1
6
```

The **`ip.is_x`** scripts take a single IP address as rgument, prints ‘true’ or ‘false’ on standard output and exits accordingly.

```sh
$ ip.is_global 8.8.4.4
true
$ ip.is_ipv4 127.0.0.1
true
$ ip.is_ipv6 127.0.0.1
false
$ ip.is_link_local fe80::1
true
$ ip.is_loopback ::1
true
$ ip.is_multicast 224.1.2.3
true
$ ip.is_private fc53:dcc5:e89d:9082:4097:6622:5e82:c654
true
$ ip.is_reserved fe00::1
true
```

## Requirements

Python 3.4+

:smile:
