# sl-xj-lib-data
Data handling classes

- About series and tables
- Description of source tree


About Xojo version: tested with Xojo 2024 release 1.1 on Mac.



## About series and tables
The library supports three main classes:

- clDataSerie
- clDataTable
- clDataPool

Note: the methods used to read and write data to files will be moved out of the core library.


## About clDataSerie
A serie is mainly a named one-dimension array. Elements of the array are 'variant'. The main purpose of this class is to store column data for clDataTable. 

### How to create a data serie ?
You can create a data serie:

- by creating an empty data serie and adding values
- by creating a populated data serie
- by loading a text file as a row source

### Creating an empty data serie and adding values

```xojo

dim my_serie As New clDataSerie("some_values")

my_serie.AddElement("abcd")
my_serie.AddElement("efgh")
...


```


### Creating a populated data serie

Depending on your version of Xojp, you may need use the helper function make\_variant_array() as follow:

```xojo

dim my_serie As New clDataSerie("some_values", VariantArray("aaa",123,True))

 
```
In recent version of Xojo, you can directly write:

```xojo

dim my_serie As New clDataSerie("some_values", "aaa",123,True)

 
```


### Loading a data serie from a file
Note that one line in the source file creates one element in the data serie. There are no processing of field delimiter, separators, ... 
(see also loading a data table from a file)

```xojo

dim fld_file as FolderItem
...

dim my_serie  As  clDataSerie = clDataSerie(append_textfile_to_DataSerie(fld_file, new clDataSerie(""), true))

```
### Typed data series
The default data series stores values as variant.

- data series index
- integer data serie
- double data serie
- boolean data serie
- string data serie
- compressed data serie

#### About data serie index clDataSerieIndex
(subclass of clDataSerie)
This class is only used to maintain the record index stored in tables. The value is automatically set to the next value of a counter. 

The value passed as parameter to methods like AddElement(), set_element() are ignored.

#### integer data serie clIntegerDataSerie
Elements of the data serie are integer. A type specific get_element_as_integer() function returns an integer instead of a variant.
Arithmetic operators (+, _, - ) have been overloaded.

#### double data serie clNumberDataSerie
Elements of the data serie are double. A type specific get_element_as_number() function returns a double instead of a variant.
Arithmetic operators (+, _, - ) have been overloaded.
Functions like count(), count_non_zero(), average(), average_non_zero(), standard_deviation(), standard_deviation_non_zero()  are reimplemented for clNumberDataSerie to exclude invalid numbers and infinite numbers.


#### boolean data serie clBooleanDataSerie
Elements of the data serie are boolean. A type specific get_element_as_boolean() function returns a boolean instead of a variant.
Boolean operators (and, or, not ) have been overloaded.


#### string data serie clStringDataSerie
Elements of the data serie are string. The data serie exposes basic string handling functions (left, right, mid, text_before, text_after, trim,…)

#### compressed data serie clCompressedDataSerie
The data serie stores it value in a string compressed form. Each cell in the column is an integer, an index to an array of values. Use this data serie instead of the standard data serie when a large number of rows contains only a few distinct values, for example a country name in a large invoice dataset.

## About clDataTable
A data table is a collection of data series. 


### How to create a data table ?
You can create a data table in any of the following ways:

- create an empty table, add columns then add rows one by one
- create a table from a set of data series
- load from a text file

### Create an empty table, adding columns then adding rows

```xojo

dim my_table As New clDataTable("table_1")

```


### Create a table from a set of data series

```xojo
Dim my_serie1 As New clDataSerie("customer")
Dim my_serie2 As New clDataSerie("product")
Dim my_serie3 As New clDataSerie("region")


// populate the series
my_serie1.AddElement(...)
...
my_serie3.AddElement(...)


Dim my_table As New clDataTable("mytable1", SerieArray(my_serie1, my_serie2))

```

A shorter way to do it:

```xojo

Dim my_table As New clDataTable("mytable", SerieArray( _
New clDataSerie("City",  "F1","F2","B1","F1","B2","I1") _
, New clDataSerie("Country", "FR","FR","BE","FR","BE","IT") _
, New clDataSerie("Year", 2000,2000,2000,2000,2000,2000) _
, New clDataSerie("Sales", 100,200,300,400,500,600) _
, New clDataSerie("Quantity", 51, 52,53,54, 55,56) _
))
```


If you need to create multiple tables from the same data series, remember that a data serie can only belong to one data table. You can tell the constructor to clone data series as required, by setting the parameter auto\_clone\_columns to true (see creation of mytable_2 below) Note that only my_serie1 will be cloned.


```xojo
Dim my_serie1 As New clDataSerie("customer")
Dim my_serie2 As New clDataSerie("product")
Dim my_serie3 As New clDataSerie("region")


// populate the series
my_serie1.AddElement(...)
...

Dim my_table1 As New clDataTable("mytable1", SerieArray(my_serie1, my_serie2))

Dim my_table2 As New clDataTable("mytable1", SerieArray(my_serie1, my_serie3), True)
```

Note the last parameter for the second call to the constructor: it is telling the constructor to clone the data serie if it belongs to another table. In the example, my_serie1 will be cloned.


### Operations on columns (data series)



This will create a new column, named 'unit_price*quantity':

```xojo

Dim mytable As New clDataTable("T1")

call mytable.AddColumn(new clDataSerie("name"))
call mytable.AddColumn(new clNumberDataSerie("quantity"))
call mytable.AddColumn(new clNumberDataSerie("unit_price"))
....

call mytable.AddColumn(clNumberDataSerie(mytable.GetColumn("unit_price")) * clNumberDataSerie(mytable.GetColumn("quantity")))


```

### Add row by row


#### by position

```xojo
Dim mytable As New clDataTable("mytable")

call mytable.AddColumns(Array("country","city","sales"))

mytable.AddRow(Array("France","Paris",1100))
mytable.AddRow(Array("France","Marseille",1200))
mytable.AddRow(Array("Belgique","Bruxelles",1300))

```

#### using clDataRow
This option is slower, but safer.

```xojo

call mytable.AddColumn(new clDataSerie("name"))
call mytable.AddColumn(new clNumberDataSerie("quantity"))
call mytable.AddColumn(new clNumberDataSerie("unit_price"))


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



### Load a data table from file

Create a folder item pointing to the file, then create the data table. The flag causes the method to use the values in the first row as field names. By default, the reader assumes utf-8 encoded, tab separated file. We need to alter the default settings for a coma-separated file.

```xojo

my_file  = data_folder.Child("myfile3_10K_comma.txt”)

Dim my_table As New clDataTable(new clTextReader(my_file, True, new clTextFileConfig(“,”)))

```
Note that you can override the default allocation of clDataSerie by providing a column allocator, a method receiving a column name and returning a subclass of clAbstractDataSerie.


### Operations on data tables

#### add a table to another table

Assuming mytable1 contains 'name' and 'first-name', mytable2 contains 'name' and 'birthyear', mytable3 contains 'name' and 'phone-nbr'


```xojo

mytable1.AddColumns(mytable2, true)

mytable1.AddColumns(mytable3, false)

```

After those two calls: mytable1 contains all the rows from the three tables. The first import also adds the column 'birthyear' since the flag 'create\_missing_columns' is set to true. 


#### iterate a table row by row

```xojo
for each row as clDataRow in mytable
  for each cell as string in row
    system.DebugLog("field " + cell + "value " + row.get_cell(cell))
    
  next
  
next
```

Remember that clDataTable maintains a distinct column that is a row index. You cannot access this column directly, but you can include its value in the clDataRow object returned by the row iterator:


```xojo
mytable.index_visible_when_iterate(True)

```

#### aggregation

Assuming the table table_customer contains sales by customer, together with the customer country, the following statement returns the total sales per country:


```xojo
Dim table_country As clDataTable = table_customer.groupby(StringArray("Country"), StringArray("Sales"), StringArray(""))
```

### filtering

Let's consider the following example:

```xojo
Dim table0 As New clDataTable("mytable")

call table0.AddColumns(Array("country","city","sales"))

table0.AddRow(Array("France","Paris",1100))
table0.AddRow(Array("France","Marseille",1200))
table0.AddRow(Array("Belgique","Bruxelles",1300))
table0.AddRow(Array("USA","NewYork",1400))
table0.AddRow(Array("Belgique","Bruxelles",1500))
table0.AddRow(Array("USA","Chicago",1600))

dim is_france() as variant = table0.FilterWithFunction(AddressOf BasicFieldFilter,"country","France")
dim is_belgium() as variant =  table0.FilterWithFunction(AddressOf BasicFieldFilter, "country","Belgique")
dim is_europe() as variant

for i as integer = 0 to is_france.Ubound
  is_europe.Append(is_france(i).integerValue + is_belgium(i).integerValue)
  
next

call table0.AddColumn(new clIntegerDataSerie("is_france"))
call table0.AddColumn(new clIntegerDataSerie("is_belgium"))
call table0.AddColumn(new clIntegerDataSerie("is_europe"))

call table0.SetColumnValues("is_france", is_france, false)
call table0.SetColumnValues("is_belgium", is_belgium, false)
call table0.SetColumnValues("is_europe", is_europe, false)


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
		  dim field_name as string = function_param(0)
		  dim field_value as variant = function_param(1)
		  
		  dim idx as integer = the_column_names.IndexOf(field_name)
		  
		  return the_cell_values(idx) = field_value
		End Function

```
The parameters the_row_index, the_row_count, the_column_names(), the_cell_values() are populated by FilterWithFunction() when it calls the filter_function().

### filtering using a masking column (boolean column)

Let's consider the following example:

```xojo
 
Dim table0 As New clDataTable("mytable")

call table0.AddColumns(Array("country","city","sales","product"))

table0.AddRow(Array("France","Paris",1100,"AA"))
table0.AddRow(Array("","Marseille",1200,"AA"))
table0.AddRow(Array("Belgique","",1300,"AA"))
table0.AddRow(Array("USA","NewYork",1400,"AA"))
table0.AddRow(Array("Belgique","Bruxelles",1500,"BB"))
table0.AddRow(Array("USA","Chicago",1600,"AA"))

dim filter_country as new clBooleanDataSerie("mask_country")
for each cell as string in table0.GetColumn("Country")
  filter_country.AddElement(cell = "Belgique")
  
next

call table0.AddColumn(filter_country)

dim filter_product as new clBooleanDataSerie("mask_product")
for each cell as string in table0.GetColumn("product")
  filter_product.AddElement(cell = "BB")
  
next

call table0.AddColumn(not filter_product)

table0.IndexVisibleWhenIterating(True)


' use the name of the boolean serie as parameter to 'filtered_on' 
for each row as clDataRow in table0.FilteredOn(“mask_country")
  … do something
next

```

### filtering using a masking data serie (boolean data serie)

The boolean data serie does not need to be a column in the table, see example below (using the same data table)
Note in this example the use of boolean operator between boolean data series.

```xojo
dim filter_country as new clBooleanDataSerie("mask_country")
for each cell as string in table0.GetColumn("Country")
  filter_country.AddElement(cell = "Belgique")
  
next 

dim filter_product as new clBooleanDataSerie("mask_product")
for each cell as string in table0.GetColumn("product")
  filter_product.AddElement(cell = "BB")
  
next 

'
' The filter series are not added to the table, but we can used them to filter the datatable

table0.index_visible_when_iterate(True)

' directly use the  boolean serie as parameter to ‘FilteredOn; and, or and not operator are overloaded for clBooleanDataSerie

for each row as clDataRow in table0.FilteredOn(filter_country and filter_product)
 … do something
next

```


### Virtual data table
A data table is virtual when it does not have its own set of columns, but uses columns managed by anoter data table. If you assume a data table is a table in a database engine, then a virtual data table is a view on a subset of columns. Adding rows to a view adds rows to the physical table. 

A virtual data table is returned by the data table method select_columns()

```xojo

my_virtual_table = my_table.SelectColumns(array("customer","product"))


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

dim col_source as new clStringDataSerie("source", "France-Paris","Belgique-","Belgque-Bruxelles", "USA-NewYork", "USA-Chicago", "France-Marseille")
dim col_sales as new clNumberDataSerie("sales", 1000,1100, 1200, 1300, 1400, 1500)

dim table1 as new clDataTable("source table", SerieArray(col_source, col_sales))

```

Creation of a new table, with split columns

```xojo
dim table2 as new clDataTable("prepared", SerieArray( _
col_source, _
col_source.TextBefore(“-“).Rename("country"), _
col_source.TextAfter(“-“).Rename("city"), _
col_sales),_
 true)
```
Getting the total sales per country

```xojo
Dim table4 As clDataTable = table2.GroupBy(StringArray("country"), StringArray("sales"), StringArray(""))
```



## About validation

(To update)

## About clDataPool
A data pool is a collection of named clDataTable. By default, the name in the pool is the name of the clDataTable, but an alternate name (key) can be provided without affecting the name of the table.

```xojo
'
dim dtp as new clDataPool
'
' Add a table to the pool
'
'.. create table as a clDataTable, with name T1
'
dtp.SetTable(table)

'
'
dtp.SetTable(dtp.get_table("T1").clone(), "res")
'
' ...
'
```


Alternate, simplified interface:
```xojo
'
dim dtp as new clDataPool
'
' Add a table to the pool
'
'.. create table as a clDataTable, with name T1
'
dtp.table = table
'
'
dtp.table("res") = dtp.table("T1").clone()
'
' ...

```

Saving all tables in the pool as data file
```xojo
Todo

```


## Description of source tree

The repo contains the following folders:

- lib-data
- lib-data (experimental)
- lib-data-examples
- lib-data-io
- lib-data-tests
- lib-data-ui-support
- test-data


### folder lib-data
This is the core library. It provides support for data series, data tables and data pool. It is all you need in most cases.


## folder lib-data (experimental)
This folder contains experimental components.  

Subfolders of lib-data:

- data-helpers
- data-pool
- data-rows
- data-series
- data-tables
- data-validation

### subfolder data-helpers
Contains helper classes and methods

### subfolder  data-pool
Handling of data pool

###  subfolder  data-rows
Handling of data row. Remember using data rows when iterating over a data table is convenient but slow.

### subfolder  data-series
Handling of data series

### subfolder  data-tables
Handling of data tables

### subfolder  data-validation
Experimental components to support data validation

## folder lib-data-examples
Examples used in the main test program. Each example can be launched from the example window. A generic window designed to display the content of an array of data table is used to show the results.

## folder lib-data-io
All IO support for data series and data tables will utimately move here in future versions.


## folder lib-data-tests
The folder contains the test cases for data series and data tables

## folder lib-data-ui-support
This folder contains ‘data table’ aware components.


## folder test-data
Test files used by some test cases


