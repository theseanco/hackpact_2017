# Hackpact Day 1 - 'Sonic Pattern'

## Documentation



## Notes

Inspired by '[Screenbashing](https://vimeo.com/148626379)', a performance by Magno I saw at ICLC 2016.

Screenbashing writes a series of simple C programs in transparent terminals which display repeated symbol patterns.

It's then backed up by a bunch of (what I assume are) Viznut-style ['Single line of C'](https://www.youtube.com/watch?v=L9KLnN0GczI) programs implemented in SuperCollider.

What I'd like to do is more of these very small text repetition pieces, maybe in Python, and implement them in a way that will feed them directly to a sound card if possible, and then maybe extend that to some OSC or something like that, and maybe make some nice thing out of that.

This ties in nicely to a thing i've been wanting to tackle ages which is 'assigning messages as they come in' - i.e. a colour is assigned to a symbol when a symbol is sent to processing, and the colour for that symbol is kept constant. A simple thing that I've never actually done before.

I'm going to start with the simple 'C' programs though. I'm going to do them in Python because that provides more flexibility later and I also don't really know my C too well...

A thing to 'send it directly to sound card' could be something like [`aplay`](https://linux.die.net/man/1/aplay) or [`sox`](http://sox.sourceforge.net/)

`aplay -v -f cd *` is a nice format for CD-quality raw audio

Tends to come out as gated white noise, when given a few reasonably large example files

Starting with the python script to make repeated patterns, python's `print` puts a newline at the end of everything, so i'm going to use `sys.stdout.write` (https://stackoverflow.com/questions/11266068/python-avoid-new-line-with-print-command)

It needs a very small sleep at the end otherwise it just spams printing in a way that's slightly unproductive

According to the original [viznut blog post](https://countercomplex.blogspot.co.uk/2011/10/algorithmic-symphonies-from-one-line-of.html), the audio was being written as 'raw PCM audio' to the sound card.

This is done in C by writing to the sound card, i can just pipe it to `aplay`

`python 01_repeatingFigures.py | aplay`

various options sound differently in various ways

I'd also like to view the output too... The issue is that the pipe only feeds to aplay. Need to pipe this in parallel.

Using `tee` does a version of it (https://stackoverflow.com/questions/5677201/how-to-pipe-stdout-while-keeping-it-on-screen-and-not-to-a-output-file), but there's quite a delay during it.

Also, after putting a `time.sleep` in the Python script i've now realised that sys.stdout.write doesn't work in conjunction with `sys.stdout.write`, why?

it's also not a problem with piping to `/dev/tty` as `/dev/stderr` does the same thing.

I'm also not flushing after writing to `stdout` which is an issue (https://stackoverflow.com/questions/2808832/problems-with-sys-stdout-write-with-time-sleep-in-a-function)

With all of that corrected, and a sleep added, playback through both sound and terminal is still a little bit jumpy.

The sound from the terminal output is also super static. Literally just a tone. That's not the most entertaining thing in the whole world

A repeated string of `'string'` produces the sound found in `01_string.wav`

Let's try shuffling the string around and seeing if it mixes things up? This is a pre-done thing https://stackoverflow.com/questions/6181304/are-there-any-way-to-scramble-strings-in-python

It just makes noise! Interestingw
If you add a bunch of spaces it adds silences but the silences are so small that it just kinda filters the sound??! this can be hear in `02_stringspace.wav`

The issue with continuous sound and printing is in the amount of data that is flowing. If i cut down the string size and massively up the sample rate, both are constant(ish)

This produces disappointing results.

Maybe to better drive the point home the terminal printing and aplay sound be independent of one another. This would involve some kind of process separation or something

Or maybe I need `aplay` as a sort of subprocess.

A simple way to do this would be to start two versions of the same script in parallel. One that writes to the terminal and one that is piped to `aplay`, but i don't know how to do this...

`python script.py & python script.py | aplay`

works, but it doesn't make the two scripts work in a way that they _actually_ work from the same output. oh, and it makes them very hard to terminate

An interesting answer on stackoverflow here (https://stackoverflow.com/questions/260738/play-audio-with-python) says something about playing numpy arrays. i'll try

Doesn't work because it is not a numpy array, and thinking about it there is no reason why this _would_ work.

Need to do this double-piping thing. Just not sure to make it work.

One way to do it would be to have a python script that recieves strings by OSC at a particular address with a listener. Then I can use the piping arrangement with two scripts running at the same time, that doesn't seem right. What I need is to run a shell _inside_ of python...

Doesn't seem right, but it could be. Time to make a send script and a receive script.

I need to:
- Get the OSC Responder script
- Wire that script up to the inside of the printing script
- Test that in the context of the `aplay` piping option and the terminal output.

OSC Responder occupies a port and they can't be co-occupied

this is a problem.

Set up an OSC responder script alongside the piping I tried earlier, and it seems to work nicely.

A continuous input on the input script would be really nice.

Overall this just produces a series of boring beeps.

Actually a pretty dull result.

Start two terminal windows in the `Python` directory

in one: `python 03_1_OSCSender.py`

In the other: `python 03_OSCHandler | tee /dev/tty | aplay -f cd`

Enjoy the DC Bias and bleeps.
