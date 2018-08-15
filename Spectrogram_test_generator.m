clear;
clf;
close all hidden;

[y,fs] = audioread('heartbeat.mp4');
F =linspace(1,1000,2000);

%Generate the spectrogram and some figure settings
spectrogram(y,500,[],F,fs,'yaxis');
colormap gray;
fig = gcf;
axes('Units', 'normalized', 'Position', [0 0 1 1])
set(fig,'Visible','on');
colorbar off;
axis off;
iptsetpref('ImshowBorder','tight');

