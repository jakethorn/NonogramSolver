function [first, last] = FindUnsolvedBodies(solution)

	[first, last] = FindBodies(solution);
	solution = [2 solution 2];
	
	i = 1;
	while i <= length(first)
		if solution(first(i)) == 2 && solution(last(i) + 2) == 2
			first(i) = [];
			last(i) = [];
		else
			i = i + 1;
		end
	end
	
end
