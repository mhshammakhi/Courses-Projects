function r = Chnl(noe,B_ch,gamma,N,M)
n=randn(1,N) + 1j*randn(1,N);
    N0 = 2;
    SNR = 10.^(0.1*gamma);
    E = SNR*N0;
if (noe==2) 
    E = ( 3*log2(sqrt(M))*E )/(M-1 );
end
r = B_ch + n/sqrt(E);
end