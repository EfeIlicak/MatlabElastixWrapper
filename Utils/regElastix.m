function [elastixReg,tranParam] = regElastix(imgs,mask,param,saveParam)
% Register dynamic data using Elastix. 
%
% Automatically creates a temporary folder to save the files and deletes it
% at the end of read by default.
%
% Inputs:
% imgs       = Dynamic images to be registered
% mask       = Mask images for improved registration performance
% param      = String pointing to parameter file required for Elastix
% saveParam  = Save transform parameters for future or transformix use
%
% Output:
% elastixReg = Registered images
% tranParam  = Transform parameter file location 
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
mhd_write(mask,[saveLoc 'mask.mhd']);



file = [saveLoc 'tmp.mhd']; % input file
oD = saveLoc; % Output folder
mF = [saveLoc 'mask.mhd']; % mask file

fixed  = [' -f ',file];
moving = [' -m ',file];
% Note that the fixed and moving image should be the same. The fixed image
% is not used for the registration, but acts as a dummy to prevent elastix
% throwing error messages.
outputDir  = [' -out ',oD];
parameters = [' -p ', param];
maskFile =   [' -fMask ',mF];

% If there is a space in the name of the folder, this might give an error.
system(['elastix',fixed,moving,outputDir,parameters,maskFile])


elastixReg = double(mhd_read([saveLoc 'result.0.mhd']));

if saveParam == 1
    savenm = sprintf(datestr(now,'dd.mmmm.yyyy-HH.MM'));
    saveLocT=[currentWorkDir '\Elastix_Transform_Parameters\',savenm,'\'];
    savestrT = saveLocT; %sprintf(saveLoc,datestr(now,'dd.mmmm.yyyy-HH.MM'));
    if exist(savestrT)==0
        mkdir(savestrT);
        addpath(savestrT);
    end
    
    copyfile([currentWorkDir '\Temp_Elastix_Folder\TransformParameters.0.txt'],saveLocT);
    tranParam = [saveLocT,'TransformParameters.0.txt'];
end
    

if deleteFolder == 1
    delete([saveLoc,'*'])
    rmdir(saveLoc)
end



