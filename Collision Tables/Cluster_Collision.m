function varargout = Cluster_Collision(varargin)
% CLUSTER_COLLISION MATLAB code for Cluster_Collision.fig
%      CLUSTER_COLLISION, by itself, creates a new CLUSTER_COLLISION or raises the existing
%      singleton*.
%
%      H = CLUSTER_COLLISION returns the handle to a new CLUSTER_COLLISION or the handle to
%      the existing singleton*.
%
%      CLUSTER_COLLISION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CLUSTER_COLLISION.M with the given input arguments.
%
%      CLUSTER_COLLISION('Property','Value',...) creates a new CLUSTER_COLLISION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Cluster_Collision_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Cluster_Collision_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Cluster_Collision

% Last Modified by GUIDE v2.5 02-Feb-2016 00:00:33

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Cluster_Collision_OpeningFcn, ...
                   'gui_OutputFcn',  @Cluster_Collision_OutputFcn, ...
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


% --- Executes just before Cluster_Collision is made visible.
function Cluster_Collision_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Cluster_Collision (see VARARGIN)

% Choose default command line output for Cluster_Collision
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Cluster_Collision wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Cluster_Collision_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
