function solution = MarkSolvedAsInactive(solution)
% solution = MarkSolvedAsInactive(solution)
%
% Replace solved bodies with OFF squares.
	
	global OFF

	[first, last] = FindSolvedBodies(solution);
	
	for i = 1:length(first)
		solution(first(i):last(i)) = OFF;
	end

end
