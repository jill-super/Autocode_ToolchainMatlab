%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Nexteer DataType Class Definition %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

classdef um3p19 < bt.uint16
   methods
      function obj = um3p19(~)
          obj = obj@bt.uint16(19);
          obj.Description = 'fixdt(1,16,19)';
      end
   end
   
end

