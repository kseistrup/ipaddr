#!/usr/bin/env python3
# -*- mode: python; coding: utf-8 -*-
"""
Usage: ip.x [OPTIONS] [IP_ADDRESS [IP_ADDRESS …]]

positional arguments:
  IP_ADDRESS       IPv4 or IPv6 address, or integer

optional arguments:
  -h, --help       show this help message and exit
  -v, --version    show version information and exit
  -c, --copyright  show copying policy and exit

The program takes one or more IP addresses as its arguments(s) and
prints the result on standard output.

If no addresses are provided on the commandline, the program will
read from standard input.
"""
##############################################################################
# This program is free software; you can redistribute it and/or modify it    #
# under the terms of the GNU General Public License as published by the Free #
# Software Foundation; either version 3 of the License, or (at your option)  #
# any later version.                                                         #
#                                                                            #
# This program is distributed in the hope that it will be useful, but with-  #
# out any warranty; without even the implied warranty of merchantability or  #
# fitness for a particular purpose. See the GNU General Public License for   #
# more details.  <http://gplv3.fsf.org/>                                     #
##############################################################################

import sys
import os
import pathlib
import argparse
import pprint
import ipaddress

try:
    from locale import (Error, setlocale, LC_ALL)
    _ = setlocale(LC_ALL, '')
except (ImportError, NameError, Error):
    pass

__author__ = 'Klaus Alexander Seistrup <klaus@seistrup.dk>'
__revision__ = '2018-04-29'
__version__ = '0.0.3 ({})'.format(__revision__)
__copyright__ = """\
ip.x {}
Copyright © 2016-18 Klaus Alexander Seistrup <klaus@seistrup.dk>

This is free software; see the source for copying conditions. There is no
warranty; not even for merchantability or fitness for a particular purpose.\
""".format(__version__)

DEBUG = os.environ.get('DEBUG', 'False')[0].upper() in '1JTY'  # 1/Ja/True/Yes

EPILOG = """\
The program takes one or more IP addresses as its arguments(s) and
prints the result on standard output.

If no addresses are provided on the commandline, the program will
read from standard input.\
"""


def die(message=None):
    """ Exit gracefully"""
    if message:
        print(message, file=sys.stderr)
    sys.exit(1 if message else 0)


def debug(head, data):
    """Possibly pretty print an object to stderr"""
    if DEBUG:
        pprint.pprint({head: data}, stream=sys.stderr)


def main(progname='ip.x'):
    """Main entry point"""

    debug('argv', sys.argv)

    parser = argparse.ArgumentParser(
        prog=progname,
        formatter_class=argparse.RawTextHelpFormatter,
        epilog=EPILOG
    )
    parser.add_argument('-v', '--version', action='version',
                        version='%(prog)s/{}'.format(__version__),
                        help='show version information and exit')
    parser.add_argument('-c', '--copyright', action='version',
                        version=__copyright__,
                        help='show copying policy and exit')
    parser.add_argument('IP_ADDRESS', nargs='*',
                        help='IPv4 or IPv6 address')

    args = parser.parse_args()
    debug('args', args)

    transform = {
        "ip.compressed": lambda ip: ip.compressed,
        "ip.exploded": lambda ip: ip.exploded,
        "ip.max_prefixlen": lambda ip: ip.max_prefixlen,
        "ip.rptr": lambda ip: ip.reverse_pointer,
        "ip.version": lambda ip: ip.version
    }.get(progname, None)

    if transform is None:
        die('please call as ip.{compressed,exploded,rptr}')

    addresses = args.IP_ADDRESS or sys.stdin.read().split()

    for addr in addresses:
        try:
            ipvx = ipaddress.ip_address(
                int(addr) if addr.isdigit() else addr
            )
        except ValueError as error:
            die(str(error))
        print(transform(ipvx))

    return 0


if __name__ == '__main__':
    sys.exit(main(pathlib.Path(sys.argv[0]).name))

# eof
