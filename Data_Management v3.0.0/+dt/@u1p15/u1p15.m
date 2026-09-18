%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Nexteer DataType Class Definition %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Change Log:
% 11feb2015     Fixed bug in call to inherited class.

classdef u1p15 < bt.uint16
   methods
      function obj = u1p15(~)
          obj = obj@bt.uint16(15);
          obj.Description = 'fixdt(1,16,15)';
      end
   end
   
end

