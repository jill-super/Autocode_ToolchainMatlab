%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Nexteer DataType Class Definition %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

classdef s0p15 < bt.sint16
   methods
      function obj = s0p15(~)
          obj = obj@bt.sint16(15);
          obj.Description = 'fixdt(1,16,15)';
      end
   end
   
end

