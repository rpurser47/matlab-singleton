# Singleton Design Pattern in MATLAB

[![Open in MATLAB Online](https://www.mathworks.com/images/responsive/global/open-in-matlab-online.svg)](https://matlab.mathworks.com/open/github/v1?repo=rpurser47/matlab-singleton&project=matlab-singleton.prj&file=toolbox/GettingStarted.mlx&focus=true)

The [singleton design pattern](https://en.wikipedia.org/wiki/Singleton_pattern) provides a global point of access to a single instance on an object. This pattern is particularly useful in MATLAB&reg; for managing resources such as file handles, database connections, or hardware interfaces, where multiple instances could lead to conflicts or excessive resource usage. By using a singleton, you can ensure that only one instance of a resource is created and shared across the entire application, leading to more efficient and manageable code.

For example, consider a scenario where you need to load a large data file in MATLAB. Using the singleton pattern, you can create a class that loads the data file only once and then provides access to this data throughout your application.

## Example

The singleton in this example, `ExampleSingleton`, has an unusual feature: it throws a warning when it is initially created, which lets us see how it operates.   You get access to the singleton by calling `ExampleSingleton.getInstance()`, which invokes the static method `getInstance` on the `ExampleSingleton` class.  Static methods are functions on the whole class that you can call without creating an object of the class first. The class has a single property, `BigMatrixFromMATFile`, but you can have as many shared resources as you need.

```matlab
theSingleton = ExampleSingleton.getInstance()
```

```matlabTextOutput
Warning: Loading from MAT File
theSingleton = 
  ExampleSingleton with properties:

    BigMatrixFromMATFile: [100x100 double]
```

Since this is the first time the class is created, the warning is shown indicating that the MAT file was loaded.  

Even if we `clear` that variable, and repeat the call to `ExampleSingleton.getInstance()`, the MAT file is not loaded a second time, since the singleton object already exists.  The handle to the global object is returned.

```matlab
clear theSingleton
theSingleton = ExampleSingleton.getInstance()
```

```matlabTextOutput
theSingleton = 
  ExampleSingleton with properties:

    BigMatrixFromMATFile: [100x100 double]
```

If we `delete` the underlying object, it forces the removal of the singleton from memory

```matlab
delete(theSingleton)
```

The next time we call `ExampleSingleton.getInstance()` the file must be reloaded.  But that happens automatically!

```matlab
theSingleton = ExampleSingleton.getInstance()
```

```matlabTextOutput
Warning: Loading from MAT File
theSingleton = 
  ExampleSingleton with properties:

    BigMatrixFromMATFile: [100x100 double]
```

```matlab
delete(theSingleton)
```

Using the singleton pattern, functions across your application can access shared resources.  The `medianBigMatrix` and `sumBigMatrix` functions use `ExampleSingleton.getInstance()` to get access to the `.BigMatrixFromMAT` property.  The first time we call one of the functions, `medianBigMatrix`, the MAT file is loaded.

```matlab
medianBigMatrix
```

```matlabTextOutput
Warning: Loading from MAT File
ans = 1x100
    0.4900    0.4768    0.3995    0.5208    0.5437    0.5070    0.5954    0.5162    0.4379    0.4665    0.5011    0.5378    0.4932    0.4472    0.6125    0.5168    0.5221    0.5073    0.4642    0.5367    0.5075    0.4967    0.5305    0.5174    0.4519    0.5137    0.5361    0.5061    0.4915    0.5507    0.5282    0.5308    0.5212    0.5313    0.5014    0.4871    0.4668    0.5057    0.5396    0.4916    0.5336    0.5387    0.4971    0.4763    0.4972    0.5053    0.5406    0.4712    0.4255    0.4823

```

But when the other function, `sumBigMatrix`, is called, the MAT file does not need to be loaded.

```matlab
sumBigMatrix
```

```matlabTextOutput
ans = 1x100
   47.8637   46.0991   42.6053   50.8013   51.9369   51.9311   57.3730   51.8042   44.7296   47.7700   49.2533   55.7308   49.5907   49.9126   58.5664   48.6605   49.2496   48.9548   49.4461   52.2143   51.7851   49.4310   52.4658   51.3570   48.5629   51.9326   53.7970   51.1076   49.3826   53.9781   52.2792   50.6981   50.6085   51.9865   49.5975   49.3895   48.1099   47.2406   53.0686   48.4215   53.5152   51.7643   48.3104   48.5596   49.7964   52.2751   49.7991   49.5366   43.8886   47.9107

```

Delete the singleton from memory and remove the variable

```matlab
delete(theSingleton)
clear theSingleton
```

## MATLAB Features Used

This demonstrates a number of MATLAB features, including:

* [MATLAB Classes](https://www.mathworks.com/help/matlab/object-oriented-programming.html)
  * [Handle Objects](https://www.mathworks.com/help/matlab/matlab_oop/handle-objects.html)
  * [Static Methods](https://www.mathworks.com/help/matlab/matlab_oop/static-methods.html)
* [MATLAB Projects](https://www.mathworks.com/help/matlab/projects.html)
* [Function Based Unit Tests](https://www.mathworks.com/help/matlab/matlab_prog/write-function-based-unit-tests.html)

## [MathWorks Products](https://www.mathworks.com)

Requires MATLAB release R2020a or newer

## License

The license is available in the `LICENSE` file in this GitHub repository.
