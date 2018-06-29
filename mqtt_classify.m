function mqtt_classify(topicName,msg)
import('org.apache.commons.codec.binary.Base64');

base64 = Base64();

fprintf('This message is sent at time %s\n', datestr(now))
disp('Topic :');
disp(topicName);
disp('msg : ');
disp(msg)
temp=uint8(convertStringsToChars(msg));
img_bytes = base64.decode(temp);
fid = fopen('test.bin','w');
fwrite(fid,img_bytes,'int8');
fclose(fid);
img = imread('test.bin');
imshow(img);
%classify(convnet,img)
end