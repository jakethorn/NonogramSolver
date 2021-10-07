function clue = GetUnsolvedClues(clue, solution)
	
	solved = GetSolvedBodySizes(solution);
	for solved_i = solved
		for i = 1:length(clue)
			if solved_i == clue(i)
				clue(i) = [];
				break
			end
		end
	end
	
end
