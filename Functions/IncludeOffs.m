function [first, last] = IncludeOffs(first, last, solution)
% [first, last] = IncludeOffs(first, last, solution)
%
% Add any OFF squares to the left and right of the body to the first and
% last boundaries.

	global OFF

	pre = solution(1:first-1);
	first_two = find(pre ~= OFF, 1, "last") + 1;
	if isempty(first_two)
		first = 1;
	else
		first = first_two;
	end
	
	post = solution(last+1:end);
	last_two = find(post ~= OFF, 1) - 1;
	if isempty(last_two)
		last = length(solution);
	else
		last = last + last_two;
	end
	
end