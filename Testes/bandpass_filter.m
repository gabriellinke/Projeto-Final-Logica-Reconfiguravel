% Filter specifications
Fs = 44100;      % Sampling frequency (Hz)
Fpass1 = 1800;   % Lower passband frequency (Hz)
Fpass2 = 2200;   % Upper passband frequency (Hz)

% Normalized frequencies
Wpass1 = Fpass1 / (Fs/2);
Wpass2 = Fpass2 / (Fs/2);

% Filter order
N = 64;

% FIR filter design using Hamming window
%h = fir1(N, [Wpass1 Wpass2], 'bandpass', hamming(N+1));

% FIR filter design using Kaiser window
Ast = 80;       % Stopband attenuation (dB)
beta = 0.1102 * (Ast - 8.7);
h = fir1(N, [Wpass1 Wpass2], 'bandpass', kaiser(N+1, beta));

% Export filter coefficients to a text file
filename = 'filter_coefficients.txt';
dlmwrite(filename, h, 'precision', '%.10f', 'delimiter', '\n');

% Frequency response plot
freqz(h, 1, 1024, Fs);

% Plotting the magnitude response
% figure;
% [H, F] = freqz(h, 1, 1024, Fs);
% plot(F, 20*log10(abs(H)));
% grid on;
% xlabel('Frequency (Hz)');
% ylabel('Magnitude Response (dB)');
% title('Magnitude Response of 16th-order FIR Bandpass Filter');

[input, Fs] = audioread('pad1.mp3');

output = filter(h, 1, input);

audiowrite('output.wav', output, Fs);
soundsc(output, Fs);

% Calculate the time axis
duration = length(input) / Fs;
time = linspace(0, duration, length(input));

% Plot the waveform
figure;
plot(time, input, 'g');
hold;
xlabel('Time (s)');
ylabel('Amplitude');
title('Waveform of Audio Signal');
grid on;
plot(time, output, 'r');

% [data, fs] = audioread('sample1.wav');
% data = data*fs/255;
% 
% plot(data(1:1000));
