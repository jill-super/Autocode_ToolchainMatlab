function blkStruct = slblocks

blkStruct.Name = ['Nexteer' sprintf('\n') 'Library'];
blkStruct.OpenFcn = 'NxtrLib';
blkStruct.MaskDisplay = '';

Browser(1).Library = 'NxtrLib';
% Browser(1).Name    = ['Nexteer ' sprintf('\n') 'Library/Development ' sprintf('\n') 'Library'];
Browser(1).Name    = 'Nexteer Library';
Browser(1).IsFlat  = 0;

blkStruct.Browser = Browser;
clear Browser;





