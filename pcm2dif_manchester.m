function [output_code] = pcm2dif_manchester( pcm_code )
%pcm2dif_manchester_code Generates the output of Diferential Manchester code from 'pcm_code'.
%   0 -> __ or --
%   1 -> _- or -_
%   Authors: Rodrigo Castiel <rcrs2@cin.ufpe.br>
%            Geovanny Lucas  <gllp@cin.ufpe.br>           
%   Date:    June 10, 2017.
%   Reference: https://en.wikipedia.org/wiki/Differential_Manchester_encoding
%   (Manchester IEEE 805.2)

    % Generate clock signal by alternating 0s and 1s.
    L = numel(pcm_code);
    clock = [zeros(1, L); ones(1, L)];
    clock = clock(:)';
    last_zero = false;
    
    % Generate output_code by doing xor operation of the input code
    % with the clock signal. Notice that both clock and output_code 
    % are 2*L long.
    output_code = [pcm_code; pcm_code];
    output_code = output_code(:)';
    
    % XOR operation between input code and clock, when the last zero didn't change the sequency order, and ~XOR when it changes.
    L = numel(output_code);    
    
    for i = 1:2:L
        if (output_code(i) == false)
            
            output_code(i) = (true == last_zero);
            output_code(i+1) = (true == last_zero);
            last_zero = xor(last_zero,true);
        
        else
            
            if (last_zero == 0)
                output_code(i) = (output_code(i) == clock(i));
                output_code(i+1) = (output_code(i+1) == clock(i+1));
            
            else
                output_code(i) = (output_code(i) ~= clock(i));
                output_code(i+1) = (output_code(i+1) ~= clock(i+1));
            
            end
            
        end
        
    end
    %We now transform the output_code in a logical array
    output_code = logical(output_code);
end

