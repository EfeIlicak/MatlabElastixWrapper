# Simple wrapper for Elastix and Transformix registration in Matlab

## Getting started

Make sure that Elastix is downloaded and installed (https://github.com/SuperElastix/elastix/releases/). 
Also, it should be accessable in your system path (like in the following screenshot). 
![Elastix](https://github.com/EfeIlicak/MatlabElastixWrapper/assets/24956226/75ca7fda-1683-4f64-92dd-dafba937d252)

## Demo file
A simple demo file is provided, which adds the necessary files to the directory. 

The demo performs non-rigid registration of a non-contrast-enhanced dynamic lung MRI data. 
![DemoResult](https://github.com/EfeIlicak/MatlabElastixWrapper/assets/24956226/6463ac3c-1360-430e-9fe9-2e2e7543e2f8)



The code was tested using Matlab R2020a and Elastix-5.0.0 on a Windows System.

The "mhd_read.m", "mhd_read_header.m", and "mhd_write.m" files are obtained from:
https://github.com/raacampbell/matlab_elastix
