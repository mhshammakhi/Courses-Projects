function varargout = p(varargin)
% P MATLAB code for p.fig
%      P, by itself, creates a new P or raises the existing
%      singleton*.
%
%      H = P returns the handle to a new P or the handle to
%      the existing singleton*.
%
%      P('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in P.M with the given input arguments.
%
%      P('Property','Value',...) creates a new P or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before p_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to p_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help p

% Last Modified by GUIDE v2.5 31-May-2014 11:58:50

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @p_OpeningFcn, ...
                   'gui_OutputFcn',  @p_OutputFcn, ...
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


% --- Executes just before p is made visible.
function p_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to p (see VARARGIN)

% Choose default command line output for p
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes p wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = p_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function nu_Callback(hObject, eventdata, handles)
% hObject    handle to nu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of nu as text
%        str2double(get(hObject,'String')) returns contents of nu as a double


% --- Executes during object creation, after setting all properties.
function nu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to nu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function lay2_Callback(hObject, eventdata, handles)
% hObject    handle to lay2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of lay2 as text
%        str2double(get(hObject,'String')) returns contents of lay2 as a double


% --- Executes during object creation, after setting all properties.
function lay2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lay2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function bitrate_Callback(hObject, eventdata, handles)
% hObject    handle to bitrate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of bitrate as text
%        str2double(get(hObject,'String')) returns contents of bitrate as a double


% --- Executes during object creation, after setting all properties.
function bitrate_CreateFcn(hObject, eventdata, handles)
% hObject    handle to bitrate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in rasm.
function rasm_Callback(hObject, eventdata, handles)
% hObject    handle to rasm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
m = (get(handles.lay2,'string'));
noo = (get(handles.nu,'string'));
rb = (get(handles.bitrate,'string'));
m=str2num(m);
noo=str2num(noo);
rb=str2num(rb);
u=[0.05:0.05:4];
x=u.^2;
sr=x/3*(m*m-1*noo*rb/(log(m)/log(2)));
qu=0.2*((u.^2-u+4).^0.5).*exp((-u.^2)/2);
pe=2*(1-1/m)*qu;
axes(handles.axes1)
hold off;
plot(sr,pe);
