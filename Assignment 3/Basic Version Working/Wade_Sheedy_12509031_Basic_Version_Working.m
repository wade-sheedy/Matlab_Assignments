function varargout = Wade_Sheedy_12509031_Basic_Version_Working(varargin)
% WADE_SHEEDY_12509031_BASIC_VERSION_WORKING MATLAB code for Wade_Sheedy_12509031_Basic_Version_Working.fig
%      WADE_SHEEDY_12509031_BASIC_VERSION_WORKING, by itself, creates a new WADE_SHEEDY_12509031_BASIC_VERSION_WORKING or raises the existing
%      singleton*.
%
%      H = WADE_SHEEDY_12509031_BASIC_VERSION_WORKING returns the handle to a new WADE_SHEEDY_12509031_BASIC_VERSION_WORKING or the handle to
%      the existing singleton*.
%
%      WADE_SHEEDY_12509031_BASIC_VERSION_WORKING('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in WADE_SHEEDY_12509031_BASIC_VERSION_WORKING.M with the given input arguments.
%
%      WADE_SHEEDY_12509031_BASIC_VERSION_WORKING('Property','Value',...) creates a new WADE_SHEEDY_12509031_BASIC_VERSION_WORKING or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Wade_Sheedy_12509031_Basic_Version_Working_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Wade_Sheedy_12509031_Basic_Version_Working_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Wade_Sheedy_12509031_Basic_Version_Working

% Last Modified by GUIDE v2.5 24-May-2017 16:15:19

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Wade_Sheedy_12509031_Basic_Version_Working_OpeningFcn, ...
                   'gui_OutputFcn',  @Wade_Sheedy_12509031_Basic_Version_Working_OutputFcn, ...
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


% --- Executes just before Wade_Sheedy_12509031_Basic_Version_Working is made visible.
function Wade_Sheedy_12509031_Basic_Version_Working_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Wade_Sheedy_12509031_Basic_Version_Working (see VARARGIN)

% Choose default command line output for Wade_Sheedy_12509031_Basic_Version_Working
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Wade_Sheedy_12509031_Basic_Version_Working wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Wade_Sheedy_12509031_Basic_Version_Working_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in Select_File.
function Select_File_Callback(hObject, eventdata, handles)
% hObject    handle to Select_File (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% openfile();

        
        % Variables
        
        R_Data = [];            % raw data
        P_Data = [];            % performance data
        T = 0;                  % Timer Variable
        Time = 0;               % Cummulative Time
        
        % open file
        
        [filename,pathname]= uigetfile('*.txt');
        file = [pathname filename];
        FileID = fopen(file,'rt');
        
        % read line
        
        %Reads one line & calculates
        line = fgetl(FileID);
        
        %There was a issue where the data was being saved to an array but
        %the whole file was not being read the j variable is a work arround
        %for this issue since each time the while loop runs it is increased
        %by 1 which means that the row number increases by 1 each time
        %which allows all of the data in the array to be read and graphed
        j = 1;  
while ischar(line)
      
        % sscanf to interpret the string
        
        line = fgetl(FileID);
        line_Data = sscanf(line,'%f V, %f counts, %i ms');
        
        %Raw Data
        
        R_Data(end+1,1) = line_Data(1);
        R_Data(end,2) = line_Data(2);
        R_Data(end,3) = line_Data(3);
        
        % calculations 
        
        % calculations preasure 
        P_Data(j,1) = ((R_Data(end,1)/5)-0.04)/0.0018; %pressure calculation as per pump specifications
                  
        %calculations flowrate 
        P_Data(j,2) = (R_Data(end,2) * 3.03)/1000; % one pulse = aprox 3.03 ml of water therefore we can convert the count of 
                                                     %pulses into milliliters and then convert into liters
                
        %calculating Hydraulic power over flowrate
        P_Data(j,3)= (P_Data(end,2) * P_Data(end,1)); %(flowrate * preasure)/1000
                
        %calculating the headaxis over the flowrate
        rho = 1000; %kg per cubic meter of water
        g = 9.81;
        P_Data(j,4) = (P_Data(end,1)*1000)/(rho*g); %preasure/(density * Gravity)
        
        %Timer
        Time = Time + (R_Data(end,3)/1000);
        P_Data(j,5) = Time;
        
        line = fgetl(FileID);
        
        % plot Data
        
        if T == 0
        %Intial Establishing of the graphs
        hold all
        handles.P_O_T = plot(handles.P_O_TAxis,P_Data(:,5),P_Data(:,1),'r-');
        xlabel(handles.P_O_TAxis,'Time(s)');
        ylabel(handles.P_O_TAxis,'Pressure(kPa)');
        title(handles.P_O_TAxis,'Pressure over Time');
        handles.F_O_T = plot(handles.F_O_TAxis,P_Data(:,5),P_Data(:,2),'b-');
        xlabel(handles.F_O_TAxis,'Time(s)');
        ylabel(handles.F_O_TAxis,'Flowrate (L/S)');
        title(handles.F_O_TAxis,'Flowrate over Time');
        handles.Head = plot(handles.HeadAxis,P_Data(:,2),P_Data(:,4),'o b');
        xlabel(handles.HeadAxis,'Flowrate(L/S)')
        ylabel(handles.HeadAxis,'Head(m)');
        title(handles.HeadAxis,'Head over Flowrate');
        handles.Hydraulics = plot(handles.HydraulicsAxis,P_Data(:,2),P_Data(:,3),'o r');
        xlabel(handles.HydraulicsAxis,'Flowrate(L/S)');
        ylabel(handles.HydraulicsAxis,'Hydraulic Power(w)');
        title(handles.HydraulicsAxis,'Hydraulic power over Flowrate');
        % simple thing to change the T value so i can skip to the else part
        % of the if statement to update the graph after intial establishing
        % of the graph which allows the program to update the plots
        T = T + 0.5;
        else
            %updates the graph after the first plot
            set(handles.P_O_T,'xdata',P_Data(:,5),'ydata',P_Data(:,1))
            set(handles.F_O_T,'xdata',P_Data(:,5),'ydata',P_Data(:,2))
            set(handles.Head,'xdata',P_Data(:,2),'ydata',P_Data(:,4))
            set(handles.Hydraulics,'xdata',P_Data(:,2),'ydata',P_Data(:,3))
            drawnow
        end
       % changes my j value so the arrays update the data correctly aka
       % each time it is row 1 then row 1+1 = row 2 etc.
       j = j + 1;
        
end