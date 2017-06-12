function waveform = pcm_modulator( m_code, vp, nb )
%CODE_TO_WAVEFORM Converts a Manchester code into a waveform.
%   waveform = pcm_modulator( m_code, vp, nb )
%   manchester_code -> output of pcm2manchester or pcm2dmanchester. 
%   vp   -> peak tension.
%   nb   -> number of samples per bit in the original PCM (power of 2, >= 2^3).
%   The output waveform will contain length(m_code)*(nb/2) elements.
%
%   Authors: Rodrigo Castiel <rcrs2@cin.ufpe.br>
%            Geovanny Lucas  <gllp@cin.ufpe.br>           
%   Date:    June 10, 2017.
%
% +++++++++++++++++++++++++++++    
%    1     2     ...     L
% -------_______-------______
% |  |  | |  |  |  |  |  |  |
% 1  2  3 ...   i  ...      N
% +++++++++++++++++++++++++++++
    nb = nb/2;

    L = numel(m_code);
    n = nb;%/4;

    % Initial supersampling.
    waveform = zeros(1, n*L);
    
    k = 1;
    for i = 1:L
        for j = 1:n
            waveform(k) = 2*vp*m_code(i) - vp;
            k = k+1;
        end
    end
    
    % Simulate a non-perfect waveform generator (by smoothing the edges).
    h_len = (nb/8);
    h = ones(1, h_len)/h_len;
    waveform = conv(waveform, h, 'same');
end

