%% Demo for non-rigid registration of non-contrast-enhanced dynamic lung MRI using Elastix and Transformix

% By default it saves: 
% transformation parameters to a new folder named "\Elastix_Transform_Parameters\"
% temporary files to "\Temp_Elastix_Folder\" (can automatically delete them)

% Add necessary files to the path
addpath(genpath('Utils'));

% Load sample data and mask
load('demo_data.mat');

% Note: The dynamic images were acquired using a bSSFP pulse. Details are
% provided in the "Acquisition Parameters.txt"

% Sample parameter list
param = 'par000_mod.txt'; 
% Note: The parameters might not be optimal. For more sample parameter files, please check:
% https://elastix.lumc.nl/modelzoo/

% For my work cases, creating a mask around the object of interest 
% (e.g., lungs)improves the registration performance. 

% Prepare mask for elastix. I repeat the mask to match the size of my data.
% I think the mask needs to be “double” type for elastix to work. But I am not that sure.
maskRepeated = double(repmat(mask,[1 1 size(dynamicImgs,3)])); 

% Run elastix using the provided data, mask, and parameter list
saveParameters = 1; 
% Run elastix
[elastixReg,transParam] = regElastix(dynamicImgs,maskRepeated,param,saveParameters); 

%% Transformix Demo
% When you run elastix and have the either transform parameters or have 
% them saved with saveParameters=1, then you can call the transformixReg.
% This is useful if you want to apply the same registration to different
% dataset. For example, same dynamic images reconstructed/denoised with 
% different methods (e.g., GRAPPA vs LORAKS or noisy vs denoised).

% Here I will just add noise to dynamic images, and use the transformation
% parameters from the previous registration to demo transformix.

% Add bivariate Gaussian noise to mimic noise in MRI magnitude images
snr = 10;
noiseLevel = max(abs(dynamicImgs(95,95,:)))/snr./sqrt(2);
[sx,sy,m] = size(dynamicImgs);
noisePattern = noiseLevel*randn([sx,sy,m])+sqrt(-1)*noiseLevel*randn([sx,sy,m]); 

% Run transformix
transformixReg = regTransformix(dynamicImgs+noisePattern,transParam); 

% Display the results (Dynamic Images / Registered Images / Noisy Images)
implay(cat(2,dynamicImgs/512,elastixReg/512,transformixReg/512))

