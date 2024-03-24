# -*- coding: utf-8 -*-
"""
PROG2 V05-05: file I/O options
"""

f = open('myfile.doc', 'wb+')           # 'b' for binary mode
f.write(b'text converted to binary')    # note the 'b' prefix
f.write(b'\x34\x99')                    # arbitrary data
f.seek(2)                               # jump to position
f.read(2)                               # read 2 bytes
f.close()                               # never forget this
