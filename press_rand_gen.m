function y = press_rand_gen()

all_val_press = evalin('base','all_val_press');
pres_info = evalin('base','pres_info');

y = randi([0 101325],1,1);
simtime = get_param(bdroot,'SimulationTime');
info = [num2str(y),' @',num2str(simtime)];

all_val_press(end + 1) = y;
assignin('base','all_val_press',all_val_press);

press_st = evalin('base','press_st');
if mod(simtime,10*press_st) == 0 && simtime >= 10*press_st
    
    avg_all_val_press = mean(all_val_press);
    
    pres_sen_cnt = evalin('base','pres_sen_cnt');
    pres_info{pres_sen_cnt,1} = num2str(all_val_press);
    pres_info{pres_sen_cnt,2} = avg_all_val_press;
    pres_info{pres_sen_cnt,3} = num2str(simtime);
    pres_sen_cnt = pres_sen_cnt+1;
    
    pre_sen_h = findall(0,'Tag','pres_sen');
    set(pre_sen_h,'Data',pres_info); 
    
    all_val_press = [];
    assignin('base','all_val_press',all_val_press);
    assignin('base','pres_info',pres_info);
    assignin('base','pres_sen_cnt',pres_sen_cnt);
    assignin('base','avg_all_val_press',avg_all_val_press);
end
