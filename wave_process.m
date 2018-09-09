clc;
clf('reset');
close all hidden;
%Wave segment will generate new data which has been segmented to aling S1
%and S2 peaks in the audio data
%wave_segment;
%% Load the data from the given directory
filePattern = fullfile('t2','set_a','*.wav');
dirListings = dir(filePattern);
dir_len = length(dirListings);
fileID = fopen('set_a_timing.csv');
data = textscan(fileID,'%s %s %s %s','Delimiter',',');
categories ={'Artifact','Extrahls','Murmur','Normal','Test_Artifact','Test_Extrahls','Test_Murmur','Test_Normal','Unlabelled'};
len = 3099;
%% Here you can modify the number of test files for training
test_artifact = 7;
test_extrahls = 7;
test_murmur = 7;
test_normal = 7;
%% Generate the relevant directory for saving the outputs the files
search_dir = fullfile('t2','images');
rmdir(search_dir,'s');
mkdir(search_dir);
for k = 1:numel(categories)
   if(exist(search_dir,'dir') == 7)
        mkdir(fullfile('t2','images',char(categories(k))));
   end
end
%% The the wave files are read, normalized and filtered and categorized images are produced
disp('Generating Unlabelled data...');
root_input = fullfile('t2','set_a');
root_output = fullfile('t2','images');
%For the unlabelled data
for d = 1:52
    [y,fs] = audioread(fullfile(root_input,dirListings(d).name));
    
    %The data is normalized using generalized min-max method.
    norm_y = ((y-min(y))/(max(y) - min(y)))*(1+1)-1;
    
    %Settings to set position of figure axes 
    axes('Units', 'normalized', 'Position', [0 0 1 1])
    F =linspace(1,600,1000);
    
    %Generate the sectrogram and save gcf to fig
    spectrogram(y,500,[],F,fs,'yaxis');
    colormap gray;
    fig = gcf;
    
    %Configurations to turn off various features of the figure
    set(fig,'Visible','off');
    colorbar off;
    axis off;
    iptsetpref('ImshowBorder','tight');
    
    %Save the image to file 
    frame = getframe(fig);
    I = frame.cdata;
    I = imresize(I,[525 700]);
    imwrite(I,strcat(fullfile(root_output,'Unlabelled',dirListings(d).name(1:end-4)),'.png'),'png');
    close all hidden;
    clf;
end 
disp('Generating Artifact data...');
%For the artifact data
for d = 53:92
    [y,fs] = audioread(fullfile(root_input,dirListings(d).name));  
    
    %The data is normalized using generalized min-max method.
    norm_y = ((y-min(y))/(max(y) - min(y)))*(1+1)-1;
    
    %Settings to set position of figure axes
    axes('Units', 'normalized', 'Position', [0 0 1 1])
    F =linspace(1,600,1000);
    
    %Generate the sectrogram and save gcf to fig
    spectrogram(y,500,[],F,fs,'yaxis');
    colormap gray;
    fig = gcf;
    
    %Configurations to turn off various features of the figure
    set(fig,'Visible','off');
    colorbar off;
    axis off;
    iptsetpref('ImshowBorder','tight');
    
    %Save the image to file
    frame = getframe(fig);
    I = frame.cdata;
    I = imresize(I,[525 700]);
    
    if(d >= 52+test_artifact)
        imwrite(I,strcat(fullfile(root_output,'Test_Artifact',dirListings(d).name(1:end-4)),'.png'),'png');
        close all hidden;
        clf;
    else
        imwrite(I,strcat(fullfile(root_output,'Artifact',dirListings(d).name(1:end-4)),'.png'),'png');
        close all hidden;
        clf;
    end
end
disp('Generating Extrahls data...');
%For the extrahls data
for d = 93:111
    [y,fs] = audioread(fullfile(root_input,dirListings(d).name));  
    
    %The data is normalized using generalized min-max method.
    norm_y = ((y-min(y))/(max(y) - min(y)))*(1+1)-1;
    
    %Settings to set position of figure axes
    axes('Units', 'normalized', 'Position', [0 0 1 1])
    F =linspace(1,600,1000);
    
    %Generate the sectrogram and save gcf to fig
    spectrogram(y,500,[],F,fs,'yaxis');
    colormap gray;
    fig = gcf;
    
    %Configurations to turn off various features of the figure
    set(fig,'Visible','off');
    colorbar off;
    axis off;
    iptsetpref('ImshowBorder','tight');
    
    %Save the image to file
    frame = getframe(fig);
    I = frame.cdata;
    I = imresize(I,[525 700]);
    if(d >= 92+test_extrahls)
        imwrite(I,strcat(fullfile(root_output,'Test_Extrahls',dirListings(d).name(1:end-4)),'.png'),'png');
        close all hidden;
        clf;
    else
        imwrite(I,strcat(fullfile(root_output,'Extrahls',dirListings(d).name(1:end-4)),'.png'),'png');
        close all hidden;
        clf;
    end
end
disp('Generating Murmur data...');
%For the Murmur data
for d = 112:145
    [y,fs] = audioread(fullfile(root_input,dirListings(d).name));  
    
    %The data is normalized using generalized min-max method.
    norm_y = ((y-min(y))/(max(y) - min(y)))*(1+1)-1;
    
    %Settings to set position of figure axes
    axes('Units', 'normalized', 'Position', [0 0 1 1])
    F =linspace(1,600,1000);
    
    %Generate the sectrogram and save gcf to fig
    spectrogram(y,500,[],F,fs,'yaxis');
    colormap gray;
    fig = gcf;
    
    %Configurations to turn off various features of the figure
    set(fig,'Visible','off');
    colorbar off;
    axis off;
    iptsetpref('ImshowBorder','tight');
   
    %Save the image to the file
    frame = getframe(fig);
    I = frame.cdata;
    I = imresize(I,[525 700]);
    if(d >= 111+test_murmur)
        imwrite(I,strcat(fullfile(root_output,'Test_Murmur',dirListings(d).name(1:end-4)),'.png'),'png');
        close all hidden;
        clf;
    else
        imwrite(I,strcat(fullfile(root_output,'Murmur',dirListings(d).name(1:end-4)),'.png'),'png');
        close all hidden;
        clf;
    end
end
disp('Generating Normal data...');
%For the Normal data
for d = 146:176
    [y,fs] = audioread(fullfile(root_input,dirListings(d).name));  
    
    %The data is normalized using generalized min-max method.
    norm_y = ((y-min(y))/(max(y) - min(y)))*(1+1)-1;
    
    %Settings to set position of figure axes
    axes('Units', 'normalized', 'Position', [0 0 1 1])
    F =linspace(1,600,1000);
    
    %Generate the sectrogram and save gcf to fig
    spectrogram(y,500,[],F,fs,'yaxis');
    colormap gray;
    fig = gcf;
    
    %Configurations to turn off various features of the figure
    set(fig,'Visible','off');
    colorbar off;
    axis off;
    iptsetpref('ImshowBorder','tight');
    
    %Save the image to the file
    frame = getframe(fig);
    I = frame.cdata;
    I = imresize(I,[525 700]);
    if(d >= 145+test_normal)
        imwrite(I,strcat(fullfile(root_output,'Test_Normal',dirListings(d).name(1:end-4)),'.png'),'png');
        close all hidden;
        clf;
    else
        imwrite(I,strcat(fullfile(root_output,'Normal',dirListings(d).name(1:end-4)),'.png'),'png');
        close all hidden;
        clf;
    end
end
%% Loading and processing a bit quicker.
rootFolder = fullfile('t2','images');

%Train with all data except the unlabelled stuff
trainData = imageDatastore(fullfile(rootFolder, categories(1:4)), 'LabelSource', 'foldernames');
testData = imageDatastore(fullfile(rootFolder, categories(5:8)), 'LabelSource', 'foldernames');
%Show a summary of each labelr
tb1 = countEachLabel(trainData);

%Determine the minimum no of images
minSetCount = min(tb1{:,2});

%Split the data into testData and trainData
[trainData,testData] = splitEachLabel(trainData,15);


%Count the number of test data
countEachLabel(testData)

%Count the number of training data
countEachLabel(trainData)


