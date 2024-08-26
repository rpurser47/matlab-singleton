function result = medianBigMatrix()
    % medianBigMatrix Median of the big matrix in MAT file cached in the singleton.
    %
    % result = medianBigMatrix()
    % result is a row vector containing the median value of the columns of the large matrix.
    %
    % Example:
    %    medianValue = medianBigMatrix();
    %
    % See also: ExampleSingleton

    % Get the singleton instance containing the data
    theInstance = ExampleSingleton.getInstance;
    
    % Compute the median of the large matrix from the MAT file
    result = median(theInstance.BigMatrixFromMATFile);
end