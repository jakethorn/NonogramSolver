function solution = CheckConstraints(cols, rows, solution)

	solution = Apply(...
		cols, rows, solution, @CheckConstraints_,...
		"Checking for constrained bodies"...
	);
	
end

function solution = CheckConstraints_(clue, solution)
	
	% place each unsolved clue at each legal position on the vector
	% there should NOT be ZERO legal positions
	% a single legal position means it must go there
	% multiple legal positions means that only overlapping squares can be
	% marked active
	
	% there are 4 restrictions on clue placement
	% 1: it cannot be placed on an cell marked inactive
	% 2: it cannot be placed such that other clues would not fit into the
	% working vector
	% 3: it cannot go further left than another solved clue that is further
	% to the left - same applies to the right
	% 4: if the clues body can already be identified, placement can be
	% severely restricted and centered around its body

	global OFF
	
	% for each clue
	for clue_idx = 1:length(clue)

		% no point to re-solve the clue
		if ClueIsSolved(clue, clue_idx, solution)
			continue
		end
		
		% the potential overlap from all unsolved clue placements
		overlap = ones(1, length(solution));
		
		% if a clue has been solved to the left, set the working vector to
		% start at the end of the clues solution and remove that clue and
		% all clues further to the left. Do the same for the right.
		[first, last, first_clue, last_clue] = GetWorkingPartition(...
			clue, clue_idx, solution...
		);
		
		% from the start to end of the working partition
		for pos = first:last - (clue(clue_idx) - 1)
			
			% clue body
			clue_body = pos:pos + (clue(clue_idx) - 1);

			% no placement if clue body is on an inactive cell
			if any(solution(clue_body) == OFF)
				continue
			end

			% no placement if prior clues cannot fit into the working
			% partition
			prior_clues = clue(first_clue:clue_idx-1);
			clue_space = sum(prior_clues) + length(prior_clues);
			if clue_space > min(clue_body) - first
				continue
			end
			
			% no placement if posterior clues cannot fit into the working
			% partition
			post_clues = clue(clue_idx+1:last_clue);
			clue_space = sum(post_clues) + length(post_clues);
			if clue_space > last - max(clue_body)
				continue
			end
			
			% calculate any overlap
			s = zeros(1, length(solution));
			s(clue_body) = 1;
			overlap = overlap .* s;
			
		end
		
		% save overlap to the final solution
		solution = max(solution, overlap);
		
	end
end

function [first, last, first_clue, last_clue] = GetWorkingPartition(clue, clue_idx, solution)
% [first, last] = GetWorkingPartition(clue, clue_idx, solution)
%
% Gets the working partition. If the clues body can be identified, the 
% partition will be centered around that body and will disregard other
% clues. Otherwise, the partitions are split by other known solved clues. 
% At worst, the partition will be the working solution.
%
% Returns the partition space and possible clues in the partition.

	[first_b, last_b, first_clue_b, last_clue_b, success] = GetPartitionFromBody(clue, clue_idx, solution);
	[first_c, last_c, first_clue_c, last_clue_c] = GetPartitionFromSolvedClues(clue, clue_idx, solution);
	
	% if body partition is unsuccessful, use the solved clue partition
	if ~success
		first = first_c;
		last = last_c;
		first_clue = first_clue_c;
		last_clue = last_clue_c;
	% else, use the most restrictive partition
	else
		area_b = 1 + last_b - first_b;
		clue_b = sum(clue(first_clue_b:last_clue_b)) + (last_clue_b - first_clue_b);

		area_c = 1 + last_c - first_c;
		clue_c = sum(clue(first_clue_c:last_clue_c)) + (last_clue_c - first_clue_c);
		
		if area_b - clue_b < area_c - clue_c
			first = first_b;
			last = last_b;
			first_clue = first_clue_b;
			last_clue = last_clue_b;
		else
			first = first_c;
			last = last_c;
			first_clue = first_clue_c;
			last_clue = last_clue_c;
		end
	end
end

function [first, last, first_clue, last_clue, success] = GetPartitionFromBody(clue, clue_idx, solution)

	% try to find the body of the clue
	[body_first, body_last, success] = FindBodyOfClue(clue, clue_idx, solution);
	
	if success
		% if successful, we can limit the working partition to be the size 
		% of the clue and centered around the body
		first = max(body_last - (clue(clue_idx) - 1), 1);
		last = min(body_first + (clue(clue_idx) - 1), length(solution));
		% we now only care about the clue
		first_clue = clue_idx;
		last_clue = clue_idx;
	else
		first =[];
		last = [];
		first_clue = [];
		last_clue = [];
	end
	
end

function [first, last, first_clue, last_clue] = GetPartitionFromSolvedClues(clue, clue_idx, solution)

	% find all solved clues (and their solutions)
	[solved_first, solved_last, solved_idx] = FindSolvedClues(clue, solution, Options.IncludeOffSquares);
		
	% find the working partition
	% at most, this will be the actual working vector
	[first, last] = GetWorkingVector(solution, Options.ExcludeSolvedBodies);

	% but it could be reduced by other solved clues to the left...
	first_solved = max(solved_last(solved_idx < clue_idx)) + 1;
	if length(first_solved) == 1
		first = first_solved;
	end

	% ... and right
	last_solved = min(solved_first(solved_idx > clue_idx)) - 1;
	if length(last_solved) == 1
		last = last_solved;
	end
	
	% get partitions clues
	[first_clue, last_clue] = GetClosestUnsolvedClues(clue, clue_idx, solved_idx);
	
end

function [first_clue, last_clue] = GetClosestUnsolvedClues(clue, clue_idx, solved_idx)
% [first_clue, last_clue] = GetClosestUnsolvedClues(clue, clue_idx, solved_idx)
%
% If a clue along the left has been solved, clues further to the left than
% that clue can be ignored. The same applies to the right.

	% find closest unsolved clue to the left
	first_clue = max(solved_idx(solved_idx < clue_idx)) + 1;
	if isempty(first_clue)
		first_clue = 1;
	end

	% find closest unsolved clue to the right
	last_clue = min(solved_idx(solved_idx > clue_idx)) - 1;
	if isempty(last_clue)
		last_clue = length(clue);
	end

end
