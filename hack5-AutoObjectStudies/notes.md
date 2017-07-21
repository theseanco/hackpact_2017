# Hack 5 - Autoobjectstudies

- This is inspired by typeEngine - a piece I really need to re-document and re-perform, and was probably the best thing I did for my MA.

- For this project I want to design a system that I can attach to an object, which will excite the object, record the excitations, push them into TidalCycles, have TidalCycles autocode the result, and then record more inputs based on the kind of music that is coming out.
- i've made a mockup set of SynthDefs which can record things, and this will need to be done after a delay
- I also need to modify the way the object is excited, with an Arduino solenoid rig, so will need some kind of parallel python script or a haskell serial library

- So I need a recorder for sounds in SuperCollider. My plan is to make a script which clears a directory and listens for onsets. When an onset is detected, a random number is generated and if that random number generator is over a certain threshold then some sound will be recorded.
- This random number generator will make it so that there isn't LOADS of sound recorded for no good reason
- The threshold for onsets will also be lowered over time so that getting recordings in is made easier
- Some dead air recording would also be nice for particularly sonorous objects

- These sounds will then be auto-loaded into TidalCycles, where they can maybe be autocoded?s
- tidal autocode works really well, it just needs to be lined up with the sounds that are auto-coded, and maybe the tracery grammar needs to be updated as more sounds are added? I'm not actually sure about this one, maybe just a bunch of empty sounds need to be created for 1-10 and then they are updated and deleted as sounds are added, or maybe the tracery grammar needs to be updated to get a more comprehensive idea of the sounds that are available. i'm not actually sure which it is.
- What would be really nice would be an atom package that responds to messages from SuperCollider that refresh when new sounds are recorded with the contents of the recorded sample directory.
- The settings for tidal-autocode are keps in ~/.atom/config.cson, I could just write direct to that.
- In order for this recording script to make a sizeable difference, all I need to do is use a unixCmd within SuperCollider to overwrite the existing tidal-autocode settings with a ~ (for when there are no files in the dir), and an index for every file in the folder. This can plug straight in to tidal autocode!
- So i'll do this with `sed`. I'll need to replace:
    - samples: " 1 2 4 6 7"
    - samples: "sounds i've recorded"
- I googled around and found this, which is an explanation of how to use a regular expression to capture things inside of quotes. https://stackoverflow.com/questions/171480/regex-grabbing-values-between-quotation-marks
- it gave me this expression to capture the line that the config file will use to determine samples:
- `samples: "(.*?)"`
- the regular expression I need is : `sed -i "/samples/c\samples: \"samples go here:4\"" config.cson`
- So, the order of execution:
    - Detect Onset
    - Record sound
    - Load new samples
    - reload tidal-autocode with the new samples in it

- tidal-autocode does not reload. Maybe a wiser thing to do would be to ust preload the settings file with an object number of like 300, as the usage of samples wraps anyway
- This works
- The object studies sound lovely. Maybe a nice thing to do would be to just get a big lovely sonorous object, invite people to ding it, and then it'll be included as part of an algorithmic composition?
- The recorded samples could eventually be deleted, making an evolving algorithmic composition possible.

- The issue is that the recordings don't get removed from SuperDirt. A really nice way to turn this into an installation would be:
- Have an object that is miced up
- invite audience to interact with object
- take rolling recordings
- make those recordings into algorithmic composition
- replace these recordings with silences after a while

- How do I do this? First I need to figure out how to clear a directory on SuperDirt.
- This can be done with freeSoundFiles.
- Maybe after a certain number of seconds, one sound is removed.
- Say:
- Sounds were recorded to obj1, obj2 and so on....
- After a certain number of seconds, sounds in obj10, 9, 8 are freed? Maybe?
- Maybe they're replaced with silences?

- One issue with freeing files is that they fit the format ~dirt.soundFiles([\filetoFree])
- this \string format I can't pass from a global variable and there isn't a way to interpret it as a string...
- it's done with .asSymbol (thanks Yaxu!)
- So recording to a 'circular filestructure' gets around the weird hackiness of having object:0-300 on TidalCycles side
- this works lovely (04_savingtoDifferentDirectories.scd)

- Okay, so there are a couple of options from here:
- Create an auto-excitation engine to create studies of an object that manually excites the object algorithmically and creates corresponding algorithmic compositions in a closed loop
- Allow participants to excite the objects themselves, and maybe turn this into a bunch of albums(...?)
- create algorithmic compositions from the room sound

This all sounds wonderful and lovely.