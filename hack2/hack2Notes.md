# Hack 2 - Brickternate Reality

An alternate reality headset that is a brick. Inspired by my 'Brick of Internet' project.

An alternate reality headset that is unwearable, and the visualisation is super cumbersome.

Inspired by [_this tweet_](https://twitter.com/CEOSleepout/status/877812107168763904), a tweet showing 'Our Sydney CEOs using virtual reality to get a glimpse of the realities faced by the people who experience [homelessness] everyday. '

It's a brick that contains a magnetometer, and screens, as well as audio speakers.

The screens will show writing about VR, and the speakers will play a 'soundscape'
One screen will show writing about

First I need to get screens working with Arduino:

https://forum.arduino.cc/index.php?topic=369998.0

This instructables seems to be worth a shot

http://www.instructables.com/id/Monochrome-096-i2c-OLED-display-with-arduino-SSD13/

This works, and has been saves as a working example in the hack directory

I did need to change the header file though, to add the proper screen resolutio

There's also an example with text here http://www.instructables.com/id/Arduino-OLED-096-IIC-Serial-128X64-Display-Setting/

John's VR experience
- They immobilse you
- They create an individual rather than collective experience

90s 00s anti-new media art writing re-emphasising the heft of the material world

Resistance comes from the latin - a thing - '' a reality

I'm going to intall Platformio, because I really hate the Arduino IDE, and i wouldn't mind being able to edit from within Atom

http://docs.platformio.org/en/latest/installation.html

NOTE: Platformio only compiles src scripts from the first level of the home dir.

So the screens work, how do i now make it direction-dependent?

Googled 'How does VR work'

> 'Head tracking means that when you wear a VR headset, the picture in front of you shifts as you look up, down and side to side or angle your head. A system called 6DoF (six degrees of freedom) plots your head in terms of your X, Y and Z axis to measure head movements forward and backwards, side to side and shoulder to shoulder, otherwise known as pitch, yaw and roll.'

Okay, fine. Think i can use an accelgyro for this.

I have a whole bunch of Accelgyros handy. I'll download the i2cdevlib MPU6050 library.

Actually maybe a compass is better here. It's actually more connected to physical space - hence the brick(?)

The magnetometer works with the screen nicely. Now I need to gather some quotes.

These will be listed in 'WishfulThinking.md'

A trio of screens would be nice

Wishful Thinking | Problem | Criticism
