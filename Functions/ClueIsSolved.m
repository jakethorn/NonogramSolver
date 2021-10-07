function is_solved = ClueIsSolved(clue, clue_idx, solution)
% is_solved = ClueIsSolved(clue, clue_idx, solution)
%
% Returns true if clue(clue_idx) is solved.

	[first, last, success] = FindBodyOfClue(clue, clue_idx, solution);
	is_solved = success && BodyIsSolved(first, last, solution);

end
