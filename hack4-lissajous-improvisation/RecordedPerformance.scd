/*

Lissajous Improvisation

I am going to be improvising using SuperCollider with a Lissajous scope

I will be using raw waves and the harmonic series to create geometric patterns as I play

I will be responding both to the geometric patterns I create and the sounds that I am hearing as I improvise.


*/



s.boot;
p = ProxySpace.push(s);
s.scope(zoom:1);
StageLimiter.activate

r = 80
~sin1 = {DFM1.ar(LPF.ar(SinOsc.ar([r,r+0.1],[0,pi*1.5],0.7),SinOsc.kr(0.1).range(100,1000)),[200,300.1],SinOsc.kr(0.1).range(0.9,2.2))}

(
d = 120;
~trix = {LFTri.ar([r*20,(r*40)+0.2]/d,0,0.6)};
~tri1 = {LFTri.ar([r*50,(r*40)]/d,0,0.4)};
~tri2 = {LFTri.ar([r*40,(r*40)]/d,0,0.3)};
~tri4 = {LFTri.ar([r*100,r*200]/d,0,0.2)};
~tri2 = {LFTri.ar([r*40,(r*40)]/d,0,0.1)};
)

~tri4.stop(30)

~tri4.stop(5)

ProxyMixer.new(p)

p.fadeTime = 5

~sin = {SinOsc.ar([r,r+Line.kr(0.0001,4334,140)],[0,pi*1.5],1)}
~sin2 = {SinOsc.ar([r+Line.kr(1,1000,40),r+XLine.kr(0.001,10,14020)]*2,[0,pi*1.5],1)}

~sin2.play

~tri4.play

~noise.stop

~del.stop(10)

~boom.stop(10)

~del = {CombN.ar(Mix.ar([~boom.ar]),0.2,0.1,10)*0.1}



~del.play

~sinx = {SinOsc.ar([r*100-0.1,r*200+0.1],0,0.1)}

~sinx.play

~tri3.fadeTime = 60

p.fadeTime = 5

~trix.play
~sin5.stop

~tri3.clear
~tri2.play

~tri3.play
~tri3.stop

~sin1.stop(60)

~pulse.stop(10)

~tri1.clear


~sin1.play

~sin1.stop(60)

~sin2 = {SinOsc.ar([r*2,r*2+0.01],[0,pi*1.5],0.6)}

~sin2.stop

~sin3.stop(20)

~sin3 = {SinOsc.ar([r*4+0.1,r*4+0.01],[0,pi*1.5],0.3)}

~sin4 = {SinOsc.ar([r*8+0.3,r*3+0.15],0,0.2)}

~sin5 = {Splay.ar(SinOsc.ar({r*LFNoise1.kr(0.1).range(1,4).round(1)+LFNoise1.kr(0.1,0.3)}!2,0,0.8))}

~noise.stop

~blip.stop

~boom.play

~noise = {Pan2.ar(WhiteNoise.ar(0.1),SinOsc.kr(0.4)) * EnvGen.ar(Env.perc,Dust.kr(0.4))}

~noise.play



~boom.stop(10)


~sin5.play

~sin4.play

~blip = {Blip.ar([400.9,501],SinOsc.kr(0.1).range(100,600),0.1)}

~blip.play

~pulse = {Pulse.ar([r/2+1,r/2-0.1],SinOsc.kr(0.1).range(0.001,0.05),0.5)}

~boom = {SinOscFB.ar([r*0.5,r*0.75]*r*2,1,2)*EnvGen.ar(Env.perc(0.01,0.1),Impulse.kr([1/5,1/4]*8))}



~boom.play

~pulse.play


~sin3.play

~sin2.play
p.fadeTime = 5

~sin1.play