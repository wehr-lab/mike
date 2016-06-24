import pyo
import time
s = pyo.Server(audio='jack').boot()
s.start()
soundAmp=.05
duration=.5
risetime=.01
falltime=.01
gaponset=duration/2
print(gaponset)
gapdur=.1
'''L=pyo.Linseg([(0, soundAmp),(gaponset, soundAmp),(gaponset,0), (gaponset+gapdur, 0),(gaponset+gapdur, soundAmp),(duration, soundAmp)]).out()
'''
envelope=pyo.Linseg([(0,soundAmp),(duration, soundAmp)]).out()
f = pyo.Fader(fadein=risetime, fadeout=falltime,
                                 dur=duration, mul=envelope)
soundWaveObj = pyo.Noise(mul=f).out()
f.play()
time.sleep(1.5*duration)
