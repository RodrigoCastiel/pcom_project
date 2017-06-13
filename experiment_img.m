clear;
close all;

k = 8;     % log2(M).
M = 2^k;   % 256-PAM.
Rs = 1;    % Symbol rate of M-PAM.
vp = 5.0;  % Peak tension in volts.
nb = 32;   % Oversampling rate (per PCM bit).
noise_std = 2.0*vp;

img_in  = imread('imgs/geomad.jpg');
img_out_1 = img_in;
img_out_2 = img_in;

pam_in = img_in(:)';
pam_in = uint8(pam_in);

% Send signal.
pcm_in = pam2pcm(pam_in, M);
waveform_in = pcm_modulator(pcm2manchester(pcm_in), vp, nb);
Rb = k * Rs;   % Bit rate of PCM.
Fs = Rb * nb;  % Frequency of sampling in waveform.

%---------------------------
% Channel: AWGN and Rayleigh.
R = sqrt(-2.0*log(rand(size(waveform_in))));
noise = randn(size(waveform_in)) * noise_std;

waveform_out_1 = waveform_in + noise;
waveform_out_2 = R.*waveform_in + noise;

waveform_out_est_1 = waveform_out_1;
waveform_out_est_2 = real(waveform_out_2 ./ R);
%---------------------------

% Output PCM.
pcm_out_1 = manchester_demodulator(waveform_out_est_1, vp, nb);
pam_out_1 = pcm2pam(pcm_out_1, k);

pcm_out_2 = manchester_demodulator(waveform_out_est_2, vp, nb);
pam_out_2 = pcm2pam(pcm_out_2, k);

img_out_1(:) = pam_out_1(:);
img_out_2(:) = pam_out_2(:);

imshowpair(img_out_1, img_out_2, 'montage');
% print('imgs/SampleDiffManchester_noise=vp','-dpng','-r0');

% Error.
snr = sum(waveform_in.^2/noise.^2)
epsilon_1 = sum(pcm_in ~= pcm_out_1)/numel(pcm_in)
epsilon_2 = sum(pcm_in ~= pcm_out_2)/numel(pcm_in)
