function is_complete = CheckComplete(cols, rows, solution)

	is_complete = true;

	for i = 1:length(rows)
		clue = AsClue(solution(i, :));
		is_complete = is_complete & isequal(rows{i}, clue);
	end

end

