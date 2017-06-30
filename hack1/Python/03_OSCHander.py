# A separate script to print paragraphs from programs in another terminal window
# this is run in tandem with a larger script which controls Arduino switching
# To be run in a second terminal window

import os, random, time, sys, OSC, threading, re

#declaring OSC Addresses
receive2_address = '127.0.0.1', 9998 #Mac Adress, Outgoing Port
# Initialize the OSC server and the client.
s = OSC.OSCServer(receive2_address)
s.addDefaultHandlers()

global patternString
patternString = '43248'


# Exception class (nopt used)
class PiException(Exception):
	def __init__(self, value):
		self.value = value
	def __str__(self):
		return repr(self.value)

def OSCMessageReceive(add, tags, stuff, source):
	global patternString
	print(stuff)
	patternString = stuff[0]


s.addMsgHandler("/string",OSCMessageReceive)

# just checking which handlers we have added
print "Registered Callback-functions are :"
for addr in s.getOSCAddressSpace():
	print addr

# Start OSCServer
print "\nStarting OSCServer. Use ctrl-C to quit."
st = threading.Thread( target = s.serve_forever )
st.start()

# Loop while threads are running.
try :
	global patternString
	while 1 :
		sys.stdout.write(patternString)
        sys.stdout.flush()
        time.sleep(0.03)


except KeyboardInterrupt :
	print "\nClosing OSCServer."
	s.close()
	print "Waiting for Server-thread to finish"
	st.join()
	print "Done"
