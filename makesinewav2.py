import pyo
Fs=44100
freq=1000
amp=.5
duration=1
fname='sine3.wav'

#            self.pyoServer = pyo.Server(audio='offline').boot()

pyoServer=pyo.Server(audio='offline')
pyoServer.boot()
pyoServer.recordOptions(dur=duration, filename=fname, fileformat=0, sampletype=0)

f=pyo.Fader(fadein=.003, fadeout=.003,dur=duration, mul=amp)
sinewave=pyo.Sine(freq=freq, mul=amp).mix(2).out()

f.play()
pyoServer.start()
