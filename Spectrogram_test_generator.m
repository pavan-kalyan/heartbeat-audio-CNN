clf;
close all hidden;

[y,fs] = audioread('Test_audio.aac');
axes('Units', 'normalized', 'Position', [0 0 1 1])
F =linspace(1,600,1000);
    
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
imwrite(I,strcat('test','.png'),'png')
% saveas(fig,strcat('test2','.png'),'png');

