function solution = Apply(cols, rows, solution, func, desc)

	arguments
		cols
		rows
		solution
		func
		desc = "Solving";
	end

	old_solution = solution;

	for i = 1:length(cols)
		solution(:, i) = func(cols{i}, solution(:, i)')';
		ShowChanges(desc, cols, rows, old_solution, solution, "col", i);
	end

	for i = 1:length(rows)
		solution(i, :) = func(rows{i}, solution(i, :));
		ShowChanges(desc, cols, rows, old_solution, solution, "row", i);
	end
	
	ShowChanges(desc, cols, rows, old_solution, solution, "", 0);
end
