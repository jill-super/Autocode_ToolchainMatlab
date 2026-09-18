% This file contains the revision history of Nexteer_Utilities folder of our
% tools.
% Current version of tools is "Nexteer_Utilities v5.0.0"

hist_NxtrUtil(1).ver = '1.0.0';
hist_NxtrUtil(1).log = 'Initial Release';
hist_NxtrUtil(1).date = '30-Sep-2014';


hist_NxtrUtil(2).ver = '1.1.0';
hist_NxtrUtil(2).log = 'Bug Fixes: LPF_KUpdate_f32 and HPF_KUpdate_f32 were fixed to remove presision loss warnings';
hist_NxtrUtil(2).date = '28-Oct-2014';

hist_NxtrUtil(2).ver = '2.0.0';
hist_NxtrUtil(2).log = 'Bug Fix: Dynamic_Rate_Limiter.';
hist_NxtrUtil(2).date = '04-Feb-2015';

hist_NxtrUtil(3).ver = '3.0.0';
hist_NxtrUtil(3).log = '1) Added library for new EA4 software libraries. All changes are backward compatible.';
hist_NxtrUtil(3).date = '18-Mar-2015';

hist_NxtrUtil(4).ver = '4.0.0';
hist_NxtrUtil(4).log = '1) Bug fixes in EA4 Interpolation blocks. 2) Change to implementation of Rate Limit blocks. 3) Creation of TblSize Simulink Library blocks to support Interpolation blocks. 4) Bug fixes in NxtrFixdPt Simulink Library. 5) Change in Filter block functionality and new blocks added.';
hist_NxtrUtil(4).date = '13-Apr-2015';

hist_NxtrUtil(5).ver = '4.0.1';
hist_NxtrUtil(5).log = '1)Corrected versioning number in last release. 2) Added documentation of Filter library changes.';
hist_NxtrUtil(5).date = '14-Apr-2015';

hist_NxtrUtil(6).ver = '4.1.0';
hist_NxtrUtil(6).log = '1) Bug fix in NxtrLim Simulink Library.';
hist_NxtrUtil(6).date = '15-Apr-2015';

hist_NxtrUtil(7).ver = '4.2.0';
hist_NxtrUtil(7).log = '1)Bug Fixes in EA4 Fixed Point Libraries.';
hist_NxtrUtil(7).date = '19-May-2015';

hist_NxtrUtil(8).ver = '4.3.0';
hist_NxtrUtil(8).log = ['1) Added NVM Client model library.'...
                        '2) Retained the unencrypted file format for Nexteer_Utilities.'];
hist_NxtrUtil(8).date = '08-Jun-2015';

hist_NxtrUtil(9).ver = '4.3.1';
hist_NxtrUtil(9).log = ['1) Unencrypted files in the NvM_Library folder.'];
hist_NxtrUtil(9).date = '08-Jun-2015';

hist_NxtrUtil(10).ver = '4.4.0';
hist_NxtrUtil(10).log = ['1) Added dynamic table look up blocks.'...
                         '2) Bug fix to correct miscalculation of array sizes.'];
hist_NxtrUtil(10).date = '07-July-2015';

hist_NxtrUtil(11).ver = '4.5.0';
hist_NxtrUtil(11).log = ['1) Updated EA4 mex files for the Bilinear Interpolation library functions to match the 1.0.1 version of AF101A.'...
                         '2) Included all EA4 files necessary to create the different mex files.'];
hist_NxtrUtil(11).date = '28-August-2015';

hist_NxtrUtil(12).ver = '4.6.0';
hist_NxtrUtil(12).log = '1) Bug fix to correct the GetErrorStatus block in NVM library.';
hist_NxtrUtil(12).date = '15-Apr-2016';

hist_NxtrUtil(13).ver = '4.7.0';
hist_NxtrUtil(13).log = '1) Nxteer Math Library: New "SinLookup_f32" library block for EA4 programs.';
hist_NxtrUtil(13).date = '15-Jul-2016';

hist_NxtrUtil(14).ver = '4.8.0';
hist_NxtrUtil(14).log = '1) EA4 Library--> Filters: Updated High Pass and Low pass Filter initialization blocks for correcting the wrong Initialization values inside the blocks.';
hist_NxtrUtil(14).date = '12-Sep-2016';

hist_NxtrUtil(15).ver = '4.9.0';
hist_NxtrUtil(15).log = '1) Reorganized Library structure to accommodate the new Development functions library.';
hist_NxtrUtil(15).date = '19-Sep-2016';

hist_NxtrUtil(16).ver = '4.10.0';
hist_NxtrUtil(16).log = '1) Bug fix for the Reorganized Library structure.';
hist_NxtrUtil(16).date = '22-Sep-2016';

hist_NxtrUtil(17).ver = '4.11.0';
hist_NxtrUtil(17).log = ['1) EA3 Library --> Interpolation: Removed float32 interpolation block (IntplVarXY_f32_f32Xf32Y_f32).'...
                         '2) EA4 Library --> IMC Client calls: New IMC client call library blocks for EA4 program.'];
hist_NxtrUtil(17).date = '27-Apr-2017';

hist_NxtrUtil(18).ver = '5.0.0';
hist_NxtrUtil(18).log = ['1) EA4 Library --> Interpolation: Updated all Bilinearblocks by transposing the matrix tables.'...
						 '2) EA4 Library --> Math Library: Updated "SinLookup_f32" library by replacing "ONEOVER2PI_ULS_F32" with "ARCHGLBPRM_ONEOVER2PI_ULS_F32".'];
hist_NxtrUtil(18).date = '16-Jun-2017';

