% Testing encoding and decoding modules.
% Input.
k = 32;
M = 2^k;
pam_in = [255, 143, 45, 0, 0, 2, 80, 179];
pcm_in = pam2pcm(pam_in, M);
man_in = pcm2manchester(pcm_in);
dif_man_in = pcm2dif_manchester(pcm_in);

man_out = man_in;
dif_man_out = dif_man_in;
pcm_out = manchester2pcm(man_out);
pcm_out_dif = dif_manchester2pcm(dif_man_out);
pam_out = pcm2pam(pcm_out, k);
pam_out_dif = pcm2pam(pcm_out_dif, k);