function y = temp_rand_gen()

all_val_temp = evalin('base','all_val_temp'); 
temp_info = evalin('base','temp_info');

y = randi([-50 150],1,1);
simtime = get_param(bdroot,'SimulationTime');
info = [num2str(y),' @',num2str(simtime)];

all_val_temp(end + 1) = y;
assignin('base','all_val_temp',all_val_temp);

temp_st = evalin('base','temp_st');
if mod(simtime,10*temp_st) == 0 && simtime >= 10*temp_st
    avg_all_val_temp = mean(all_val_temp);
    
    temp_sen_cnt = evalin('base','temp_sen_cnt');
    temp_info{temp_sen_cnt,1} = num2str(all_val_temp);
    temp_info{temp_sen_cnt,2} = avg_all_val_temp;
    temp_info{temp_sen_cnt,3} = num2str(simtime);
    temp_sen_cnt = temp_sen_cnt+1;
    
    temp_sen_h = findall(0,'Tag','temp_sen');
    set(temp_sen_h,'Data',temp_info); 
    
    all_val_temp = [];
    assignin('base','all_val_temp',all_val_temp);
    assignin('base','temp_info',temp_info);
    assignin('base','temp_sen_cnt',temp_sen_cnt);
    
    assignin('base','avg_all_val_temp',avg_all_val_temp);
end
