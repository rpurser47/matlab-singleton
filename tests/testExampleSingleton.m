% Test suite for ExampleSingleton
% Visit https://www.mathworks.com/help/matlab/matlab_prog/write-simple-test-case-with-functions.html for more info
% to run this, open the project at the root, and type "runtests"

function tests = testExampleSingleton
    tests = functiontests(localfunctions);
end


function setup(~)  % do not change function name
    % Make sure that the singleton does not exist before each test
    delete(ExampleSingleton.getInstance())

    %Suppress display of the pedantic warning while tests are running
    warning('off','ExampleSingleton:loadWarning')
end

function teardown(~)
    %Restore display of the pedantic warning
    warning('on','ExampleSingleton:loadWarning')
end

function testBasicFunctionality(testCase)
    import matlab.unittest.qualifications.Verifiable

    % Verify that the first time its used, the pedantic warning is thrown
    % We have to turn it on for this one test
    w = warning('on','ExampleSingleton:loadWarning');
    verifyWarning(testCase,@()(ExampleSingleton.getInstance()),'ExampleSingleton:loadWarning')
    warning(w); % Restores the warning state

    theInstance = ExampleSingleton.getInstance();

    % Verify that you get an ExampleSingleton, and that it's a handle class
    verifyClass(testCase,theInstance,"ExampleSingleton")
    verifyInstanceOf(testCase,theInstance,"handle")

    % Verify that the property is a double matrix of size 100 x 100
    verifyClass(testCase,theInstance.BigMatrixFromMATFile,"double")
    verifySize(testCase,theInstance.BigMatrixFromMATFile,[100 100])

    % Make sure that the first and second instances returned are one and the same
    secondInstance = ExampleSingleton.getInstance();
    verifySameHandle(testCase,theInstance,secondInstance) 
end

function testToolboxFunctions(testCase)
    theInstance = ExampleSingleton.getInstance();

    % Verify that the function returns the right type, size, and result.
    result = medianBigMatrix();
    verifyClass(testCase,result,"double")
    verifySize(testCase,result,[1 100])
    verifyEqual(testCase,result,median(theInstance.BigMatrixFromMATFile))

    result = sumBigMatrix();
    verifyClass(testCase,result,"double")
    verifySize(testCase,result,[1 100])
    verifyEqual(testCase,result,sum(theInstance.BigMatrixFromMATFile))
end

function testExample(~)
    % Just run the example through, and make sure there are no errors
    % We do evalc to avoid outputting to the commmand window
    evalc("GettingStarted");
end