%This file should segment the audio data Network to process

%% Open the relevant directory to process the wave files
filePattern = fullfile('t2','set_a','*.wav');
dirListings = dir(filePattern);
dir_len = length(dirListings);
fileID = fopen('set_a_timing.csv');
data = textscan(fileID,'%s %s %s %s','Delimiter',',');
categories ={'Artifact','Extrahls','Murmur','Normal','Unlabelled'};

% %% Process every file in the directory
% for i = 1:dirlen
%     [y,fs] = audioread(strcat('t2\set_a\',dirListings(d).name));
%     
% end

%% Test module for the spectrogram
[y,fs] = audioread(strcat('t2\set_a\','normal__201108011118.wav'));
axes('Units', 'normalized', 'Position', [0 0 1 1])
F =linspace(1,600,2000);

%resubplot(2,1,1);
spectrogram(y,500,[],F,fs,'yaxis')
colormap gray;
fig = gcf;
%Configurations to turn off various features of the figure
set(fig,'Visible','on');
colorbar off;
axis off;
iptsetpref('ImshowBorder','tight');

    
frame = getframe(fig);
imwrite(frame.cdata,strcat('test','.png'),'png');
% subplot(2,1,2);
% [y2,fs2] = audioread(strcat('Test_audio.aac'));
% spectrogram(y2,500,[],F,fs2,'yaxis')
% colormap gray;

% imwrite(frame.cdata,strcat('t','.png'),'png')
% a = imread('t.png');
% rgb2gray(a);
% imshow(a),title('Original Image');
% 
% b = imadjust(a);
% figure, imshow(b)
% title('Sharpened Image');

x_dat = str2double(data{1,4}(368:391));
%plot(y);
%hold;
%plot(x_dat,y(x_dat),'*','r');

%  %% Test module for the segmation
%  segment_index = ecgemowinmax(y,14000);
%  max_pos = find(segment_index);
%  init_pos = 0;
%  final_pos = 0;
% while(i < size(max_pos))
%     midpoint = max[i+1]+max
%     segment
% end