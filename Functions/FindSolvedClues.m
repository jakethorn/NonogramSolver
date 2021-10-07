function [first, last, idx] = FindSolvedClues(clue, solution, option)
% [first, last, idx] = FindSolvedClues(clue, solution, option)
%
% Returns indices of all solved clues along with their solutions.

	arguments
		clue
		solution
		option (1, 1) Options {mustBeMember(option, ["IncludeOffSquares" "ExcludeOffSquares"])} = Options.ExcludeOffSquares
	end

	first = [];
	last = [];
	idx = [];

	[first_solved, last_solved] = FindSolvedBodies(solution);
	
	% for each solved body
	for i = 1:length(first_solved)
		
		% get the bodies possible clues
		clue_idx = GetPossibleClues(...
			clue, first_solved(i), last_solved(i), solution...
		);
		
		% the clue can be considered solved if it is the only possible clue
		% of the solved body
		if length(clue_idx) == 1
			
			% include surrouding off squares if requested
			if option == Options.IncludeOffSquares
				[first(end+1), last(end+1)] = IncludeOffs(first_solved(i), last_solved(i), solution);
			else
				first(end+1) = first_solved(i);
				last(end+1) = last_solved(i);
			end
			
			idx(end+1) = clue_idx;
		end
		
	end
	
end
