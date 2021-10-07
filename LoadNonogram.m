function [cols, rows] = LoadNonogram(file)

	opts = detectImportOptions(file);
	opts = setvartype(opts, "string");
	nonogram = readtable(file, opts, "ReadVariableNames", false);

	for i = 2:width(nonogram)
		cols{i-1} = str2double(split(nonogram{1, i}, " "));
	end

	for i = 2:height(nonogram)
		rows{i-1} = str2double(split(nonogram{i, 1}, " "));
	end

end
