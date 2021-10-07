function [first, last] = FindEnclosures(solution)
% [first, last] = FindEnclosures(solution)
%
% Find empty spaces between inactive squares.

	global UNKNOWN
	global OFF

	first = [];
	last = [];
	
	% the zeroth and N+1 cells are treated as OFFs
	all_offs = [0 find(solution == OFF) length(solution)+1];
	
	for i = 1:length(all_offs)-1
		
		left = all_offs(i) + 1;
		right = all_offs(i+1) - 1;
		enclosure = solution(left:right);
		
		% discard small enclosures and enclosures containing bodies
		if length(enclosure) >= 1 && all(enclosure == UNKNOWN)
			first(end+1) = left;
			last(end+1) = right;
		end
		
	end
	
end
