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

//updated removal script
(
for (0, 10,
	{arg i;
		~filePath = ("../object"++i.asString++"/").resolveRelative;
		("rm "++~filePath.asString++"*.wav").unixCmd;
		i = i + 1;
});
//create file number
~fileNumber = 0;
)


//
// //Recording SynthDef
// (
// // this will record to the disk
// SynthDef("help-Diskout", {arg bufnum;
// 	DiskOut.ar(bufnum, SoundIn.ar(1));
// }).send(s);
// )
//
// //record!
// (
// ~buffer = Buffer.alloc(s, 65536, 1);
// ~buffer.write(("../object/"++~fileNumber.asString++".wav").resolveRelative, "aiff", "int16", 0, 0, true);
// ~diskOut = Synth.tail(nil, "help-Diskout", ["bufnum", ~buffer]);
// ~fileNumber = ~fileNumber + 1;
// )
//
//
// // stop recording
// (
// ~diskOut.free;
// ~buffer.close;
// ~buffer.free;
// )


/*//this re-loads all sound files in the dir
~dirt.loadSoundFiles("../object".resolveRelative);

/*//load kick to test onsets
~kick = Buffer.read(s,"/home/smc/src/github/co34pt_LiveCode/setup/SuperCollider/Samples/k/1.wav")*/

(
//define path
~filePath = "../object/".resolveRelative;
//clean file path
("rm "++~filePath.asString++"*.wav").unixCmd;
//create file number
~fileNumber = 0;
)*/

//Modified Onsets.kr example
//The threshold needs to be reduced over time. Could do this by feeding the trigger from onsets back into an envelope that is contained within it to control the threshold? That seems reasonable...
(
~fftBuf = Buffer.alloc(s,512);
~onsetDetect = {
    var sig, chain, onsets, pips;

    // A simple generative signal
	sig = SoundIn.ar(0);
    // or, uncomment this line if you want to play the buffer in
    //sig = PlayBuf.ar(1, d, BufRateScale.kr(d), loop: 1);

    chain = FFT(~fftBuf, sig);

    onsets = Onsets.kr(chain, MouseX.kr(0,1), \rcomplex);

	SendReply.kr(onsets,'/mic_onset');
    // You'll hear percussive "ticks" whenever an onset is detected
	//pips = PlayBuf.ar(2,~kick,1,onsets);
    Out.ar(0,0);
}.play;
)

/*//a variable to say if we are recording or not - useful so that a bunch of recording doesn't alll go on at once
~recording = 0;

//a test function to check how the
{SendReply.kr(Impulse.kr(0.5),'/mic_onset')}.play*/

//an OSCdef to control the recording - a test function
//this should keep track of ~recording so that recording isn't done multiple times
(
SynthDef("help-Diskout", {arg bufnum;
	DiskOut.ar(bufnum, SoundIn.ar(0));
}).send(s);
~recording = 0;
//~fileStringName = "~";
//~string2 = "sed -i \"/samples/c\\    samples: \\\""++~fileStringName.asString++"\\\"\""+"/home/smc/.atom/config.cson";
//~string2.unixCmd;
OSCdef(\onsetResponder, { |msg, rand| rand = rrand(1,40).postln;
	if( rand > 35 && ~recording == 0,
		{
			Task({
				//record stuff
				"recording!".postln;
				// ~filePath = ("../object"++~fileNumber.asString++"/").asString;
				// ~filePath = ~filePath.resolveRelative;
				~filePath = "/home/smc/src/github/hackpact_2017/hack5-AutoObjectStudies/object"++~fileNumber++"/";
				("rm "++~filePath.asString++"*.wav").unixCmd;
				~recording = 1;
				0.01.wait;
				~buffer = Buffer.alloc(s, 65536, 1);
				//for some reason I have to specify an an absolute path as relative paths don't work when loaded from within a task because reasons.
				~buffer.write("/home/smc/src/github/hackpact_2017/hack5-AutoObjectStudies/object"++~fileNumber.asString++"/sound.wav", "aiff", "int16", 0, 0, true);
				~diskOut = Synth.tail(nil, "help-Diskout", ["bufnum", ~buffer]);
				//wait for 3 seconds (maybe make this some kind of conditional thing based on the loundness of the recording, I dunno)
				4.wait;
				//stop recording
				~diskOut.free;
				~buffer.close;
				~buffer.free;
				~recording = 0;
				0.01.wait;
				("recording"+~fileNumber.asString+"saved!").postln;
				~fileStringName = ~fileStringName++", object:"++~fileNumber;
				//THIS NEEDS TO BE FINISHED. NEEDS TO FREE THE FILE WE ARE ABOUT TO LOAD.
				~dirt.freeSoundFiles([("object"++~fileNumber).asSymbol]);
				~dirt.loadSoundFiles("/home/smc/src/github/hackpact_2017/hack5-AutoObjectStudies/object"++~fileNumber.asString++"/");
				~fileNumber = ~fileNumber + 1;
				if ( ~fileNumber > 10 ,
					{~fileNumber = 0} );
				//this re-loads all sound files in the dir
				1.wait;
				//YOU NEED TO COMBINE THE STRING BEFORE YOU DO IT. This _cannot_ be done at runtime, for reasons.
				//~string2 = "sed -i \"/samples/c\\    samples: \\\""++~fileStringName.asString++"\\\"\""+"/home/smc/.atom/config.cson";
				//~string2.unixCmd;i made a thing that turns sounds you make into automatic algorithmic compositions using @tidalcycles today - would make a nice installation
			}).start;
	});
}, '/mic_onset');
)


("object"++~fileNumber).asSymbol

~three = 3
~fileName = \object++~three.asString

~name = "object2"

~fileName.

~dirt.freeSoundFiles([~name.asSymbol])


s.stopRecording

/*

//free the onset detection function
~onsetDetect.free;

"cat /home/smc/.atom/config.cson".runInTerminal

//play buffer tester
~playBuf = Buffer.read(s,"../object/3.wav".resolveRelative)
~playBuf.play;

~string2 = "se -i \"/samples/c\\samples: \\\""++~fileStringName.asString++"\\\"\""+"/home/smc/.atom/config.cson"

~string2.runInTerminal


"sed -i \"/samples/c\\samples: \\\""++~fileStringName++"\\\" "+" /home/smc/src/github/hackpact_2017/hack5-AutoObjectStudies/sed_tests/config.cson".runInTerminal


/home/smc/src/github/hackpact_2017/hack5-AutoObjectStudies/sed_tests


{SoundIn.ar(0)}.play

*/

/////////////// SCRATCHPAD AND OLD STUFF GOES DOWN HERE, descending over time
/*

//setup for Onsets.kr example


(
s.waitForBoot({
    // Prepare the buffers
    b = Buffer.alloc(s, 512);
    // Feel free to load a more interesting clip!
    // a11wlk01 is not an ideal example of musical onsets.
    d = Buffer.read(s, Platform.resourceDir +/+ "sounds/a11wlk01.wav");
});
)

~kick = Buffer.read(s,"/home/smc/src/github/co34pt_LiveCode/setup/SuperCollider/Samples/k/1.wav")

//Onsets.kr example
(
x = {
    var sig, chain, onsets, pips;

    // A simple generative signal
	sig = SoundIn.ar(1);
    // or, uncomment this line if you want to play the buffer in
    //sig = PlayBuf.ar(1, d, BufRateScale.kr(d), loop: 1);

    chain = FFT(b, sig);

    onsets = Onsets.kr(chain, MouseX.kr(0,1), \rcomplex);

    // You'll hear percussive "ticks" whenever an onset is detected
	    pips = PlayBuf.ar(2,~kick,1,onsets);
    Out.ar(0, Pan2.ar(pips, 0.75, 1));
}.play;
)
x.free; // Free the synth

o = OSCFunc({ |msg| msg.postln }, '/the_answer');




//an OSCdef to control the recording - a test function
//this should keep track of ~recording so that recording isn't done multiple times
(
OSCdef(\onsetResponder, { |msg, rand| rand = rrand(1,40).postln;
	if( rand > 35 && ~recording == 0,
		{
			Task({
			"one".postln;
			0.1.wait;
			"two".postln;
			0.01.wait;
			"doone!".postln;
			}).start;
	});
}, '/mic_onset');
)

//free the onset detection
~onsetDetect.free;

*/

~strings = List.new

~strings.add("fjdk5")

~fileStringName = ""

~fileName = "object"

for ( 0, ~strings.size-1 ,
	{ arg i;
		~fileStringName = ~fileStringName++~fileName++":"++i++", "
})

~fileStringName

//sed string
sed -i "/samples/c\samples: \"samples go here:4\"" ~/.atom/config.cson


