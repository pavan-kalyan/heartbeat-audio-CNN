clear;
%% Load the data from the given directory and normalize the amplitudes
filePattern = fullfile('set_a','*.wav');
dirListings = dir(filePattern);
dir_len = length(dirListings);
fileID = fopen('set_a_timing.csv');
data = textscan(fileID,'%s %s %s %s','Delimiter',',');
categories ={'Artifact','Extrahls','Murmur','Normal','Unlabelled'};

len = 3099;
%% The the wave files are read, normalized and filtered and categorized images are produced

%For the unlabelled data
for d = 1:52
    [y,fs] = audioread(strcat('set_a\',dirListings(d).name));  
    
    %The data is normalized using generalized min-max method.
    norm_y = ((y-min(y))/(max(y) - min(y)))*(1+1)-1;
    
    %Filter using a lowpass filter
    filt_y = doFilter(norm_y);
    
    image = spectrogram(filt_y,256,224,1024,fs,'yaxis');
    
    image = image(:,mod(0:len-1, numel(image(1,:))) + 1); %repeat audio to length
    
    imwrite(image,strcat('images\Unlabelled\',dirListings(d).name(1:end-4),'.png'),'png');
end

%For the artifact data
for d = 53:92
    [y,fs] = audioread(strcat('set_a\',dirListings(d).name));  
    
    %The data is normalized using generalized min-max method.
    norm_y = ((y-min(y))/(max(y) - min(y)))*(1+1)-1;
    
    %Filter using a lowpass filter
    filt_y = doFilter(norm_y);
    
    image = spectrogram(filt_y,256,224,1024,fs,'yaxis');
    
    image = image(:,mod(0:len-1, numel(image(1,:))) + 1); %repeat audio to length
    
    imwrite(image,strcat('images\Artifact\',dirListings(d).name(1:end-4),'.png'),'png');
end

%For the extrahls data
for d = 93:111
    [y,fs] = audioread(strcat('set_a\',dirListings(d).name));  
    
    %The data is normalized using generalized min-max method.
    norm_y = ((y-min(y))/(max(y) - min(y)))*(1+1)-1;
    
    %Filter using a lowpass filter
    filt_y = doFilter(norm_y);
    
    image = spectrogram(filt_y,256,224,1024,fs,'yaxis');
    
    image = image(:,mod(0:len-1, numel(image(1,:))) + 1); %repeat audio to length
    
    imwrite(image,strcat('images\Extrahls\',dirListings(d).name(1:end-4),'.png'),'png');
end

%For the Murmur data
for d = 112:145
    [y,fs] = audioread(strcat('set_a\',dirListings(d).name));  
    
    %The data is normalized using generalized min-max method.
    norm_y = ((y-min(y))/(max(y) - min(y)))*(1+1)-1;
    
    %Filter using a lowpass filter
    filt_y = doFilter(norm_y);
    
    image = spectrogram(filt_y,256,224,1024,fs,'yaxis');
    
    image = image(:,mod(0:len-1, numel(image(1,:))) + 1); %repeat audio to length
    
    imwrite(image,strcat('images\Murmur\',dirListings(d).name(1:end-4),'.png'),'png');
end

%For the Normal data
for d = 146:176
    [y,fs] = audioread(strcat('set_a\',dirListings(d).name));  
    
    %The data is normalized using generalized min-max method.
    norm_y = ((y-min(y))/(max(y) - min(y)))*(1+1)-1;
    
    %Filter using a lowpass filter
    filt_y = doFilter(norm_y);
    
    image = spectrogram(filt_y,256,224,1024,fs,'yaxis');
    
    image = image(:,mod(0:len-1, numel(image(1,:))) + 1); %repeat audio to length
    
    imwrite(image,strcat('images\Normal\',dirListings(d).name(1:end-4),'.png'),'png');
end
%% Loading and processing a bit quicker.
rootFolder = fullfile('images');

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


