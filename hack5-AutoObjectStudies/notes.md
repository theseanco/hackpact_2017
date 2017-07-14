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