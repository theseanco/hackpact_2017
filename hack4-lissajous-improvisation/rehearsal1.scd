/*

Available UGens

SinOsc
SinOscFB
LFTri
Saw
SawDPW
Pulse
PulseDPW


*/


p = ProxySpace.push(s);
StageLimiter.activate;
s.scope(zoom:0.01);p.fadeTime = 5

~sin1 = {DFM1.ar(LPF.ar(SinOsc.ar([100,100],[0,pi*1.5],0.7),SinOsc.kr(0.1).range(200,600)),[100,200],SinOsc.kr(0.1).range(0.9,1.2))}
~sin1.play

~sin1.clear

~sin2 = {SinOsc.ar([200,100+LFNoise1.kr],0,0.2)}
~sin2.play

~sin3 = {SinOscFB.ar([100,100.1],SinOsc.kr(0.01).range(0,1),0.1)}
~sin3.play

~sin3.stop(10)

~sq1 = {Pulse.ar([50.2,50],SinOsc.kr(0.1).range(0.01,0.1),0.4)*EnvGen.ar(Env.perc(0.0001,0.05),Dust.kr(100))}
~sq1.play

~sq2 = {Pulse.ar([200,200.2],SinOsc.kr(0.1).range(0.01,0.1),0.4)*EnvGen.ar(Env.perc(0.0001,0.1),Dust.kr(10))}

~sq2.play

~sin4 = {SinOsc.ar({LFNoise1.kr(0.1).range(100,400).round(100)/2}!2,0,0.3)}

~sin2.stop(20)
~sin4.stop(10)


~sq1.stop(20)
~sq2.stop(20)

~blip = {Blip.ar([314,122],LFNoise1.kr([0.1,0.09]).range(10,1000),0.4)}

~noise = {Pan2.ar(WhiteNoise.ar(LFNoise1.kr(0.1).range(0.1,0.4)),LFNoise1.kr(0.4)) * EnvGen.ar(Env.perc,Dust.kr(0.1))}

~noise.play

~boom = {SinOscFB.ar([50,100],1.2,0.4) * EnvGen.ar(Env.perc(0.01,0.1),Impulse.kr([4,5]/2))}

~noise.stop

~sin2 = {SinOsc.ar([500,600.01],[0,pi*1.5],0.1)}

~tri = {LFTri.ar([300,300+LFNoise1.kr(0.1,10)],0,0.3)}
~tri.play

~blip.stop(40)

s.scope(zoom:0.5)

~tri.clear

~sin2.play

~boom.play

~blip.play


~sin4.play

s.scope(zoom:1);

p.fadeTime = 3