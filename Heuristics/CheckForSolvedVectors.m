function solution = CheckForSolvedVectors(cols, rows, solution)

	solution = Apply(...
		cols, rows, solution, @CheckForSolvedVectors_,...
		"Checking for solved vectors"...
	);
	
end

function solution = CheckForSolvedVectors_(clue, solution)

	attempt = AsClue(solution);
	if isequal(attempt, clue)
		solution(solution ~= 1) = 2;
	end
	
end
