# using sys because print writes a newline and i want something a bit faster than that.
import time
import sys

i = 0

string = '3   rwe h  h    a   t w   oo    sm    rn  $  !)  ~~~}[   .>>]'

while True:
    sys.stdout.write(string)
    sys.stdout.flush()
