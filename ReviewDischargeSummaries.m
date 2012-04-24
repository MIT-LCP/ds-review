function varargout = ReviewDischargeSummaries(varargin)
% REVIEWDISCHARGESUMMARIES MATLAB code for ReviewDischargeSummaries.fig
%      REVIEWDISCHARGESUMMARIES, by itself, creates a new REVIEWDISCHARGESUMMARIES or raises the existing
%      singleton*.
%
%      H = REVIEWDISCHARGESUMMARIES returns the handle to a new REVIEWDISCHARGESUMMARIES or the handle to
%      the existing singleton*.
%
%      REVIEWDISCHARGESUMMARIES('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in REVIEWDISCHARGESUMMARIES.M with the given input arguments.
%
%      REVIEWDISCHARGESUMMARIES('Property','Value',...) creates a new REVIEWDISCHARGESUMMARIES or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ReviewDischargeSummaries_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ReviewDischargeSummaries_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ReviewDischargeSummaries

% Last Modified by GUIDE v2.5 20-Apr-2012 14:01:14
% First created on March 2nd 2011 by Louis Mayaud (c) University of Oxford
% Contact louis.mayaud@gmail.com

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ReviewDischargeSummaries_OpeningFcn, ...
                   'gui_OutputFcn',  @ReviewDischargeSummaries_OutputFcn, ...
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


% --- Executes just before ReviewDischargeSummaries is made visible.
function ReviewDischargeSummaries_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ReviewDischargeSummaries (see VARARGIN)

% Choose default command line output for ReviewDischargeSummaries
handles.output = hObject;

% Read the expert file to allocate readings
set(handles.expert,'String',textread('experts_names.txt','%s'));

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes ReviewDischargeSummaries wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = ReviewDischargeSummaries_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double
%# enable horizontal scrolling



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


% --------------------------------------------------------------------
function load_button_Callback(hObject, eventdata, handles)
% hObject    handle to load_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[FileName,PathName] = uigetfile('*.mat','Select the discharge summary file to edit');
if FileName~=0
    load([PathName FileName]) ;
    handles.FileName = FileName ;
    handles.PathName = PathName ;

    handles.subject_id = subject_id ;
    handles.icustay_id = icustay_id ;
    handles.hadm_id = hadm_id ;
    handles.dischSum = disch_sum ;
    if exist('results','var')
        handles.results = results;
    else
        handles.results = {};
    end
    if ~isfield(handles.results,'isDone')
        handles.results.isDone = zeros(length(icustay_id),1);
    end

    handles.currentID = 1;
    handles = display_discharge_summary(handles);
end
% Update handles structure
guidata(hObject, handles);


% --- Executes on button press in checkbox1.
function checkbox1_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox1


% --- Executes on selection change in gui_admission.
function gui_admission_Callback(hObject, eventdata, handles)
% hObject    handle to gui_admission (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns gui_admission contents as cell array
%        contents{get(hObject,'Value')} returns selected item from gui_admission


% --- Executes during object creation, after setting all properties.
function gui_admission_CreateFcn(hObject, eventdata, handles)
% hObject    handle to gui_admission (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in gui_vent.
function gui_vent_Callback(hObject, eventdata, handles)
% hObject    handle to gui_vent (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of gui_vent


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.results.isDone(handles.currentID) = 1; 
handles.results.aids(handles.currentID) = get(handles.gui_aids,'Value');
handles.results.hepfail(handles.currentID) = get(handles.gui_hepfail,'Value');
handles.results.lymph(handles.currentID) = get(handles.gui_lymph,'Value');
handles.results.metcan(handles.currentID) = get(handles.gui_metcan,'Value');
handles.results.leuk(handles.currentID) = get(handles.gui_leuk,'Value');
handles.results.immunosup(handles.currentID) = get(handles.gui_immunosup,'Value');
handles.results.cirrhosis(handles.currentID) = get(handles.gui_cirrhosis,'Value');
handles.results.admission(handles.currentID) = get(handles.gui_admission,'Value');
handles.results.vent(handles.currentID) = get(handles.gui_vent,'Value');
handles.results.isSepticShock(handles.currentID) = get(handles.checkbox10,'Value');

if handles.currentID+1<=length(handles.results.isDone)
    handles.currentID = handles.currentID + 1;
else
    handles.currentID = 1;
end
handles = display_discharge_summary(handles);

% Update handles structure
guidata(hObject, handles);


% --- Executes on selection change in expert.
function expert_Callback(hObject, eventdata, handles)
% hObject    handle to expert (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns expert contents as cell array
%        contents{get(hObject,'Value')} returns selected item from expert
handles = display_discharge_summary(handles);

% --- Executes during object creation, after setting all properties.
function expert_CreateFcn(hObject, eventdata, handles)
% hObject    handle to expert (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in gui_aids.
function gui_aids_Callback(hObject, eventdata, handles)
% hObject    handle to gui_aids (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of gui_aids


% --- Executes on button press in gui_hepfail.
function gui_hepfail_Callback(hObject, eventdata, handles)
% hObject    handle to gui_hepfail (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of gui_hepfail


% --- Executes on button press in gui_lymph.
function gui_lymph_Callback(hObject, eventdata, handles)
% hObject    handle to gui_lymph (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of gui_lymph


% --- Executes on button press in gui_metcan.
function gui_metcan_Callback(hObject, eventdata, handles)
% hObject    handle to gui_metcan (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of gui_metcan


% --- Executes on button press in gui_leuk.
function gui_leuk_Callback(hObject, eventdata, handles)
% hObject    handle to gui_leuk (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of gui_leuk


% --- Executes on button press in gui_immunosup.
function gui_immunosup_Callback(hObject, eventdata, handles)
% hObject    handle to gui_immunosup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of gui_immunosup


% --- Executes on button press in gui_cirrhosis.
function gui_cirrhosis_Callback(hObject, eventdata, handles)
% hObject    handle to gui_cirrhosis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of gui_cirrhosis


% --------------------------------------------------------------------
function savework_Callback(hObject, eventdata, handles)
% hObject    handle to savework (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
results = handles.results;
subject_id = handles.subject_id ;
icustay_id = handles.icustay_id ;
hadm_id = handles.hadm_id ;
disch_sum = handles.dischSum;
results = handles.results;
save([handles.PathName handles.FileName],'results','subject_id','icustay_id','hadm_id','disch_sum'); 
helpdlg('Your work was saved thanks!');


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

expertNum = length(get(handles.expert,'String'));
if handles.currentID-expertNum>1
    handles.currentID = handles.currentID-expertNum;
else
    handles.currentID = 1;
end
handles = display_discharge_summary(handles);

% Update handles structure
guidata(hObject, handles);


% --- Executes on button press in checkbox10.
function checkbox10_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox10


% --- Executes on selection change in pop_immunosup.
function pop_immunosup_Callback(hObject, eventdata, handles)
% hObject    handle to pop_immunosup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns pop_immunosup contents as cell array
%        contents{get(hObject,'Value')} returns selected item from pop_immunosup


% --- Executes during object creation, after setting all properties.
function pop_immunosup_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pop_immunosup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in pop_cirrhosis.
function pop_cirrhosis_Callback(hObject, eventdata, handles)
% hObject    handle to pop_cirrhosis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns pop_cirrhosis contents as cell array
%        contents{get(hObject,'Value')} returns selected item from pop_cirrhosis


% --- Executes during object creation, after setting all properties.
function pop_cirrhosis_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pop_cirrhosis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in pop_leuk.
function pop_leuk_Callback(hObject, eventdata, handles)
% hObject    handle to pop_leuk (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns pop_leuk contents as cell array
%        contents{get(hObject,'Value')} returns selected item from pop_leuk


% --- Executes during object creation, after setting all properties.
function pop_leuk_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pop_leuk (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in pop_metcan.
function pop_metcan_Callback(hObject, eventdata, handles)
% hObject    handle to pop_metcan (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns pop_metcan contents as cell array
%        contents{get(hObject,'Value')} returns selected item from pop_metcan


% --- Executes during object creation, after setting all properties.
function pop_metcan_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pop_metcan (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in pop_lymph.
function pop_lymph_Callback(hObject, eventdata, handles)
% hObject    handle to pop_lymph (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns pop_lymph contents as cell array
%        contents{get(hObject,'Value')} returns selected item from pop_lymph


% --- Executes during object creation, after setting all properties.
function pop_lymph_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pop_lymph (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in pop_hepfail.
function pop_hepfail_Callback(hObject, eventdata, handles)
% hObject    handle to pop_hepfail (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns pop_hepfail contents as cell array
%        contents{get(hObject,'Value')} returns selected item from pop_hepfail


% --- Executes during object creation, after setting all properties.
function pop_hepfail_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pop_hepfail (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in pop_aids.
function pop_aids_Callback(hObject, eventdata, handles)
% hObject    handle to pop_aids (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns pop_aids contents as cell array
%        contents{get(hObject,'Value')} returns selected item from pop_aids


% --- Executes during object creation, after setting all properties.
function pop_aids_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pop_aids (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in pop_vent.
function pop_vent_Callback(hObject, eventdata, handles)
% hObject    handle to pop_vent (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns pop_vent contents as cell array
%        contents{get(hObject,'Value')} returns selected item from pop_vent


% --- Executes during object creation, after setting all properties.
function pop_vent_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pop_vent (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
