function varargout = prj1(varargin)
% PRJ1 MATLAB code for prj1.fig
%      PRJ1, by itself, creates a new PRJ1 or raises the existing
%      singleton*.
%
%      H = PRJ1 returns the handle to a new PRJ1 or the handle to
%      the existing singleton*.
%
%      PRJ1('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PRJ1.M with the given input arguments.
%
%      PRJ1('Property','Value',...) creates a new PRJ1 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before guidprj1_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to prj1_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help prj1

% Last Modified by GUIDE v2.5 14-Apr-2016 16:50:35

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @prj1_OpeningFcn, ...
    'gui_OutputFcn',  @prj1_OutputFcn, ...
    'gui_LayoutFcn',  [] , ...
    'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT



% --- Executes just before prj1 is made visible.
function prj1_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to prj1 (see VARARGIN)

% Choose default command line output for prj1
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes prj1 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = prj1_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1
set(handles.listbox3,'visible','off')


% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
project_num=get(handles.listbox2,'value');
switch project_num
    case 1
        sig_modu=get(handles.popupmenu1,'value');
    case 2
        sig_modu=get(handles.popupmenu2,'value');
        
end
SNR=linspace(-10,30,25);
N=get(handles.edit1,'string');N=str2double(N);
N = 2^ceil(log2(N));
data_bit = randsrc(N,1,[1 0]);
gamma = 0:25;
inp2=0;

switch project_num
    case 1
        
    case 2
        %         list3_vis=strcmp(get(handles.listbox3,'visible'),'on')
        coh=0;is_gray=0;
        modu_mode=sig_modu;
        [data_power,sig_Trans,ber_mod,precod,coh]=Trans(data_bit,sig_modu,get(handles.listbox3,'value'),is_gray);
        %% Passing through AWGN Channel
        
        Sig_Chnl=Chnl(sig_Trans,SNR,sig_modu,data_power,length(data_bit));
        %% Demodulation Process
        [data_demod,hError]= Recei(SNR,sig_modu,Sig_Chnl);
        %%
        %Plot Transmited data
        subplot(1,1,1,'Parent',handles.uipanel3);
        plot(real(sig_Trans),imag(sig_Trans),'*')
        ax =[min(real(sig_Trans)),max(real(sig_Trans)),min(imag(sig_Trans)),max(imag(sig_Trans))];
        ax=[-0.1,0.1,-0.1,0.1].*abs(ax)+ax;
        ax=[min(ax(1),-1.1),max(ax(2),1.1),min(ax(3),-1.1),max(ax(4),1.1)];
        axis(ax);
        %%
        if (sig_modu==3)
            dim=1;
        else
            dim=2;
        end
        
        for i=1:length(SNR)
            subplot(sqrt(numel(SNR)),sqrt(numel(SNR)),i,'Parent',handles.uipanel2);
            plot(real(Sig_Chnl(:,i)),imag(Sig_Chnl(:,i)),'.');
            ax =[min(real(Sig_Chnl(:,i))),max(real(Sig_Chnl(:,i))),min(imag(Sig_Chnl(:,i))),max(imag(Sig_Chnl(:,i)))];
            ax=[-0.1,0.1,-0.1,0.1].*abs(ax)+ax;
            ax=[min(ax(1),-1.1),max(ax(2),1.1),min(ax(3),-1.1),max(ax(4),1.1)];
            axis(ax);
            err(i)=mean(data_demod(:,i)~=data_bit);
            
        end
        subplot(1,1,1,'Parent',handles.uipanel4);
        
        err_calcu=1;
        switch err_calcu
            case 1
                run Err_Cal;
                semilogy(snr_vec,(ber_vec));
                grid on
                title(['BER vs SNR']);
                xlabel('SNR(dB)');ylabel('BER ');
                set(gca,'XTick',(min(snr_vec):2:max(snr_vec)),...
                    'ylim',[1E-8 1E0],...
                    'xlim',[min(snr_vec) max(snr_vec)]);
                hold on
                semilogy(snr_vec,ErrRate,'r');
                
                semilogy(snr_vec,intvl,'g');
                
                legend('Theory','Empirical','Monte-Carlo');
                hold off;
            case 2
                
                plot(1:size(SNR,2),err);
        end
end

% --- Executes on selection change in listbox2.
function listbox2_Callback(hObject, eventdata, handles)
% hObject    handle to listbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox2
project_num=get(handles.listbox2,'value');
switch project_num
    case 1
        set(handles.popupmenu1,'visible','on')
        set(handles.popupmenu2,'visible','off')
        set(handles.listbox3,'visible','off')
    case 2
        set(handles.popupmenu1,'visible','off')
        set(handles.popupmenu2,'visible','on')
        if get(handles.popupmenu2,'value')==7
            set(handles.listbox3,'visible','on')
        end
end

% str1=['np= ',num2str(a)];
% set(handles.text2,'string',str1);


% --- Executes during object creation, after setting all properties.
function listbox2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu2.
function popupmenu2_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu2
modu=get(handles.popupmenu2,'value');
if modu==7
    set(handles.listbox3,'visible','on')
else
    set(handles.listbox3,'visible','off')
end

% --- Executes during object creation, after setting all properties.
function popupmenu2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox3.
function listbox3_Callback(hObject, eventdata, handles)
% hObject    handle to listbox3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox3 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox3


% --- Executes during object creation, after setting all properties.
function listbox3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox4.
function listbox4_Callback(hObject, eventdata, handles)
% hObject    handle to listbox4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox4 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox4


% --- Executes during object creation, after setting all properties.
function listbox4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
