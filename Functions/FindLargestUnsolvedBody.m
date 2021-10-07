function [first, last] = FindLargestUnsolvedBody(solution)
	
	[first, last] = FindUnsolvedBodies(solution);
	[~, idx] = max(last - first);
	first = first(idx);
	last = last(idx);
	
end
