function varargout = Humid_Sensor(varargin)
% HUMID_SENSOR MATLAB code for Humid_Sensor.fig
%      HUMID_SENSOR, by itself, creates a new HUMID_SENSOR or raises the existing
%      singleton*.
%
%      H = HUMID_SENSOR returns the handle to a new HUMID_SENSOR or the handle to
%      the existing singleton*.
%
%      HUMID_SENSOR('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in HUMID_SENSOR.M with the given input arguments.
%
%      HUMID_SENSOR('Property','Value',...) creates a new HUMID_SENSOR or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Humid_Sensor_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Humid_Sensor_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Humid_Sensor

% Last Modified by GUIDE v2.5 09-Jan-2016 00:31:58

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Humid_Sensor_OpeningFcn, ...
                   'gui_OutputFcn',  @Humid_Sensor_OutputFcn, ...
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


% --- Executes just before Humid_Sensor is made visible.
function Humid_Sensor_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Humid_Sensor (see VARARGIN)

% Choose default command line output for Humid_Sensor
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Humid_Sensor wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Humid_Sensor_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
