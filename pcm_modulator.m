function waveform = pcm_modulator( m_code, vp, nb )
%CODE_TO_WAVEFORM Converts a Manchester code into a waveform.
%   manchester_code -> output of pcm2manchester or pcm2dmanchester. 
%   vp              -> peak tension.
%   nb              -> number of samples per bit (power of 2, >= 2^3).
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

    L = numel(m_code);
    n = nb/4;

    % Initial supersampling.
    waveform = zeros(1, n*L);
    
    k = 1;
    for i = 1:L
        for j = 1:n
            waveform(k) = 2*vp*m_code(i) - vp;
            k = k+1;
        end
    end
    
    % Interpolate values to increase sampling.
    N = nb * L;
    waveform = interp1(1:4:N, waveform, 1:N);
end

