% Base case: Transposing an empty list yields an empty list.
transpose([], []).

% Transpose non-empty list.
transpose([[]|_], []).
transpose(Matrix, [FirstCol|RestCols]) :-
    % Extract the first column of the matrix.
    first_column(Matrix, FirstCol, RestMatrix),
    % Transpose the rest of the matrix.
    transpose(RestMatrix, RestCols).

% Helper predicate to extract the first column of a matrix.
first_column([], [], []).
first_column([[X|Xs]|Rows], [X|Col], [Xs|RestRows]) :-
    first_column(Rows, Col, RestRows).
