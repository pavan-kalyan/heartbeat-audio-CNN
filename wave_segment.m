%This file should segment the audio data Network to process

for i = 1:dir_len
    if(contains(dirListings(i).name,'Normal')||contains(dirListings(i).name,'Murmur')||contains(dirListings(i).name,'Extrahls'))
        [y,fs] = audioread(fullfile(root_input,dirListings(i).name));    
        wave_segment_Shannon(y,dirListings(i).name,fs,'seg_dat');
    end
end
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
[y,fs] = audioread(strcat('footsteps.wav'));
norm_y = (y./max(abs(y))).^2;
shannon_energy = -((norm_y.^2).*log(norm_y.^2));
for i = 1:length(shannon_energy)
     if(isnan(shannon_energy(i)) == 1)
        shannon_energy(i) = 0;
    end
end
average_shannon = sum(shannon_energy)/length(shannon_energy);
standard_deviation = std(shannon_energy);
normalized_shannon = (shannon_energy-average_shannon)/standard_deviation;

subplot(2,2,1);
plot(norm_y);
subplot(2,2,2);
plot(shannon_energy);
subplot(2,2,3);
[y_upper,y_lower] = envelope(shannon_energy,1000,'peak');
plot(y);
subplot(2,2,4);
plot(y);
