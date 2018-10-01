function mqtt_classify(topicName,msg)


global MQTT
fprintf('This message is sent at time %s\n', datestr(now))
disp('Topic :');
disp(topicName);
disp('msg : ');
disp(msg);
%loading model
load trainedNet

%audio processing
%Spectrogram_test_generator
classify_heartbeat(msg)
result = classify(trainedNet,imread(char(strcat(msg,'.png'))))
str = char(result(1));


publish(MQTT,'out',str);
end