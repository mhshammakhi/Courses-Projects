function dec=gray2dec(gra)
[N,bit]=size(gra);
for i=1:N
    for j=1:bit
        b(j)=mod(sum(gra(i,1:j)),2);
    end
    dec(i)=bin2dec(num2str(b));
end


end