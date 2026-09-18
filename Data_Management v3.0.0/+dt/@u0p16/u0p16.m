%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Nexteer DataType Class Definition %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

classdef u0p16 < bt.uint16
   methods
      function obj = u0p16(~)
          obj = obj@bt.uint16(16);
          obj.Description = 'fixdt(1,16,16)';
      end
   end
   
end

