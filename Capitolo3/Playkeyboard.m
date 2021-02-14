function varargout = Playkeyboard(varargin)
% PLAYKEYBOARD M-file for Playkeyboard.fig
%      PLAYKEYBOARD, by itself, creates a new PLAYKEYBOARD or raises the existing
%      singleton*.
%
%      H = PLAYKEYBOARD returns the handle to a new PLAYKEYBOARD or the handle to
%      the existing singleton*.
%
%      PLAYKEYBOARD('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PLAYKEYBOARD.M with the given input arguments.
%
%      PLAYKEYBOARD('Property','Value',...) creates a new PLAYKEYBOARD or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Playkeyboard_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Playkeyboard_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Playkeyboard

% Last Modified by GUIDE v2.5 23-Feb-2016 15:29:12

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Playkeyboard_OpeningFcn, ...
                   'gui_OutputFcn',  @Playkeyboard_OutputFcn, ...
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


% --- Executes just before Playkeyboard is made visible.
function Playkeyboard_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Playkeyboard (see VARARGIN)

% Choose default command line output for Playkeyboard
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Playkeyboard wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Playkeyboard_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global x Fs A

set(handles.Note_text,'String','C');
%wavplay(A*x(ceil(1:end/4)),Fs);
sound(A*x(ceil(1:end/4)),Fs);


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over pushbutton1.
function pushbutton1_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% global x Fs A
% 
% set(handles.Note_text,'String','C');
% wavplay(A*x(ceil(1:end/4)),Fs);

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global x Fs A

set(handles.Note_text,'String','D');
half = 2^(2/12);
%wavplay(A*x(ceil(1:half:end/(2^(22/12)))),Fs);
sound(A*x(ceil(1:half:end/(2^(22/12)))),Fs);

% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global x Fs A

set(handles.Note_text,'String','E');
half = 2^(4/12);
% wavplay(A*x(ceil(1:half:end/(2^(20/12)))),Fs);
sound(A*x(ceil(1:half:end/(2^(20/12)))),Fs);


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global x Fs A

set(handles.Note_text,'String','F');
half = 2^(5/12);
sound(A*x(ceil(1:half:end/(2^(19/12)))),Fs);


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global x Fs A

set(handles.Note_text,'String','G');
half = 2^(7/12);
sound(A*x(ceil(1:half:end/(2^(17/12)))),Fs);


% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global x Fs A

set(handles.Note_text,'String','A');
half = 2^(9/12);
sound(A*x(ceil(1:half:end/(2^(15/12)))),Fs);


% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global x Fs A

set(handles.Note_text,'String','B');
half = 2^(11/12);
sound(A*x(ceil(1:half:end/(2^(13/12)))),Fs);


% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global x Fs A

set(handles.Note_text,'String','C');
half = 2^(12/12);
sound(A*x(ceil(1:half:end/2)),Fs);


% --- Executes on button press in pushbutton9.
function pushbutton9_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global x Fs A

set(handles.Note_text,'String','C#');
half = 2^(1/12);
sound(A*x(ceil(1:half:end/(2^(23/12)))),Fs);


% --- Executes on button press in pushbutton10.
function pushbutton10_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global x Fs A

set(handles.Note_text,'String','D#');
half = 2^(3/12);
sound(A*x(ceil(1:half:end/(2^(21/12)))),Fs);


% --- Executes on button press in pushbutton11.
function pushbutton11_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global x Fs A

set(handles.Note_text,'String','F#');
half = 2^(6/12);
sound(A*x(ceil(1:half:end/(2^(18/12)))),Fs);


% --- Executes on button press in pushbutton12.
function pushbutton12_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global x Fs A

set(handles.Note_text,'String','G#');
half = 2^(8/12);
sound(A*x(ceil(1:half:end/(2^(16/12)))),Fs);


% --- Executes on button press in pushbutton13.
function pushbutton13_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global x Fs A

set(handles.Note_text,'String','A#');
half = 2^(10/12);
sound(A*x(ceil(1:half:end/(2^(14/12)))),Fs);


% --- Executes on button press in pushbutton18.
function pushbutton18_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton18 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global x Fs A

set(handles.Note_text,'String','D');
half = 2^(14/12);
sound(A*x(ceil(1:half:end/(2^(10/12)))),Fs);


% --- Executes on button press in pushbutton19.
function pushbutton19_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton19 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global x Fs A

set(handles.Note_text,'String','E');
half = 2^(16/12);
sound(A*x(ceil(1:half:end/(2^(8/12)))),Fs);


% --- Executes on button press in pushbutton20.
function pushbutton20_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton20 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global x Fs A

set(handles.Note_text,'String','F');
half = 2^(17/12);
sound(A*x(ceil(1:half:end/(2^(7/12)))),Fs);


% --- Executes on button press in pushbutton21.
function pushbutton21_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global x Fs A

set(handles.Note_text,'String','G');
half = 2^(19/12);
sound(A*x(ceil(1:half:end/(2^(5/12)))),Fs);


% --- Executes on button press in pushbutton22.
function pushbutton22_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global x Fs A

set(handles.Note_text,'String','A');
half = 2^(21/12);
sound(A*x(ceil(1:half:end/(2^(3/12)))),Fs);


% --- Executes on button press in pushbutton23.
function pushbutton23_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton23 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global x Fs A

set(handles.Note_text,'String','B');
half = 2^(23/12);
sound(A*x(ceil(1:half:end/(2^(1/12)))),Fs);


% --- Executes on button press in pushbutton24.
function pushbutton24_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton24 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global x Fs A

set(handles.Note_text,'String','C#');
half = 2^(13/12);
sound(A*x(ceil(1:half:end/(2^(11/12)))),Fs);


% --- Executes on button press in pushbutton25.
function pushbutton25_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton25 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global x Fs A

set(handles.Note_text,'String','D#');
half = 2^(15/12);
%wavplay(A*x(ceil(1:half:end/(2^(9/12)))),Fs);
sound(A*x(ceil(1:half:end/(2^(9/12)))),Fs);


% --- Executes on button press in pushbutton26.
function pushbutton26_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton26 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global x Fs A

set(handles.Note_text,'String','F#');
half = 2^(18/12);
sound(A*x(ceil(1:half:end/(2^(6/12)))),Fs);


% --- Executes on button press in pushbutton27.
function pushbutton27_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton27 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global x Fs A

set(handles.Note_text,'String','G#');
half = 2^(20/12);
sound(A*x(ceil(1:half:end/(2^(4/12)))),Fs);


% --- Executes on button press in pushbutton28.
function pushbutton28_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton28 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global x Fs A

set(handles.Note_text,'String','A#');
half = 2^(22/12);
sound(A*x(ceil(1:half:end/(2^(2/12)))),Fs);


% --- Executes on button press in pushbutton29.
function pushbutton29_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton29 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global x Fs A

set(handles.Note_text,'String','C');
half = 2^(24/12);
sound(A*x(ceil(1:half:end)),Fs);


% --- Executes on button press in radiobutton1.
function radiobutton1_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton1


% --- Executes on button press in radiobutton2.
function radiobutton2_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton2


% --- Executes on button press in radiobutton3.
function radiobutton3_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton3


% --- Executes on button press in radiobutton4.
function radiobutton4_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton4


% --- Executes on button press in radiobutton5.
function radiobutton5_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton5


% --- Executes on button press in radiobutton6.
function radiobutton6_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton6


% --- Executes on button press in radiobutton7.
function radiobutton7_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton7


% --- Executes on button press in radiobutton8.
function radiobutton8_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton8


% --- Executes on button press in radiobutton9.
function radiobutton9_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton9


% --- Executes on button press in radiobutton10.
function radiobutton10_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton10


% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global A

A = get(hObject,'Value');


% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
global A

if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

A = 1;


% --- Executes during object creation, after setting all properties.
function uipanel4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to uipanel4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called



% --- Executes during object creation, after setting all properties.
function radiobutton3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to radiobutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

global x Fs
set(hObject,'Value',1);
[x,Fs] = audioread('instr_piano.wav');


% --- Executes when selected object is changed in uipanel4.
function uipanel4_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in uipanel4 
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global x Fs

gg = get(hObject,'Tag');
switch gg
    case 'radiobutton3' 
        str = '_piano';
    case 'radiobutton2'
        str = '_organ';
    case 'radiobutton5'
        str = '_violin';
    case 'radiobutton1' 
        str = '_flute';
    case 'radiobutton4'
        str = '_sax';
    case 'radiobutton6'
        str = '_tpt';
    case 'radiobutton7' 
        str = '_tbone';
    case 'radiobutton8'
        str = '_mutetpt';
    case 'radiobutton9'
        str = '_cello';
    case 'radiobutton10'
        str = '_acoustie';
    otherwise
        error('Strumento sconosciuto');
end
name = ['instr' str '.wav'];
[x, Fs] = audioread(name);


% --- Executes during object creation, after setting all properties.
function Note_text_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Note_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
