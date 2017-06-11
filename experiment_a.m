k = 8;     % log2(M).
M = 2^k;   % 256-PAM.
Rs = 1;    % Symbol rate of M-PAM.
vp = 5.0;  % Peak tension in volts.
nb = 128;  % Oversampling rate (per PCM bit).
noise_variance = vp/10.0;

pam_in = [3, 14, 15, 92, 65, 35, 89, 79, 32, 38, 46, 26]; % Input signal.

% Send signal.
pcm_in = pam2pcm(pam_in, M);
waveform_in = pcm_modulator(pcm2manchester(pcm_in), vp, nb);
Rb = k * Rs;   % Bit rate of PCM.
Fs = Rb * nb;  % Frequency of sampling in waveform.

% Sent waveform.
subplot(2, 1, 1);
plot_waveform(waveform_in, Rb, Fs); title('Sent waveform');

% Simulate additive white gaussian noise.
noise = randn(size(waveform_in)) * noise_variance;

% Received waveform.
waveform_out = waveform_in + noise;
subplot(2, 1, 2);
plot_waveform(waveform_out, Rb, Fs); title('Received waveform');