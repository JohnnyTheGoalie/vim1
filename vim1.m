T = readtable('RSSI Database.xls');

% Ensure AP1..AP8 are cleaned the same way
for i = 1:8
    col = T{:, i};                 % work with raw column values

    if isnumeric(col)
        % Column was imported as numeric (e.g., AP8) → '*' became NaN
        col(isnan(col)) = -120;    % make all NaNs be -120
        T{:, i} = col;
    else
        % Column was imported as text/cell/string → contains '*'
        col = string(col);
        col(col == "*") = "-120";  % replace '*' with '-120'
        T{:, i} = str2double(col); % convert to numeric
        T{isnan(T{:, i}), i} = -120; % safety: any leftover NaN -> -120
    end
end
