classdef ExampleSingleton < handle
    %ExampleSingleton  Example singleton pattern that loads data from a MAT file once
    %    The singleton design pattern provides a global point of access to a single instance on an object. This pattern is particularly useful for
    %    managing resources such as file handles, database connections, or hardware interfaces, where multiple instances could lead to conflicts or
    %    excessive resource usage. By using a singleton, you can ensure that only one instance of a resource is created and shared across the entire
    %    application, leading to more efficient and manageable code.
    %
    %    This example loads data from a MAT file the first time it's instantiated / created, and makes it available as a property on the object.
    %    Whenever the object is accessed using |ExampleSingleton.getInstance|, the single instance of the class is returned, so that the file is only
    %    loaded once. Any function in a toolbox can get access to the shared data without having to reload the MAT file.
    %
    % Background: https://en.wikipedia.org/wiki/Singleton_pattern
    %             https://medium.com/@bishikh90/design-patterns-in-matlab-part-1-b0dac5dc9eb7

    properties(SetAccess = private)
        BigMatrixFromMATFile;
    end

    methods(Access = private)
        function obj = ExampleSingleton()
            warning("ExampleSingleton:loadWarning","Loading from MAT File")
            fromMATFile = load("ExampleData.mat");
            obj.BigMatrixFromMATFile = fromMATFile.BigMatrix;
        end
    end

    methods(Static)
        function obj = getInstance()
            persistent instance
            if isempty(instance) || ~isvalid(instance)
                instance = ExampleSingleton();
            end
            obj = instance;
        end
    end
end