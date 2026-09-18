%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Nexteer DataType Class Definition %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

classdef um6p22 < bt.uint16
   methods
      function obj = um6p22(~)
          obj = obj@bt.uint16(22);
          obj.Description = 'fixdt(1,16,22)';
      end
   end
   
end

