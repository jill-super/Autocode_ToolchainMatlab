%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Nexteer DataType Class Definition %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

classdef u2p14 < bt.uint16
   methods
      function obj = u2p14(~)
          obj = obj@bt.uint16(14);
          obj.Description = 'fixdt(1,16,14)';
      end
   end
   
end

