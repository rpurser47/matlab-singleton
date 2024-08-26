function result = sumBigMatrix()
    % sumBigMatrix Sum of the big matrix in MAT file cached in the singleton.
    %
    % result = sumBigMatrix()
    % result is a row vector containing the total of the columns of the large matrix.
    %
    % Example:
    %    sumValue = sumBigMatrix();
    %
    % See also: ExampleSingleton

    % Get the singleton instance containing the data
    data = ExampleSingleton.getInstance;

    % Compute the sum of the large matrix from the MAT file
    result = sum(data.BigMatrixFromMATFile);
end