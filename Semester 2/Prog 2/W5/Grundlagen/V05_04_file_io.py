# -*- coding: utf-8 -*-
"""
PROG2 V05-04: file I/O repetition

output:
* 1st call: "hello"
* 2nd call: "hellohello"
* ...
"""

# open file for read + write access
f = open('myfile.txt', 'a+')
# a: append if file exists, otherwise create file
# +: also support reading

f.write('hello')

# to get content: go back to start of file
f.seek(0)

print(f.read())

# close file properly
f.close()
