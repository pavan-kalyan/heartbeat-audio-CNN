function mqtt_classify(topicName,msg)


global myMQTT
fprintf('This message is sent at time %s\n', datestr(now))
disp('Topic :');
disp(topicName);
disp('msg : ');
disp(msg);

%audio processing
[y,fs] = audioread('C:\Users\Sapy\Documents\MATLAB\example.wav');
y = y(:,1);
dt = 1/fs;
t = 0:dt:(length(y)*dt)-dt;
%spectrogram generation
image = spectrogram(y,256,[],[],fs,'yaxis');
image = image(:,mod(0:len-1, numel(image(1,:))) + 1); %repeat audio to length
imshow(image);
%classification
result = classify(convnet,image)
str = char(result(1));


publish(myMQTT,'out',str);
end