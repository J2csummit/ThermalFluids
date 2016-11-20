function [ value ] = interpolate( startValue, table, columnStart, columnDesired )
%interpolate interpolate through tables
%   Interpolate through a table of values using a starting value/column,
%   and then obtained the interpolated value in the column desired

% Initialize interpolated variables in orginal column
a1 = 0; a2 = 0;

% Intialize interpolated variables in desired column
b1 = 0; b2 = 0;

startColumn = table(:,columnStart);
for i=1:length(startColumn)
    a2 = startColumn(i);
    if a2 > startValue && i > 1
        a1 = startColumn(i-1);
        b1 = table(i-1, columnDesired);
        b2 = table(i, columnDesired);
    end
end

assert(a1 == 0 && b1 == 0 && b2 == 0)

value = ((startValue - a1)/(a2 - a1))*(b2 - b1) + b1;

end

