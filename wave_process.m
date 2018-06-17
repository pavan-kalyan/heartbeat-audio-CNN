clear;
%% Load the data from the given directory and normalize the amplitudes
filePattern = fullfile('Noisy_dataset','setb','*.wav');
dirListings = dir(filePattern);
dir_len = length(dirListings);
fileID = fopen('set_b.csv');
data = textscan(fileID,'%s %s %s %*[^\n]','Delimiter',',');
labels = data{1,3}(2:end);
categories ={'Normal','Extrastole','Murmur','Normal'};

len = 3099;
%% The the wave files are read, normalized and filtered and categorized images are produced

%For the unlabelled data
for d = 1:195
    [y,fs] = audioread(strcat('Noisy_dataset\setb\',dirListings(d).name));  
    
    %The data is normalized using generalized min-max method.
    norm_y = ((y-min(y))/(max(y) - min(y)))*(1+1)-1;
    
    %Filter using a lowpass filter
    filt_y = doFilter(norm_y);
    
    image = spectrogram(filt_y,256,224,1024,fs,'yaxis');
    
    image = image(:,mod(0:len-1, numel(image(1,:))) + 1); %repeat audio to length
    
    imwrite(image,strcat('t2\Unlabelled\',dirListings(d).name(1:end-4),'.png'),'png');
end

%For the extrastole data
for d = 196:241
    [y,fs] = audioread(strcat('Noisy_dataset\setb\',dirListings(d).name));  
    
    %The data is normalized using generalized min-max method.
    norm_y = ((y-min(y))/(max(y) - min(y)))*(1+1)-1;
    
    %Filter using a lowpass filter
    filt_y = doFilter(norm_y);
    
    image = spectrogram(filt_y,256,224,1024,fs,'yaxis');
    
    image = image(:,mod(0:len-1, numel(image(1,:))) + 1); %repeat audio to length
    
    imwrite(image,strcat('t2\Extrastole\',dirListings(d).name(1:end-4),'.png'),'png');
end

%For the murmur data
for d = 242:336
    [y,fs] = audioread(strcat('Noisy_dataset\setb\',dirListings(d).name));  
    
    %The data is normalized using generalized min-max method.
    norm_y = ((y-min(y))/(max(y) - min(y)))*(1+1)-1;
    
    %Filter using a lowpass filter
    filt_y = doFilter(norm_y);
    
    image = spectrogram(filt_y,256,224,1024,fs,'yaxis');
    
    image = image(:,mod(0:len-1, numel(image(1,:))) + 1); %repeat audio to length
    
    imwrite(image,strcat('t2\Murmur\',dirListings(d).name(1:end-4),'.png'),'png');
end

%For the normal data
for d = 337:656
    [y,fs] = audioread(strcat('Noisy_dataset\setb\',dirListings(d).name));  
    
    %The data is normalized using generalized min-max method.
    norm_y = ((y-min(y))/(max(y) - min(y)))*(1+1)-1;
    
    %Filter using a lowpass filter
    filt_y = doFilter(norm_y);
    
    image = spectrogram(filt_y,256,224,1024,fs,'yaxis');
    
    image = image(:,mod(0:len-1, numel(image(1,:))) + 1); %repeat audio to length
    
    imwrite(image,strcat('t2\Normal\',dirListings(d).name(1:end-4),'.png'),'png');
end

%% Loading and processing a bit quicker.
rootFolder = fullfile('t2');

%Train with all data except the unlabelled stuff
trainData = imageDatastore(fullfile(rootFolder, categories(2:end)), 'LabelSource', 'foldernames');

%Show a summary of each labelr
tb1 = countEachLabel(trainData);

%Determine the minimum no of images
minSetCount = min(tb1{:,2});

% Use splitEachLabel method to trim the set.
trainData = splitEachLabel(trainData, minSetCount, 'randomize');

% Notice that each set now has exactly the same number of images.
countEachLabel(trainData)
%% Loading the traning data and processing
% trainData = imageDatastore('t2\*.png','labelSource','none');
% trainData.Labels=categorical(labels(125:174));
% 
% for i=53:length(dirListings)
%     [y,fs] = audioread(strcat('Noisy_dataset\setb\',dirListings(i).name));
% 
%     %The data is normalized using generalized min-max method.
%     norm_y = ((y-min(y))/(max(y) - min(y)))*(1+1)-1;
%     
%     %Filter using a lowpass filter
%     filt_y = doFilter(norm_y);
%     
%     image = spectrogram(filt_y,256,224,1024,fs,'yaxis');
%     image = image(:,mod(0:len-1, numel(image(1,:))) + 1);
%     imwrite(image,strcat('images\',dirListings(i).name(1:end-4),'.png'),'png');
%     disp(dirListings(i).name);
% end
% trainData = imageDatastore('images\*.png','labelSource','none');
% trainData.Labels=categorical(labels(1:313));


