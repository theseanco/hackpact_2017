import OSC

while True:
    patternInput = raw_input("Pattern String:   ")
    c = OSC.OSCClient()
    c.connect(('127.0.0.1', 9998))   # localhost, port 57120
    oscmsg = OSC.OSCMessage()
    oscmsg.setAddress("/string")
    oscmsg.append(patternInput)
    c.send(oscmsg)
