% main implementation
% Copyright (2017) University of Colorado
% All Rights Reserved
% Author: John Letey

% Call hits.m
run('hits.m');
% Open output.csv and write to it
T = cell2table(PSSM, 'RowNames', {'A', 'C', 'G', 'T'});
writetable(T, 'output.csv', 'WriteRowNames', true);
fileID2 = fopen('output.csv', 'w');
csvwrite('output.csv', [''], 1, 1);
fprintf(fileID2, '%s %s \n', 'searching', chrName);
fprintf(fileID2, '%s %s \n', 'for transcription factor', TF);
fprintf(fileID2, '%s %s \n', 'weak threshold:', num2str(weakThresh));
fprintf(fileID2, '%s %s \n', 'strong threshold:', num2str(strongThresh));
fprintf(fileID2, '%s %s %s \n', 'The PSSM for transcription factor', TF, 'is');
variableNames = mat2cell(1:lenOfPSSM, 1);
% Compare the weak and strong sites
categories = [];
for i = 1:size(positionOfStrong, 2)
    for j = 1:size(positionOfWeak, 2)
        mat = zeros(1, str2num(input{8, 1})/str2num(input{7, 1}));
        value = abs(positionOfStrong{1, i} - positionOfWeak{1, j});
        for k = 1:str2num(input{8, 1})/str2num(input{7, 1})
            if value <= (str2num(input{7, 1})*k)
                mat(k) = value;
            end
        end
        if mat ~= zeros(1, str2num(input{8, 1})/str2num(input{7, 1}))
            categories = vertcat(categories, mat);
        end
    end
end
% Plot the histogram
histogram(categories)
% Close output.csv
fclose(fileID2);