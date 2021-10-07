function [clue_idx, clue_size] = GetPossibleClues(clue, first, last, solution, option)
% [possible_clues, clue_idx] = GetPossibleClues(clue, first, last, solution)
%
% Find all clues that the body could potentially be solving.

	arguments
		clue
		first
		last
		solution
		option (1, 1) Options {mustBeMember(option, ["CheckBodyIndex" "IgnoreBodyIndex"])} = Options.CheckBodyIndex
	end
	
	global UNKNOWN

	clue_idx = [];
	clue_size = [];
	
	in_enclosure = all(solution(first:last) == UNKNOWN);
	body_size = (1 + last - first);
	
	% get first and last possible clues based on body index
	if option == Options.CheckBodyIndex
		[first_clue, last_clue] = GetBodyIndexClues(clue, first, last, solution);
	% else, get all clues
	else
		first_clue = 1;
		last_clue = length(clue);
	end
	
	% get working vector
	[~, vec_last] = GetWorkingVector(solution, Options.IncludeSolvedBodies);
	
	% for each clue
	for i = first_clue:last_clue
		
		% check prior clues fit in working vector
		prior_clues = clue(1:i-1);
		room_for_prior_clues = CheckAvailableSpace(prior_clues, solution(1:first-2));
		
		% if we are testing an enclosure, also check if prior clues could
		% fit inside the enclosure itself (as well as the current clue)
		if in_enclosure && ~room_for_prior_clues
			prior_clue_space = sum(prior_clues) + length(prior_clues);
			room_for_prior_clues = prior_clue_space + clue(i) <= last;
		end
		
		% check posterior clues fit in working vector
		posterior_clues = clue(i+1:end);
		room_for_posterior_clues = CheckAvailableSpace(posterior_clues, solution(last+2:end));
		
		% if we are testing an enclosure, also check if posterior clues could
		% fit inside the enclosure itself (as well as the current clue)
		if in_enclosure && ~room_for_posterior_clues
			posterior_clue_space = sum(posterior_clues) + length(posterior_clues);
			room_for_posterior_clues = posterior_clue_space + clue(i) <= vec_last - first;
		end
		
		% if we are testing an enclosure, the body must be bigger than
		% the clue
		if in_enclosure
			clue_is_big_enough = clue(i) <= body_size;
		% else, if we are checking a whole or partial body, the body must
		% be smaller than the clue
		else
			clue_is_big_enough = clue(i) >= body_size;
		end
		
		% if all checks are passed, add clue to retval
		if room_for_prior_clues && room_for_posterior_clues && clue_is_big_enough
			clue_idx(end+1) = i;
			clue_size(end+1) = clue(i);
		end

	end

end

function [first_clue, last_clue] = GetBodyIndexClues(clue, first, last, solution)

	num_clues = length(clue);

	% default first/last clues
	first_clue = 1;
	last_clue = num_clues;
	
	% get guaranteed separate bodies from the solution
	[body_first, body_last] = FindSeparateBodies(clue, solution);

	% for each body
	num_bodies = length(body_first);
	for body_idx = 1:num_bodies

		% we are within a body
		if first >= body_first(body_idx) && last <= body_last(body_idx)

			% we cannot be part of any clues with indices earlier than the
			% separated bodies index number (works similarly in the other
			% direction as well)
			first_clue = body_idx;
			last_clue = num_clues - (num_bodies - body_idx);
			return
		end
		
	end

end

function is_space = CheckAvailableSpace(clue, solution)
	
	global UNKNOWN
	global ON
	global OFF
	
	% clear all known bodies
	solution(solution == ON) = UNKNOWN;
	
	[encl_first, encl_last] = FindEnclosures(solution);
	
	% definitely is space if there are no clues
	is_space = isempty(clue);
	
	% for each clue
	for clue_idx = 1:length(clue)
		
		% if we still have clues, but no enclosures there must not be space
		if isempty(encl_first)
			is_space = false;
			return
		end
		
		% while there is at least 1 enclosure
		while ~isempty(encl_first)
			
			% calculate first enclosures size
			encl_size = 1 + encl_last(1) - encl_first(1);
			
			% if it's big enough to fit the clue
			if encl_size >= clue(clue_idx)
				
				% fill in a little bit and move onto the next clue
				solution(encl_first(1):encl_first(1) + clue(clue_idx)) = OFF; % might overflow
				[encl_first, encl_last] = FindEnclosures(solution);
				
				% if we are fitting in clues, there must be space
				is_space = true;
				break
				
			else
				
				% fill in completely and try the next enclosure
				solution(encl_first(1):encl_last(1)) = OFF;
				[encl_first, encl_last] = FindEnclosures(solution);
				
				% if we are not fitting in, there must not be space
				is_space = false;
				
			end
			
		end
		
	end
	
end
