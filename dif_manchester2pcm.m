function pcm_code = dif_manchester2pcm( dif_manchester_code )
%dif_manchester2pcm Generates a PCM sequence from a Differential Manchester code.
%   dif_manchester_code -> input code, where each pair of bits is a frame.
%   Manchester IEEE 805.2
%   0 -_   1 _-
%   Authors: Rodrigo Castiel <rcrs2@cin.ufpe.br>
%            Geovanny Lucas  <gllp@cin.ufpe.br>           
%   Date:    June 11, 2017.
%   Reference: https://en.wikipedia.org/wiki/Differential_Manchester_encoding

    % Generate clock signal by alternating 0s and 1s.
    L = numel(dif_manchester_code)/2;
    clock = [zeros(1, L); ones(1, L)];
    clock = clock(:)';
    
    % Generate pcm code by doing xor operation of the input code
    % with the clock signal. Notice that the output_code is L/2 long.
    pcm_code = dif_manchester_code;
    
    for i = 1:2:2*L
        pcm_code(i) = (pcm_code(i) == clock(i));
        pcm_code(i+1) = (pcm_code(i+1) == clock(i+1));
        if (pcm_code(i) == pcm_code(i+1))
            pcm_code(i) = 1&1;
        else
            pcm_code(i) = 1&0;
        end
    end
    
    pcm_code = pcm_code(1:2:end);
end

