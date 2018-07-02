clear;
%Wave segment will generate new data which has been segmented to aling S1
%and S2 peaks in the audio data
%wave_segment;
%% Load the data from the given directory
filePattern = fullfile('t2','set_a','*.wav');
dirListings = dir(filePattern);
dir_len = length(dirListings);
fileID = fopen('set_a_timing.csv');
data = textscan(fileID,'%s %s %s %s','Delimiter',',');
categories ={'Artifact','Extrahls','Murmur','Normal','Unlabelled'};
len = 3099;
%% Generate the relevant directory for saving the outputs the files
search_dir = fullfile('t2','images');
mkdir(search_dir);
for k = 1:numel(categories)
   if(exist(search_dir,'dir') == 7)
        mkdir(fullfile('t2','images',char(categories(k))));
   end
end
%% The the wave files are read, normalized and filtered and categorized images are produced

%For the unlabelled data
for d = 1:52
    [y,fs] = audioread(strcat('t2\set_a\',dirListings(d).name));  
    
    %The data is normalized using generalized min-max method.
    norm_y = ((y-min(y))/(max(y) - min(y)))*(1+1)-1;
    
    %image = spectrogram(norm_y,256,224,1024,fs,'yaxis');
    %Settings to set position of figure axes
    axes('Units', 'normalized', 'Position', [0 0 1 1])
    colormap gray;
    %Generate the sectrogram and save gcf to fig
    spectrogram(norm_y,length(norm_y),[],1024,fs,'yaxis');
    fig = gcf;
    %Configureations to turn off various features of the figure
    set(fig,'Visible','off');
    colorbar off;
    axis off;
    iptsetpref('ImshowBorder','tight');
    
    %Save the image and modify to ensure all spectrograms are of same
    %length
    saveas(fig,strcat('t2\images\Unlabelled\',dirListings(d).name(1:end-4),'.png'),'png');
    image = imread(strcat('t2\images\Unlabelled\',dirListings(d).name(1:end-4),'.png'));
    image = image(:,mod(0:len-1, numel(image(1,:))) + 1); %repeat audio to length
    imwrite(image,strcat('t2\images\Unlabelled\',dirListings(d).name(1:end-4),'.png'),'png');
    
end

%For the artifact data
for d = 53:92
    [y,fs] = audioread(strcat('t2\set_a\',dirListings(d).name));  
    
    %The data is normalized using generalized min-max method.
    norm_y = ((y-min(y))/(max(y) - min(y)))*(1+1)-1;
    
    %Settings to set position of figure axes
    axes('Units', 'normalized', 'Position', [0 0 1 1])
    colormap gray;
    %Generate the sectrogram and save gcf to fig
    spectrogram(norm_y,length(norm_y),[],1024,fs,'yaxis');
    fig = gcf;
    %Configureations to turn off various features of the figure
    set(fig,'Visible','off');
    colorbar off;
    axis off;
    iptsetpref('ImshowBorder','tight');
    
    %Save the image and modify to ensure all spectrograms are of same
    %length
    saveas(fig,strcat('t2\images\Artifact\',dirListings(d).name(1:end-4),'.png'),'png');
    image = imread(strcat('t2\images\Artifact\',dirListings(d).name(1:end-4),'.png'));
    image = image(:,mod(0:len-1, numel(image(1,:))) + 1); %repeat audio to length
    imwrite(image,strcat('t2\images\Artifact\',dirListings(d).name(1:end-4),'.png'),'png');
end

%For the extrahls data
for d = 93:111
    [y,fs] = audioread(strcat('t2\set_a\',dirListings(d).name));  
    
    %The data is normalized using generalized min-max method.
    norm_y = ((y-min(y))/(max(y) - min(y)))*(1+1)-1;
    
    %Settings to set position of figure axes
    axes('Units', 'normalized', 'Position', [0 0 1 1])
    colormap gray;
    %Generate the sectrogram and save gcf to fig
    spectrogram(norm_y,length(norm_y),[],1024,fs,'yaxis');
    fig = gcf;
    %Configureations to turn off various features of the figure
    set(fig,'Visible','off');
    colorbar off;
    axis off;
    iptsetpref('ImshowBorder','tight');
    
    %Save the image and modify to ensure all spectrograms are of same
    %length
    saveas(fig,strcat('t2\images\Extrahls\',dirListings(d).name(1:end-4),'.png'),'png');
    image = imread(strcat('t2\images\Extrahls\',dirListings(d).name(1:end-4),'.png'));
    image = image(:,mod(0:len-1, numel(image(1,:))) + 1); %repeat audio to length
    imwrite(image,strcat('t2\images\Extrahls\',dirListings(d).name(1:end-4),'.png'),'png');
end

%For the Murmur data
for d = 112:145
    [y,fs] = audioread(strcat('t2\set_a\',dirListings(d).name));  
    
    %The data is normalized using generalized min-max method.
    norm_y = ((y-min(y))/(max(y) - min(y)))*(1+1)-1;
    
    %Settings to set position of figure axes
    axes('Units', 'normalized', 'Position', [0 0 1 1])
    colormap gray;
    %Generate the sectrogram and save gcf to fig
    spectrogram(norm_y,length(norm_y),[],1024,fs,'yaxis');
    fig = gcf;
    %Configureations to turn off various features of the figure
    set(fig,'Visible','off');
    colorbar off;
    axis off;
    iptsetpref('ImshowBorder','tight');
    
    %Save the image and modify to ensure all spectrograms are of same
    %length
    saveas(fig,strcat('t2\images\Murmur\',dirListings(d).name(1:end-4),'.png'),'png');
    image = imread(strcat('t2\images\Murmur\',dirListings(d).name(1:end-4),'.png'));
    image = image(:,mod(0:len-1, numel(image(1,:))) + 1); %repeat audio to length
    imwrite(image,strcat('t2\images\Murmur\',dirListings(d).name(1:end-4),'.png'),'png');
end

%For the Normal data
for d = 146:176
    [y,fs] = audioread(strcat('t2\set_a\',dirListings(d).name));  
    
    %The data is normalized using generalized min-max method.
    norm_y = ((y-min(y))/(max(y) - min(y)))*(1+1)-1;
    
    %Settings to set position of figure axes
    axes('Units', 'normalized', 'Position', [0 0 1 1])
    colormap gray;
    %Generate the sectrogram and save gcf to fig
    spectrogram(norm_y,length(norm_y),[],1024,fs,'yaxis');
    fig = gcf;
    %Configureations to turn off various features of the figure
    set(fig,'Visible','off');
    colorbar off;
    axis off;
    iptsetpref('ImshowBorder','tight');
    
    %Save the image and modify to ensure all spectrograms are of same
    %length
    saveas(fig,strcat('t2\images\Normal\',dirListings(d).name(1:end-4),'.png'),'png');
    image = imread(strcat('t2\images\Normal\',dirListings(d).name(1:end-4),'.png'));
    image = image(:,mod(0:len-1, numel(image(1,:))) + 1); %repeat audio to length
    imwrite(image,strcat('t2\images\Normal\',dirListings(d).name(1:end-4),'.png'),'png');
end
%% Loading and processing a bit quicker.
rootFolder = fullfile('t2','images');

%Train with all data except the unlabelled stuff
trainData = imageDatastore(fullfile(rootFolder, categories(1:4)), 'LabelSource', 'foldernames');

%Show a summary of each labelr
tb1 = countEachLabel(trainData);

%Determine the minimum no of images
minSetCount = min(tb1{:,2});

% Use splitEachLabel method to trim the set.
trainData = splitEachLabel(trainData, minSetCount, 'randomize');

% Notice that each set now has exactly the same number of images.
countEachLabel(trainData)


