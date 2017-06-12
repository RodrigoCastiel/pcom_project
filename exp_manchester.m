function [ out8bit, snr, err_pcm ] = exp_manchester( in8bit, noise, vp, nb )
%EXP_MANCHASTER: 256-PAM -> PCM -> Manchester Mod -> Channel ->
%                        -> Manchester Demod -> PCM -> 256-PAM.
%   INPUT -----------------------------------------------------
%   in8bit -> 1D uint8-array of size L.
%   noise  -> AWGN: must be k*L*nb long.
%   vp     -> peak tension in volts.
%   nb     -> number of samples per PCM bit in receiver.
%   OUTPUT ----------------------------------------------------
%   out8bit -> 1D uint8-array of size L.
%   snr     -> signal-to-noise ratio of the received waveform.
%   err_pcm -> #wrong_bits/#bits in PCM.
%   -----------------------------------------------------------
%   Authors: Rodrigo Castiel <rcrs2@cin.ufpe.br>
%            Geovanny Lucas  <gllp@cin.ufpe.br>

    k = 8;     % log2(M).
    M = 2^k;   % 256-PAM.
    
    % Send signal.
    pcm_in = pam2pcm(in8bit, M);
    waveform_in = pcm_modulator(pcm2manchester(pcm_in), vp, nb);
    
    %----------------------------------------
    % Channel: add noise and Rayleigh fading.
    
    waveform_out = waveform_in + noise;
    
    %----------------------------------------

    % Output PCM.
    pcm_out = manchester_demodulator(waveform_out, vp, nb);
    out8bit = pcm2pam(pcm_out, k);
    
    % PCM error.
    err_pcm = sum(pcm_in ~= pcm_out)/numel(pcm_in);
    
    % SNR.
    snr = sum(waveform_in.^2)/sum(noise.^2);
    
    % subplot(2, 1, 1);
    % plot_waveform(waveform_in, Rb, Fs); title('Sent waveform');
    % subplot(2, 1, 2);
    % plot_waveform(waveform_out, Rb, Fs); title('Received waveform');
end

