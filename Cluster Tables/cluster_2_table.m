function varargout = cluster_2_table(varargin)
% CLUSTER_2_TABLE MATLAB code for cluster_2_table.fig
%      CLUSTER_2_TABLE, by itself, creates a new CLUSTER_2_TABLE or raises the existing
%      singleton*.
%
%      H = CLUSTER_2_TABLE returns the handle to a new CLUSTER_2_TABLE or the handle to
%      the existing singleton*.
%
%      CLUSTER_2_TABLE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CLUSTER_2_TABLE.M with the given input arguments.
%
%      CLUSTER_2_TABLE('Property','Value',...) creates a new CLUSTER_2_TABLE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before cluster_2_table_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to cluster_2_table_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help cluster_2_table

% Last Modified by GUIDE v2.5 06-Jan-2016 22:33:49

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @cluster_2_table_OpeningFcn, ...
                   'gui_OutputFcn',  @cluster_2_table_OutputFcn, ...
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


% --- Executes just before cluster_2_table is made visible.
function cluster_2_table_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to cluster_2_table (see VARARGIN)

% Choose default command line output for cluster_2_table
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes cluster_2_table wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = cluster_2_table_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
