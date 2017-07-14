// I need to plug the output of the server into these FreqScopes.
// It can be done from the inside of the first SynthDef that is played

(
s.boot;
)
(
f = Buffer.alloc(s,1024,2);
b = Bus.audio(s,1);

//Window needs to be a specific height
w=Window.new("494094");

//make window full screen
w.fullScreen;
//get height of window
//w.bounds.height;
//get width of window
//w.bounds.width;
)
(
/*
for (0, 8,
	{arg i;
		for (0, 8,
			{arg n;
				i.post;
				n.post;
})})*/

c = List.new;
d = Dictionary.new;
//adjust this for a variable grid size
d.add(\numTilesWidth -> 4);
d.add(\numTilesHeight -> 10);
for(0, d[\numTilesWidth],
	{ arg i;
		for (0, d[\numTilesHeight],
			{arg j;
				c.add(ScopeView(w.view,Rect(i*(w.bounds.width/d[\numTilesWidth]),j*(w.bounds.height/d[\numTilesHeight]),w.bounds.width/d[\numTilesWidth],w.bounds.height/d[\numTilesHeight])));
})});


for (0, c.size-1,
	{ arg i;
		c[i].bufnum = f.bufnum;
		c[i].server_(s);
})

)
(
// listening to the bus, using ScopeOut to write it to the buffer
a=SynthDef("monoscope", { arg bus, bufnum;
                var z;
                z = In.ar(bus,2);
                // ScopeOut writes the audio to the buffer
                ScopeOut2.ar(z, bufnum);
            }).play(
                RootNode(s),
                [\bus,b.index, \bufnum, f.bufnum] ,
                \addToTail // make sure it goes after what you are scoping
            );

// making noise onto the buffer
d=SynthDef("noise", { arg bus;
                var z;
                z = LFSaw.ar(SinOsc.kr(0.1).range(300,1000),[0,1]*pi) * 0.1;
                Out.ar(bus, z);
            }).play(
                s,
                [\bus,b.index]
            );

for (0, c.size-1,
	{arg i;
		c[i].start;
});
)

//randomly switch the style of all of the scopes present
for (0, c.size-1,
	{arg i;
		c[i].style = rrand(0,2)
})


c.style = 0 // vertically spaced
c.style = 1 // overlapped
c.style = 2 // x/y

(
//remember to free your stuff when finished
a.free;
d.free;
f.free;
b.free;
w.close;
) 