function [PeakLocations,Midpoints] = wave_segment_Shannon(WaveVector,filename,fs,output_file)
norm_y = (WaveVector./max(abs(WaveVector))).^2;
shannon_energy = -((norm_y.^2).*log(norm_y.^2));

%Gets rid of the NaN values in the Shannon vector
for i = 1:length(shannon_energy)
     if(isnan(shannon_energy(i)) == 1)
        shannon_energy(i) = 0;
    end
end

[y_upper,~] = envelope(shannon_energy,1000,'peak');
[~,PeakLocations] = findpeaks(y_upper,'MinPeakDistance',10000);
%Clean the peaklocations to remove false peaks. Done by thresholding
for i = 1:length(PeakLocations)
    if(y_upper(PeakLocations(i)) < 0.04)
        PeakLocations(i) = 0;
    end    
end

ActualPeaks = PeakLocations([find(PeakLocations ~= 0)]);
%% Find a set of midpoints from the obtained peak locations in the wave 
Midpoints(1) = 1;
for i = 1:length(ActualPeaks)-1
    Midpoints(i+1) = round((ActualPeaks(i)+ActualPeaks(i+1))/2);
end
Midpoints(end+1) = length(shannon_energy);
disp(Midpoints)
%% Generate a directory for the segmented data if one does not exist
%Generate it for the traning wave files
search_dir = fullfile('t2',output_file);

for i = 1:2:length(Midpoints)
    if(i+2 < length(Midpoints))
        start = Midpoints(i);
        disp(start)
        stop = Midpoints(i+2);
        disp(stop)
        audio_vector = WaveVector(start:stop);
        audiowrite(fullfile(search_dir,strcat(filename,int2str(i),'.wav')),audio_vector,fs);
    else
        start = Midpoints(i);
        stop = Midpoints(end);
        audio_vector = WaveVector(start:stop);
    end
end

