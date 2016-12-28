clear;

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

all_val_temp = 0;
all_val_wind = 0;
all_val_press = 0;
all_val_humid = 0;

rand_cluster_1 = [];
rand_cluster_2 = [];
rand_cluster_3 = [];

avg_all_val_humid = [];
avg_all_val_press = [];
avg_all_val_temp = [];
avg_all_val_wind = [];

queue_clus1.val = '';
queue_clus1.type = '';

queue_clus2.val = '';
queue_clus2.type = '';

queue_clus3.val = '';
queue_clus3.type = '';

cluster_1_table = {};
cluster_2_table = {};
cluster_3_table = {};

cluster_1_table_count = 1;
cluster_2_table_count = 1;
cluster_3_table_count = 1;

pres_sen_cnt = 1;
pres_info = {};
humid_sen_cnt = 1;
humid_info = {};
wind_sen_cnt = 1;
wind_info = {};
temp_sen_cnt = 1;
temp_info = {};

lasttime = 0;

Set_Sensor_Priorities