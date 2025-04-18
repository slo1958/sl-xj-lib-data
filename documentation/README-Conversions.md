
# About data conversion

(Update 2025-04-18)


## clDataSerie

The clDataSerie stores its data as variant. 

- methods like AddElement() and SetElement() expect a variant as parameter 
- the method GetElement() returns a variant.

## Type specific data series

Type specific data serie classes, like clNumberDataSerie, clBooleanDataSerie, … store their values using the native type (double, boolean, …) 

- methods like AddElement() and SetElement() expect a variant as parameter 
-  the method GetElement() returns a variant.

When AddElement() or SetElement() from type specific data series receive a string (a variant of which type is string), they will use the optional parser defined by the user or let Xojo do the conversion if no parser is defined.

When GetElementAsString() from type specific data series is called, it will use the optional formatter defined by the user or let Xojo do the conversion if no formatter is defined.


## Obtaining a value with a given type

The library provides the following methods

- GetElementAsInteger()
- GetElementAsNumber()
- GetElementAsString()

Those methods return the value with the expected type are available for all type specific data serie classes, conversions may be required and an error is generated if a conversion fails.

Default behaviour

The library provides default conversions implemented as follows
- Obtain the value as a variant
- Convert to the expected type
- Return the converted value


## clIntegerDataSerie

### Behaviour of GetElementAsXxx()

GetElementAsInteger() returns the value without any conversion since values are stored as integer

GetElementAsNumber() returns the value converted to a double, using Xojo type conversion

GetElementAsString() returns the value converted to a string as follow:
	if an integer formatter is defined using SetStringFormat(), the formatter is used to format the number
	if there are no integer formatter, v.ToString provided by Xojo is used

There are two formatter classed provided by the library for integer:

- clIntegerFormatting() which uses the format string passed to its constructor to format numbers, using the Xojo str() method
- clIntegerLocalFormatting() which uses the format string passed to its constructor to format numbers, using the Xojo Format() method (using local settings)

Custom formatter are expected to implement two methods:

- FormatInteger(v as integer) as string
- GetInfo() as string


## clNumberDataSerie

### Behaviour of GetElementAsXxx()

GetElementAsInteger() returns the value converted to a integer, using Xojo type conversion

GetElementAsNumber() returns the value without any conversion since values are stored as double

GetElementAsString() returns the value converted to a string as follow:
	if a number formatter is defined using SetStringFormat(), the formatter is used to format the number
	if there are no number formatter, v.ToString provided by Xojo is used

There are two formatter classed provided by the library for number:

-  clNumberFormatting() which uses the format string passed to its constructor to format numbers, using the Xojo str() method
- clNumberLocalFormatting() which uses the format string passed to its constructor to format numbers, using the Xojo Format() method (using local settings)
- clNumberRangeFormatting() which format the number based on ranges. 

Custom formatter are expected to implement two methods:

- FormatNumber(v as double) as string
- GetInfo() as string

