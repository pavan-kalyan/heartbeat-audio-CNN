msg_count = 0;
img_bytes=[];
%load('netAttempt1.mat')
config;
global MQTT;

MQTT = mqtt(host,'ClientID',client_name,...
        'Port',port,'Username',username,'Password',password);
mySub = subscribe(MQTT,'in');
mySub.Callback = @mqtt_classify;