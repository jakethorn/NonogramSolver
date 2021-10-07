function ShowChanges(desc, cols, rows, old_solution, new_solution, axis, vector)

	solution = new_solution;
	if axis == "col"
		solution(:, vector) = solution(:, vector) + 3;
	elseif axis == "row"
		solution(vector, :) = solution(vector, :) + 3;
	end
	
	diff = old_solution ~= new_solution;
	solution(diff) = new_solution(diff) + 3;

	ShowSolution(cols, rows, solution, desc);
	pause(.1);
	
end

