function [first, last] = FindSolvedBodies(solution)
% [first, last] = FindSolvedBodies(solution)
%
% Returns bodies surrounded by OFF squares.

	% find all bodies in solution
	[first, last] = FindBodies(solution);
	
	% for each body
	i = 1;
	while i <= length(first)
		
		% keep if the body is solved
		if BodyIsSolved(first(i), last(i), solution)
			i = i + 1;
		% else, discard it
		else
			first(i) = [];
			last(i) = [];
		end
		
	end

end
