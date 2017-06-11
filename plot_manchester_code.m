function plot_manchester_code( bin_code, bit_rate, vp )
%PLOT_CODE Plots a binary waveform.
%   bin_code -> manchester code generated from a PCM signal.
%   bit_rate -> bit rate of the original PCM signal.
%   vp       -> peak tension of the signal.
%
%   Authors: Rodrigo Castiel <rcrs2@cin.ufpe.br>
%            Geovanny Lucas  <gllp@cin.ufpe.br>           
%   Date:    June 10, 2017.

    Ts = (1.0/bit_rate);      % Sampling period. 
    Tc = Ts/2.0;              % Clock period.

    % v are the key points in the waveform.
    v = [bin_code; bin_code];
    v = v(:)';
    v = 2*v*vp - vp;
    
    % Generate vector with time values.
    % > t = [0 Tc Tc 2Tc 2Tc ... LTc]
    t = 1:numel(bin_code)-1;
    t = [t; t];
    t = t(:)';
    t = [0, t, length(bin_code)];
    t = t .* Tc;
    
    p = plot(t, v, '-r');
    ylabel('Amplitude (V)');
    xlabel('Time (s)');
    set(p,'LineWidth', 2.5);
    grid on;
    axis([0.0 t(end) -2*vp +2*vp]);
    
    % Plot vertical lines sampled at bit rate.
    hold on;
    for ts = 0:numel(bin_code)/2
        plot(Ts*[ts, ts], vp*[1.5, -1.5], '--b');
    end
    hold off;
    
end

