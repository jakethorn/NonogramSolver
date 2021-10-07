function solution = CheckUnreachable(cols, rows, solution)

	solution = Apply(...
		cols, rows, solution, @CheckUnreachable_,...
		"Checking for unreachable squares"...
	);
	
end

function solution = CheckUnreachable_(clue, solution)

	% squares can be unreachable for example, if each clue has an assigned
	% body and there is a square further away than every clues body + the
	% size of the clue

	global OFF
	
	% overlap of unreachable squares
	% if no clues can reach a square, the square can be marked OFF
	reachable = zeros(1, length(solution));

	% for each clue
	for i = 1:length(clue)
		
		% if the clue has only one possible body
		[body_first, body_last, success] = FindBodyOfClue(clue, i, solution);
		if success
			
			% mark reachable squares
			first = max(body_last - (clue(i) - 1), 1);
			last = min(body_first + (clue(i) - 1), length(solution));
			reachable(first:last) = 1;
		else
			
			% there is a rogue body, so we don't know what's reachable
			return
		end
		
	end
	
	% any square that was not reachable by any clue's body can be marked OFF
	solution(reachable == 0) = OFF;

end
