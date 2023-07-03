function transformixReg = regTransformix(imgs,transParam)
% Register dynamic data using Transformix. 
%
% Automatically creates a temporary folder to save the files and deletes it
% at the end of read by default.
%
% Inputs:
% imgs       = Dynamic images to be registered
% transParam = Transform parameters coming from Elastix output
%
% Output:
% transformixReg = Registered images
%
% Requires a toolbox necessary for converting matlab data to mhd files.
% (Melastix toolbox contains one).

deleteFolder = 1; % To delete the temporary files

currentWorkDir = pwd; 

% Create Temp Save Directory
saveLoc=[currentWorkDir '\Temp_Elastix_Folder\'];
savestr = saveLoc; %sprintf(saveLoc,datestr(now,'dd.mmmm.yyyy-HH.MM'));
if exist(savestr)==0
    mkdir(savestr);
    addpath(savestr);
end

mhd_write(imgs,[saveLoc 'tmp.mhd']);




file = [saveLoc 'tmp.mhd']; % input file
oD = saveLoc; % Outout folder

inputImg   = [' -in ',file];
outputDir  = [' -out ',oD];
tParam     = [' -tp ', transParam];

system(['transformix',inputImg,outputDir,tParam])


transformixReg = double(mhd_read([saveLoc 'result.mhd']));



if deleteFolder == 1
    delete([saveLoc,'*'])
    rmdir(saveLoc)
end


end