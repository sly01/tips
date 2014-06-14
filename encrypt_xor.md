#!/usr/bin/env python

from itertools import izip, cycle
import base64

def xor_crypt_string(data, key='myprivatekey', encode=False, decode=False):
        if decode:
                data = base64.decodestring(data)
        xored = ''.join(chr(ord(x) ^ ord(y)) for (x,y) in izip(data, cycle(key)))
        if encode:
                return base64.encodestring(xored).strip()
                return xored
 

secret_data = 'fatih'
print xor_crypt_string(secret_data, encode=True) 
#print xor_crypt_string(xor_crypt_string(secret_data, encode=True), decode=True)
