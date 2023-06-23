%% Mean-Shift Video Tracking
% by Mohammad Hasan Shammakhi
% Jan 2016
%% Description
% This is a simple example of how to use
% the Mean-Shift video tracking algorithm
% implemented in 'MeanShift_Algorithm.m'.
% It imports the video 'Ball.avi' from
% the 'Videos' folder and tracks a selected
% feature in it.
% The resulting video sequence is played after
% tracking, but is also exported as a AVI file
% 'Movie_out.avi' in the 'Videos' folder.

clear;clc;
close all;
warning off;

%% Import movie
% and time it with tic/toc
address=which('main');address(end-6:end)=[];
cd(address);cd('files')
tic
[temp,path] = uigetfile('*.avi','Select the Video file');
Movie=Import_mov([path,temp]);
% Movie=Import_mov('C:\Users\mh\Desktop\computer vision code\motinas_emilio_webcam\motinas_emilio_webcam.avi');
% which()
toc
Movie.Length=250;
%{
%% Play the movie
% % Put the figure in the center of the screen,
% % without axes and menu bar.
% scrsz = get(0,'ScreenSize');
% figure('Position',[scrsz(3)/2-width/2 scrsz(4)/2-height/2 width height],...
%     'MenuBar','none');
% axis off
% % Image position inside the figure
% set(gca,'Units','pixels','Position',[1 1 width height])
% % Play the movie
% movie(Movie);
%}
%% Variables
Prev_Frame=FrameStore();
Crnt_Frame=FrameStore();
Alrthm_Par=Alrthm_Param();
Alrthm_Par.index_start = 1;
% Similarity Threshold
Alrthm_Par.f_thresh = 0.96;
% Number max of iterations to converge
Alrthm_Par.max_it = 5;
% Parzen window parameters
Alrthm_Par.kernel_type = 'Gaussian';
Alrthm_Par.radius = 1;

%% Target Selection in Reference Frame
Prev_Frame = Select_patch(Movie.RGB(Alrthm_Par.index_start).cdata,0);
pause(0.2);
%% Run the Mean-Shift algorithm
% Calculation of the Parzen Kernel window
Parzen = Parzen_window(Prev_Frame.H,Prev_Frame.W,Alrthm_Par.radius,Alrthm_Par.kernel_type,0);
% Conversion from RGB to Indexed colours
% to compute the colour probability functions (PDFs)
[I,map] = rgb2ind(Movie.RGB(Alrthm_Par.index_start).cdata,65536);ind_Movie={I,map};clear I map;
Lmap = length(ind_Movie{2})+1;
%%
%
temp=detectFASTFeatures(rgb2gray(Prev_Frame.T_frame));
Prev_Frame.corners=temp.Location;
Prev_Frame.Corner_Struct=temp;
feature_HOG_Per={};
for i=1:size(Prev_Frame.corners,1)
    feature_HOG_Per{i}= extractHOGFeatures(Prev_Frame.Orginal(Prev_Frame.y0+Prev_Frame.corners(i,1)-4:Prev_Frame.y0+Prev_Frame.corners(i,1)+5, ...
        Prev_Frame.x0+Prev_Frame.corners(i,2)-4:Prev_Frame.x0+Prev_Frame.corners(i,2)+5,:),'CellSize',[5 5]);
end
Prev_Frame.Corner_HOG=feature_HOG_Per;
clear temp feature_HOG_Per;
temp=Prev_Frame.T_frame;
Prev_Frame.T_frame = rgb2ind(Prev_Frame.T_frame,ind_Movie{2});
% Estimation of the target PDF
q = Density_estim(Prev_Frame.T_frame,Lmap,Parzen{1},Prev_Frame.H,Prev_Frame.W,0);
% Flag for target loss
loss = 0;
% Similarity evolution along tracking
f = zeros(1,(Movie.Length-1)*Alrthm_Par.max_it);
% Sum of iterations along tracking and index of f
f_indx = 1;
% Draw the selected target in the first frame
Movie.RGB(Alrthm_Par.index_start).cdata = Draw_target(Prev_Frame.x0,Prev_Frame.y0,Prev_Frame.W,Prev_Frame.H,...
    Movie.RGB(Alrthm_Par.index_start).cdata,2);
Prev_Frame.T_frame=temp;
%%
% TRACKING
WaitBar = waitbar(0,'Tracking in progress, be patient...');
% From 1st frame to last one
%}
load('t_e_m_p.mat');
for t=1:Movie.Length-1
    disp(t);
    % Next frame
    Crnt_Frame.Orginal = rgb2ind(Movie.RGB(t+1).cdata,ind_Movie{2});
    % Apply the Mean-Shift algorithm to move (x,y)
    % to the target location in the next frame.
    [Crnt_Frame.x0,Crnt_Frame.y0,loss,f,f_indx] = MeanShift_Tracking(q,Crnt_Frame.Orginal,Lmap,...
        Movie.H,Movie.W,Alrthm_Par.f_thresh,Alrthm_Par.max_it,Prev_Frame.x0,Prev_Frame.y0,Prev_Frame.H,Prev_Frame.W,...
        Parzen{1},Parzen{2},Parzen{3},f,f_indx,loss);
    % Check for target loss. If true, end the tracking
    if loss == 2
        break;
    else
        %
        
        
        %
        Crnt_Frame.Orginal=(Movie.RGB(t+1).cdata);
        Crnt_Frame.T_frame= Crnt_Frame.Orginal(Prev_Frame.y0:Prev_Frame.y0+Prev_Frame.H-1,Prev_Frame.x0:Prev_Frame.x0+Prev_Frame.W-1,:);
        
        
        temp=detectFASTFeatures(rgb2gray(Crnt_Frame.T_frame));
        Crnt_Frame.corners=temp.Location;
        Crnt_Frame.Corner_Struct=temp;
        
        % Drawing the target location in the next frame
        Movie.RGB(t+1).cdata = Draw_target(Prev_Frame.x0,Prev_Frame.y0,Prev_Frame.H,Prev_Frame.W,Movie.RGB(t+1).cdata,2);
        feature_HOG_Cur={};
        for i=1:size(Crnt_Frame.corners,1)
            feature_HOG_Cur{i}= extractHOGFeatures(Crnt_Frame.Orginal(Crnt_Frame.y0+Crnt_Frame.corners(i,1)-4:Crnt_Frame.y0+Crnt_Frame.corners(i,1)+5, ...
                Crnt_Frame.x0+Crnt_Frame.corners(i,2)-4:Crnt_Frame.x0+Crnt_Frame.corners(i,2)+5,:),'CellSize',[5 5]);
        end
        Crnt_Frame.Corner_HOG=feature_HOG_Cur;
        clear temp feature_HOG_Per feature_HOG_Cur;
        err=[];
        for j=1:length(Prev_Frame.Corner_HOG)
            for i=1:length(Crnt_Frame.Corner_HOG)
                err(i,j)=sum((Crnt_Frame.Corner_HOG{i}-Prev_Frame.Corner_HOG{j}).^2);
            end
        end
        if ~isempty(err)
            [feature_final(1,1),feature_final(1,2)]=find(err==min(min(err)));min(min(err))
            err(feature_final(1,1),:)=100;err(:,feature_final(1,2))=100;
            if size(err,1)>1 & size(err,2)>1
                [feature_final(2,1),feature_final(2,2)]=find(err==min(min(err)));min(min(err))
            end
        
        %%
        
        subplot(1,2,1)
        imshow(Crnt_Frame.T_frame);hold all;
        plot(Crnt_Frame.Corner_Struct(feature_final(1,1)))
        point2=Crnt_Frame.Corner_Struct(feature_final(:,1));
        hold off;
        subplot(1,2,2)
        imshow(Prev_Frame.T_frame);hold all;
        plot(Prev_Frame.Corner_Struct(feature_final(1,2)))
        point1=Prev_Frame.Corner_Struct(feature_final(:,2));
        hold off;
        end
        pause;
        Crnt_Frame.H=Prev_Frame.H;
        Crnt_Frame.W=Prev_Frame.W;
        % Updating the waitbar
        waitbar(t/(Movie.Length-1));
        Prev_Frame=Crnt_Frame;
        clear point1 point2 feature_final Crnt_Frame err
    end
end
close(WaitBar);
%%%% End of TRACKING

%% Export/Show the processed movie
% Export the video sequence as an AVI file in the Videos folder
% WaitBar = waitbar(0,'Exporting the output AVI file, be patient...');
% movie2avi(Movie,'Videos\Movie_out','Quality',50);
% waitbar(1);
% close(WaitBar);

% Put a figure in the center of the screen,
% without menu bar and axes.
scrsz = get(0,'ScreenSize');
figure(1)
set(1,'Name','Movie Player','Position',...
    [scrsz(3)/2-Movie.W/2 scrsz(4)/2-Movie.H/2 Movie.W Movie.H],...
    'MenuBar','none');
axis off
% Image position inside the figure
set(gca,'Units','pixels','Position',[1 1 Movie.W Movie.H])
% Play the movie
movie(Movie.RGB);

%% End of File
%=============%