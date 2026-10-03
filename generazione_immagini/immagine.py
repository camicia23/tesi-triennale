import urllib.request
import numpy as np
import matplotlib.pyplot as plt
from scipy.interpolate import interp1d
from gwpy.timeseries import TimeSeries

# 1. Coordinate temporali dell'evento GW150914 a Hanford (H1)
t_event = 1126259462.423

# 2. Scarica 8 secondi di dati reali H1 da GWOSC
print("Scaricamento dati LIGO H1...")
data_h1 = TimeSeries.fetch_open_data('H1', t_event - 4, t_event + 4, cache=True)

# 3. Scarica il template teorico ufficiale di Relatività Numerica
url_template = "https://gwosc.org/s/events/GW150914/GW150914_4_NR_waveform.txt"
print("Scaricamento template teorico ufficiale...")
urllib.request.urlretrieve(url_template, "GW150914_NR.txt")
nr_time, nr_strain = np.genfromtxt("GW150914_NR.txt").T

# 4. Interpolazione del template sulla stessa griglia temporale dei dati reali
interpolator = interp1d(nr_time + t_event, nr_strain, bounds_error=False, fill_value=0.0)
nr_aligned = interpolator(data_h1.times.value)
nr_ts = TimeSeries(nr_aligned, times=data_h1.times)

# 5. Sbiancamento (whitening) di entrambi i segnali con lo stesso PSD
print("Elaborazione del segnale...")
psd = data_h1.psd(fftlength=4, overlap=2)
white_data = data_h1.whiten(asd=psd**0.5)
white_nr = nr_ts.whiten(asd=psd**0.5)

# 6. Filtro passa-banda (35 - 350 Hz)
filtered_data = white_data.bandpass(35, 350)
filtered_nr = white_nr.bandpass(35, 350)

# 7. Ritaglio attorno al merger per il grafico
window = (t_event - 0.15, t_event + 0.05)
plot_data = filtered_data.crop(*window)
plot_nr = filtered_nr.crop(*window)

# 8. Generazione della figura PIÙ PICCOLA
# Diminuita la dimensione della finestra (es. 7x3.5 pollici)
plt.figure(figsize=(7, 3.5), dpi=300)

time_axis = plot_data.times.value - t_event

# Spessore delle linee leggermente ridotto
plt.plot(time_axis, plot_data.value, color='#555555', alpha=0.7, lw=1.2, label='LIGO Hanford H1 (dati filtrati)')
plt.plot(time_axis, plot_nr.value, color='#d9381e', lw=2.0, label='Template teorico (NR)')

# FONT RIMPICCIOLITI per titolo, assi, tick e legenda
plt.title('GW150914: Dati del rivelatore vs Template teorico', fontsize=10, fontweight='bold', pad=8)
plt.xlabel("Tempo dall'evento (s)", fontsize=9)
plt.ylabel('Strain normalizzato', fontsize=9)

# Font per i numerini sugli assi
plt.xticks(fontsize=8)
plt.yticks(fontsize=8)

plt.xlim(-0.15, 0.05)
plt.grid(True, linestyle=':', alpha=0.6)

# Legenda più piccola
plt.legend(loc='upper left', frameon=True, facecolor='white', framealpha=0.9, fontsize=8)

plt.tight_layout()
plt.savefig('gw150914_overlay_slide_small.png')
plt.show()
# plt.save("simulazione.pdf")