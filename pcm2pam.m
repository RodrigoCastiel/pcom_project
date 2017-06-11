function [ pam_signal, M ] = pcm2pam( pcm_code, k )
%PCM_ENCODER Converts a k-PCM sequence into a M-PAM signal (sequence).
%   [ pam_signal, M ] = pcm2pam( pcm_code, k )
%   pcm_code -> row vector containing L samples. 
%   k        -> number of bits per symbol.
%
%   pam_signal will contain L/k.
%   M = 2^k.
%   k = log2(M).
%
%   Authors: Rodrigo Castiel <rcrs2@cin.ufpe.br>
%            Geovanny Lucas  <gllp@cin.ufpe.br>           
%   Date:    June 10, 2017.
    
    L = numel(pcm_code);     
    num_samples = idivide(uint32(L), uint32(k));
    pam_signal = zeros(1, num_samples);
    M = 2^k;
    
    for i = 0:num_samples-1
        binary = pcm_code(i*k+1:(i+1)*k);
        pam_signal(i+1) = sum(2.^(k-1:-1:0).*binary);
    end
end