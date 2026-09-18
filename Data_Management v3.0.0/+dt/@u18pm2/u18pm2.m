%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Nexteer DataType Class Definition %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

classdef u18pm2 < bt.uint16
   methods
      function obj = u18pm2(~)
          obj = obj@bt.uint16(-2);
          obj.Description = 'fixdt(1,16,-2)';
      end
   end
   
end

