function pcm_code = dif_manchester2pcm( manchester_code )
%manchester2pcm Generates a PCM sequence from a Manchester code.
%   manchester_code -> input code, where each pair of bits is a frame.
%   Manchester IEEE 802.3
%   0 -_   1 _-
%   Authors: Rodrigo Castiel <rcrs2@cin.ufpe.br>
%            Geovanny Lucas  <gllp@cin.ufpe.br>           
%   Date:    June 11, 2017.
%   Reference: https://en.wikipedia.org/wiki/Differential_Manchester_encoding

    % Generate clock signal by alternating 0s and 1s.
    L = numel(manchester_code)/2;
    clock = [zeros(1, L); ones(1, L)];
    clock = clock(:)';
    
    % Generate pcm code by doing xor operation of the input code
    % with the clock signal. Notice that the output_code is L/2 long.
    pcm_code = manchester_code;
    pcm_code = (pcm_code == clock);
    pcm_code = pcm_code(1:2:end);
end

