function solution = CheckForSolvedBodies(cols, rows, solution)

	solution = Apply(...
		cols, rows, solution, @CheckForSolvedBodies_,...
		"Checking for solved bodies"...
	);
	
end

function solution = CheckForSolvedBodies_(clue, solution)

	% if there is a body that is equal in size to its largest possible 
	% clue, that body has been solved and can be surrounded by inactive 
	% cells
	
	global OFF

	[first, last] = FindUnsolvedBodies(solution);
	
	% for each unsolved body
	for i = 1:length(first)
		
		% get that bodies potential clues
		[~, clue_size] = GetPossibleClues(...
			clue, first(i), last(i), solution...
		);
	
		% mark as solved if body matches the maximum clue size
		body_size = 1 + last(i) - first(i);
		if body_size == max(clue_size)

			% if within bounds
			if first(i) - 1 >= 1
				solution(first(i) - 1) = OFF;
			end

			% if within bounds
			if last(i) + 1 <= length(solution)
				solution(last(i) + 1) = OFF;
			end

		end

	end
	
end
