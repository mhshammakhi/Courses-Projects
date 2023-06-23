clc;clear;close all;
addpath([pwd,'/files']);
choice = menu('which part do you want to run?','Ex1 Part1','Ex1 Part2','Ex1 Part3','Ex2');
switch(choice)
    case 1
        %%
        %Parameter Initializing
        Nu=5;
        cell_area=100;
        sigma=1e-10;
        Pmax=1;
        Pinit=0.5*Pmax*ones(1,Nu);
        Path_gain_coef=0.1;
        OPC_constant=0.05;
        %%
        %define location
        user_loc=(cell_area*rand(2,Nu)-50);
        run OPC_Algorithm.m
        figure(1);
        cell_legend={};
        for i=1:Nu
            plot(Power_mat(:,i));
            hold on;
            cell_legend=[cell_legend,{['user ',num2str(i)]}];
        end
        title([num2str(Nu),' User Power']);
        xlabel('time')
        ylabel('Power')
        legend(cell_legend,'FontSize',12,'TextColor','blue')
        %%
        figure(2)
        cell_legend={};
        for i=1:Nu
            plot(SINR_mat(:,i));
            hold on;
            cell_legend=[cell_legend,{['user ',num2str(i)]}];
        end
        title([num2str(Nu),' User SINR']);
        xlabel('time')
        ylabel('SINR')
        legend(cell_legend,'FontSize',12,'TextColor','blue')
    case 2
        %%
        %Parameter Initializing
        Nu=5;
        cell_area=100;
        sigma=1e-10;
        Pmax=1;
        Pinit=0.5*Pmax*ones(1,Nu);
        Path_gain_coef=0.1;
        %define location
        user_loc=(cell_area*rand(2,Nu)-50);
        n_i=1;
        for i=0.05:0.01:1
            OPC_constant=i;
            run OPC_Algorithm.m
            SinrTotal(n_i,:)=SINR_mat(end,:);
            n_i=n_i+1;
        end
        figure(1);
        cell_legend={};
        %%
        figure(1)
        cell_legend={};
        for i=1:Nu
            plot(0.05:0.01:1,log2(1+SinrTotal(:,i)));
            hold on;
            cell_legend=[cell_legend,{['user ',num2str(i)]}];
        end
        title([num2str(Nu),' User SINR']);
        xlabel('OPC Constant')
        ylabel('Sum Rate')
        legend(cell_legend,'FontSize',12,'TextColor','blue')
    case 3
        %%
        %Parameter Initializing
        Nu=5;
        cell_area=100;
        sigma=1e-10;
        Pmax=1;
        Pinit=0.5*Pmax*ones(1,Nu);
        Path_gain_coef=0.1;
        %define location
        user_loc=(cell_area*rand(2,Nu)-50);
        n_i=1;
        for i=0.05:-0.01:0.01
            OPC_constant=i;
            run OPC_Algorithm.m
            SinrTotal(n_i,:)=SINR_mat(end,:);
            n_i=n_i+1;
        end
        figure(1);
        cell_legend={};
        %%
        figure(1)
        cell_legend={};
        for i=1:Nu
            plot(0.05:-0.01:0.01,log2(1+SinrTotal(:,i)));
            hold on;
            cell_legend=[cell_legend,{['user ',num2str(i)]}];
        end
        title([num2str(Nu),' User SINR']);
        xlabel('OPC Constant')
        ylabel('Sum Rate')
        legend(cell_legend,'FontSize',12,'TextColor','blue')
    case 4
        %%
        %Parameter Initializing
        Nu=9;
        sigma=1e-10;
        Pmax=1;
        Pinit=1*Pmax*ones(1,Nu);
        Path_gain_coef=0.1;
        OPC_constant=0.5;
        run OPC_Algorithm2.m
        figure(1);
        cell_legend={};
        for i=1:Nu
            plot(0:1e-3:30,PowerMatrix(:,i));
            hold on;
            cell_legend=[cell_legend,{['user ',num2str(i)]}];
        end
        title([num2str(Nu),' User Power']);
        xlabel('time')
        ylabel('Power')
        legend(cell_legend,'FontSize',12,'TextColor','blue')
        %%
        figure(2)
        cell_legend={};
        for i=1:Nu
            plot(0:1e-3:30,SinrMatrix(:,i));
            hold on;
            cell_legend=[cell_legend,{['user ',num2str(i)]}];
        end
        title([num2str(Nu),' User SINR']);
        xlabel('time')
        ylabel('SINR')
        legend(cell_legend,'FontSize',12,'TextColor','blue')
end