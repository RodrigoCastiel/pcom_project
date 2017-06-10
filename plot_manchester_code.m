function plot_manchester_code( bin_sequence, freq_sampling, peak_amplitude )
%PLOT_CODE Plots a binary waveform.
%   Authors: Rodrigo Castiel <rcrs2@cin.ufpe.br>
%            Geovanny Lucas  <gllp@cin.ufpe.br>           
%   Date:    June 10, 2017.

    Ts = (1.0/freq_sampling); % Sampling period. 
    Tc = Ts/2.0;              % Clock period.

    % v are the key points in the waveform.
    v = [bin_sequence; bin_sequence];
    v = v(:)';
    v = 2*v*peak_amplitude - peak_amplitude;
    
    % Generate vector with time values.
    % > t = [0 Tc Tc 2Tc 2Tc ... LTc]
    t = 1:length(bin_sequence)-1;
    t = [t; t];
    t = t(:)';
    t = [0, t, length(bin_sequence)];
    t = t .* Tc;
    
    p = plot(t, v, '-r');
    ylabel('Amplitude (V)');
    xlabel('Time (s)');
    set(p,'LineWidth', 2.5);
    grid on;
    axis([0.0 t(end) -2*peak_amplitude +2*peak_amplitude]);
    
    % Plot vertical lines sampled at freq_sampling.
    hold on;
    for ts = 0:length(bin_sequence)/2
        plot(Ts*[ts, ts], peak_amplitude*[1.5, -1.5], '--b');
    end
    hold off;
    
end

