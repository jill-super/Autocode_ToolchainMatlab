%  NxtrKeyWrdChk tool tries to perform the following tasks:
%    1. If Call_Type is 'CreateDD' then tool will look for an empty identify
%       Long Name and will update it based on our approved Keyword list.
%    2. If Call_Type is 'VerifyDD' then tool will parse each Signal &
%       Paramter name and will gather the list of Unknown keywords used it it.
%       This Unknown Keyword list would be returned back to VerifyDD tool.
%           Call_Type   -- This can be CreateDD or VerifyDD.
%           Data        -- Group of workspace variables in the form of Nexteer data classes.
%           Names       -- Group of workspace variable names as persent in the Data Dictionary.
%
