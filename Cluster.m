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

numInPorts=4;

block.NumInputPorts = numInPorts;
block.NumOutputPorts = 0;

% Setup port properties to be inherited or dynamic
block.SetPreCompInpPortInfoToDynamic;

% Override input port properties
% block.InputPort(1).Name        = 'a';
for inID = 1 : numInPorts
    block.InputPort(inID).DatatypeID  = 0;  % double
    block.InputPort(inID).Complexity  = 'Real';
    
    % block.InputPort(1).Name        = 'B';
end
block.InputPort(1).Dimensions=1;
block.InputPort(2).Dimensions=1;
block.InputPort(3).Dimensions=1;
block.InputPort(4).Dimensions=1;
% Dimension of the input are found from the 3rd input
assignin('base','prt',block.BlockHandle);
evalin('base','prt1=get(prt,''PortConnectivity'');');
% block.InputPort(1).Dimensions = str2num(evalin('base','get(prt1(3).SrcBlock,''Value'')'));

block.NumDialogPrms = 0;
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

humid_change = 0;
press_change = 0;
temp_change = 0;
wind_change = 0;

Temperature_Val=block.InputPort(1).Data;
Humidity_Val=block.InputPort(2).Data;
Wind_Val = block.InputPort(3).Data;
Pressure_Val = block.InputPort(4).Data;

try
    avg_all_val_humid = evalin('base','avg_all_val_humid');
catch
end
try
    avg_all_val_press = evalin('base','avg_all_val_press');
catch
end
try
    avg_all_val_temp = evalin('base','avg_all_val_temp');
catch
end
try
    avg_all_val_wind = evalin('base','avg_all_val_wind');
catch
end

try
    prev_val_humid = evalin('base','prev_val_humid');
    prev_val_press = evalin('base','prev_val_press');
    prev_val_temp = evalin('base','prev_val_temp');
    prev_val_wind = evalin('base','prev_val_wind');
catch
end

try
    pres_info = evalin('base','pres_info');
    humid_info = evalin('base','humid_info');
    wind_info = evalin('base','wind_info');
    temp_info = evalin('base','temp_info');
catch
end

try
    rand_cluster_1 = evalin('base','rand_cluster_1');
    rand_cluster_2 = evalin('base','rand_cluster_2');
    rand_cluster_3 = evalin('base','rand_cluster_3');
catch
end

try
    cluster_1_table = evalin('base','cluster_1_table');
    cluster_2_table = evalin('base','cluster_2_table');
    cluster_3_table = evalin('base','cluster_3_table');
catch
end

try
    cluster_1_table_count = evalin('base','cluster_1_table_count');
    cluster_2_table_count = evalin('base','cluster_2_table_count');
    cluster_3_table_count = evalin('base','cluster_3_table_count');
catch
end

len_clus1 = length(rand_cluster_1);
len_clus2 = length(rand_cluster_2);
len_clus3 = length(rand_cluster_3);
position = 1;

%% Humidity Cluster
try
    if ~isempty(avg_all_val_humid)
        
        set_param(gcbh,'BackgroundColor','Yellow');
        pause(0.5);
        set_param(gcbh,'BackgroundColor','White');
        pause(0.5);
        
        rand_cluster_humid = randi([1 3],1,1);
        if rand_cluster_humid == 1
            queue_clus1 = evalin('base','queue_clus1');
            len_queue_clus1 = length(queue_clus1);
            for ele_ind = 1:len_queue_clus1
                if strcmp(queue_clus1(ele_ind).type,'humid')
                    position = ele_ind;
                    break;
                end
            end
            if strcmp(queue_clus1(position).type,'humid')
                rand_cluster_1(len_clus1 + 1).val = queue_clus1(position).val;
                queue_clus1(position).val = avg_all_val_humid;
                queue_clus1(position).type = 'humid';
            else
                rand_cluster_1(len_clus1 + 1).val = avg_all_val_humid;
            end
            rand_cluster_1(len_clus1 + 1).sensor = 'Humidity';
            evalin('base','clear avg_all_val_humid');
            assignin('base','rand_cluster_1',rand_cluster_1);
            
            cluster_1_table{cluster_1_table_count,1} = rand_cluster_1(end).sensor;
            cluster_1_table{cluster_1_table_count,2} = rand_cluster_1(end).val;
            cluster1_tag = findall(0,'Tag','cluster1');
            
            set(cluster1_tag,'Data',cluster_1_table);
            cluster_1_table_count = cluster_1_table_count+1;
            
            assignin('base','cluster_1_table',cluster_1_table);
            assignin('base','cluster_1_table_count',cluster_1_table_count);
            
            figure(2);
            s1(1) = subplot(3,1,1); title('Cluster 1');
            s1(2) = subplot(3,1,2); title('Cluster 2');
            s1(3) = subplot(3,1,3); title('Cluster 3'); xlabel('(Red - Temp, Blue - Humidity, Green - Pressure, Yellow - Wind)');
            simtime = get_param(bdroot,'SimulationTime');
            hold(s1(1),'on');
            hold(s1(2),'on');
            hold(s1(3),'on');
            figure(2);
            stem(s1(1),2,simtime,'g--o');
            
            
            
        end
        if rand_cluster_humid == 2
            queue_clus2 = evalin('base','queue_clus2');
            len_queue_clus2 = length(queue_clus2);
            for ele_ind = 1:len_queue_clus2
                if strcmp(queue_clus2(ele_ind).type,'humid')
                    position = ele_ind;
                    break;
                end
            end
            if strcmp(queue_clus2(position).type,'humid')
                rand_cluster_2(len_clus2 + 1).val = queue_clus2(position).val;
                queue_clus2(position).val = avg_all_val_humid;
                queue_clus2(position).type = 'humid';
            else
                rand_cluster_2(len_clus2 + 1).val = avg_all_val_humid;
            end
            rand_cluster_2(len_clus2 + 1).sensor = 'Humidity';
            evalin('base','clear avg_all_val_humid');
            assignin('base','rand_cluster_2',rand_cluster_2);
            
            cluster_2_table{cluster_2_table_count,1} = rand_cluster_2(end).sensor;
            cluster_2_table{cluster_2_table_count,2} = rand_cluster_2(end).val;
            cluster2_tag = findall(0,'Tag','cluster2');
            
            set(cluster2_tag,'Data',cluster_2_table);
            cluster_2_table_count = cluster_2_table_count+1;
            
            assignin('base','cluster_2_table',cluster_2_table);
            assignin('base','cluster_2_table_count',cluster_2_table_count);
            
            figure(2);
            s1(1) = subplot(3,1,1); title('Cluster 1');
            s1(2) = subplot(3,1,2); title('Cluster 2');
            s1(3) = subplot(3,1,3); title('Cluster 3'); xlabel('(Red - Temp, Blue - Humidity, Green - Pressure, Yellow - Wind)');
            simtime = get_param(bdroot,'SimulationTime');
            hold(s1(1),'on');
            hold(s1(2),'on');
            hold(s1(3),'on');
            figure(2);
            stem(s1(2),2,simtime,'g--o');
            
        end
        if rand_cluster_humid == 3
            queue_clus3 = evalin('base','queue_clus3');
            len_queue_clus3 = length(queue_clus3);
            for ele_ind = 1:len_queue_clus3
                if strcmp(queue_clus3(ele_ind).type,'humid')
                    position = ele_ind;
                    break;
                end
            end
            if strcmp(queue_clus3(position).type,'humid')
                rand_cluster_3(len_clus3 + 1).val = queue_clus3(position).val;
                queue_clus3(position).val = avg_all_val_humid;
                queue_clus3(position).type = 'humid';
            else
                rand_cluster_3(len_clus3 + 1).val =  avg_all_val_humid;
            end
            rand_cluster_3(len_clus3 + 1).sensor = 'Humidity';
            evalin('base','clear avg_all_val_humid');
            assignin('base','rand_cluster_3',rand_cluster_3);
            
            cluster_3_table{cluster_3_table_count,1} = rand_cluster_3(end).sensor;
            cluster_3_table{cluster_3_table_count,2} = rand_cluster_3(end).val;
            cluster3_tag = findall(0,'Tag','cluster3');
            
            set(cluster3_tag,'Data',cluster_3_table);
            cluster_3_table_count = cluster_3_table_count+1;
            
            assignin('base','cluster_3_table',cluster_3_table);
            assignin('base','cluster_3_table_count',cluster_3_table_count);
            
            figure(2);
            s1(1) = subplot(3,1,1); title('Cluster 1');
            s1(2) = subplot(3,1,2); title('Cluster 2');
            s1(3) = subplot(3,1,3); title('Cluster 3'); xlabel('(Red - Temp, Blue - Humidity, Green - Pressure, Yellow - Wind)');
            simtime = get_param(bdroot,'SimulationTime');
            hold(s1(1),'on');
            hold(s1(2),'on');
            hold(s1(3),'on');
            figure(2);
            stem(s1(3),2,simtime,'g--o');
        end
    end
    
    humid_info{end,4} = num2str(rand_cluster_humid);
    humid_sen_h = findall(0,'Tag','humid_sen');
    set(humid_sen_h,'Data',humid_info);
    assignin('base','humid_info',humid_info);
    
catch
    %     disp('I am in catch 1');
end

%% Temperature Cluster
try
    if ~isempty(avg_all_val_temp)
        
        set_param(gcbh,'BackgroundColor','Orange');
        pause(0.5);
        set_param(gcbh,'BackgroundColor','White');
        pause(0.5);
        
        rand_cluster_temp = randi([1 3],1,1);
        if rand_cluster_temp == 1
            queue_clus1 = evalin('base','queue_clus1');
            len_queue_clus1 = length(queue_clus1);
            for ele_ind = 1:len_queue_clus1
                if strcmp(queue_clus1(ele_ind).type,'temp')
                    position = ele_ind;
                    break;
                end
            end
            if strcmp(queue_clus1(position).type,'temp')
                rand_cluster_1(len_clus1 + 1).val = queue_clus1(position).val;
                queue_clus1(position).val = avg_all_val_temp;
                queue_clus1(position).type = 'temp';
            else
                rand_cluster_1(len_clus1 + 1).val = avg_all_val_temp;
            end
            rand_cluster_1(len_clus1 + 1).sensor = 'Temperature';
            evalin('base','clear avg_all_val_temp');
            assignin('base','rand_cluster_1',rand_cluster_1);
            
            cluster_1_table{cluster_1_table_count,1} = rand_cluster_1(end).sensor;
            cluster_1_table{cluster_1_table_count,2} = rand_cluster_1(end).val;
            cluster1_tag = findall(0,'Tag','cluster1');
            
            set(cluster1_tag,'Data',cluster_1_table);
            cluster_1_table_count = cluster_1_table_count+1;
            
            assignin('base','cluster_1_table',cluster_1_table);
            assignin('base','cluster_1_table_count',cluster_1_table_count);
            
            figure(2);
            s1(1) = subplot(3,1,1); title('Cluster 1');
            s1(2) = subplot(3,1,2); title('Cluster 2');
            s1(3) = subplot(3,1,3); title('Cluster 3'); xlabel('(Red - Temp, Blue - Humidity, Green - Pressure, Yellow - Wind)');
            simtime = get_param(bdroot,'SimulationTime');
            hold(s1(1),'on');
            hold(s1(2),'on');
            hold(s1(3),'on');
            figure(2);
            stem(s1(1),1,simtime,'r--o');
            
        end
        if rand_cluster_temp == 2
            queue_clus2 = evalin('base','queue_clus2');
            len_queue_clus2 = length(queue_clus2);
            for ele_ind = 1:len_queue_clus2
                if strcmp(queue_clus2(ele_ind).type,'temp')
                    position = ele_ind;
                    break;
                end
            end
            if strcmp(queue_clus2(position).type,'temp')
                rand_cluster_2(len_clus2 + 1).val = queue_clus2(position).val;
                queue_clus2(position).val = avg_all_val_temp;
                queue_clus2(position).type = 'temp';
            else
                rand_cluster_2(len_clus2 + 1).val = avg_all_val_temp;
            end
            rand_cluster_2(len_clus2 + 1).sensor='Temperature';
            evalin('base','clear avg_all_val_temp');
            assignin('base','rand_cluster_2',rand_cluster_2);
            
            cluster_2_table{cluster_2_table_count,1} = rand_cluster_2(end).sensor;
            cluster_2_table{cluster_2_table_count,2} = rand_cluster_2(end).val;
            cluster2_tag = findall(0,'Tag','cluster2');
            
            set(cluster2_tag,'Data',cluster_2_table);
            cluster_2_table_count = cluster_2_table_count+1;
            
            assignin('base','cluster_2_table',cluster_2_table);
            assignin('base','cluster_2_table_count',cluster_2_table_count);
            
            figure(2);
            s1(1) = subplot(3,1,1); title('Cluster 1');
            s1(2) = subplot(3,1,2); title('Cluster 2');
            s1(3) = subplot(3,1,3); title('Cluster 3'); xlabel('(Red - Temp, Blue - Humidity, Green - Pressure, Yellow - Wind)');
            simtime = get_param(bdroot,'SimulationTime');
            hold(s1(1),'on');
            hold(s1(2),'on');
            hold(s1(3),'on');
            figure(2);
            stem(s1(2),1,simtime,'r--o');
            
        end
        if rand_cluster_temp == 3
            queue_clus3 = evalin('base','queue_clus3');
            len_queue_clus3 = length(queue_clus3);
            for ele_ind = 1:len_queue_clus3
                if strcmp(queue_clus3(ele_ind).type,'temp')
                    position = ele_ind;
                    break;
                end
            end
            if strcmp(queue_clus3(position).type,'temp')
                rand_cluster_3(len_clus3 + 1).val = queue_clus3(position).val;
                queue_clus3(position).val = avg_all_val_temp;
                queue_clus3(position).type = 'temp';
            else
                rand_cluster_3(len_clus3 + 1).val = avg_all_val_temp;
            end
            rand_cluster_3(len_clus3 + 1).sensor='Temperature';
            evalin('base','clear avg_all_val_temp');
            assignin('base','rand_cluster_3',rand_cluster_3);
            
            cluster_3_table{cluster_3_table_count,1} = rand_cluster_3(end).sensor;
            cluster_3_table{cluster_3_table_count,2} = rand_cluster_3(end).val;
            cluster3_tag = findall(0,'Tag','cluster3');
            
            set(cluster3_tag,'Data',cluster_3_table);
            cluster_3_table_count = cluster_3_table_count+1;
            
            assignin('base','cluster_3_table',cluster_3_table);
            assignin('base','cluster_3_table_count',cluster_3_table_count);
            
            figure(2);
            s1(1) = subplot(3,1,1); title('Cluster 1');
            s1(2) = subplot(3,1,2); title('Cluster 2');
            s1(3) = subplot(3,1,3); title('Cluster 3'); xlabel('(Red - Temp, Blue - Humidity, Green - Pressure, Yellow - Wind)');
            simtime = get_param(bdroot,'SimulationTime');
            hold(s1(1),'on');
            hold(s1(2),'on');
            hold(s1(3),'on');
            figure(2);
            stem(s1(3),1,simtime,'r--o');
            
        end
    end
    
    temp_info{end,4} = num2str(rand_cluster_temp);
    temp_sen_h = findall(0,'Tag','temp_sen');
    set(temp_sen_h,'Data',temp_info);
    assignin('base','temp_info',temp_info);
    
catch
end

%% Pressure Cluster
try
    if ~isempty(avg_all_val_press)
        
        set_param(gcbh,'BackgroundColor','Cyan');
        pause(0.5);
        set_param(gcbh,'BackgroundColor','White');
        pause(0.5);
        
        rand_cluster_press = randi([1 3],1,1);
        if rand_cluster_press == 1
            queue_clus1 = evalin('base','queue_clus1');
            len_queue_clus1 = length(queue_clus1);
            for ele_ind = 1:len_queue_clus1
                if strcmp(queue_clus1(ele_ind).type,'press')
                    position = ele_ind;
                    break;
                end
            end
            if strcmp(queue_clus1(position).type,'press')
                rand_cluster_1(len_clus1 + 1).val = queue_clus1(position).val;
                queue_clus1(position).val = avg_all_val_press;
                queue_clus1(position).type = 'press';
            else
                rand_cluster_1(len_clus1 + 1).val = avg_all_val_press;
            end
            rand_cluster_1(len_clus1 + 1).sensor = 'Pressure';
            evalin('base','clear avg_all_val_press');
            assignin('base','rand_cluster_1',rand_cluster_1);
            
            cluster_1_table{cluster_1_table_count,1} = rand_cluster_1(end).sensor;
            cluster_1_table{cluster_1_table_count,2} = rand_cluster_1(end).val;
            cluster1_tag = findall(0,'Tag','cluster1');
            
            set(cluster1_tag,'Data',cluster_1_table);
            cluster_1_table_count = cluster_1_table_count+1;
            
            assignin('base','cluster_1_table',cluster_1_table);
            assignin('base','cluster_1_table_count',cluster_1_table_count);
            
            figure(2);
            s1(1) = subplot(3,1,1); title('Cluster 1');
            s1(2) = subplot(3,1,2); title('Cluster 2');
            s1(3) = subplot(3,1,3); title('Cluster 3'); xlabel('(Red - Temp, Blue - Humidity, Green - Pressure, Yellow - Wind)');
            simtime = get_param(bdroot,'SimulationTime');
            hold(s1(1),'on');
            hold(s1(2),'on');
            hold(s1(3),'on');
            figure(2);
            stem(s1(1),3,simtime,'b--o');
            
        end
        if rand_cluster_press == 2
            queue_clus2 = evalin('base','queue_clus2');
            len_queue_clus2 = length(queue_clus2);
            for ele_ind = 1:len_queue_clus2
                if strcmp(queue_clus2(ele_ind).type,'press')
                    position = ele_ind;
                    break;
                end
            end
            if strcmp(queue_clus2(position).type,'press')
                rand_cluster_2(len_clus2 + 1).val = queue_clus2(position).val;
                queue_clus2(position).val = avg_all_val_press;
                queue_clus2(position).type = 'press';
            else
                rand_cluster_2(len_clus2 + 1).val = avg_all_val_press;
            end
            rand_cluster_2(len_clus2 + 1).sensor = 'Pressure';
            evalin('base','clear avg_all_val_press');
            assignin('base','rand_cluster_2',rand_cluster_2);
            
            cluster_2_table{cluster_2_table_count,1} = rand_cluster_2(end).sensor;
            cluster_2_table{cluster_2_table_count,2} = rand_cluster_2(end).val;
            cluster2_tag = findall(0,'Tag','cluster2');
            
            set(cluster2_tag,'Data',cluster_2_table);
            cluster_2_table_count = cluster_2_table_count+1;
            
            assignin('base','cluster_2_table',cluster_2_table);
            assignin('base','cluster_2_table_count',cluster_2_table_count);
            
            figure(2);
            s1(1) = subplot(3,1,1); title('Cluster 1');
            s1(2) = subplot(3,1,2); title('Cluster 2');
            s1(3) = subplot(3,1,3); title('Cluster 3'); xlabel('(Red - Temp, Blue - Humidity, Green - Pressure, Yellow - Wind)');
            simtime = get_param(bdroot,'SimulationTime');
            hold(s1(1),'on');
            hold(s1(2),'on');
            hold(s1(3),'on');
            figure(2);
            stem(s1(2),3,simtime,'b--o');
            
        end
        if rand_cluster_press == 3
            queue_clus3 = evalin('base','queue_clus3');
            len_queue_clus3 = length(queue_clus3);
            for ele_ind = 1:len_queue_clus3
                if strcmp(queue_clus3(ele_ind).type,'press')
                    position = ele_ind;
                    break;
                end
            end
            if strcmp(queue_clus3(position).type,'press')
                rand_cluster_3(len_clus3 + 1).val = queue_clus3(position).val;
                queue_clus3(position).val = avg_all_val_press;
                queue_clus3(position).type = 'press';
            else
                rand_cluster_3(len_clus3 + 1).val = avg_all_val_press;
            end
            rand_cluster_3(len_clus3 + 1).sensor = 'Pressure';
            evalin('base','clear avg_all_val_press');
            assignin('base','rand_cluster_3',rand_cluster_3);
            
            cluster_3_table{cluster_3_table_count,1} = rand_cluster_3(end).sensor;
            cluster_3_table{cluster_3_table_count,2} = rand_cluster_3(end).val;
            cluster3_tag = findall(0,'Tag','cluster3');
            
            set(cluster3_tag,'Data',cluster_3_table);
            cluster_3_table_count = cluster_3_table_count+1;
            
            assignin('base','cluster_3_table',cluster_3_table);
            assignin('base','cluster_3_table_count',cluster_3_table_count);
            
            figure(2);
            s1(1) = subplot(3,1,1); title('Cluster 1');
            s1(2) = subplot(3,1,2); title('Cluster 2');
            s1(3) = subplot(3,1,3); title('Cluster 3'); xlabel('(Red - Temp, Blue - Humidity, Green - Pressure, Yellow - Wind)');
            simtime = get_param(bdroot,'SimulationTime');
            hold(s1(1),'on');
            hold(s1(2),'on');
            hold(s1(3),'on');
            figure(2);
            stem(s1(3),3,simtime,'b--o'); xlabel('(Red - Temp, Blue - Humidity, Green - Pressure, Yellow - Wind)');
        end
    end
    
    pres_info{end,4} = num2str(rand_cluster_press);
    pres_sen_h = findall(0,'Tag','pres_sen');
    set(pres_sen_h,'Data',pres_info);
    assignin('base','pres_info',pres_info);
    
catch
end

%% Wind Cluster
try
    if ~isempty(avg_all_val_wind)
        
        set_param(gcbh,'BackgroundColor','Green');
        pause(0.5);
        set_param(gcbh,'BackgroundColor','White');
        pause(0.5);
        
        rand_cluster_wind = randi([1 3],1,1);
        if rand_cluster_wind == 1
            queue_clus1 = evalin('base','queue_clus1');
            len_queue_clus1 = length(queue_clus1);
            for ele_ind = 1:len_queue_clus1
                if strcmp(queue_clus1(ele_ind).type,'wind')
                    position = ele_ind;
                    break;
                end
            end
            if strcmp(queue_clus1(position).type,'wind')
                rand_cluster_1(len_clus1 + 1).val = queue_clus1(position).val;
                queue_clus1(position).val = avg_all_val_wind;
                queue_clus1(position).type = 'wind';
            else
                rand_cluster_1(len_clus1 + 1).val = avg_all_val_wind;
            end
            rand_cluster_1(len_clus1 + 1).sensor = 'Wind';
            evalin('base','clear avg_all_val_wind');
            assignin('base','rand_cluster_1',rand_cluster_1);
            
            cluster_1_table{cluster_1_table_count,1} = rand_cluster_1(end).sensor;
            cluster_1_table{cluster_1_table_count,2} = rand_cluster_1(end).val;
            cluster1_tag = findall(0,'Tag','cluster1');
            
            set(cluster1_tag,'Data',cluster_1_table);
            cluster_1_table_count = cluster_1_table_count+1;
            
            assignin('base','cluster_1_table',cluster_1_table);
            assignin('base','cluster_1_table_count',cluster_1_table_count);
            
            figure(2);
            s1(1) = subplot(3,1,1); title('Cluster 1');
            s1(2) = subplot(3,1,2); title('Cluster 2');
            s1(3) = subplot(3,1,3); title('Cluster 3'); xlabel('(Red - Temp, Blue - Humidity, Green - Pressure, Yellow - Wind)'); xlabel('(Red - Temp, Blue - Humidity, Green - Pressure, Yellow - Wind)');
            simtime = get_param(bdroot,'SimulationTime');
            hold(s1(1),'on');
            hold(s1(2),'on');
            hold(s1(3),'on');
            figure(2);
            stem(s1(1),4,simtime,'y--o');
            
        end
        if rand_cluster_wind == 2
            queue_clus2 = evalin('base','queue_clus2');
            len_queue_clus2 = length(queue_clus2);
            for ele_ind = 1:len_queue_clus2
                if strcmp(queue_clus2(ele_ind).type,'wind')
                    position = ele_ind;
                    break;
                end
            end
            if strcmp(queue_clus2(position).type,'wind')
                rand_cluster_2(len_clus2 + 1).val = queue_clus2(position).val;
                queue_clus2(position).val = avg_all_val_wind;
                queue_clus2(position).type = 'wind';
            else
                rand_cluster_2(len_clus2 + 1).val = avg_all_val_wind;
            end
            rand_cluster_2(len_clus2 + 1).sensor='Wind';
            evalin('base','clear avg_all_val_wind');
            assignin('base','rand_cluster_2',rand_cluster_2);
            
            cluster_2_table{cluster_2_table_count,1} = rand_cluster_2(end).sensor;
            cluster_2_table{cluster_2_table_count,2} = rand_cluster_2(end).val;
            cluster2_tag = findall(0,'Tag','cluster2');
            
            set(cluster2_tag,'Data',cluster_2_table);
            cluster_2_table_count = cluster_2_table_count+1;
            
            assignin('base','cluster_2_table',cluster_2_table);
            assignin('base','cluster_2_table_count',cluster_2_table_count);
            
            figure(2);
            s1(1) = subplot(3,1,1); title('Cluster 1');
            s1(2) = subplot(3,1,2); title('Cluster 2');
            s1(3) = subplot(3,1,3); title('Cluster 3'); xlabel('(Red - Temp, Blue - Humidity, Green - Pressure, Yellow - Wind)'); xlabel('(Red - Temp, Blue - Humidity, Green - Pressure, Yellow - Wind)');
            simtime = get_param(bdroot,'SimulationTime');
            hold(s1(1),'on');
            hold(s1(2),'on');
            hold(s1(3),'on');
            figure(2);
            stem(s1(2),4,simtime,'y--o');
            
        end
        if rand_cluster_wind == 3
            queue_clus3 = evalin('base','queue_clus3');
            len_queue_clus3 = length(queue_clus3);
            for ele_ind = 1:len_queue_clus3
                if strcmp(queue_clus3(ele_ind).type,'wind')
                    position = ele_ind;
                    break;
                end
            end
            if strcmp(queue_clus3(position).type,'wind')
                rand_cluster_3(len_clus3 + 1).val = queue_clus3(position).val;
                queue_clus3(position).val = avg_all_val_wind;
                queue_clus3(position).type = 'wind';
            else
                rand_cluster_3(len_clus3 + 1).val = avg_all_val_wind;
            end
            rand_cluster_3(len_clus3 + 1).sensor='Wind';
            evalin('base','clear avg_all_val_wind');
            assignin('base','rand_cluster_3',rand_cluster_3);
            
            cluster_3_table{cluster_3_table_count,1} = rand_cluster_3(end).sensor;
            cluster_3_table{cluster_3_table_count,2} = rand_cluster_3(end).val;
            cluster3_tag = findall(0,'Tag','cluster3');
            
            set(cluster3_tag,'Data',cluster_3_table);
            cluster_3_table_count = cluster_3_table_count+1;
            
            assignin('base','cluster_3_table',cluster_3_table);
            assignin('base','cluster_3_table_count',cluster_3_table_count);
            
            figure(2);
            s1(1) = subplot(3,1,1); title('Cluster 1');
            s1(2) = subplot(3,1,2); title('Cluster 2');
            s1(3) = subplot(3,1,3); title('Cluster 3'); xlabel('(Red - Temp, Blue - Humidity, Green - Pressure, Yellow - Wind)'); xlabel('(Red - Temp, Blue - Humidity, Green - Pressure, Yellow - Wind)');
            simtime = get_param(bdroot,'SimulationTime');
            hold(s1(1),'on');
            hold(s1(2),'on');
            hold(s1(3),'on');
            figure(2);
            stem(s1(3),4,simtime,'y--o');
            
            
        end
    end
    
    wind_info{end,4} = num2str(rand_cluster_wind);
    wind_sen_h = findall(0,'Tag','wind_sen');
    set(wind_sen_h,'Data',wind_info);
    assignin('base','wind_info',wind_info);
    
catch
end

%% Compare with previous to check for a change
try
    if prev_val_humid ~= avg_all_val_humid
        humid_change = 1;
    end
    
    if prev_val_press ~= avg_all_val_press
        press_change = 1;
    end
    
    if prev_val_temp ~= avg_all_val_temp
        temp_change = 1;
    end
    
    if prev_val_wind ~= avg_all_val_wind
        wind_change = 1;
    end
    
catch
    % Do nothing now
end

%% To check if collision occurs
lasttime = evalin('base','lasttime');
if (humid_change && temp_change) && (rand_cluster_humid == rand_cluster_temp)
    pipe_storage(avg_all_val_humid,'humid');
    % Need to do something here
    set_param(gcbh,'BackgroundColor','Red');
    pause(0.5);
    set_param(gcbh,'BackgroundColor','White');
    pause(0.5);
    simtime = get_param(bdroot,'SimulationTime');
    disp(['Collision between temp and humidity @' num2str(simtime) ' in Cluster:' num2str(rand_cluster_humid)]);
    AssignColCluster(rand_cluster_humid, 'Humid and Temp', simtime-lasttime);
    lasttime = simtime;
    assignin('base','lasttime',lasttime);
elseif (press_change && wind_change) && (rand_cluster_press == rand_cluster_wind)
    pipe_storage(avg_all_val_wind,'wind');
    % Need to do something here
    set_param(gcbh,'BackgroundColor','Red');
    pause(0.5);
    set_param(gcbh,'BackgroundColor','White');
    pause(0.5);
    simtime = get_param(bdroot,'SimulationTime');
    disp(['Collision between press and wind @' num2str(simtime) ' in Cluster:' num2str(rand_cluster_press)]);
    AssignColCluster(rand_cluster_press, 'Press and Wind', simtime-lasttime);
    lasttime = simtime;
    assignin('base','lasttime',lasttime);
elseif (humid_change && press_change) && (rand_cluster_humid == rand_cluster_press)
    pipe_storage(avg_all_val_press,'press');
    % Need to do something here
    set_param(gcbh,'BackgroundColor','Red');
    pause(0.5);
    set_param(gcbh,'BackgroundColor','White');
    pause(0.5);
    simtime = get_param(bdroot,'SimulationTime');
    disp(['Collision between humid and press @' num2str(simtime) ' in Cluster:' num2str(rand_cluster_humid)]);
    AssignColCluster(rand_cluster_humid, 'Humid and Wind', simtime-lasttime);
    lasttime = simtime;
    assignin('base','lasttime',lasttime);
elseif (temp_change && wind_change) && (rand_cluster_temp == rand_cluster_wind)
    pipe_storage(avg_all_val_wind,'wind');
    % Need to do something here
    set_param(gcbh,'BackgroundColor','Red');
    pause(0.5);
    set_param(gcbh,'BackgroundColor','White');
    pause(0.5);
    simtime = get_param(bdroot,'SimulationTime');
    disp(['Collision between temp and wind @' num2str(simtime) ' in Cluster:' num2str(rand_cluster_temp)]);
    AssignColCluster(rand_cluster_temp, 'Temp and Wind', simtime-lasttime);
    lasttime = simtime;
    assignin('base','lasttime',lasttime);
elseif (humid_change && wind_change) && (rand_cluster_humid == rand_cluster_wind)
    pipe_storage(avg_all_val_wind,'wind');
    % Need to do something here
    set_param(gcbh,'BackgroundColor','Red');
    pause(0.5);
    set_param(gcbh,'BackgroundColor','White');
    pause(0.5);
    simtime = get_param(bdroot,'SimulationTime');
    disp(['Collision between wind and humidity @' num2str(simtime) ' in Cluster:' num2str(rand_cluster_humid)]);
    AssignColCluster(rand_cluster_humid, 'Wind and Humid', simtime-lasttime);
    lasttime = simtime;
    assignin('base','lasttime',lasttime);
elseif (temp_change && press_change) && (rand_cluster_temp == rand_cluster_press)
    pipe_storage(avg_all_val_press,'press');
    % Need to do something here
    set_param(gcbh,'BackgroundColor','Red');
    pause(0.5);
    set_param(gcbh,'BackgroundColor','White');
    pause(0.5);
    simtime = get_param(bdroot,'SimulationTime');
    disp(['Collision between temp and press @' num2str(simtime) ' in Cluster:' num2str(rand_cluster_temp)]);
    AssignColCluster(rand_cluster_temp, 'Temp and Press', simtime-lasttime);
    lasttime = simtime;
    assignin('base','lasttime',lasttime);
end

%%
% Assign current to previous
try
    prev_val_humid = avg_all_val_humid;
    prev_val_press = avg_all_val_press;
    prev_val_temp = avg_all_val_temp;
    prev_val_wind = avg_all_val_wind;
catch
end

try
    assignin('base','prev_val_humid',prev_val_humid);
    assignin('base','prev_val_press',prev_val_press);
    assignin('base','prev_val_temp',prev_val_temp);
    assignin('base','prev_val_wind',prev_val_wind);
catch
end

%end
%% Function: Terminate ===================================================
function Terminate(block)
% end Terminate

function AssignColCluster(clusno,senscol,delay)

cluscol_h = findall(0,'Tag',['cluscol',num2str(clusno)]);

curr_data = get(cluscol_h,'Data');

if strcmp(curr_data{end,1},'')
    curr_data = {};
    
    %     hold on;
end

figure(1); % new figure
s(1) = subplot(3,1,1); title('Cluster 1'); 
s(2) = subplot(3,1,2); title('Cluster 2'); ylabel('Collision Delay');
s(3) = subplot(3,1,3); title('Cluster 3'); xlabel('Sampling Time');
hold(s(1),'on');
hold(s(2),'on');
hold(s(3),'on');

simtime = get_param(bdroot,'SimulationTime');
curr_data{end+1,1} = num2str(simtime);
curr_data{end,2} = num2str(delay);
curr_data{end,3} = senscol;

set(cluscol_h,'Data',curr_data);

if clusno==1
    figure(1);
    stem(s(1),simtime,delay,'b--o');
end

if clusno==2
    figure(1);
    stem(s(2),simtime,delay,'b--o');
end

if clusno==3
    figure(1);
    stem(s(3),simtime,delay,'b--o');
end