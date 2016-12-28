function Cluster(block)
%custom_sat Customized Saturation block
%
%CUSTOM_SAT is a Level-2 M-file S-function that allows the user to
%  independently specify lower or upper bounds as either a input signal
%  or block parameter. Each saturation limit can also be toggled off.

%  Copyright 1990-2007 The MathWorks, Inc.

%%
%% The setup method is used to setup the basic attributes of the
%% S-function such as ports, parameters, etc. Do not add any other
%% calls to the main body of the function.
%%
setup(block);
%end function Mdl_Integrated_Runtime
%% Function: setup ===================================================
function setup(block)

% % Simulink passes an instance of the Simulink.MSFcnRunTimeBlock class
% to the setup method in the input argument "block". This is known as
% the S-function block's run-time object.
% Register original number of input ports based on the S-function
% parameter values

numInPorts=0;

block.NumInputPorts = numInPorts;
block.NumOutputPorts = 0;

% Setup port properties to be inherited or dynamic
block.SetPreCompInpPortInfoToDynamic;

% Override input port properties
% block.InputPort(1).Name        = 'a';
% for inID = 1 : numInPorts
%     block.InputPort(inID).DatatypeID  = 0;  % double
%     block.InputPort(inID).Complexity  = 'Real';
%
%     % block.InputPort(1).Name        = 'B';
% end
% block.InputPort(1).Dimensions=1;
% block.InputPort(2).Dimensions=1;
% block.InputPort(3).Dimensions=1;
% block.InputPort(4).Dimensions=1;
% Dimension of the input are found from the 3rd input
assignin('base','prt',block.BlockHandle);
evalin('base','prt1=get(prt,''PortConnectivity'');');
% block.InputPort(1).Dimensions = str2num(evalin('base','get(prt1(3).SrcBlock,''Value'')'));

block.NumDialogPrms     = 0;
% Register continuous sample times [0 offset]
block.SampleTimes = [-1 0];

%% -----------------------------------------------------------------
%% Options
%% -----------------------------------------------------------------
% Specify if Accelerator should use TLC or call back into
% M-file
block.SetAccelRunOnTLC(false);

%% -----------------------------------------------------------------
%% Register methods called during update diagram/compilation
%% -----------------------------------------------------------------

block.RegBlockMethod('SimStatusChange',      @SimStatusChange);
block.RegBlockMethod('PostPropagationSetup', @DoPostPropSetup);
block.RegBlockMethod('ProcessParameters',    @ProcessPrms);
block.RegBlockMethod('Outputs',              @Outputs);
block.RegBlockMethod('Terminate',            @Terminate);
%end setup function
%% Function: DoPostPropSetup ===================================================
function DoPostPropSetup(block)
% end
%% Function: ProcessPrms ===================================================
function ProcessPrms(block)
block.AutoUpdateRuntimePrms;
%end ProcessPrms function
%% Function: SimStatusChange ===================================================
function SimStatusChange(block, s)

% end SimStatusChange function
%% Function: Outputs ===================================================
function Outputs(block)

all_data = {};
data_for_table = {};

try
    rand_cluster_1 = evalin('base','rand_cluster_1');
    rand_cluster_2 = evalin('base','rand_cluster_2');
    rand_cluster_3 = evalin('base','rand_cluster_3');
    
    basestation1_tag = findall(0,'Tag','basestation1');
    all_data = [rand_cluster_1,rand_cluster_2,rand_cluster_3];
    
    for ii = 1:size(all_data,2)
        data_for_table{ii,1} = all_data(ii).sensor;
        data_for_table{ii,2} = all_data(ii).val;
    end
    
    cluster1_tag = findall(0,'Tag','cluster1');
    cluster2_tag = findall(0,'Tag','cluster2');
    cluster3_tag = findall(0,'Tag','cluster3');
    
    set(basestation1_tag,'Data',data_for_table);
    
%     if ~isempty(data_for_table)
%         pause(0.25);
%         set(cluster1_tag,'Data',[]);
%         set(cluster2_tag,'Data',[]);
%         set(cluster3_tag,'Data',[]);
%     end
    
catch
end

% rand_cluster_1 = [];
% rand_cluster_2 = [];
% rand_cluster_3 = [];
%
% assignin('base','rand_cluster_1',rand_cluster_1);
% assignin('base','rand_cluster_2',rand_cluster_2);
% assignin('base','rand_cluster_3',rand_cluster_3);

simtime = get_param(bdroot,'SimulationTime');

% set_param(gcbh,'BackgroundColor','Yellow');
% pause(1);
% disp(['All clusters cleared @' num2str(simtime)]);
% set_param(gcbh,'BackgroundColor','White');

%end
%% Function: Terminate ===================================================
function Terminate(block)
% end Terminate