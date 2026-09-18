%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Nexteer DataType Class Definition %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Structure datatype class definition

% Change Log:
% 04feb2015             Bug Fix: Removed unused property .DataType that caused error in the validate method.
% 13feb2015             Bug Fix: In validateUserEngInit changed to call EngInit not EngVal.
% 17apr2015             Added functionality to handle empty structures.
% 15May2015  P Lefler   Bug Fixes: Methods validateUserEngVal and validateUserEngInit would erase stored warning messages.
% 06Oct2015  P Lefler   Support for arrays of structures was added.
% 20Oct2015  P Lefler   Support for variable EngMin and EngMax has been added.


classdef struct < Simulink.AliasType
    properties
        InitString@char;
        Fields@bt.structelement;
        InterfacePath = '/PortInterfaces/CalPortInterface_rec';
    end
    methods
        function obj = struct(~)
        end
        
        function [engmin,scaledmin,str] = validateUserEngMin(dtobj,val)
            % check that val is a struct if not set engmin and scaledmin to default struct
            if ~isstruct(val)
                val = eval(dtobj.InitString);
                for i = 1:length(dtobj.Fields)
                    if isempty(dtobj.Fields(i).EngMin)
                        val.(dtobj.Fields(i).Name) = validateUserEngMin(dtobj.Fields(i).EngDT,dtobj.Fields(i).EngMin);
                    else
                        val.(dtobj.Fields(i).Name) = dtobj.Fields(i).EngMin;
                    end
                    
                end
                
            end
            % loop through obj.Fields and check that corresponding Min values in val are within limits set by the structure data class.
            tempstr = val;
            for i = 1:length(dtobj.Fields)
                [min,~,fldstr] = validateUserEngVal(dtobj.Fields(i).EngDT,dtobj.Fields(i),val.(dtobj.Fields(i).Name));
                if ~strcmp(fldstr,'')
                    warning('In workspace, Struct.EngMin has been increased to the EngMin of the Struct data type. Please update your saved files.');
                end
                tempstr.(dtobj.Fields(i).Name) = min;
            end
            
            engmin = tempstr;
            scaledmin = [];
            str = '';
        end
        
        function [engmax,scaledmax,str] = validateUserEngMax(dtobj,val)
            % check that val is a struct if not set engmin and scaledmin to default struct
            if ~isstruct(val)
                val = eval(dtobj.InitString);
                for i = 1:length(dtobj.Fields)
                    if isempty(dtobj.Fields(i).EngMax)
                        val.(dtobj.Fields(i).Name) = validateUserEngMax(dtobj.Fields(i).EngDT,dtobj.Fields(i).EngMax);
                    else
                        val.(dtobj.Fields(i).Name) = dtobj.Fields(i).EngMax;
                    end
                    
                end
            end
            % loop through obj.Fields and check that corresponding Max values in val are within limits set by the structure data class.
            tempstr = val;
            for i = 1:length(dtobj.Fields)
                [min,~,fldstr] = validateUserEngVal(dtobj.Fields(i).EngDT,dtobj.Fields(i),val.(dtobj.Fields(i).Name));
                if ~strcmp(fldstr,'')
                    warning('In workspace, Struct.EngMax has been increased to the EngMax of the Struct data type. Please update your saved files.');
                end
                tempstr.(dtobj.Fields(i).Name) = min;
            end
            
            engmax = tempstr;
            scaledmax = [];
            str = '';
        end
        
        function [engval,scaledval,str] = validateUserEngVal(dtobj,calobj,val)
            
            if strcmp(dtobj.InitString,'')
                engval = [];
                scaledval = [];
                str = '';
                return;
            end
            
            dtfnames = cell(0);
            
            for i = 1:length(dtobj.Fields)
                dtfnames{i,1} = dtobj.Fields(i).Name;
            end
            
            try
                ipfnames = fieldnames(val);
                namecomp = ~strcmp(dtfnames,ipfnames);
                if any(namecomp)
                    error('dtstruct:validateUserEngVal:IncompatableStuctNames', 'Names don''t match!')
                end
                str = '';
            catch err
                switch err.identifier
                    case   'MATLAB:strcmp:InputsSizeMismatch'
                        str = 'There is a mismatch between the number of fields in the inputed structure and the structure of the selected type. No change has been made.';
                        val = calobj.EngVal;
                    case 'dtstruct:validateUserEngVal:IncompatableStuctNames'
                        str = 'Struct field names dont''t match! No change has been made.';
                        val = calobj.EngVal;
                    case 'MATLAB:UndefinedFunction'
                        if isequal(dtobj.BaseType,calobj.DataType)
                            % EngVal isn't a structure.
                            val = calobj.EngVal;
                            str = 'Input %s.EngVal isn''t a structure. No change has been made.';
                        else
                            % EngDT has changed.
                            val = evalin('base',dtobj.InitString);
                            str = '';
                        end
                        
                end
            end
            
            for i = 1:length(dtobj.Fields)
                dtelement = dtobj.Fields(i).EngDT;
                objelement = calobj.EngDT.Fields(i);
                
                if isstruct(calobj.EngMin)
                    objelement.EngMin = calobj.EngMin.(dtfnames{i});
                end
                
                if isstruct(calobj.EngMax)
                    objelement.EngMax = calobj.EngMax.(dtfnames{i});
                end
                
                [eVal,sVal,txt] = validateUserEngVal(dtelement,objelement, val.(dtfnames{i}));
                engval.(dtfnames{i}) = eVal;
                scaledval.(dtfnames{i}) = sVal;
                
                if ~isempty(txt)
                    str = sprintf('%s, %s',str,txt);
                end
                
            end
            str = sprintf('%s',str);
          end
        
        function [enginit,scaledinit,str] = validateUserEngInit(dtobj,calobj,val)
            
            if strcmp(dtobj.InitString,'')
                enginit = [];
                scaledinit = [];
                str = '';
                return;
            end
            
            dtfnames = cell(0);
            
            for i = 1:length(dtobj.Fields)
                dtfnames{i,1} = dtobj.Fields(i).Name;
            end
            
            try
                ipfnames = fieldnames(val);
                namecomp = ~strcmp(dtfnames,ipfnames);
                if any(namecomp)
                    error('dtstruct:validateUserEngVal:IncompatableStuctNames', 'Names don''t match!')
                end
                str = '';
            catch err
                switch err.identifier
                    case   'MATLAB:strcmp:InputsSizeMismatch'
                        str = 'There is a mismatch between the number of fields in the inputed structure and the structure of the selected type. No change has been made.';
                        val = calobj.EngInit;
                    case 'dtstruct:validateUserEngVal:IncompatableStuctNames'
                        str = 'Struct field names dont''t match! No change has been made.';
                        val = calobj.EngInit;
                    case 'MATLAB:UndefinedFunction'
                        if isequal(dtobj.BaseType,calobj.DataType)
                            % EngVal isn't a structure.
                            val = calobj.EngInit;
                            str = 'Input %s.EngVal isn''t a structure. No change has been made.';
                        else
                            % EngDT has changed.
                            val = evalin('base',dtobj.InitString);
                            str = '';
                        end
                end
            end
            
            for i = 1:length(dtobj.Fields)
                for j = 1:size(val,1)
                    for k = 1:size(val,2)
                        dtelement = dtobj.Fields(i).EngDT;
                        objelement = calobj.EngDT.Fields(i);
                        [eVal,sVal,txt] = validateUserEngVal(dtelement,objelement, val(j,k).(dtfnames{i}));
                        enginit(j,k).(dtfnames{i}) = eVal;
                        scaledinit(j,k).(dtfnames{i}) = sVal;
                        if ~isempty(txt)
                            str = sprintf('%s, %s',str,txt);
                        end
                    end
                end
            end
        end
        
        function [engdt,str] = validateUserEngDT(dtobj,val)
            meta = metaclass(val);
            pname = meta.ContainingPackage.Name;
            % "meta.ContainingPackage" will tell us what kind of object the user has given.
            if (isempty(meta.ContainingPackage)) || ((~strcmp('dt',pname)) && (~strcmp('enum',pname)) && (~strcmp('enumEA3',pname)) && (~strcmp('struct',pname)) && (~strcmp('structEA3',pname)))
                engdt = dtobj;
                str = '%s.EngDT input is not a ''dt'', ''enum'', or ''enumEA3'' object.';
            else
                engdt = val;
                str = '';
            end
            
        end
        
    end
end