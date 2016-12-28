function [ output_queue ] = pipe_storage( value_to_store,type)
%LEFT_SHIFT Summary of this function goes here
%   Detailed explanation goes here

flag_temp1 = 0;
flag_humid1 = 0;
flag_wind1 = 0;
flag_press1 = 0;

flag_temp2 = 0;
flag_humid2 = 0;
flag_wind2 = 0;
flag_press2 = 0;

flag_temp3 = 0;
flag_humid3 = 0;
flag_wind3 = 0;
flag_press3 = 0;

try
    queue_1 = evalin('base','queue_clus1');
    len1 = length(queue_1);
catch
    len1 = 0;
end

try
    queue_2 = evalin('base','queue_clus2');
    len2 = length(queue_2);
catch
    len2 = 0;
end

try
    queue_3 = evalin('base','queue_clus3');
    len3 = length(queue_3);
catch
    len3 = 0;
end
    
if strcmp(type,'temp')
    if len1 < 4
        for i = 1:len1
            if strcmp(queue_1(i).type,'temp')
                flag_temp1 = 1;
                break;
            end
        end
        if flag_temp1 == 0
            queue_1(len1 + 1).val = value_to_store;
            queue_1(len1 + 1).type = type;
            assignin('base','queue_clus2',queue_2);
        end
    elseif len2 < 4
        for i = 1:len2
            if strcmp(queue_2(i).type,'temp')
                flag_temp2 = 1;
                break;
            end
        end
        if flag_temp2 == 0
            queue_2(len2 + 1).val = value_to_store;
            queue_2(len2 + 1).type = type;
            assignin('base','queue_clus2',queue_2);
        end
    elseif len3 < 4
        for i = 1:len3
            if strcmp(queue_3(i).type,'temp')
                flag_temp3 = 1;
                break;
            end
        end
        if flag_temp3 == 0
            queue_3(len3 + 1).val = value_to_store;
            queue_3(len3 + 1).type = type;
            assignin('base','queue_clus3',queue_3);
        end
    end
end
        
if strcmp(type,'humid')
    if len1 < 4
        for i = 1:len1
            if strcmp(queue_1(i).type,'humid')
                flag_humid1 = 1;
                break;
            end
        end
        if flag_humid1 == 0
            queue_1(len1 + 1).val = value_to_store;
            queue_1(len1 + 1).type = type;
            assignin('base','queue_clus2',queue_2);
        end
    elseif len2 < 4
        for i = 1:len2
            if strcmp(queue_2(i).type,'humid')
                flag_humid2 = 1;
                break;
            end
        end
        if flag_humid2 == 0
            queue_2(len2 + 1).val = value_to_store;
            queue_2(len2 + 1).type = type;
            assignin('base','queue_clus2',queue_2);
        end
    elseif len3 < 4
        for i = 1:len3
            if strcmp(queue_3(i).type,'humid')
                flag_humid3 = 1;
                break;
            end
        end
        if flag_humid3 == 0
            queue_3(len3 + 1).val = value_to_store;
            queue_3(len3 + 1).type = type;
            assignin('base','queue_clus3',queue_3);
        end
    end
end

if strcmp(type,'press')
    if len1 < 4
        for i = 1:len1
            if strcmp(queue_1(i).type,'press')
                flag_press1 = 1;
                break;
            end
        end
        if flag_press1 == 0
            queue_1(len1 + 1).val = value_to_store;
            queue_1(len1 + 1).type = type;
            assignin('base','queue_clus2',queue_2);
        end
    elseif len2 < 4
        for i = 1:len2
            if strcmp(queue_2(i).type,'press')
                flag_press2 = 1;
                break;
            end
        end
        if flag_press2 == 0
            queue_2(len2 + 1).val = value_to_store;
            queue_2(len2 + 1).type = type;
            assignin('base','queue_clus2',queue_2);
        end
    elseif len3 < 4
        for i = 1:len3
            if strcmp(queue_3(i).type,'press')
                flag_press3 = 1;
                break;
            end
        end
        if flag_press3 == 0
            queue_3(len3 + 1).val = value_to_store;
            queue_3(len3 + 1).type = type;
            assignin('base','queue_clus3',queue_3);
        end
    end
end

if strcmp(type,'wind')
    if len1 < 4
        for i = 1:len1
            if strcmp(queue_1(i).type,'wind')
                flag_wind1 = 1;
                break;
            end
        end
        if flag_wind1 == 0
            queue_1(len1 + 1).val = value_to_store;
            queue_1(len1 + 1).type = type;
            assignin('base','queue_clus2',queue_2);
        end
    elseif len2 < 4
        for i = 1:len2
            if strcmp(queue_2(i).type,'wind')
                flag_wind2 = 1;
                break;
            end
        end
        if flag_wind2 == 0
            queue_2(len2 + 1).val = value_to_store;
            queue_2(len2 + 1).type = type;
            assignin('base','queue_clus2',queue_2);
        end
    elseif len3 < 4
        for i = 1:len3
            if strcmp(queue_3(i).type,'wind')
                flag_wind3 = 1;
                break;
            end
        end
        if flag_wind3 == 0
            queue_3(len3 + 1).val = value_to_store;
            queue_3(len3 + 1).type = type;
            assignin('base','queue_clus3',queue_3);
        end
    end
end