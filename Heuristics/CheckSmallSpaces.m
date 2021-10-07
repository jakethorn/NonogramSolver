function solution = CheckSmallSpaces(cols, rows, solution)

	solution = Apply(...
		cols, rows, solution, @CheckSmallSpaces_,...
		"Checking for small spaces"...
	);
	
end

function solution = CheckSmallSpaces_(clue, solution)

	% if there is a space between two inactives that is smaller than all
	% possible clues, then the space is also inactive
	
	global OFF
	
	[first, last] = FindEnclosures(solution);
	
	% for each enclosure
	for i = 1:length(first)
		
		% "fill in" enclosure if it is smaller than all possible clues
		[~, clue_size] = GetPossibleClues(clue, first(i), last(i), solution);
		
		if isempty(clue_size)
			solution(first(i):last(i)) = OFF;
		end
	end
	
end
