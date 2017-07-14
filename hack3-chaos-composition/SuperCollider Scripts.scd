// inspired by 'a henon map in curved waves', here are a few more chaos audiovisual compositions.
// Going to make a hack which shows a grid of frequency analysers with a number of different versions of the waves
p = ProxySpace.push(s)
s.scope
//TODO: Record this with freqscope
(
~masterspeed = {XLine.kr(0.1,120,120)};
~mastermod1 = {GbmanL.ar(~masterspeed,1.2,2.1)};
~mastermod2 = {GbmanL.ar(~masterspeed,1.1,2.2)};
~mastermod3 = {GbmanL.ar(~masterspeed,1.0,1.9)};
~mastermod4 = {GbmanL.ar(~masterspeed,1.1,2.0)};
~mastermod5 = {GbmanL.ar(~masterspeed,1.3,2.4)};

//array version with different frequencies
~sin = {SinOscFB.ar([(~mastermod1*440).round(0)]!2*[1,1.0001],0,XLine.kr(0.000001,0.3,1))};
~sin2 = {SinOscFB.ar([(~mastermod2*440).round(0)]!2*[1,1.0001],0,XLine.kr(0.000001,0.3,2))};
~sin3 = {SinOscFB.ar([(~mastermod3*440).round(0)]!2*[1.0001,1],0,XLine.kr(0.000001,0.3,4))};
~sin4 = {SinOscFB.ar([(~mastermod4*880).round(0)]!2*[1.0001,1],0,XLine.kr(0.000001,0.1,8))};
~sin5 = {SinOscFB.ar([(~mastermod5*1760).round(0)]!2*[1.0001,1.0004],0,XLine.kr(0.000001,0.05,20))};
~sin.play;~sin2.play;~sin3.play;~sin4.play;~sin5.play;
)

//GBmanL
//multiple non-interpolated chaotic equations could make really nice polyrhythms
//sine waves are randomly panned when the values of the equations change to create visuals
(
~masterspeed = {XLine.kr(0.1,120,480)};
~mastermod1 = {GbmanN.ar(~masterspeed,1.2,2.1)};
~mastermod2 = {GbmanN.ar(~masterspeed,1.1,2.2)};
~mastermod3 = {GbmanN.ar(~masterspeed,1.0,1.9)};
~mastermod4 = {GbmanN.ar(~masterspeed,1.1,2.0)};
~mastermod5 = {GbmanN.ar(~masterspeed,1.3,2.4)};
~randomTrig = {Changed.ar(~mastermod1.ar)};
~sin1 = {Pan2.ar(SinOscFB.ar((~mastermod1*400).round(25),0,0.2),TRand.kr(-1.0,1.0,~randomTrig))};
~sin2 = {Pan2.ar(SinOscFB.ar((~mastermod2*400).round(25),0,0.2),TRand.kr(-1.0,1.0,~randomTrig))};
~sin3 = {Pan2.ar(SinOscFB.ar((~mastermod3*400).round(25),0,0.2),TRand.kr(-1.0,1.0,~randomTrig))};
~sin4 = {Pan2.ar(SinOscFB.ar((~mastermod4*400).round(25),0,0.2),TRand.kr(-1.0,1.0,~randomTrig))};
~sin5 = {Pan2.ar(SinOscFB.ar((~mastermod5*400).round(25),0,0.2),TRand.kr(-1.0,1.0,~randomTrig))};
~sin1.play;~sin2.play;~sin3.play;~sin4.play;~sin5.play;
)

// I want to make a GUI element that is full of multiple scopes plotting the chaos functions.



ScopeView(

Stethoscope.new(s,2,0,256).style(2)