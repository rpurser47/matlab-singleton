function result = sumBigMatrix()
    %SUMBIGMATRIX Return the sum from the big matrix from the MAT file that is cached in the singleton.
    data = ExampleSingleton.getInstance;
    result = sum(data.BigMatrixFromMATFile);
end