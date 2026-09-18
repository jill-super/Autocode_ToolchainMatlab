%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Nexteer DataType Class Definition %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

classdef u10p6 < bt.uint16
   methods
      function obj = u10p6(~)
          obj = obj@bt.uint16(6);
          obj.Description = 'fixdt(1,16,6)';
      end
   end
   
end

