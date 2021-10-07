function clue = AsClue(solution)
% clue = AsClue(solution)
%
% Returns the body sizes of the solution in the form of a clue.

	[first, last] = FindBodies(solution);
	clue = 1 + last - first;
	
	if isempty(clue)
		clue = 0;
	end
	
	clue = clue';
	
end
