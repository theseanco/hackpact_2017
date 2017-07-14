//how to load files into SuperDirt on the fly
(
// configure the sound server: here you could add hardware specific options
// see http://doc.sccode.org/Classes/ServerOptions.html
s.options.numBuffers = 1024 * 16; // increase this if you need to load more samples
s.options.memSize = 8192 * 16; // increase this if you get "alloc failed" messages
s.options.maxNodes = 1024 * 32; // increase this if you are getting drop outs and the message "too many nodes"
s.options.numOutputBusChannels = 2; // set this to your hardware output channel size, if necessary
s.options.numInputBusChannels = 2; // set this to your hardware input channel size, if necessary
// boot the server and start SuperDirt
s.waitForBoot {
	~dirt = SuperDirt(2, s); // two output channels, increase if you want to pan across more channels
	~dirt.loadSoundFiles;   // load samples (path containing a wildcard can be passed in)
	// for example: ~dirt.loadSoundFiles("/Users/myUserName/Dirt/samples/*");
	s.sync; // wait for samples to be read
	~dirt.start(57120, [0, 0]);   // start listening on port 57120, create two orbits, each sending audio to channel 0. You can direct sounds to the orbits from tidal e.g. by: `# orbit "0 1 1"
}
)

// load files into server with this
~dirt.loadSoundFiles("/home/smc/Documents/Samples/TidalSamples/*");

//then need a little SynthDef to record audio, chop it up, spit it out as sound files, then load it into SuperDirt, this should be quite easy

//Recording SynthDef
(
// this will record to the disk
SynthDef("help-Diskout", {arg bufnum;
	DiskOut.ar(bufnum, SoundIn.ar(1));
}).send(s);
)


//Record
(
b= Buffer.alloc(s, 65536, 1);
b.write("object/1.wav".resolveRelative, "aiff", "int16", 0, 0, true);
c = Synth.tail(nil, "help-Diskout", ["bufnum", b]);
)


// stop recording
(
c.free;
b.close;
b.free;
)

q = Buffer.read(s,"object/1.wav".resolveRelative)
q.play

//this re-loads all sound files in the dir
~dirt.loadSoundFiles("object".resolveRelative);