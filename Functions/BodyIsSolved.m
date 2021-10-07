function is_solved = BodyIsSolved(first, last, solution)
% is_solved = BodyIsSolved(first, last, solution)
%
% Returns true if the body is surrounded by OFF squares.

	arguments
		first
		last
		solution {mustBeABody(solution, first, last)}
	end

	global ON
	global OFF
	
	% if the squares inside the body are ON and the squares to the left and
	% right of the body are both OFF, the body has been solved
	solution = [OFF solution OFF];
	is_solved = all(solution(first+1:last+1) == ON) && all(solution([first last+2]) == OFF);
	
end

function mustBeABody(solution, first, last)
	
	global OFF

    if any(solution(first:last) == OFF)
        eid = 'BodyIsSolved:mustBeABody';
        msg = 'solution(%d:%d) must be a body.';
        throwAsCaller(MException(eid, msg, first, last))
    end
end
