(
s.boot;
)
(
f = Buffer.alloc(s,1024,2);
b = Bus.audio(s,1);

w=Window.new.front;
c = ScopeView(w.view,w.view.bounds.insetAll(10,10,10,10));
c.bufnum = f.bufnum;
c.server_(s);
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
c.start;

)

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