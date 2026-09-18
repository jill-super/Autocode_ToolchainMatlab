%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Nexteer DataType Class Definition %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

classdef u16p0 < bt.uint16
   methods
      function obj = u16p0(~)
          obj = obj@bt.uint16(0);
          obj.Description = 'fixdt(1,16,0)';
      end
   end
   
end

