function [first, last] = FindBodies(solution)
% [first, last] = FindBodies(solution)
%
% Find all solved and unsolved bodies in the solution vector.

	global ON

	solution = [0 solution == ON 0];
	
	delta = diff(solution);
	first = find(delta == 1);
	last = find(delta == -1) - 1;
	
end
