function r_2 = Recei(sym_mod,sig_rec,N,M)
    com1=(ones(N,1)*sym_mod)';
    com1=((abs(com1)).^2)./com1;
    com2=ones(M,1)*sig_rec;
    com=abs(com1-com2);
    com=com.^2;
    fi=ones(M,1)*min(com,[],1);
    min_matrix=(fi==com);
    r_2=sym_mod*min_matrix;
    
end