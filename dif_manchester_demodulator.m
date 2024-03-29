function pcm_code = dif_manchester_demodulator( waveform, vp, nb )
    
    % First step: generate signals s00(t), s01(t), s10(t) and s11(t).
    % Manchester Diferential IEEE 805.2.
    half_n = idivide(int32(nb), 2);
    
    s10 = [ones(1, half_n) zeros(1, half_n)];  % --__
    s11 = [zeros(1, half_n) ones(1, half_n)];  % __--
    
    s00 = zeros(1,nb); % ____
    s01 = ones(1,nb);  % ----
    
    s10 = 2*vp*s10 - vp;
    s11 = 2*vp*s11 - vp;
    
    s00 = 2*vp*s00 - vp;
    s01 = 2*vp*s01 - vp;
    
    % Split input waveform into windows of size nb; then,
    % compute the cross-correlation between the input and the s00, s01, s10 and s11.
    % Choose si with the largest correlation.
    wi = 1;
    wf = nb;
    L = numel(waveform);
    
    pcm_code = [];
    
    while (wi < L)
        p00 = sum(s00.*waveform(wi:wf));
        p01 = sum(s01.*waveform(wi:wf));
        
        p10 = sum(s10.*waveform(wi:wf));
        p11 = sum(s11.*waveform(wi:wf));
        
        p0 = max(p00,p01);
        p1 = max(p10,p11);
        
        if (p0 > p1)
            bit = 0;
        else
            bit = 1;
        end;
        
        pcm_code = [pcm_code, bit];
       
        wi = wi+nb;
        wf = wf+nb;        
    end
end
