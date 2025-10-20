# sl-xj-lib-data
Data handling classes

The library is a in-memory column store, designed for convenience, not speed, inspired by the Pandas library available in Python. The data are stored in columns, so a table is an array of columns and a column is an array of values. The table object is responsible for maintaining a consistent number of elements across columns. Finally, a damapool is a set of tables and a data pool can be loaded or saved (persisted) with a single call.

The typical use cases are:

- caching UI data before committing to a database
- caching query results, which are then sliced and diced locally

The library is provided as is for free and it is available in a github repo. Please give credit to the author when applicable. 
In the unlikely case someone finds a bug ;), please use github to report the issue.


## About Xojo version
Tested with Xojo 2025 release 2.1 on Mac.



## About series and tables
The library supports three main classes:

- clDataSerie
- clDataTable
- clDataPool

To ease handling of data row, we also have:

- clDataRow


Note that the library handle data by columns, any use of clDataRow means the called method need to transpose some data, which is time consuming.

## About clDataSerie
A serie is mainly a named one-dimension array. Elements of the array are 'variant' in the untype version of the data serie (clDataSerie), see below for more information about type data series. The main purpose of this class is to store column data for clDataTable. 

### How to create a data serie ?
You can create a data serie:

- by creating an empty data serie and adding values
- by creating a populated data serie
- by loading a text file as a row source

### Creating an empty data serie and adding values

```xojo
// Snippet 001

var my_serie As New clDataSerie("some_values")

my_serie.AddElement("abcd")
my_serie.AddElement("efgh")
...


```


### Creating a populated data serie

Depending on your version of Xojp, you may need use the helper function make\_variant_array() as follow:

```xojo
// Snippet 002

var my_serie As New clDataSerie("some_values", VariantArray("aaa",123,True))

 
```
In recent version of Xojo, you can directly write:

```xojo
// Snippet 003

var my_serie As New clDataSerie("some_values", "aaa",123,True)

 
```


### Loading a data serie from a file
Note that one line in the source file creates one element in the data serie. There are no processing of field delimiter, separators, ... 
(see also loading a data table from a file)

```xojo
// Snippet 004

var fld_file as FolderItem
...

var my_serie  As  clDataSerie = clDataSerie(append_textfile_to_DataSerie(fld_file, new clDataSerie(""), true))

```
### Typed data series
The default data series is a child class of clAbstractDataSerie and stores values as variant. The following type specific data series are provided by the library:

- data series index
- integer data serie
- double data serie
- boolean data serie
- string data serie
- compressed string data serie
- date date serie
- datetime data serie

When you convert an element to/from a number or to a string:

- clDataSerie only provide an element as a variant, it is the caller responsibility to handle the conversion

- clIntegerDataSerie(), clNumberDataSerie() to string: the library uses the default conversion provided by Xojo, unless you define a corresponding formatter

- clIntegerDataSerie(), clNumberDataSerie() from string: the library uses the default conversion provided by Xojo, unless you define a corresponding parser

- clStringDataSerie() to integer or number: the library uses the default conversion provided by Xojo, unless you define a corresponding parser

- clStringDataSerie() from integer or number: the library uses the default conversion provided by Xojo

Please also refer to the file ‘README-Conversion.md’ in the documentation folder in the source tree.


#### about data serie index clDataSerieIndex
(subclass of clDataSerie)
This class is only used to maintain the record index stored in tables. The value is automatically set to the next value of a counter. 

The value passed as parameter to methods like AddElement(), set_element() are ignored.

#### integer data serie clIntegerDataSerie
Elements of the data serie are integer. A type specific get_element_as_integer() function returns an integer instead of a variant.
Arithmetic operators (+, _, - ) have been overloaded.
Operators +, - and * are overloaded using a constant or another integer data serie as second operanda

#### double data serie clNumberDataSerie
Elements of the data serie are double. A type specific get_element_as_number() function returns a double instead of a variant.
Arithmetic operators (+, _, - ) have been overloaded.
Functions like count(), count_non_zero(), average(), average_non_zero(), standard_deviation(), standard_deviation_non_zero()  are reimplemented for clNumberDataSerie to exclude invalid numbers and infinite numbers.
Operators +, - and * are overloaded using a constant or another number data serie as second operand.


#### boolean data serie clBooleanDataSerie
Elements of the data serie are boolean. A type specific get_element_as_boolean() function returns a boolean instead of a variant.
Boolean operators (and, or, not ) have been overloaded.
Operators ‘or’, ‘and’ and ‘not’ are overloaded using another boolean data serie as second operand.


#### string data serie clStringDataSerie
Elements of the data serie are string. The data serie exposes basic string handling functions (left, right, mid, text_before, text_after, trim,…)

#### compressed string data serie clCompressedDataSerie
The data serie stores it value in a string compressed form. Each cell in the column is an integer, an index to an array of values. Use this data serie instead of the standard data serie when a large number of rows contains only a few distinct values, for example a country name in a large invoice dataset. Those operations are totally transparent. You add strings to the compressed data serie and the clCompressedDataSerie handles the conversion behind the scene. 


#### date data serie clDateDataSerie
This data series stores its value as DateTime, but the time part is not used. The data serie provide date related method to extract day, month, year…. Value as integer data serie.

#### dateTime data serie clDateTimeDataSerie
This data series stores its value as DateTime. The data serie provide date related method to extract day, month, year…. Value as integer data serie, and time related methods to extract hours, minutes, …. Values as integer data serie.

## About clDataTable
A data table is a collection of data series. 

The library support common basic operations on a data table:

- add column
- add row
- filter rows
- iterate over rows
-  iterate over rows with filter
- grouping
- sorting
- pivot and unpivot
- loopup
- inner joins
- outer joins
-  …

Some operations are implemented using transformers available as a set of distinct classes.

A table can be a view on another table, we means we use a subset of the columns of the underlying table without data duplication. 


### How to create a data table ?
You can create a data table in any of the following ways:

- create an empty table, add columns then add rows one by one
- create a table from a set of data series
- load from a text file

### Create an empty table, adding columns then adding rows

```xojo

var my_table As New clDataTable("table_1")

```


### Create a table from a set of data series

```xojo
// Snippet 005

var my_serie1 As New clDataSerie("customer")
var my_serie2 As New clDataSerie("product")
var my_serie3 As New clDataSerie("region")


// populate the series
my_serie1.AddElement(...)
...
my_serie3.AddElement(...)


var my_table As New clDataTable("mytable1", SerieArray(my_serie1, my_serie2))

```

A shorter way to do it:

```xojo
// Snippet 006

var my_table As New clDataTable("mytable", SerieArray( _
New clDataSerie("City",  "F1","F2","B1","F1","B2","I1") _
, New clDataSerie("Country", "FR","FR","BE","FR","BE","IT") _
, New clDataSerie("Year", 2000,2000,2000,2000,2000,2000) _
, New clDataSerie("Sales", 100,200,300,400,500,600) _
, New clDataSerie("Quantity", 51, 52,53,54, 55,56) _
))
```


If you need to create multiple tables from the same data series, remember that a data serie can only belong to one data table. You can tell the constructor to clone data series as required, by setting the parameter auto\_clone\_columns to true (see creation of mytable_2 below) Note that only my_serie1 will be cloned.


```xojo
// Snippet 007

var my_serie1 As New clDataSerie("customer")
var my_serie2 As New clDataSerie("product")
var my_serie3 As New clDataSerie("region")


// populate the series
my_serie1.AddElement(...)
...

var my_table1 As New clDataTable("mytable1", SerieArray(my_serie1, my_serie2))

var my_table2 As New clDataTable("mytable1", SerieArray(my_serie1, my_serie3), True)
```

Note the last parameter for the second call to the constructor: it is telling the constructor to clone the data serie if it belongs to another table. In the example, my_serie1 will be cloned.


### Operations on columns (data series)



This will create a new column, named 'unit_price*quantity':

```xojo
// Snippet 008

var mytable As New clDataTable("T1")

call mytable.AddColumn(new clDataSerie("name"))
call mytable.AddColumn(new clNumberDataSerie("quantity"))
call mytable.AddColumn(new clNumberDataSerie("unit_price"))

....
// add data to the table
....

// Base syntax (the column will be named ‘unit_price*quantity’)
call mytable.AddColumn(clNumberDataSerie(mytable.GetColumn("unit_price")) * clNumberDataSerie(mytable.GetColumn("quantity")))


// simplified syntax:
call mytable.AddColumn(mytable.GetNumberColumn("unit_price") * mytable.GetNumberColumn("quantity"))


// If the target column exists in the table
call mytable.AddColumn(new clNumberDataSerie("total"))
Call mytable.SetColumnValues("total", mytable.GetNumberColumn("unit_price") * mytable.GetNumberColumn("quantity"))


```

### Add row by row


#### by position

```xojo
// Snippet 009

var mytable As New clDataTable("mytable")

call mytable.AddColumns(Array("country","city","sales"))

mytable.AddRow(Array("France","Paris",1100))
mytable.AddRow(Array("France","Marseille",1200))
mytable.AddRow(Array("Belgique","Bruxelles",1300))

```
Note that the constructor of the clDataTable receives the list of columns to create, since adding a row from a dictionary will only update existing columns.


#### using clDataRow
This option is slower, but safer.

```xojo
// Snippet 010

var mytable As New clDataTable("T1")

call mytable.AddColumn(new clDataSerie("name"))
call mytable.AddColumn(new clNumberDataSerie("quantity"))
call mytable.AddColumn(new clNumberDataSerie("unit_price"))

// ...

var temp_row as clDataRow

// ...
temp_row = New clDataRow
temp_row.SetCell("name","alpha")
temp_row.SetCell("quantity",50)
temp_row.SetCell("unit_price",6)
mytable.AddRow(temp_row)

temp_row = New clDataRow
temp_row.SetCell("name","alpha")
temp_row.SetCell("quantity",20)
temp_row.SetCell("unit_price",8)
mytable.AddRow(temp_row)

```

You can also pass a dictionary:

```xojo
// Snippet 011

var mytable As New clDataTable("T1")

call mytable.AddColumn(new clDataSerie("name"))
call mytable.AddColumn(new clNumberDataSerie("quantity"))
call mytable.AddColumn(new clNumberDataSerie("unit_price"))

mytable.AddRow(new Dictionary("name": "alpha", "quantity":50, "unit_price": 6))
mytable.AddRow(new Dictionary("name": "alpha", "quantity":20, "unit_price": 8))

```


Or directly define the values:

```xojo
// Snippet 012

var mytable As New clDataTable("T1")

call mytable.AddColumn(new clDataSerie("name"))
call mytable.AddColumn(new clNumberDataSerie("quantity"))
call mytable.AddColumn(new clNumberDataSerie("unit_price"))

mytable.AddRow("name": "alpha", "quantity":50, "unit_price": 6)
mytable.AddRow("name": "alpha", "quantity":20, "unit_price": 8)

```



### Load a data table from file

Create a folder item pointing to the file, then create the data table. The flag causes the method to use the values in the first row as field names. By default, the reader assumes utf-8 encoded, tab separated file. We need to alter the default settings for a coma-separated file.

```xojo
// Snippet 013

var data_folder as FolderItem
var my_file as FolderItem

// Setup data_folder to point to the folder containing the data file

my_file  = data_folder.Child("myfile3_10K_comma.txt")


var my_table As New clDataTable(new clTextReader(my_file, True, new clTextFileConfig(",")))


```
Note that you can override the default allocation of clDataSerie by providing a column allocator, a method receiving a column name and returning a subclass of clAbstractDataSerie.


### Operations on data tables

#### add a table to another table

Assuming mytable1 contains

- 'name'
- ‘first-name'

Assuming mytable2 contains 

- ‘name'
- ‘birthyear'

Assuming mytable3 contains 

- ‘name'
- ‘phone-nbr'


```xojo
// Snippet 014

var myTable1, myTable2, myTable3 as clDataTable

mytable1.AddTableData(mytable2, clDataTable.AddRowMode.CreateNewColumn)

mytable1.AddTableData(mytable3, clDataTable.AddRowMode.IgnoreNewColumn)



```

After those two calls: mytable1 contains all the rows from the three tables. 
The first import also adds the column 'birthyear' since the insert mode is set to ‘CreateNewColumn’.


#### iterate a table row by row

```xojo
// Snippet 015

var mytable as clDataTable

// add the table data

for each row as clDataRow in mytable
  for each cell as string in row
    system.DebugLog("field " + cell + "value " + row.GetCell(cell))
    
  next
  
next

```

Remember that clDataTable maintains a distinct column that is a row index. You cannot access this column directly, but you can include its value in the clDataRow object returned by the row iterator:


```xojo

mytable.IndexVisibleWhenIterating(True)

```

#### aggregation

Assuming the table table_customer contains sales by customer, together with the customer country, the following statement returns the total sales per country:

```xojo
// Snippet 016

var table_Customers as clDataTable

// Add data to table_customers 

var table_country As clDataTable = table_customers.groupby(StringArray("Country"), StringArray("Sales"))

```

### filtering

Let's consider the following example:

```xojo
// Snippet 017

var MyTable As New clDataTable("mytable")

call MyTable.AddColumns(Array("country","city","sales"))

MyTable.AddRow(Array("France","Paris",1100))
MyTable.AddRow(Array("France","Marseille",1200))
MyTable.AddRow(Array("Belgique","Bruxelles",1300))
MyTable.AddRow(Array("USA","NewYork",1400))
MyTable.AddRow(Array("Belgique","Bruxelles",1500))
MyTable.AddRow(Array("USA","Chicago",1600))

var is_france() as variant = MyTable.ApplyFilterFunction(AddressOf BasicFieldFilter,"country","France")
var is_belgium() as variant =  MyTable.ApplyFilterFunction(AddressOf BasicFieldFilter, "country","Belgique")
var is_europe() as variant

for i as integer = 0 to is_france.Ubound
  is_europe.Append(is_france(i).integerValue + is_belgium(i).integerValue)
  
next

call MyTable.AddColumn(new clIntegerDataSerie("is_france"))
call MyTable.AddColumn(new clIntegerDataSerie("is_belgium"))
call MyTable.AddColumn(new clIntegerDataSerie("is_europe"))

call MyTable.SetColumnValues("is_france", is_france, false)
call MyTable.SetColumnValues("is_belgium", is_belgium, false)
call MyTable.SetColumnValues("is_europe", is_europe, false)


```

The function table.FilterWithFunction() returns an array of variant, one element corresponds to one row in the table, the element is true if the filter function passed as parameter returns 'true' when processing the record.

The filter function BasicFieldFilter(fieldname, fieldvalue) returns True if the field fieldname has the value fieldvalue, the function receives the current row to apply the test (more details under 'About filter function')


The resulting arrays are then saved to new columns using the function 'set_column_value'


#### About filter function

A filter function has the following prototype:

```xojo

Function xyz(the_row_index as integer, the_row_count as integer, the_column_names() as string, the_cell_values() as variant, paramarray function_param as variant) As Boolean
```

The array function_param receives the additional parameters passed to FilterWithFunction()

For example, the function BasicFieldFilter() used before has the following implementation:

```xojo

		Function BasicFieldFilter(the_row_index as integer, the_row_count as integer, the_column_names() as string, the_cell_values() as variant, paramarray function_param as variant) As Boolean
		  var field_name as string = function_param(0)
		  var field_value as variant = function_param(1)
		  
		  var idx as integer = the_column_names.IndexOf(field_name)
		  
		  return the_cell_values(idx) = field_value
		End Function

```

The parameters the_row_index, the_row_count, the_column_names(), the_cell_values() are populated by FilterWithFunction() when it calls the filter_function().

### filtering using a masking column (boolean column)

Let's consider the following example:

```xojo
 
// Snippet 018

var MyTable As New clDataTable("mytable")

call MyTable.AddColumns(Array("country","city","sales","product"))

MyTable.AddRow(Array("France","Paris",1100,"AA"))
MyTable.AddRow(Array("","Marseille",1200,"AA"))
MyTable.AddRow(Array("Belgique","",1300,"AA"))
MyTable.AddRow(Array("USA","NewYork",1400,"AA"))
MyTable.AddRow(Array("Belgique","Bruxelles",1500,"BB"))
MyTable.AddRow(Array("USA","Chicago",1600,"AA"))

var filter_country as new clBooleanDataSerie("mask_country")
for each cell as string in MyTable.GetColumn("Country")
  filter_country.AddElement(cell = "Belgique")
  
next

call MyTable.AddColumn(filter_country)

var filter_product as new clBooleanDataSerie("mask_product")
for each cell as string in MyTable.GetColumn("product")
  filter_product.AddElement(cell = "BB")
  
next

call MyTable.AddColumn(not filter_product)

MyTable.IndexVisibleWhenIterating(True)

// use the name of the boolean serie as parameter to 'filtered_on' 

for each row as clDataRow in MyTable.FilteredOn("mask_country")
  // … do something
next
```

### filtering using a masking data serie (boolean data serie)

The boolean data serie does not need to be a column in the table, see example below (using the same data table)
Note in this example the use of boolean operator between boolean data series.

```xojo
/// Snippet 019

var MyTable as clDataTable

// add data to the table  ...

var filter_country as new clBooleanDataSerie("mask_country")
for each cell as string in MyTable.GetColumn("Country")
  filter_country.AddElement(cell = "Belgique")
  
next 

var filter_product as new clBooleanDataSerie("mask_product")
for each cell as string in MyTable.GetColumn("product")
  filter_product.AddElement(cell = "BB")
  
next 

'
' The filter series are not added to the table, but we can used them to filter the datatable

MyTable.IndexVisibleWhenIterating(True)

' directly use the  boolean serie as parameter to ‘FilteredOn; and, or and not operator are overloaded for clBooleanDataSerie

for each row as clDataRow in MyTable.FilteredOn(filter_country and filter_product)
  // … do something
next
```


### Virtual data table
A data table is virtual when it does not have its own set of columns, but uses columns managed by anoter data table. If you assume a data table is a table in a database engine, then a virtual data table is a view on a subset of columns. Adding rows to a view adds rows to the physical table. 

A virtual data table is returned by the data table method select_columns()

```xojo

var my_virtual_table as clDataTable = MyTable.SelectColumns(array("customer","product"))

```

### An example for string handling

We have a dataset with two columns:

- source: which contains country-city
- sales: which contains sales for the source

We want to get:

- split source column into country and city columns
- get total sales per country
- get unique pairs of country / city


Creation of the test dataset

```xojo
// Snippet 020

Var col_source as new clStringDataSerie("source", "France-Paris","Belgique-","Belgque-Bruxelles", "USA-NewYork", "USA-Chicago", "France-Marseille")
var col_sales as new clNumberDataSerie("sales", 1000,1100, 1200, 1300, 1400, 1500)

var table1 as new clDataTable("source table", SerieArray(col_source, col_sales))

```

Creation of a new table, with split columns

```xojo
// Snippet 021

// defined in previous snippet:
Var col_source as new clStringDataSerie("source")
var col_sales as new clNumberDataSerie("Sales")

var table2 as new clDataTable("prepared", SerieArray( _
col_source, _
col_source.TextBefore("-").Rename("country"), _
col_source.TextAfter("-").Rename("city"), _
col_sales),_
true)


```
Getting the total sales per country

```xojo
// Snippet 022

// defined in previous snippet:
var table2 as clDataTable


var table4 As clDataTable = table2.GroupBy(StringArray("country"), StringArray("sales"))

```

### Updating columns

Use GetColumn() to get access to a columns.
Use SetColumnValues() to update a column.

Use simplified syntax for common cases.


```xojo
// Snippet 023

var MyTable as new clDataTable("mytable")

Var MyColumn as clAbstractDataSerie = MyTable.GetColumn("name")

// Create a new column if needed
Var updated_column as clAbstractDataSerie =  MyTable.SetColumnValues("another_column", MyColumn, True)

// Do not create a new column and ignore the returned value
Call MyTable.SetColumnValues("another_column", MyColumn, False)

// Use simple syntax, target column must exist
MyTable.Column("another_column") =  MyColumn

//
// Another example
// 

// Create a column
call MyTable.AddColumn(new clNumberDataSerie("Total"))

// Update the column with     a constant value
MyTable.Column("Total") =  0

// Update the column from other columns
MyTable.column("Total") = clNumberDataSerie(MyTable.Column("Total")) + clNumberDataSerie(MyTable.Column("something"))


// Add a column with unit_price x quantity
var new_column as clAbstractDataSerie = mytable.AddColumn(mytable.GetNumberColumn("unit_price") * mytable.GetNumberColumn("quantity"))


```
 

## About validation

(To update)

## About clDataPool
A data pool is a collection of named clDataTable. By default, the name in the pool is the name of the clDataTable, but an alternate name (key) can be provided without affecting the name of the table.

```xojo
// Snippet 024

var dtp as new clDataPool
var table as clDataTable
//
// Add a table to the pool
//
// . create table as a clDataTable, with name T1
//
dtp.SetTable(table)

//

dtp.SetTable(dtp.GetTable("T1").clone(), "res")
//
// ...
//
```


Alternate, simplified interface:

```xojo
// Snippet 025

var mytable as clDataTable
var dtp as new clDataPool
//
// Add a table to the pool
//
// . create table as a clDataTable, with name T1
//
dtp.table = mytable

//

dtp.table("res") = dtp.table("T1").clone()
//
// ...
//
```


Saving all tables in the pool as data file

```xojo
Todo

```


## Description of source tree

The repo contains the following folders:

- documentation
- imported libraries
- lib-data
- lib-data (experimental)
- lib-data-examples
- lib-data-io
- lib-data-tests
- lib-data-ui-support
- test-data


### folder documentation
The folder contains more information about 

- conversion from and to string 
- range formatting (for example format the values in a clNumberDataColumn as ‘HIGH’, ‘MEDIUM’, ‘LOW’ based on ranges of values)
- how to use the example viewer integrated in the test program


### folder imported_libraries
Libraries I imported from other projects, currently

- lib-loving imported from ‘sl-xj-lib-loging’ (also available on github)


### folder lib-data
This is the core library. It provides support for data series, data tables and data pool. It is all you need in most cases.


## folder lib-data (experimental)
This folder contains experimental components.  

Subfolders of lib-data:

- data-common
- data-grouper-and-sorter
- date-parsers-and-formatters
- data-pool
- data-rows
- data-series
- data-series-io
- data-tables
- data-table-transformer
- data-table-io
- data-validation
- database-access

### subfolder data-common
The folder contains

- enumerations used in the source tree
- basic math functions
- metadata handling (used for data series and data tables)
- helper functions

### subfolder data-grouper-and-sorter
Contains classes used to sort and group values.

### subfolder date-parsers-and-formatters
The folder contains

- parser and formatter for boolean values
- parser and formatter for integer values
- parser and formatter for double values


### subfolder  data-pool
Handling of data pool

###  subfolder  data-rows
Handling of data row. Remember using data rows when iterating over a data table is convenient but slow.


### subfolder  data-series-io
The folder contains methods to read and write data series to text file.

### subfolder  data-series
Handling of data series (clAbstractDataSerie and al its child classes)


### subfolder  data-tables
Handling of data tables

### subfolder  data-table-transformer
Classes reading data from one or multiple data table, applying a transformation and producing one or more output data tables. Used internally by clDataTable to group, sort, join, …

There are examples showing how to use a transformer directly.


### subfolder  data-table-io
Reading and writing the content of a data table to text files, database table, …

### subfolder  data-validation
Experimental components to support data validation

## folder lib-data-examples
Examples used in the main test program. Each example can be launched from the example window. A generic window designed to display the content of an array of data table is used to show the results.

## folder lib-data-tests
The folder contains the test cases for data series and data tables

## folder lib-data-ui-support
This folder contains ‘data table’ aware components.


## folder test-data
Test files used by some test cases
 