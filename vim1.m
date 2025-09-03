% Keep original headers (optional, just to avoid the warning)
T = readtable('RSSI Database.xls', 'VariableNamingRule', 'preserve');

for i = 1:8   % AP1..AP8 only
    vname = T.Properties.VariableNames{i};
    col   = T.(vname);              % get the whole variable

    if isnumeric(col)
        % Column imported as numeric (e.g., '*' already became NaN)
        col(isnan(col)) = -120;
        T.(vname) = col;            % replace entire variable
    else
        % Column imported as text/cell/string — make numeric
        col = string(col);
        col(col == "*") = "-120";
        num = str2double(col);
        num(isnan(num)) = -120;     % safety for blanks, etc.
        T.(vname) = num;            % replace entire variable (type becomes double)
    end
end


