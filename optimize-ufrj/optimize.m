function varargout = optimize(varargin)
% OPTIMIZE M-file for optimize.fig
%      OPTIMIZE, by itself, creates a new OPTIMIZE or raises the existing
%      singleton*.
%
%      H = OPTIMIZE returns the handle to a new OPTIMIZE or the handle to
%      the existing singleton*.
%
%      OPTIMIZE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in OPTIMIZE.M with the given input arguments.
%
%      OPTIMIZE('Property','Value',...) creates a new OPTIMIZE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before optimize_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to optimize_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help optimize

% Last Modified by GUIDE v2.5 19-Oct-2010 23:01:07

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @optimize_OpeningFcn, ...
                   'gui_OutputFcn',  @optimize_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin & isstr(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT

% --- Executes just before optimize is made visible.
function optimize_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to optimize (see VARARGIN)

% Choose default command line output for optimize
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% set(handles.edit_nvar,'Enable','off');
% set(handles.slider,'Enable','off');

% Centralizando a interface
movegui(hObject,'center');

% UIWAIT makes optimize wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = optimize_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes on button press in otimizar.
function otimizar_Callback(hObject, eventdata, handles)
% hObject    handle to otimizar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
warning off MATLAB:warn_parse_feval_script;

metodos = get(handles.popupmenu_mo,'String');
ind_metodo = get(handles.popupmenu_mo,'Value');
metodo = char(metodos(ind_metodo,:));

switch metodo
    case 'Gradiente'
        mo = 0;
        mo_aux = 0;
        
    case 'Gradiente Conjugado (PR)'
        mo = 1;
        mo_aux = 0;
        
    case 'Gradiente Conjugado (FR)'
        mo = 1;
        mo_aux = 1;
        
    case 'Newton'
        mo = 2;
        mo_aux = 0;
        
    case 'Newton Modificado'
        mo = 3;
        mo_aux = 0;
        
    case 'Quase-Newton (DFP)'
        mo = 4;
        mo_aux = 0;
        
    case 'Quase-Newton (BFGS)'
        mo = 4;
        mo_aux = 1;

    otherwise
        error('Selecione um Método de Otimizaçao!');
end

buscas = get(handles.popupmenu_bl,'String');
ind_busca = get(handles.popupmenu_bl,'Value');
busca = char(buscas(ind_busca,:));

switch busca
    case 'Fibonacci'
        bl = 1;
        
    case 'Razão Áurea'
        bl = 2;
        
    case 'Interpolação Quadrática'
        bl = 3;
        
    case 'Interpolação (Brent)'
        bl = 4;
    otherwise
        error('Selecione uma Busca Linear!');
end

crit_parada = [];
crit_parada_abs = get(handles.radiobuttonAbs,'Value');
crit_parada_rel = get(handles.radiobuttonRel,'Value');
crit_parada_grad = get(handles.radiobuttonGrad,'Value');
crit_parada_max = get(handles.radiobuttonMax,'Value');

if crit_parada_abs == 1
    crit_parada(1) = str2num(get(handles.editAbs,'String'));
else
    crit_parada(1) = -1;
end

if crit_parada_rel == 1
    crit_parada(2) = str2num(get(handles.editRel,'String'));
else
    crit_parada(2) = -1;
end

if crit_parada_grad == 1
    crit_parada(3) = str2num(get(handles.editGrad,'String'));
else
    crit_parada(3) = -1;
end

if crit_parada_max == 1
    crit_parada(4) = str2num(get(handles.editMax,'String'));
else
    crit_parada(4) = -1;
end

crit_parada(5) = str2num(get(handles.editBusca,'String'));

fun = get(handles.editfun,'String');
x0 = get(handles.editx0,'String');
evalin('base',strcat('x0 = ',x0,';'));
evalin('base','nvar = length(x0);');

assignin('base','mo',mo);
assignin('base','mo_aux',mo_aux);
assignin('base','metodo',metodo);
assignin('base','bl',bl);
assignin('base','busca',busca);
assignin('base','crit_parada',crit_parada);
assignin('base','fun',fun);

otimizar

% --- Executes during object creation, after setting all properties.
function popupmenu_mo_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu_mo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end


% --- Executes on selection change in popupmenu_mo.
function popupmenu_mo_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu_mo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popupmenu_mo contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu_mo


% --- Executes during object creation, after setting all properties.
function popupmenu_bl_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu_bl (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end


% --- Executes on selection change in popupmenu_bl.
function popupmenu_bl_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu_bl (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popupmenu_bl contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu_bl

function editfun_Callback(hObject, eventdata, handles)
% hObject    handle to editfun (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editfun as text
%        str2double(get(hObject,'String')) returns contents of editfun as a double


% --- Executes during object creation, after setting all properties.
function editfun_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editfun (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in radiobuttonAbs.
function radiobuttonAbs_Callback(hObject, eventdata, handles)
% hObject    handle to radiobuttonAbs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobuttonAbs



function editAbs_Callback(hObject, eventdata, handles)
% hObject    handle to editAbs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editAbs as text
%        str2double(get(hObject,'String')) returns contents of editAbs as a double


% --- Executes during object creation, after setting all properties.
function editAbs_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editAbs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in radiobuttonRel.
function radiobuttonRel_Callback(hObject, eventdata, handles)
% hObject    handle to radiobuttonRel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobuttonRel



function editRel_Callback(hObject, eventdata, handles)
% hObject    handle to editRel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editRel as text
%        str2double(get(hObject,'String')) returns contents of editRel as a double


% --- Executes during object creation, after setting all properties.
function editRel_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editRel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in radiobuttonGrad.
function radiobuttonGrad_Callback(hObject, eventdata, handles)
% hObject    handle to radiobuttonGrad (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobuttonGrad



function editGrad_Callback(hObject, eventdata, handles)
% hObject    handle to editGrad (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editGrad as text
%        str2double(get(hObject,'String')) returns contents of editGrad as a double


% --- Executes during object creation, after setting all properties.
function editGrad_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editGrad (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end





function editx0_Callback(hObject, eventdata, handles)
% hObject    handle to editx0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editx0 as text
%        str2double(get(hObject,'String')) returns contents of editx0 as a double


% --- Executes during object creation, after setting all properties.
function editx0_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editx0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end





function editBusca_Callback(hObject, eventdata, handles)
% hObject    handle to editBusca (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editBusca as text
%        str2double(get(hObject,'String')) returns contents of editBusca as a double


% --- Executes during object creation, after setting all properties.
function editBusca_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editBusca (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




% --- Executes on button press in radiobuttonMax.
function radiobuttonMax_Callback(hObject, eventdata, handles)
% hObject    handle to radiobuttonMax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobuttonMax



function editMax_Callback(hObject, eventdata, handles)
% hObject    handle to editMax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editMax as text
%        str2double(get(hObject,'String')) returns contents of editMax as a double


% --- Executes during object creation, after setting all properties.
function editMax_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editMax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


