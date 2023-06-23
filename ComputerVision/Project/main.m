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
%% Import movie
% and time it with tic/toc
address=which('main');address(end-6:end)=[];
cd(address);cd('files')
tic
[temp,path] = uigetfile('*.avi','Select the Video file');
Movie=Import_mov([path,temp]);
% Movie=Import_mov('C:\Users\mh\Desktop\computer vision code\motinas_emilio_webcam\motinas_emilio_webcam.avi');
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
Target = Select_patch(Movie.RGB(Alrthm_Par.index_start).cdata,0);
pause(0.2);

%% Run the Mean-Shift algorithm
% Calculation of the Parzen Kernel window
Parzen = Parzen_window(Target.H,Target.W,Alrthm_Par.radius,Alrthm_Par.kernel_type,0);
% Conversion from RGB to Indexed colours
% to compute the colour probability functions (PDFs)
[I,map] = rgb2ind(Movie.RGB(Alrthm_Par.index_start).cdata,65536);ind_Movie={I,map};clear I map;
Lmap = length(ind_Movie{2})+1;
Target.RGB = rgb2ind(Target.RGB,ind_Movie{2});
% Estimation of the target PDF
q = Density_estim(Target.RGB,Lmap,Parzen{1},Target.H,Target.W,0);
% Flag for target loss
loss = 0;
% Similarity evolution along tracking
f = zeros(1,(Movie.Length-1)*Alrthm_Par.max_it);
% Sum of iterations along tracking and index of f
f_indx = 1;
% Draw the selected target in the first frame
Movie.RGB(Alrthm_Par.index_start).cdata = Draw_target(Target.x0,Target.y0,Target.W,Target.H,...
    Movie.RGB(Alrthm_Par.index_start).cdata,2);
%%
% TRACKING
WaitBar = waitbar(0,'Tracking in progress, be patient...');
% From 1st frame to last one
feature_HOG_Per={};
for t=1:Movie.Length-1
    % Next frame
    I2 = rgb2ind(Movie.RGB(t+1).cdata,ind_Movie{2});
    % Apply the Mean-Shift algorithm to move (x,y)
    % to the target location in the next frame.
    [x,y,loss,f,f_indx] = MeanShift_Tracking(q,I2,Lmap,...
        Movie.H,Movie.W,Alrthm_Par.f_thresh,Alrthm_Par.max_it,Target.x0,Target.y0,Target.H,Target.W,...
        Parzen{1},Parzen{2},Parzen{3},f,f_indx,loss);
    % Check for target loss. If true, end the tracking
    if loss == 2
        break;
    else
        % Drawing the target location in the next frame
        Movie.RGB(t+1).cdata = Draw_target(x,y,Target.H,Target.W,Movie.RGB(t+1).cdata,2);
        % Next frame becomes current frame
        Target.y0 = y;
        Target.x0 = x;
        
        %%
        %
        temp=(Movie.RGB(t).cdata);
        temp=temp(Target.y0:Target.y0+Target.W-1,Target.x0:Target.x0+Target.H-1,:);
        imshow(temp);hold on;
        temp=detectFASTFeatures(rgb2gray(temp));
        corner_Loc=temp.Location;
        feature_HOG_Cur={};
        for i=1:size(corner_Loc,1)
            feature_HOG_Cur{i}= extractHOGFeatures(Movie.RGB(t).cdata(corner_Loc(i,1)-4:corner_Loc(i,1)+5, ...
                corner_Loc(i,2)-4:corner_Loc(i,2)+5),'CellSize',[5 5]);
        end
        for i=feature_HOG_Cur
            for j=feature_HOG_Per
            sum((cell2mat(i)-cell2mat(j)).^2);
            end
        end
        plot(temp.selectStrongest(size(temp,1)))
        hold off;
        pause;
        % Updating the waitbar
        waitbar(t/(Movie.Length-1));
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