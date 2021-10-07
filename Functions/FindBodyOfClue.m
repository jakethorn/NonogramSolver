function [first, last, success] = FindBodyOfClue(clue, clue_idx, solution)
% [first, last, success] = FindBodyOfClue(clue, clue_idx, solution)
%
% Finds the guaranteed body of the clue. If multiple potential bodies are
% found, they will be merged together providing all bodies' only potential
% clue is clue(clue_idx).

	[first, last] = FindPossibleBodies(clue, clue_idx, solution);
	success = length(first) >= 1;
	
	% check all bodies only potential clue is clue(clue_idx)
	for i = 1:length(first)
		poss_idx = GetPossibleClues(clue, first(i), last(i), solution);
		success = success && length(poss_idx) == 1;
	end
	
	% merge multiple bodies together
	if success
		first = first(1);
		last = last(end);
	end
	
end
