
function ShowSolution(cols, rows, solution, desc)

	c = zeros(height(solution), width(solution), 3);
	
	ind = find(solution == 0);
	[row, col] = ind2sub(size(solution), ind);
	c(sub2ind(size(c), row, col, repelem(1, length(row))')) = 1;
	c(sub2ind(size(c), row, col, repelem(2, length(row))')) = 1;
	c(sub2ind(size(c), row, col, repelem(3, length(row))')) = 1;
	
	ind = find(solution == 1);
	[row, col] = ind2sub(size(solution), ind);
	c(sub2ind(size(c), row, col, repelem(1, length(row))')) = 0.5;
	c(sub2ind(size(c), row, col, repelem(2, length(row))')) = 1.0;
	c(sub2ind(size(c), row, col, repelem(3, length(row))')) = 0.5;
	
	ind = find(solution == 2);
	[row, col] = ind2sub(size(solution), ind);
	c(sub2ind(size(c), row, col, repelem(1, length(row))')) = 1.0;
	c(sub2ind(size(c), row, col, repelem(2, length(row))')) = 0.5;
	c(sub2ind(size(c), row, col, repelem(3, length(row))')) = 0.5;
	
	ind = find(solution == 3);
	[row, col] = ind2sub(size(solution), ind);
	c(sub2ind(size(c), row, col, repelem(1, length(row))')) = 0.75;
	c(sub2ind(size(c), row, col, repelem(2, length(row))')) = 0.75;
	c(sub2ind(size(c), row, col, repelem(3, length(row))')) = 0.75;
	
	ind = find(solution == 4);
	[row, col] = ind2sub(size(solution), ind);
	c(sub2ind(size(c), row, col, repelem(1, length(row))')) = 0.25;
	c(sub2ind(size(c), row, col, repelem(2, length(row))')) = 0.75;
	c(sub2ind(size(c), row, col, repelem(3, length(row))')) = 0.25;
	
	ind = find(solution == 5);
	[row, col] = ind2sub(size(solution), ind);
	c(sub2ind(size(c), row, col, repelem(1, length(row))')) = 0.75;
	c(sub2ind(size(c), row, col, repelem(2, length(row))')) = 0.25;
	c(sub2ind(size(c), row, col, repelem(3, length(row))')) = 0.25;
	
	image(c);
	axis equal
	grid on
	
	rows_str = [];
	for i = 1:length(rows)
		row = rows{i};
		rows_str = [rows_str join(string(row), ", ")];
	end
	
	cols_str = [];
	for i = 1:length(cols)
		col = cols{i};
		cols_str = [cols_str join(string(col), ", ")];
	end
	
	ylim([.5 length(rows)+.5]);
	yticks(1:length(rows));
	yticklabels(rows_str);
	
	xlim([.5 length(cols)+.5]);
	xticks(1:length(cols));
	xticklabels(cols_str);
	
	ax = gca;
	ax.XAxisLocation = "top";
	ax.XTickLabelRotation = -45;
	
	if exist("desc", "var") == 1
		text(1, 1, desc);
	end

end
