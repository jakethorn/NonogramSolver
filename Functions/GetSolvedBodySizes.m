function sizes = GetSolvedBodySizes(solution)
	
	[first, last] = FindSolvedBodies(solution);
	sizes = (last - first) + 1;
	
end
