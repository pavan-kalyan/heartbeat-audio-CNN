%{
This is a more generalized version of wave process and is a little less clunky
This file generates spectrograms from the dataset gven in 'set_a'.

In general, when adding new wavefiles, follow the formats:
--->Artifact: artifact__random_numbers.wav
--->Unlabelled: Aunlabelledtest__random_numbers.wav
--->Extrahls: extrahls__random_numbers.wav
--->Murmur: murmur__random_numbers.wav
--->Normal: normal__random_numbers.wav
(Notice the two underscores)

This file is dependant on the function fileswave segment shannon 
%}
%% Clear all previous figures and saved variables from the workspace
clc;
clf('reset');
close all hidden;

%% Seting the root folder from which the '.wav' files are read(Input folders).
filePattern = fullfile('t2','set_a','*.wav');
dirListings = dir(filePattern);
dir_len = length(dirListings);
fileID = fopen('set_a_timing.csv');
data = textscan(fileID,'%s %s %s %s','Delimiter',',');
categories ={'Artifact','Extrahls','Murmur','Normal','Test_Artifact','Test_Extrahls','Test_Murmur','Test_Normal','Unlabelled'};
len = 3099;
root_input = fullfile('t2','set_a');
%% Generate the relevant directory for saving the outputs the files(Output folders).
root_output = fullfile('t2','images');
%Remove the directory if it exists, else skip.
if(exist(root_output,'dir') == 7)
    rmdir(root_output,'s');
end
mkdir(root_output);
for k = 1:numel(categories)
   if(exist(root_output,'dir') == 7)
        mkdir(fullfile(root_output,char(categories(k))));
   end
end

%% Setting thresholds for the number of samples to be takes as training data
training_artifact = 21;
training_extrahls = 21;
training_murmur = 21;
training_normal = 21;

%% Generate the spectrograms and sort into appropriate files
counter = zeros(4,1);
for d = 1:dir_len
    if(contains(dirListings(d).name,'Aunlabelled'))
        disp("Generating unlabelled data...")
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
        
    elseif(contains(dirListings(d).name,'artifact'))
        disp("Generating artifact data...")
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
        
        %Increase the counter to keep track of number of traning data
        counter(1) = counter(1)+1;
        
        %Save the image to file
        frame = getframe(fig);
        I = frame.cdata;
        I = imresize(I,[525 700]);
        
        if(counter(1) <= training_artifact)
            imwrite(I,strcat(fullfile(root_output,'Artifact',dirListings(d).name(1:end-4)),'.png'),'png');
            close all hidden;
            clf;
        else
            imwrite(I,strcat(fullfile(root_output,'Test_Artifact',dirListings(d).name(1:end-4)),'.png'),'png');
            close all hidden;
            clf;
        end
        
    elseif(contains(dirListings(d).name,'extrahls'))
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
        
        %Increase the counter to keep track of number of traning data
        counter(2) = counter(2)+1;
        
        %Save the image to file
        frame = getframe(fig);
        I = frame.cdata;
        I = imresize(I,[525 700]);
        
        if(counter(2) <= training_extrahls)
            imwrite(I,strcat(fullfile(root_output,'Extrahls',dirListings(d).name(1:end-4)),'.png'),'png');
            close all hidden;
            clf;
        else
            imwrite(I,strcat(fullfile(root_output,'Test_Extrahls',dirListings(d).name(1:end-4)),'.png'),'png');
            close all hidden;
            clf;
        end
    elseif(contains(dirListings(d).name,'murmur'))
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
        
        %Increase the counter to keep track of number of traning data
        counter(3) = counter(3)+1;
        
        %Save the image to the file
        frame = getframe(fig);
        I = frame.cdata;
        I = imresize(I,[525 700]);
        if(counter(3) <= training_murmur)
            imwrite(I,strcat(fullfile(root_output,'Murmur',dirListings(d).name(1:end-4)),'.png'),'png');
            close all hidden;
            clf;
        else
            imwrite(I,strcat(fullfile(root_output,'Test_Murmur',dirListings(d).name(1:end-4)),'.png'),'png');
            close all hidden;
            clf;
        end
    elseif(contains(dirListings(d).name,'normal'))
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
        
        %Increase the counter to keep track of number of traning data
        counter(4) = counter(4)+1;
        
        %Save the image to the file
        frame = getframe(fig);
        I = frame.cdata;
        I = imresize(I,[525 700]);
        
        if(counter(4) <= training_normal)
            imwrite(I,strcat(fullfile(root_output,'Normal',dirListings(d).name(1:end-4)),'.png'),'png');
            close all hidden;
            clf;
        else
            imwrite(I,strcat(fullfile(root_output,'Test_Normal',dirListings(d).name(1:end-4)),'.png'),'png');
            close all hidden;
            clf;
        end
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

%Count the number of test data
tb2 = countEachLabel(testData);

%Modifying the labels for the trainData
total = sum(tb2{1:4,2});
for i = 1:total
    if(testData.Labels(i) == "Test_Artifact")
        testData.Labels(i) = "Artifact";
    elseif(testData.Labels(i) == "Test_Extrahls")
        testData.Labels(i) = "Extrahls";
    elseif(testData.Labels(i) == "Test_Murmur")
        testData.Labels(i) = "Murmur";
    elseif(testData.Labels(i) == "Test_Normal")
        testData.Labels(i) = "Normal";
    end
        
end


%Count the number of training data
countEachLabel(trainData)
countEachLabel(testData)