%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Nexteer DataType Class Definition %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Structure element datatype class definition

classdef structelement
    properties
        Name@char;
        EngDT;
        EngMin;
        EngMax;
        DocUnits@char;
        Dimensions = [];
        Description@char;
    end

end