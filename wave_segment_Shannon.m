function [PeakLocations,Midpoints] = wave_segment_Shannon(WaveVector)
norm_y = (WaveVector./max(abs(WaveVector))).^2;
shannon_energy = -((norm_y.^2).*log(norm_y.^2));

%Gets rid of the NaN values in the Shannon vector
for i = 1:length(shannon_energy)
     if(isnan(shannon_energy(i)) == 1)
        shannon_energy(i) = 0;
    end
end

[y_upper,~] = envelope(shannon_energy,1000,'peak');
[~,PeakLocations] = findpeaks(y_upper);
%% 
Midpoints(1) = 0;
for i = 2:length(PeakLocations)
    Midpoints(i) = round(PeakLocations(i)+PeakLocations(i+1)/2);
end

end

