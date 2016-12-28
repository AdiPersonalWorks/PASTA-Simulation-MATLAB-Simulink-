function y = humid_rand_gen()

all_val_humid = evalin('base','all_val_humid'); 
humid_info = evalin('base','humid_info');

y = randi([1 100],1,1);
simtime = get_param(bdroot,'SimulationTime');
info = [num2str(y),' @',num2str(simtime)];

all_val_humid(end + 1) = y;
assignin('base','all_val_humid',all_val_humid);

hum_st = evalin('base','hum_st');
if mod(simtime,10*hum_st) == 0 && simtime >= 10*hum_st
    avg_all_val_humid = mean(all_val_humid);
    
    humid_sen_cnt = evalin('base','humid_sen_cnt');
    humid_info{humid_sen_cnt,1} = num2str(all_val_humid);
    humid_info{humid_sen_cnt,2} = avg_all_val_humid;
    humid_info{humid_sen_cnt,3} = num2str(simtime);
    humid_sen_cnt = humid_sen_cnt+1;
    
    humid_sen_h = findall(0,'Tag','humid_sen');
    set(humid_sen_h,'Data',humid_info); 
    
    all_val_humid = [];
    assignin('base','all_val_humid',all_val_humid);
    assignin('base','humid_info',humid_info);
    assignin('base','humid_sen_cnt',humid_sen_cnt);
    
    assignin('base','avg_all_val_humid',avg_all_val_humid);
end
