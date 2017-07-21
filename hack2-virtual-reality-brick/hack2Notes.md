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

Actually maybe a compass is better here. It's adatalogctually more connected to physical space - hence the brick(?)

The magnetometer works with the screen nicely. Now I need to gather some quotes.

These will be listed in 'WishfulThinking.md'

A trio of screens would be nice

Wishful Thinking | Problem | Criticism

These are listed as such as markdown files in the repo

These are also listed on the Arduino SD card as

wrong | reality | criticism

\*.txt

I need a shell script to split these markdown files by line and then read them to the Arduino, rather than have the Arduino do the parsing.

----

Potential browser-based version

Use a 3D model of an oculus rift

From the Chris Milk video: 'It Feels like Truth' 

It's a machine but inside of it it feels like truth

[A machine that] feels like truth

'You're not watching it [on a screen] you are sitting there with her'

Project Details

'A well-crafted narrative affords us the opportunity to see the world through the eyes of another.  Virtual really empowers not just to see, but also to step in, walk around & experience.  With VR we can interact, feel & understand the point-of-view of another like never before.'

- Truc de Ouf Productions (http://tdoprod.com/)

'In V.R., we instinctively feel a surge of empathy for those whose experiences we are immersed in. The suffering of people in war zones becomes our suffering, just as the killing of animals in the wild and in factory farms becomes a source of our pain as well.'

- Will Byrne and Dale Knauss (for Fastcompany) https://www.fastcompany.com/3067598/vr-builds-empathy-it-can-build-more-inclusive-business-too

In his TED talk on the subject, Chris Milk talks about Virtual Reality as the ultimate empathy machine, or '[a machine that] feels like truth', and contemporary utopian narratives paint Virtual Reality's empathic potential as an effective way to deal with human problems ranging from the interpersonal to the geopolitical (Milk's own example is a VR piece dealing with the experiences of Syrian Refugees). The idea the Virtual Reality can be used to help people understand the lived reality of others in a way that is conducive to creating positive change is a powerful one, painting technological innovation as a saviour of society from deeply entrenched structural problems.

The problematic nature of this narrative about VR was brought into sharp relief when I saw this tweet from CEO Sleepout Australia, an event where business CEOs raise money for homeless charities in Australia. 

'Our Sydney CEOs using virtual reality to get a glimpse of the realities faced by the people who experience this everyday.'

- @CEOSleepout, via Twitter, 22nd June 2017 https://twitter.com/CEOSleepout/status/877812107168763904

In this video and tweet, a group of headset-wearing CEOs move their heads around in what is assumed to be a virtual reality simulation of homelessness as part of CEO Sleepout. While raising money for charities is undeniably a good thing, is VR simply allowing these CEOs to feel as if they have confronted the problem of homelessness through virtual empathy while they return to their six figure (CEOs in Australia earn an average of AU$181,113 http://www.payscale.com/research/AU/Job=Chief_Executive_Officer_(CEO)/Salary ) salaries? Meanwhile, the people through whom they have briefly vicariously lived face the visceral reality of what homelessness actually means today.

For this commission I will be responding to these themes with '[a machine that] feels like truth'. It will be a browser-based interactive sketch written in p5.js that will use mouse movement within a browser window to juxtapose quotes, images and snippets sourced from various forms of media which deal with the use of VR as an 'Empathy Machine' from various perspectives. These forms of media potentially include lectures, news articles, thinkpieces, critical essays and other forms. Viewers of the work will use the mouse to 'explore' combinations of these pieces of media, much like a person wearing a VR headset explores their virtual environment by moving their head. This will be backed by a creative-commons licensed soundtrack sourced from a repository.

Through this juxtaposition, '[a machine that] feels like truth' will be aimed at provoking a critical discussion around the role of VR as a method to address profound human issues, and its potential relationship to the structures that surround these issues. The juxtapositions of materials will be randomly generated for every user, creating a unique, explorable experience through a simple generative technique.

For the commission I will spend a half-day collecting media, and a half-day creating the interactive sketch, and the result of the commission would be exhibited in the form of a webpage.

Artist Bio

Sean Cotterill is a live coder, musician and artist-programmer working in Newcastle-upon-Tyne, UK. Cotterill is currently working on practice-based research into an Open Source Digital/Hybrid arts practice supported by the Northern Bridge Doctoral Training Partnership.

Current long-running projects include live coding reverse-engineered dance music in nightclubs as coï¿¥ï¾¡pt and interfacing 16th century embroidery techniques with contemporary musical sampling for sampler/sampler.

Cotterill regularly performs live coded music as part of 'Algorave' internationally, and has presented artworks in the UK, Germany, Canada and South Africa.

Examples of recent work:

https://theseanco.github.io/howto_co34pt_liveCode/ - howto_co34pt_liveCode - a documentation, tutorial series and codebase showing how I live coding in SuperCollider (archive of performances can be found at co34pt.bandcamp.com)
http://seancotterill.xyz/Performance-for-AlgoMech-Festival-12th-November-2016 - sampler/sampler - A project interfacing 16th century embroidery and live coding techniques
https://theseanco.github.io/SJT-Web/ - SJT-Web - A quickly-produced 'hack' using p5.js to perform visualisation and sonification of the Steinhaus-Johnson-Trotter permutation algorithm


---

How do I then exhibit the core components of this work in an 'open' fashion?

