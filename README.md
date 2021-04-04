# sl-xj-lib-data
Data handling classes

## about series and tables
The library supports two main classes:
- clDataSerie
- clDataTable

###clDataSerie
A serie is mainly a named one-dimension array. Elements of the array are 'variant'. The main purpose of this class is to store column data for clDataTable. 

###clDataSerieIndex
(subclass of clDataSerie)
This class is only used to maintain the record index stored in tables. The value is automatically set to the next value of a counter. 


###clDataTable
A data table is a collection of data series. 


###How to create a data table ?
You can create a data table in any of the following ways:
- create an empty table, add columns then add rows one by one
- create a table from a set of data series
- load from a text file

###Create an empty table, adding columns then adding rows

```xojo

dim my_table As New clDataTable("table_1")

```


###Create a table from a set of data series

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




###Virtual data table
A data table is virtual when it does not have its own set of columns, but uses columns managed by anoter data table. If you assume a data table is a table in a database engine, then a virtual data table is a view on a subset of columns. Adding rows to a view adds row to the physical table. 

A virtual data table is returned by the data table method select_columns()

```xojo

my_virtual_table = my_table.select_columns(array("customer","product"))


```