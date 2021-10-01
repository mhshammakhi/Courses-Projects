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
%      applied to the GUI before prj1_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to prj1_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help prj1

% Last Modified by GUIDE v2.5 07-Apr-2015 03:07:50

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

axes(handles.axes5);
imshow('mh.jpg');
% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1


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

N=10000;
gamma = 0:25;
noe = get(handles.popupmenu1,'value');
inp2=0;
switch noe
    case 1
    fb=5;
    nop=[1,3,6,9,11];d_m=4;
    case 2
    fb=3;
    nop=[1,3,6];d_m=4;
    case 3
    fb=1;
    M=16;
    nop=1;d_m=2;
    landa=3.15;
    inp1=landa;
    case 4
    fb=1;
    M=32;
    landa1=2.84;
    landa2=5.27;
    inp1=landa1;
    inp2=landa2;
    nop=1;d_m=2;
end
for b=1:fb
    for k=1:length(gamma)
    switch noe
    case 1
    M=2^b;
    inp1=M;
    case 2
    M=2^(2*b);
    inp1=M;
    end
    sig_index =  floor(M*rand(1,N)+1);
    [T_sig,sig_mod] = Trans(noe,sig_index,inp1,inp2);
    subplot(ceil(fb/2),d_m,nop(b):nop(b)+1,'Parent',handles.uipanel3);
    plot(real(T_sig),imag(T_sig),'.')
    if(noe==1)
        axis([-1,1,-1,1]);
    end
    r = Chnl(noe,T_sig,gamma(k),N,M);
    subplot(ceil(fb/2),d_m,nop(b):nop(b)+1,'Parent',handles.uipanel2);
    plot(real(r),imag(r),'.')
    r_2 = Recei(sig_mod,r,N,M);
    error(b,k)=length( nonzeros(r_2-T_sig));
    end
end

SER = error/N;
axes(handles.axes1);
hold off;
for b=1:fb
    BER = SER(b,:)/b;
    semilogy(gamma,BER)
    hold all;
    grid;
end
