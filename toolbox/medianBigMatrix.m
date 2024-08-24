function result = medianBigMatrix()
    %medianBigMatrix Return the median from the big matrix from the MAT file that is cached in the singleton.
    data = ExampleSingleton.getInstance;
    result = median(data.BigMatrixFromMATFile);
end