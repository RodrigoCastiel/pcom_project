function [ y ] = rayleigh_channel(D,d,L,s)
%Function that creates a Rayleigh fading channnel with D-paths, distance d
%and loss exponent L
%It also makes the convulution between the entering signal and the filter
%impulse response

%Real and imaginary parts of the filter
h_re = sqrt(d^-L).*randn(D,1);
h_im = sqrt(d^-L).*randn(D,1);
h = h_re + 1i*h_im;

%Applying the convolution
y = conv(s,h,('same'));

end

