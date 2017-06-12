clear;
close all;

k = 8;     % log2(M).
M = 2^k;   % 256-PAM.
Rs = 1;    % Symbol rate of M-PAM.
vp = 5.0;  % Peak tension in volts.
nb = 64;   % Oversampling rate (per PCM bit).
noise_std = 0.1*vp;

pam_in = [3, 14, 15]; %, 92, 65, 35, 89, 79, 32, 38, 46, 26]; % Input signal.
%pam_in = 50*cos(0:0.01:6*3.141592) + 60;
% pam_in = uint8(pam_in);

pam_in = uint8(pam_in);

% Send signal.
pcm_in = pam2pcm(pam_in, M);
waveform_in = pcm_modulator(pcm2manchester(pcm_in), vp, nb);
Rb = k * Rs;   % Bit rate of PCM.
Fs = Rb * nb;  % Frequency of sampling in waveform.

% Sent waveform.
subplot(3, 1, 1);
plot_waveform(waveform_in, Rb, Fs); title('Sent waveform');

%---------------------------
% Channel: AWGN and Rayleigh.
R = sqrt(-2.0*log(rand(size(waveform_in))));
noise = randn(size(waveform_in)) * noise_std;

waveform_out = R.*waveform_in + noise;
waveform_out_est = real(waveform_out ./ R);

%---------------------------

% Received waveform.
subplot(3, 1, 2);
plot_waveform(waveform_out, Rb, Fs); title('Received waveform');
% Waveform estimate.
subplot(3, 1, 3);
plot_waveform(waveform_out_est, Rb, Fs); title('Waveform Estimate');

% 
% subplot(2, 1, 2);
% plot_waveform(abs(waveform_out), Rb, Fs); title('Received waveform');
% print('imgs/SampleManchester_noise=vp','-dpng','-r0');

% Output PCM.
pcm_out = manchester_demodulator(waveform_out_est, vp, nb);
pam_out = pcm2pam(pcm_out, k);

%figure;
% hold on; 
% plot(pam_in, '-b'); plot(pam_out, '-r');
% hold off;

% Error.
epsilon = sum(pcm_in ~= pcm_out)/numel(pcm_in)
