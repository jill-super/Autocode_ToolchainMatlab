%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Nexteer DataType Class Definition %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

classdef um7p23 < bt.uint16
   methods
      function obj = um7p23(~)
          obj = obj@bt.uint16(23);
          obj.Description = 'fixdt(1,16,23)';
      end
   end
   
end

