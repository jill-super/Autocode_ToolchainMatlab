%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Nexteer DataType Class Definition %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

classdef u5p11 < bt.uint16
   methods
      function obj = u5p11(~)
          obj = obj@bt.uint16(11);
          obj.Description = 'fixdt(1,16,11)';
      end
   end
   
end

