function plot_waveform( waveform, bit_rate, fs )
%PLOT_WAVEFORM Plots a generic waveform assuming that it was sampled.
%              at fs. It also uses the bit_rate of the sent PCM to
%              render and scales the curve.            
%   plot_waveform( waveform, bit_rate, fs )
%   waveform  -> discrete signal of doubles. 
%   bit_rate  -> bits per second in the sent PCM.
%   fs        -> freq_sampling of waveform.
%
%   Authors: Rodrigo Castiel <rcrs2@cin.ufpe.br>
%            Geovanny Lucas  <gllp@cin.ufpe.br>           
%   Date:    June 11, 2017.
    
    Ts = 1.0/fs;       % Sampling period. 
    Tb = 1.0/bit_rate; % Bit period (acts like a reference).

    % Find y-axis boundaries.
    vmax = max(waveform);
    vmin = min(waveform);
    
    % Generate vector with time values.
    % > t = [0 Ts 2Ts .. (L-1)Ts]
    t = 0:numel(waveform)-1;
    t = t .* Ts;
    
    p = plot(t, waveform, '-r');
    ylabel('Amplitude (V)');
    xlabel('Time (s)');
    set(p,'LineWidth', 2.5);
    grid on;
    axis([0.0 t(end) 2*vmin 2*vmax]);
    
    % Plot vertical lines sampled at bit rate.
    hold on;
    tb = 0.0;
    while (tb <= t(end))
        plot([tb, tb], [1.5*vmax, 1.5*vmin], '-b');
        tb = tb+Tb;
    end
    hold off;
end

