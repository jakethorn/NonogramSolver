function [first, last] = GetWorkingVector(solution, option)
% [first, last] = GetWorkingVector(solution, options)
%
% Returns boundaries of the available space in the solution.

	arguments
		solution
		option (1, 1) Options {mustBeMember(option, ["IncludeSolvedBodies" "ExcludeSolvedBodies"])}
	end

	global OFF
	
	if option == Options.ExcludeSolvedBodies
		solution = MarkSolvedAsInactive(solution);
	end
	
	first = find(solution ~= OFF, 1);
	last = find(solution ~= OFF, 1, "last");
	
end
