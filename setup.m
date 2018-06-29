msg_count = 0;
img_bytes=[];
%load('netAttempt1.mat')
config;

myMQTT = mqtt(host,'ClientID',client_name,...
        'Port',port,'Username',username,'Password',password);
mySub = subscribe(myMQTT,'in');
mySub.Callback = @mqtt_classify;