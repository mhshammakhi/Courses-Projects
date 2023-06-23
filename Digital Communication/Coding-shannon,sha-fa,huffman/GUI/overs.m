mode=2;
switch mode
%%
%Gain Margin
    case 1
            i=1;
        for a=1:-0.01:0.1
            [mar(i),~,~,~]=margin(a*g/(1+a*g));
            i=i+1;
        end
%%    
%OverShoot
    case 2

        for a=1:-0.01:0.1
            temp=stepinfo(a*g/(1+a*g));
                if(temp.Overshoot==0)
                    break;
                end
        end
end

