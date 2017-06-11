function pcm_code = manchester_demodulator( waveform, vp, nb )
    
    % First step: generate signals s0(t) and s1(t).
    % Manchester IEEE 802.3.
    half_n = idivide(int32(nb), 2);
    s0 = [ones(1, half_n) zeros(1, half_n)];  % --__
    s1 = [zeros(1, half_n) ones(1, half_n)];  % __--
    s0 = 2*vp*s0 - vp;
    s1 = 2*vp*s1 - vp;
    
    % Split input waveform into windows of size nb; then,
    % compute the cross-correlation between the input and the s0, s1.
    % Choose si with the largest correlation.
    wi = 1;
    wf = nb;
    L = numel(waveform);
    
    pcm_code = [];
    
    while (wi < L)
        p0 = sum(s0.*waveform(wi:wf));
        p1 = sum(s1.*waveform(wi:wf));
        
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
