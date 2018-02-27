function varargout = gui_with_timer_demo(varargin)
% GUI_WITH_TIMER_DEMO MATLAB code for gui_with_timer_demo.fig
%      GUI_WITH_TIMER_DEMO, by itself, creates a new GUI_WITH_TIMER_DEMO or raises the existing
%      singleton*.
%
%      H = GUI_WITH_TIMER_DEMO returns the handle to a new GUI_WITH_TIMER_DEMO or the handle to
%      the existing singleton*.
%
%      GUI_WITH_TIMER_DEMO('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_WITH_TIMER_DEMO.M with the given input arguments.
%
%      GUI_WITH_TIMER_DEMO('Property','Value',...) creates a new GUI_WITH_TIMER_DEMO or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before gui_with_timer_demo_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to gui_with_timer_demo_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help gui_with_timer_demo

% Last Modified by GUIDE v2.5 19-May-2017 13:55:11

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @gui_with_timer_demo_OpeningFcn, ...
                   'gui_OutputFcn',  @gui_with_timer_demo_OutputFcn, ...
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


% --- Executes just before gui_with_timer_demo is made visible.
function gui_with_timer_demo_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to gui_with_timer_demo (see VARARGIN)

% Choose default command line output for gui_with_timer_demo
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes gui_with_timer_demo wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = gui_with_timer_demo_OutputFcn(hObject, eventdata, handles) 
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

% Clear the data
handles.data.x = [];
handles.data.y = [];

% Create a new plot object
handles.hPlot = plot(handles.axes1, NaN, NaN, 'r-*');

% Create a timer object.
% Notice: we can pass additional arguments to the TimerFcn by supplying a
% cell array and listing additional parameters after the function itself.
handles.update_timer = timer('TimerFcn', {@TimerFcn, hObject}, 'Period', 0.2, 'ExecutionMode', 'FixedSpacing');

% We have modified handles so we need to save our changes. Do this before
% we start the timer because the TimerFcn needs to be able to read the
% latest copy of handles out of guidata.
guidata(hObject, handles);

% Now start the timer
start(handles.update_timer);

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Stop the timer
stop(handles.update_timer);
% Will break if the user clicks 'stop' before 'start'. I leave it to you to
% fix this ;)

%% From the Timer Demo Unaltered
function TimerFcn(hTimer, eventdata, hObject)
% hTimer      handle to the timer object itself
% eventdata   data about the event
% hObject     handle to a GUI object (from which we can extract handles)

% Get a fresh copy of handles (with the latest values)
handles = guidata(hObject);

% Read the next line of data from the sensors
handles.data.x(end+1) = numel(handles.data.x);
handles.data.y(end+1) = rand();

% Update plot
set(handles.hPlot, 'XData', handles.data.x, 'YData', handles.data.y);

% Save handles back into the guidata
guidata(hObject, handles);
%%