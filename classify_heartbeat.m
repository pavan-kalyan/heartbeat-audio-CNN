function classify_heartbeat(str)
clf;
close all hidden;

[y,fs] = audioread(strcat(str,'.wav'));
output = fullfile('t2','test_input');
spec_output = fullfile('t2','test_output');
wave_segment_Shannon(y,'test',fs,output);
dirListings = dir(output);
dir_len = length(dirListings);
for i = 1:dir_len
[y,fs] = audioread(fullfile(output,dirListings.name(i)));  
axes('Units', 'normalized', 'Position', [0 0 1 1])
F =linspace(1,1000,2000);
    
%Generate the sectrogram and save gcf to fig
spectrogram(y,500,[],F,fs,'yaxis');
colormap gray;
fig = gcf;

%Configurations to turn off various features of the figure
set(fig,'Visible','on');
colorbar off;
axis off;
iptsetpref('ImshowBorder','tight');

%Write an image to file with name 'test.png'
frame = getframe(gcf);
I = frame.cdata;
I = imresize(I,[525 700]);
imwrite(I,strcat(fullfile(spec_output,dirListings(i).name(1:end-4)),'.png'),'png')
% saveas(fig,strcat('test2','.png'),'png');
end