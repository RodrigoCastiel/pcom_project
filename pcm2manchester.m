function output_code = pcm2manchester( pcm_code )
%MANCHESTER_CODE Generates the output of Manchester code from 'pcm_code'.
%   Manchester IEEE 802.3
%   0 -_   1 _-
%   Authors: Rodrigo Castiel <rcrs2@cin.ufpe.br>
%            Geovanny Lucas  <gllp@cin.ufpe.br>           
%   Date:    June 10, 2017.
%   Reference: https://en.wikipedia.org/wiki/Manchester_code

    % Generate clock signal by alternating 0s and 1s.
    L = numel(pcm_code);
    clock = [zeros(1, L); ones(1, L)];
    clock = clock(:)';
    
    % Generate output_code by doing xor operation of the input code
    % with the clock signal. Notice that both clock and output_code 
    % are 2*L long.
    output_code = [pcm_code; pcm_code];
    output_code = output_code(:)';
    
    % XOR operation between input code and clock.
    output_code = (output_code == clock);  
end