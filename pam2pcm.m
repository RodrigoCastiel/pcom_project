function [output_pcm_code, k] = pam2pcm( input_sequence, M )
%PCM_ENCODER Converts a M-PAM signal (sequence) into a PCM.
%   [output_pcm_code, k] = pam2pcm( input_sequence, M )
%   input_sequence              -> row vector containing L samples. 
%   M [2^8, 2^16, 2^32 or 2^64] -> quantization.
%   output_pcm_code -> output sequence containing L x log2(M) samples.
%   k = log2(M).
%   Authors: Rodrigo Castiel <rcrs2@cin.ufpe.br>
%            Geovanny Lucas  <gllp@cin.ufpe.br>           
%   Date:    June 10, 2017.
    
    m_pam = input_sequence;
    k = uint32(ceil(log2(M)));  % k >= log2(M).

    % Force input to be M-PAM. 
%     if (k == 8)
%         m_pam = uint8(m_pam);
%     elseif (k == 16)
%         m_pam = uint16(m_pam);
%     elseif (k == 32)
%         m_pam = uint32(m_pam);
%     else
%         m_pam = uint64(m_pam);
%     end;

    L = numel(m_pam);
    output_pcm_code = [];%zeros(1, k*L, 'uint8');
    
    for i = 1:L
        bin_array = uint8(dec2bin(m_pam(i)) - '0');
        num_len = length(bin_array);
        
        if (num_len < k)
           bin_array = [zeros(1, k-num_len, 'uint8'), bin_array]; 
        end
        output_pcm_code = [output_pcm_code, bin_array];
    end
end

