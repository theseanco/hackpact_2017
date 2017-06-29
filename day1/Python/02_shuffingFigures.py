# using sys because print writes a newline and i want something a bit faster than that.
import time
from random import shuffle
import sys

i = 0

# this needs to be recast as a list and shuffled around

def shuffle_word(word):
    word = list(word)
    shuffle(word)
    return ''.join(word)

string = 'string                                                   '

while True:
    sys.stdout.write(shuffle_word(string))
    sys.stdout.flushw
    time.sleep(0.003)
