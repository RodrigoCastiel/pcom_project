clear;
close all;

%% Experiment parameters.
k = 8;
% M = 2^k;
vp = 5;   % peak tension = 5V.
nb = 32;  % number of samples per PCM bit.
Rs = 1e5; % 100k pulses per second.
t = linspace(0, 1, Rs);
raw_data = 80*cos(4*pi*t) + 100;
%plot(t, raw_data);

%% Quantization: convert raw_data into M-PAM, for M = 256.
in8bit = uint8(raw_data);
%plot(t, in8bit);

% Total length of the transmitted/received waveform.
L = numel(in8bit)*k*nb;

%% Run exp_manchester and exp_diff_manchester for different sigma values.
N = 50;
M = 1;
manchester_pb  = zeros(1, N);
manchester_snr = zeros(1, N);
dmanchester_pb  = zeros(1, N);
dmanchester_snr = zeros(1, N);
i = 1;
for sigma = linspace(1e-10*vp, 5.0*vp, N)
    pb_m = 0.0;
    pb_d = 0.0;
    
    % For each sigma, run M times and compute the average SNR and Pb.
    for j = 1:M
        % Generate Rayleigh fading.
        noise = normrnd(0.0, sigma, 1, L);
        R = sqrt(-2.0*log(rand(1, L)));
        
        % Run different line codes.
        [~, snr_m, pb_mj] = exp_manchester(in8bit, noise, vp, nb, R);
        [~, snr_d, pb_dj] = exp_diff_manchester(in8bit, noise, vp, nb, R);
        pb_m = pb_m + pb_mj;
        pb_d = pb_d + pb_dj;
    end
    pb_m = pb_m/M;
    pb_d = pb_d/M;
        
    manchester_pb(i) = pb_m;
    dmanchester_pb(i) = pb_d;
    manchester_snr(i)  = snr_m;
    dmanchester_snr(i) = snr_d;
    
    i = i+1;
end

% to dB.
manchester_snr  = 10*log10(manchester_snr);
dmanchester_snr = 10*log10(dmanchester_snr);

%% Plot data.
figure;
p1 = semilogy(manchester_snr, manchester_pb, '-r');
hold on;
p2 = semilogy(dmanchester_snr, dmanchester_pb, '--b');
hold off;
set(p1,'LineWidth', 2.0);
set(p2,'LineWidth', 2.0);

title('Efficiency Curve - PCM with Rayleigh fading and AWGN');
legend('Manchester IEEE 802.3', 'Differential Manchester');
ylabel('Bit error probability Pb');
xlabel('SNR (dB)');
grid on;
print('imgs/Man_vsDiffMan_efficiency_rayleigh','-dpng','-r0');