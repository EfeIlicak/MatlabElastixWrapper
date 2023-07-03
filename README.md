# Simple wrapper for Elastix and Transformix registration in Matlab

## Getting started

Make sure that Elastix is downloaded and installed (https://github.com/SuperElastix/elastix/releases/). 
Also, it should be accessable in your system path (like in the following screenshot). 

![Elastix](https://github.com/EfeIlicak/MatlabElastixWrapper/assets/24956226/34430697-e578-4808-8306-575dfd184b28)


## Demo file
A simple demo file is provided, which adds the necessary files to the directory. 

The demo performs non-rigid registration of a non-contrast-enhanced dynamic lung MRI data. 

![video](https://github.com/EfeIlicak/MatlabElastixWrapper/assets/24956226/501cfd32-76fb-49a7-94ec-92bd06e1a7fc)

Dynamic Acquisition    |    Registered (via Elastix)    |    Registered (via Transformix)(added noise)

The code was tested using Matlab R2020a and Elastix-5.0.0 on a Windows System.

The "mhd_read.m", "mhd_read_header.m", and "mhd_write.m" files are obtained from:
https://github.com/raacampbell/matlab_elastix
