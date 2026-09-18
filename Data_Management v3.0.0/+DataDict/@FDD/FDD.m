% DataDict.FDD
% This script defines the data class required for Nexteer FDD documentation.

% Change Log
% 12feb2014 K Derry    Initial Release
% 24feb2014 K Derry    Constructor method now writes actual variable name to string instead of concatentaing .Type and .Number
%                      Changed .Name property to .LongName for clarity.
% 12mar2014 K Derry    Added DesignASIL property.  Improved robustness of String() method.
%                      New methods to provide list of legal property values
% 14mar2014 K Derry    Added empty ('' or []) as legal property values.
%                      Improved robustness of methods to empty requests.
% 10apr2014 K Derry    Bug fix in String method that occured when .Description was a certain length.  Metod was parsing into multi-line incorrectly.
% 09may2014 K Derry    Renamed SwCName to ShortName.  Renamed ShortName to Mnemonic (trying to better align with Autosar lingo).
% 04jun2014 K Derry    Moved .LongName syntax verification from this file into VerifyDD tool as a reusable feature for checking Long Name of other variable types.
% 30aug2014 K Derry    Uses new WriteDescription function in String method.
% 22sep2014 K Derry    Removed Type, Number, Variant properties. Version property now formatted as '1.0.X'
%                      Renamed ShortName to ShoName to match OpSignal class.
%                      New Release property.
% 09jan2015 PLefler    Added 'Dependancies' property,
%                      Updated String method accept a flag to change the methods behavior based on which EA version is desired.
% 09feb2015 PLefler    Corrected spelling of Dependencies property.
% 16feb2015 PLefler    Removed 'Owner' from String method and changed set.Owner method to make the Owner property to ''.
% 16mar2015 PLefler    Updated Ntc property to include the NTC Debounce (None, Deb) type and check for the proper type and format of the NTC number.
% 05Jun2015 Siva       Removed .Dependencies property as new ImprtdCal data class has been released(Issue no:49).
% 19Jun2015 Siva       Retained .Dependencies property to support ImprtdCal data class.
%                      Converted .Dependencies property as a default property of FDD data class for both EA3 & EA4 programs instead of EA4 programs alone.
%                      Added logic to notify users if an old format is used for .Dependencies property.
% 10July2015 Siva      Removed ".Ntc" property from String method as new ".NTC" data class is introduced.
% 17July2015 CWheatley Added logic to not have a comma added at the end of the dependencies list if the number of dependencies is 1
% 13Apr2016  Siva      Removed .Dependencies property.
% 19Sep2016  Siva      Added support for Development Data Dictionaries.
%

classdef FDD
    %% PROPERTIES
    properties
        Version      = '0.0.X';  % This is the FDD version number, chosen by user.
        Owner        = '';
        LongName     = '';
        ShoName      = '';
        Mnemonic     = '';
        DesignASIL   = '';
        Description  = '';
        Ntc          = {};
        Dependencies = {};
    end

    %% METHODS
    methods
        function varargout = Valid(obj)
            % Provides list of valid property values that can be used in verification tools.
            % output1 is structure of character arrays.  output2 is structure of cell arrays.
            varargout{1}.Owner = [''''',' 'Birsching, ' 'Eickholt, ' 'Hales, ' 'Klein, ' 'Kleinau, ' 'Kushion, ' 'Pattok, ' 'Wittig'];
            varargout{2}.Owner = {'',     'Birsching', 'Eickholt', 'Hales', 'Klein', 'Kleinau', 'Kushion', 'Pattok', 'Wittig'};
            varargout{1}.DesignASIL = [''''', ' 'QM, ' 'A, ' 'B, ' 'C, ' 'D'];
            varargout{2}.DesignASIL = {'',      'QM',  'A',  'B',  'C',  'D'};
        end


        function obj = set.Version(obj,rqstval)
            if isnumeric(rqstval) || isempty(regexp(rqstval,'^[0-9]+.[0-9]+.[Xx]','match'))
                msg = 'FDD.Version property must be a string with format of ''integer.integer.X''.';
                warning off backtrace; warning(msg)
            else
                obj.Version = rqstval;
            end
        end

        function obj = set.Owner(obj,~)
            obj.Owner = '';
        end

        function obj = set.LongName(obj,rqstval)
            if ~isempty(rqstval)
                if isnumeric(rqstval)
                    warning off backtrace; warning('FDD.LongName property not changed because user entered a numeric value.')
                else
                    obj.LongName = rqstval;
                end
            end
        end

        function obj = set.ShoName(obj,rqstval)
            if ~isempty(rqstval)
                if isnumeric(rqstval)
                    warning off backtrace; warning('FDD.ShoName property not changed because user entered a numeric value.')
                else
                    newval=regexprep(rqstval, '[~!@#$%^&*()_\-:;"''><,\.?\\ ]',''); %Remove illegal characters and spaces.
                    newval(1) = upper(newval(1));                                  %We know at least first letter should be capitalized.
                    if strcmp(rqstval,newval)
                        obj.ShoName = newval;
                    else
                        msg = sprintf(['FDD.ShoName property not changed because entry is invalid.\n' ...
                            ' Requested Value:\t' rqstval '\n Suggested Fix:  \t' newval]);
                        warning off backtrace; warning(msg)
                    end
                end
            end
        end

        function obj = set.Mnemonic(obj,rqstval)
            if ~isempty(rqstval)
                if isnumeric(rqstval)
                    warning off backtrace; warning('FDD.Mnemonic property not changed because user entered a numeric value.')
                else
                    newval=regexprep(rqstval, '[~!@#$%^&*()_\-:;"''><,\.?\\ ]',''); %Remove illegal characters and spaces.
                    newval(1) = upper(newval(1));                                  %We know at least first letter should be capitalized.
                    if strcmp(rqstval,newval)
                        obj.Mnemonic = newval;
                    else
                        msg = sprintf(['FDD.Mnemonic property not changed because entry is invalid.\n' ...
                            ' Requested Value:\t' rqstval '\n Suggested Fix:  \t' newval]);
                        warning off backtrace; warning(msg)
                    end
                end
            end
        end

        function obj = set.DesignASIL(obj,rqstval)
            if ~isempty(rqstval)
                if isnumeric(rqstval)
                    warning off backtrace; warning('FDD.DesignASIL property not changed because user entered a numeric value.')
                else
                    [str,cel] = Valid(obj);
                    if any(strcmp(rqstval,cel.DesignASIL))
                        obj.DesignASIL = rqstval;
                    else
                        msg = sprintf(['FDD.DesignASILroperty not changed because entry is invalid.\n' ...
                            ' Requested Value:\t' '''' rqstval '''\n' ...
                            ' Allowed values: \t' str.DesignASIL]);
                        warning off backtrace; warning(msg)
                    end
                end
            end
        end

        function obj = set.Ntc(obj,val)
            if ~iscell(val)
                error('FDD.Ntc must be a cell array.')
            end

            for i = 1:size(val,1)
                % Check NTC string
                NtcNr = regexp(val{i,1},'NTCNR_0X[0-9A-F]+','match');
                if isempty(NtcNr)
                    error('NTC number %s doesn''t follow correct format. It should be of the format NTCNR_0X000.', val{i,1});
                else
                    temp = regexp(NtcNr,'NTCNR_0X[0-9A-F]{3}','match');
                    if strcmp(NtcNr,temp{1})
                        hex = regexp(NtcNr,'NTCNR_0X(?<Num>[0-9A-F]{3})','names');
                        dec = hex2dec(hex{1}.Num);
                        if dec > 511
                            error('NTC Number %s is out of range of acceptable values.',NtcNr{1});
                        end
                    else
                        error('NTC Number %s has an invalid character or length.',NtcNr{1});
                    end
                end
                % Check NTC type
                allowedVals = {'Deb' 'None'};
                if ~any(strcmp(val(i,2),allowedVals))
                    error('''%s'' is not an accepted input for NTC type. Accepted values are ''Deb'' and ''None''.',val{i,2})
                end

            end
            obj.Ntc = val;
        end


        function txt = String(obj,flag)
            % This function creates a string that looks like the original structure.
            % If the string is placed into a Matlab script, then running the script
            % would generate the original structure in Matlab's workspace.
            if(~strcmp(flag,'dev'))
                var = upper(inputname(1));
                cl = class(obj);
                txt = sprintf('%s = %s;\n', var, cl);
                
                txt = sprintf('%s%s.Version = ''%s'';\n', txt,var,num2str(obj.Version));
                txt = sprintf('%s%s.LongName = ''%s'';\n', txt,var,obj.LongName);
                txt = sprintf('%s%s.ShoName  = ''%s'';\n', txt,var,obj.ShoName);
                txt = sprintf('%s%s.DesignASIL = ''%s'';\n', txt,var,obj.DesignASIL);
                dsc = WriteDescription(var, obj.Description);
                txt = sprintf('%s%s\n', txt,dsc);
                
                switch flag
                    case 'ea3'
                        txt = sprintf('%s%s.Mnemonic  = ''%s'';\n', txt,var,obj.Mnemonic);
                    case 'ea4'
                        
                        %                     ntc = '';
                        %                     for i = 1:size(obj.Ntc,1)
                        %                         ntc = sprintf('%s''%s'',''%s''\n\t ',ntc,obj.Ntc{i,1},obj.Ntc{i,2});
                        %                     end
                        %                     txt = sprintf('%s%s.Ntc = ...\n\t{%s};\n', txt,var,ntc);
                        
                        
                    otherwise
                end
            else
                var = upper(inputname(1));
                cl = class(obj);
                txt = sprintf('%s = %s;\n', var, cl);
                
                txt = sprintf('%s%s.Version = ''%s'';\n', txt,var,num2str(obj.Version));
                txt = sprintf('%s%s.ShoName = ''%s'';\n', txt,var,obj.ShoName);
                
                dsc = WriteDescription(var, obj.Description);
                txt = sprintf('%s%s\n', txt,dsc);                
            end
        end

    end


end % classdef

%#ok<*ATUNK> This comment suppresses warnings. Do not uncomment or delete.
