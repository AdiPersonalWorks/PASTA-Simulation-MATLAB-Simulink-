function varargout = Press_Sensor(varargin)
% PRESS_SENSOR MATLAB code for Press_Sensor.fig
%      PRESS_SENSOR, by itself, creates a new PRESS_SENSOR or raises the existing
%      singleton*.
%
%      H = PRESS_SENSOR returns the handle to a new PRESS_SENSOR or the handle to
%      the existing singleton*.
%
%      PRESS_SENSOR('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PRESS_SENSOR.M with the given input arguments.
%
%      PRESS_SENSOR('Property','Value',...) creates a new PRESS_SENSOR or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Press_Sensor_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Press_Sensor_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Press_Sensor

% Last Modified by GUIDE v2.5 08-Jan-2016 19:34:33

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Press_Sensor_OpeningFcn, ...
                   'gui_OutputFcn',  @Press_Sensor_OutputFcn, ...
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


% --- Executes just before Press_Sensor is made visible.
function Press_Sensor_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Press_Sensor (see VARARGIN)

% Choose default command line output for Press_Sensor
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Press_Sensor wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Press_Sensor_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
