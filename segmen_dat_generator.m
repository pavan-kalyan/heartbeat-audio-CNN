%% This file takes the data from set_a and generates segmented data for Normal,Murmur and Extrahls.
filePattern = fullfile('t2','set_a','*.wav');
dirListings = dir(filePattern);
dir_len = length(dirListings);
output_file = 'seg_dat';
search_dir = fullfile('t2',output_file);
root_input = fullfile('t2','set_a');

if(exist(search_dir,'dir') == 7)
    rmdir(search_dir,'s');
    mkdir(search_dir);
else
    mkdir(search_dir);
end

for i = 1:dir_len
   [y,fs] = audioread(fullfile(root_input,dirListings(i).name));
   if(contains(dirListings(i).name,'murmur') || contains(dirListings(i).name,'extrahls') ||contains(dirListings(i).name,'normal'))
       wave_segment_Shannon(y,dirListings(i).name(1:end-4),fs,'seg_dat');
   end
end

