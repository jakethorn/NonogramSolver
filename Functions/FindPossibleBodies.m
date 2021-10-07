function [first, last] = FindPossibleBodies(clue, clue_idx, solution)
% [first, last] = FindPossibleBodies(clue, clue_idx, solution)
%
% Find all bodies that could be the partial or whole solution of clue(clue_idx).

	[first, last] = FindBodies(solution);
	
	% for each body
	i = 1;
	while i <= length(first)
		
		% get the bodies potential clues
		poss_idx = GetPossibleClues(...
			clue, first(i), last(i), solution...
		);
		
		% dicard bodies that do not have clue(clue_idx) as a potential clue
		if all(poss_idx ~= clue_idx)
			first(i) = [];
			last(i) = [];
		else
			i = i + 1;
		end
		
	end

end
