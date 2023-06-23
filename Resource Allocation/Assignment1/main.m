clc;clear;close all;
addpath([pwd,'/files']);
choice = menu('which part do you want to run?','Part1','Part2','Part3','Part4');
switch(choice)
    case 1
        %%
        %Parameter Initializing
        Nu=5;
        cell_area=50;
        sigma=10^-10;
        Pmax=1e-3;
        TSINR=ones(1,Nu)*0.05;
        Pinit=Pmax*rand(1,Nu);
        SINR=TSINR;
        Path_gain_coef=0.09;
        run TPC_Algorithm.m
        figure(1);
        cell_legend={};
        for i=1:5
            plot(Power_mat(:,i));
            hold on;
            cell_legend=[cell_legend,{['user ',num2str(i)]}];
        end
        legend(cell_legend,'FontSize',12,'TextColor','blue')
        %%
        figure(2);
        cell_legend={};
        for i=1:5
            plot(SINR_mat(:,i));
            hold on;
            cell_legend=[cell_legend,{['user ',num2str(i)]}];
        end
        
        legend(cell_legend,'FontSize',12,'TextColor','blue')
    case 2
        for Nu=5:10
            cell_area=50;
            sigma=10^-10;
            Pmax=1e-3;
            TSINR=ones(1,Nu)*0.05;
            Pinit=Pmax*rand(1,Nu);
            SINR=TSINR;
            Path_gain_coef=0.09;
            run TPC_Algorithm.m
            disp([num2str(Nu),' user isfeasibility :',num2str(isfeasible)]);
            disp([' Target SINR Squre Error :',num2str(sqrt(sum((SINR_mat(end,:)-0.05).^2)))]);
            err(Nu-4)=sqrt(sum((SINR_mat(end,:)-0.05).^2));
        end
        figure(1)
        plot(err)
    case 3
        for TSINR_val=0.01:0.01:1
            Nu=5;
            cell_area=50;
            sigma=10^-10;
            Pmax=1e-3;
            TSINR=ones(1,Nu)*TSINR_val;
            Pinit=Pmax*rand(1,Nu);
            SINR=TSINR;
            Path_gain_coef=0.09;
            run TPC_Algorithm.m
            disp(['Target SIN =:',num2str(TSINR_val),': user isfeasibility:',num2str(isfeasible)]);
        end
end