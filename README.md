# sl-xj-lib-data
Data handling classes

## About series and tables
The library supports three main classes:

- clDataSerie
- clDataTable
- clDataPool


## About clDataSerie
A serie is mainly a named one-dimension array. Elements of the array are 'variant'. The main purpose of this class is to store column data for clDataTable. 

### How to create a data serie ?
You can create a data serie:

- by creating an empty data serie and adding values
- by creating a populated data serie
- by loading a text file

### Creating an empty data serie and adding values

```xojo

dim my_serie As New clDataSerie("some_values")

my_serie.append_element("abcd")
my_serie.append_element("efgh")
...


```


### Creating a populated data serie
You will use the helper function make_variant_array() as follow:

```xojo

dim my_serie As New clDataSerie("some_values", make_variant_array("aaa",123,True))

 
```

### Loading a data serie from a file
Note that one line in the source file creates one element in the data serie. There are no processing of field delimiter, separators, ... 
(see also loading a data table from a file)

```xojo

dim fld_file as FolderItem
...

dim my_serie As New clDataSerie(fld_file)


```
### Typed data series
The default data series stores values as variant.

- data series index
- integer data serie
- double data serie
- boolean data serie
- compressed data serie

#### About data serie index clDataSerieIndex
(subclass of clDataSerie)
This class is only used to maintain the record index stored in tables. The value is automatically set to the next value of a counter. 

The value passed as parameter to methods like append_element(), set_element() are ignored.

#### integer data serie clIntegerDataSerie
Elements of the data serie are integer. A type specific get_element_as_integer() function returns an integer instead of a variant.
Arithmetic operators (+, _, - ) have been overloaded.

#### double data serie clNumberDataSerie
Elements of the data serie are double. A type specific get_element_as_number() function returns an integer instead of a variant.
Arithmetic operators (+, _, - ) have been overloaded.


#### boolean data serie clBooleanDataSerie
Elements of the data serie are boolean. A type specific get_element_as_boolean() function returns an integer instead of a variant.
Boolean operators (and, or, not ) have been overloaded.


#### compressed data serie clCompressedDataSerie
The data serie stores it value in a string compressed form. Each cell in the column is an integer, an index to an array of values. Use this data serie instead of the standard data serie when a large number of rows contains only a few distinct values, for example a country name in a large address book.


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
my_serie1.append_element(...)
...
my_serie3.append_element(...)


Dim my_table As New clDataTable("mytable1", make_serie_array(my_serie1, my_serie2))

```

A shorter way to do it:

```xojo

Dim my_table As New clDataTable("mytable", serie_array( _
New clDataSerie("City",  "F1","F2","B1","F1","B2","I1") _
, New clDataSerie("Country", "FR","FR","BE","FR","BE","IT") _
, New clDataSerie("Year", 2000,2000,2000,2000,2000,2000) _
, New clDataSerie("Sales", 100,200,300,400,500,600) _
, New clDataSerie("Quantity", 51, 52,53,54, 55,56) _
))
```


If you need to create multiple tables from the same data series, remember that a data serie can only belong to one data table. You can tell the constructor to clone data series as required, by setting the parameter auto_clone_columns to true (see creation of mytable_2 below) Note that only my_serie1 will be cloned.


```xojo
Dim my_serie1 As New clDataSerie("customer")
Dim my_serie2 As New clDataSerie("product")
Dim my_serie3 As New clDataSerie("region")


// populate the series
my_serie1.append_element(...)
...

Dim my_table1 As New clDataTable("mytable1", make_serie_array(my_serie1, my_serie2))

Dim my_table2 As New clDataTable("mytable1", make_serie_array(my_serie1, my_serie3), True)
```

Note the last parameter for the second call to the constructor: it is telling the constructor to clone the data serie if it belongs to another table. In the example, my_serie1 will be cloned.


### Operations on columns (data series)



This will create a new column, named 'unit_price*quantity':

```xojo

Dim mytable As New clDataTable("T1")

call mytable.add_column(new clDataSerie("name"))
call mytable.add_column(new clNumberDataSerie("quantity"))
call mytable.add_column(new clNumberDataSerie("unit_price"))
....

call mytable.add_column(clNumberDataSerie(mytable.get_column("unit_price")) * clNumberDataSerie(mytable.get_column("quantity")))


```

### Add row by row


#### by position

```xojo
Dim mytable As New clDataTable("mytable")

call mytable.add_columns(Array("country","city","sales"))

mytable.append_row(Array("France","Paris",1100))
mytable.append_row(Array("France","Marseille",1200))
mytable.append_row(Array("Belgique","Bruxelles",1300))

```

#### using clDataRow
This option is slower, but safer.

```xojo

call mytable.add_column(new clDataSerie("name"))
call mytable.add_column(new clNumberDataSerie("quantity"))
call mytable.add_column(new clNumberDataSerie("unit_price"))


temp_row = New clDataRow
temp_row.set_cell("name","alpha")
temp_row.set_cell("quantity",50)
temp_row.set_cell("unit_price",6)
mytable.append_row(temp_row)

temp_row = New clDataRow
temp_row.set_cell("name","alpha")
temp_row.set_cell("quantity",20)
temp_row.set_cell("unit_price",8)
mytable.append_row(temp_row)

```



### Load a data table from file

Create a folder item pointing to the file, then create the data table. The flag causes the method to use the values in the first row as field names.

```xojo

my_file  = data_folder.Child("myfile3_10K_comma.txt")

Dim my_table As New clDataTable("x")

my_table.load_from_text(my_file, New clRowParser_full(Chr(9)), True)

```
Note that you can override the default allocation of clDataSerie by providing a column allocator, a method receiving a column name and returning a subclass of clAbstractDataSerie.


### Operations on data tables

#### add a table to another table

Assuming mytable1 contains 'name' and 'first-name', mytable2 contains 'name' and 'birthyear', mytable3 contains 'name' and 'phone-nbr'


```xojo

mytable1.append_rows_from_table(mytable2, true)

mytable1.append_rows_from_table(mytable3, false)

```

After those two calls: mytable1 contains all the rows from the three tables. The first import also adds the column 'birthyear' since the flag 'create_missing_columns' is set to true. 


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
Dim table_country As clDataTable = table_customer.groupby(string_array("Country"), string_array("Sales"), string_array(""))
```

### filtering

Let's consider the following example:

```xojo
Dim table0 As New clDataTable("mytable")

call table0.add_columns(Array("country","city","sales"))

table0.append_row(Array("France","Paris",1100))
table0.append_row(Array("France","Marseille",1200))
table0.append_row(Array("Belgique","Bruxelles",1300))
table0.append_row(Array("USA","NewYork",1400))
table0.append_row(Array("Belgique","Bruxelles",1500))
table0.append_row(Array("USA","Chicago",1600))

dim is_france() as variant = table0.apply_filter(AddressOf field_filter,"country","France")
dim is_belgium() as variant =  table0.apply_filter(AddressOf field_filter, "country","Belgique")
dim is_europe() as variant

for i as integer = 0 to is_france.Ubound
  is_europe.Append(is_france(i).integerValue + is_belgium(i).integerValue)
  
next

call table0.add_column(new clIntegerDataSerie("is_france"))
call table0.add_column(new clIntegerDataSerie("is_belgium"))
call table0.add_column(new clIntegerDataSerie("is_europe"))

call table0.set_column_values("is_france", is_france, false)
call table0.set_column_values("is_belgium", is_belgium, false)
call table0.set_column_values("is_europe", is_europe, false)


```

The function table.apply_filter() returns an array of variant, one element corresponds to one row in the table, the element is true if the filter function passed as parameter returns 'true' when processing the record.

The filter function field_filter(fieldname, fieldvalue) returns True if the field fieldname has the value fieldvalue, the function receives the current row to apply the test (more details under 'About filter function')


The resulting arrays are then saved to new columns using the function 'set_column_value'


#### About filter function

A filter function has the following prototype:

```xojo
Function xyz(the_row_index as integer, the_row_count as integer, the_column_names() as string, the_cell_values() as variant, paramarray function_param as variant) As Boolean
```

The array function_param receives the additional parameters passed to apply_filter()

For example, the function field_filter() used before has the following implementation:

```xojo

		Function field_filter(the_row_index as integer, the_row_count as integer, the_column_names() as string, the_cell_values() as variant, paramarray function_param as variant) As Boolean
		  dim field_name as string = function_param(0)
		  dim field_value as variant = function_param(1)
		  
		  dim idx as integer = the_column_names.IndexOf(field_name)
		  
		  return the_cell_values(idx) = field_value
		End Function

```
The parameters the_row_index, the_row_count, the_column_names(), the_cell_values() are populated by apply_filter() when it calls the filter_function().


### Virtual data table
A data table is virtual when it does not have its own set of columns, but uses columns managed by anoter data table. If you assume a data table is a table in a database engine, then a virtual data table is a view on a subset of columns. Adding rows to a view adds rows to the physical table. 

A virtual data table is returned by the data table method select_columns()

```xojo

my_virtual_table = my_table.select_columns(array("customer","product"))


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
dtp.set_table(table)

'
'
dtp.set_table(dtp.get_table("T1").clone(), "res")
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



## About Xojo

Compiled with Xojo 2023 on Mac.
