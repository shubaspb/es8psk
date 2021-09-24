
import matplotlib.pyplot as plt
import cmath
import math
import numpy as np
import time
import keyboard
real=cmath.cos
imag=cmath.sin
exp=cmath.exp
pi=cmath.pi


def plot_param(plt1, x, y, title, xlab, ylab):
    plt1.plot(x, y)
    plt1.set_title(title)
    plt1.set_xlabel(xlab)
    plt1.set_ylabel(ylab)
    plt1.grid()
    #plt.xlim(0,1)
    #plt.ylim(0,1)
    return 0

def spectrum_db(x):
    sp = np.fft.fft(x)
    sp_db = np.arange(0,len(sp),1)
    for i in range(0, len(sp)):
        sp_db[i] = 20*math.log10(abs(sp[i]))
    max_db = np.max(sp_db)
    for i in range(0, len(sp)):
        sp_db[i] = sp_db[i]-max_db
    return sp_db



fs=60

x = np.loadtxt('output_file.txt', skiprows=20, delimiter=',')
cnt=x[:,0]
x_iq=x[:,1]+1j*x[:,2]

#sp_env = spectrum_db(x_env)
#tt = np.arange(0,len(x_env),1)/fs
#f_axe = np.arange(0,len(sp_env),1)/len(sp_env)*fs

f_axe=cnt/(2**32)*fs

mag_db=np.arange(0,len(x_iq),1)
for i in range(0, len(x_iq)):
    mag_db[i] = 20*math.log10(abs(x_iq[i])+1)-110

fig, axs = plt.subplots(1, 1)
#plot_param(axs[0, 0],fmag_dbsp_env, 'spectrum envelope', 'MHz', 'dB')
plot_param(axs, f_axe, mag_db, 'magnitude', 'MHz', '')
plt.show()