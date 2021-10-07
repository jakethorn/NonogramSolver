function [first, last] = FindSeparateBodies(clue, solution)
% [first, last] = FindSeparateBodies(clue, solution)
%
% Returns bodies that are guaranteed to be part of different clues. If two
% bodies could be solving the same clue, they will be joined together.

	global OFF

	% find all bodies
	[first, last] = FindBodies(solution);
	
	% for each body
	i = 1;
	while i < length(first)
		
		% get the space inbetween this and next body
		inbetween = solution(last(i) + 1:first(i+1) - 1);
		
		% bodies are different if there is an off square between them
		different = ismember(OFF, inbetween);
		
		if different
			i = i + 1;
			continue
		end
		
		% bodies are different if there is no clue that can be solved if
		% the two bodies were joined together
		possibles = GetPossibleClues(...
			clue, first(i), last(i+1), solution,...
			Options.IgnoreBodyIndex...
		);
		
		if isempty(possibles)
			i = i + 1;
			continue
		end
		
		% as they are not definately different, join the bodies together
		last(i) = last(i+1);
		
		first(i+1) = [];
		last(i+1) = [];
		
		i = 1;
	end
	
end
