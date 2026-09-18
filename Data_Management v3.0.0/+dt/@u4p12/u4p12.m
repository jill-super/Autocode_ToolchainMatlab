%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Nexteer DataType Class Definition %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

classdef u4p12 < bt.uint16
   methods
      function obj = u4p12(~)
          obj = obj@bt.uint16(12);
          obj.Description = 'fixdt(1,16,12)';
      end
   end
   
end

