
global UNKNOWN
UNKNOWN = 0;

global ON
ON = 1;

global OFF
OFF = 2;

% load nonogram
[cols, rows] = LoadNonogram("example_nonogram_8");
height = length(rows);
width = length(cols);

% initialise solution
solution = zeros(height, width);
ShowSolution(cols, rows, solution);

% loop until complete
while CheckComplete(cols, rows, solution) == false
	
	% check vectors based on rules
	solution = CheckConstraints(cols, rows, solution);
	solution = CheckForSolvedBodies(cols, rows, solution);
	solution = CheckSmallSpaces(cols, rows, solution);
	solution = CheckUnreachable(cols, rows, solution);
	solution = CheckForSolvedVectors(cols, rows, solution);
	
end

% show success
ShowSolution(cols, rows, solution, "Success");















