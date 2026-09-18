% DataDict.NTC
%   The NTC class is used to communicate NTC information for NTCs owned
%   by a component.

% Change Log
% 7Jul2015 P Lefler     Initial Release
% 14Aug2015 PLefler     Changed the class that DataDict.NTC inherits from to AUTOSAR.Parameter.
%                       Added logic to allow ConfigParams to be the NtcNr.
% 16Jun2017  Siva       Replaced reference to NtcNr2 with NtcNr1 enumeration.

classdef NTC < AUTOSAR.Parameter
    
    properties
        NtcNr
        NtcTyp
        LongName
        NtcStInfo
    end
    
    methods
        function obj = NTC(~)
            %             obj.NtcNr = NtcNr2.NTCNR_0X000;
            obj.NtcNr = NtcNr1.NTCNR_0X001;
            obj.NtcTyp = 'None';
            obj.LongName = '';
            obj.Description = '';
            obj.NtcStInfo = DataDict.NtcStInfoBitPacked;
            
        end
        
        function set.NtcNr(obj,val)
            meta = metaclass(val);
            
            if isempty(meta.SuperclassList)
                
                if ischar(val)
                    
                    cfgprm = regexp(val,'\w+_\w+_\w+_\w+','match');
                    
                    if ~isempty(regexp(val,'NTCNR_0X([0-9A-F]{3})','match'))
                        warning('NtcNr strings of the format ''%s'' are no longer accepted. Please use the NtcNr enumeration data class, or the name of a ConfigParam in your workspace.',val)
                        
                    elseif isempty(cfgprm)
                        error('The NtcNr from ConfigParam, %s doesn''t follow the correct format. It should be of the format <SHONAME>_<IDENTITY>_<UNITS>_<DATATYPE>.', val);
                    else
                        try
                            ntcvalue = evalin('base',cfgprm{1});
                            obj.Value = ntcvalue.EngVal;
                        catch
                            error('ConfigParam %s doesn''t exist in the workspace.',cfgprm{1});
                        end
                    end
                else
                    error('Unrecognized value for NtcNr.')
                end
                
            elseif strcmp(meta.SuperclassList.Name,'Simulink.IntEnumType')
                obj.Value = val;
            end
            obj.NtcNr = val;
        end
        
        function set.NtcTyp(obj,val)
            if ~any(strcmp(val,{'Deb','None'})) || ~ischar(val)
                error('Ntc Type for NtcNr %s must be either ''Deb'' or ''None''.',obj.NtcNr)
            end
            obj.NtcTyp = val;
        end
        
        function set.LongName(obj,val)
            if ~ischar(val)
                error('Ntc LongName for NtcNr % must be a string.',obj.NtcNr);
            end
            obj.LongName = val;
        end
        
        function set.NtcStInfo(obj,val)
            meta = metaclass(val);
            if ~(strcmp(meta.Name,'DataDict.NtcStInfoIdx') || strcmp(meta.Name,'DataDict.NtcStInfoBitPacked'))
                error('Unknown data class for NTC NtcStInfo property. This property must be NtcStInfoIdx or NtcStInfoBitPacked.')
            end
            obj.NtcStInfo = val;
        end
        
        function txt = String(obj)
            % This function creates a string that looks like the original structure.
            % If the string is placed into a Matlab script, then running the script
            % would generate the original structure in Matlab's workspace.
            var = inputname(1);
            cl = class(obj);
            txt = sprintf('%s = %s;\n', var, cl);
            
            meta = metaclass(obj.NtcNr);
            if ischar(obj.NtcNr)
                txt = sprintf('%s%s.NtcNr = ''%s'';\n', txt, var, Val2String(obj.NtcNr));
            elseif(strcmp(meta.SuperclassList.Name,'Simulink.IntEnumType'))
                txt = sprintf('%s%s.NtcNr = %s;\n', txt, var, Val2String(obj.NtcNr));
            else
                error('Unknown NtcNr for')
            end
            txt = sprintf('%s%s.NtcTyp = ''%s'';\n', txt, var, obj.NtcTyp);
            txt = sprintf('%s%s.LongName = ''%s'';\n', txt, var, obj.LongName);
            txt = sprintf('%s%s.Description = ''%s'';\n', txt, var, obj.Description);
            txt = sprintf('%s%s.NtcStInfo = %s;\n',txt, var, class(obj.NtcStInfo));
            tempobj = obj.NtcStInfo;
            txt = sprintf('%s%s',txt, strrep(String(tempobj),'tempobj',var));
            
        end
    end
    
end

%#ok<*MCSUP>