function y = wind_rand_gen()

all_val_wind = evalin('base','all_val_wind'); 
wind_info = evalin('base','wind_info');

y = randi([0 50],1,1);
simtime = get_param(bdroot,'SimulationTime');
info = [num2str(y),' @',num2str(simtime)];

all_val_wind(end + 1) = y;
assignin('base','all_val_wind',all_val_wind);

wind_st = evalin('base','wind_st');
if mod(simtime,10*wind_st) == 0 && simtime >= 10*wind_st
    avg_all_val_wind = mean(all_val_wind);
    
    wind_sen_cnt = evalin('base','wind_sen_cnt');
    wind_info{wind_sen_cnt,1} = num2str(all_val_wind);
    wind_info{wind_sen_cnt,2} = avg_all_val_wind;
    wind_info{wind_sen_cnt,3} = num2str(simtime);
    wind_sen_cnt = wind_sen_cnt+1;
    
    wind_sen_h = findall(0,'Tag','wind_sen');
    set(wind_sen_h,'Data',wind_info); 
    
    all_val_wind = [];
    assignin('base','all_val_wind',all_val_wind);
    assignin('base','wind_info',wind_info);
    assignin('base','wind_sen_cnt',wind_sen_cnt);
    
    assignin('base','avg_all_val_wind',avg_all_val_wind);
end
