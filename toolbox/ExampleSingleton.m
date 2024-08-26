classdef ExampleSingleton < handle
    %ExampleSingleton  Example singleton pattern that loads data from a MAT file once
    %    The singleton design pattern provides a global point of access to a single instance on an object. This pattern is particularly useful for
    %    managing resources such as file handles, database connections, or hardware interfaces, where multiple instances could lead to conflicts or
    %    excessive resource usage. By using a singleton, you can ensure that only one instance of a resource is created and shared across the entire
    %    application, leading to more efficient and manageable code.
    %
    %    This example loads data from a MAT file the first time it's instantiated / created, and makes it available as a property on the object.
    %    Whenever the object is accessed using ExampleSingleton.getInstance(), the single instance of the class is returned, so that the file is only
    %    loaded once. Any function in a toolbox can get access to the shared data without having to reload the MAT file.
    %
    % Background: https://en.wikipedia.org/wiki/Singleton_pattern
    %             https://medium.com/@bishikh90/design-patterns-in-matlab-part-1-b0dac5dc9eb7
    %
    % A more general implementation of an extensible singleton class: 
    %             https://www.mathworks.com/matlabcentral/fileexchange/24911-design-pattern-singleton-creational

    properties(SetAccess = private)
        % The matrix loaded from the MAT file on creation
        BigMatrixFromMATFile;
    end

    methods(Access = private)
        function obj = ExampleSingleton()
            % ExampleSingleton Private constructor to prevent direct creation.  Call ExampleSingleton.getInstance() to create the singleton.

            % For pedalogical reasons, display a warning message when loading data from the MAT file so people can see when the MAT file is loaded.
            % You would normally never do this.
            warning("ExampleSingleton:loadWarning","Loading from MAT File")
            fromMATFile = load("ExampleData.mat");

            % Store the loaded matrix in the property
            obj.BigMatrixFromMATFile = fromMATFile.BigMatrix;
        end
    end

    methods(Static)
        function obj = getInstance()
            % ExampleSingleton.getInstance Get the singleton 
            % 
            % This ensures that only one instance of a resource is created and shared across the entire application, leading to more efficient and
            % manageable code. getInstance is the traditional name of the method used in computer science to get access to a Singleton.

            % Persistent variable to hold the single instance
            persistent instance

            % Check if the instance is empty (first time run) or deleted
            if isempty(instance) || ~isvalid(instance)
                % Create a new instance if it doesn't exist or is deleted
                instance = ExampleSingleton();
            end

            % Return the single instance
            obj = instance;
        end
    end
end