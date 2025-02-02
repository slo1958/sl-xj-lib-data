# sl-xj-lib-data
Data handling classes

About Xojo version: tested with Xojo 2024 release 4.1 on Mac.

Latest update this document: 2025-02-02


## Adding the library to your project

- open the project test-lib-data
- locate the folder ‘lib-data’
- copy the folder
- paste in your project
- Xojo may expand the folder after pasting, you can collapse it
- If you want to display the content of data table in a form, for example for debugging purposes, repeat this operation for the folder ‘lib-data-ui-support’


## About the project test-lib-data
If you run the project, you will get a window used to run test cases and examples. 
By clicking the button labelled ’See examples’, you can run individual examples and check the results. The UI component used to display the results is ‘wnd\_table_viewer’ available in the folder ‘lib-data-ui-support’.

This window display a list of tables on the left side, the content of the selected table in the middle and the meta data for the current column in the right side. 

## A simple groupby / sum

Assuming we have two arrays, one with some categories, the second with sales data, the purpose of this project is to get the total sales per category.

Create a new method and paste the following code:


```xojo
var SourceTable as new clDataTable("MyTable")

call SourceTable.AddColumn(new clStringDataSerie("Category", Array("3", "1", "3", "2", "1", "2", "3", "2") ))
call SourceTable.AddColumn(new clNumberDataSerie("Sales", Array(20.00, 10.00, 30.00, 25.00, 15.00, 10.00, 20.00, 8.00) ))

var GroupedTable as clDataTable = SourceTable.Groupby(array("Category"), array("Sales"))

for each row as clDataRow in GroupedTable
  
  System.DebugLog("CategoryGroup=" + row.GetCell("Category") + " Sales = " + format(row.GetCell("Sum of Sales").DoubleValue, "-####0.###"))
  
next
```

### What are we doing there ?

- we create an empty table
- add a column with the categories
- add a column with the sales data
- run a groupby operation, the first array indicates the columns to group, the second array indicates the columns to sum
- iterate thru the rows of the calculated table

The method AddColumn() returns the column as a, clAbstractDataSerie. We do not use this returned value, so we use a ‘call’ to tell that to the compiler.

## What if we have a column for quantity and another column for unit price

```xojo
var SourceTable as new clDataTable("MyTable")

call SourceTable.AddColumn(new clStringDataSerie("Category", Array("3", "1", "3", "2", "1", "2", "3", "2") ))

var qtt as clNumberDataSerie  = new clNumberDataSerie("Quantity", array(2,1,3,5,3,1,2,4))
var price as clNumberDataSerie =  new clNumberDataSerie("UnitPrice", array(10,10,10,5,5,10,20,2))

call SourceTable.AddColumn(qtt)
call SourceTable.AddColumn(price)

call  SourceTable.AddColumn(qtt * price)

var GroupedTable as clDataTable = SourceTable.Groupby(array("Category"), array(“Quantity*UnitPrice”))

for each row as clDataRow in GroupedTable
  
  System.DebugLog("CategoryGroup=" + row.GetCell("Category") + " Sales = " + format(row.GetCell("Sum of Sales").DoubleValue, "-####0.###"))
  
next
```

### What are we doing there ?
- we create an empty table
- add a column with the categories
- add a column with the quantity data
- add a column with the price data
- add a column with the sales data calculated from quantity and price
- run a groupby operation, the first array indicates the columns to group, the second array indicates the columns to sum
- iterate thru the rows of the calculated table

Note that the sales column is named ‘Quantity*UnitPrice’. This column is the result of the product of quantity and price, its name is generated automatically. To update its name, change the code to:

```xojo
Var calc as clNumberDataSerie = qtt  * price
calc.Rename("Sales")
call SourceTable.AddColumn(calc)
```

Remembering that the method AddColumn() returns a reference to the column, we can simplify this as follow:

```xojo	
SourceTable.AddColumn(qtt  * price).Rename("Sales")
```

### What if we do not have a reference to the qtt or price columns ?

```xojo
var qtt as clNumberDataSerie = clNumberDataSerie(SourceTable.GetColumn("Quantity"))
var price as clNumberDataSerie = clNumberDataSerie(SourceTable.GetColumn("UnitPrice"))
```

Note that GetColumn() returns a clAbstractDataSerie(), so we need to type cast the value to the proper type (clNumberDataSerie in this case)


## Adding some taxes
Now, we want to calculate taxes on the sales data. The tax rate is fixed.

We can do this as follow:

```xojo
SourceTable.AddColumn(qtt * price * 0.2).Rename("Taxes")
```

The full method is now (you can find this code in Example_032

```xojo
var SourceTable as new clDataTable("MyTable")

call SourceTable.AddColumn(new clStringDataSerie("Category", Array("3", "1", "3", "2", "1", "2", "3", "2") ))
call SourceTable.AddColumn( new clNumberDataSerie("Quantity", array(2,1,3,5,3,1,2,4)))
call SourceTable.AddColumn( new clNumberDataSerie("UnitPrice", array(10,10,10,5,5,10,20,2)))


var qtt as clNumberDataSerie = clNumberDataSerie(SourceTable.GetColumn("Quantity"))
var price as clNumberDataSerie = clNumberDataSerie(SourceTable.GetColumn("UnitPrice"))


SourceTable.AddColumn(qtt  * price).Rename("Sales")
SourceTable.AddColumn(qtt * price * 0.2).Rename("Taxes")

var GroupedTable as clDataTable = SourceTable.Groupby(array("Category"), array("Sales", "Taxes"))
GroupedTable.Rename("Sales per category")

```

## Time for some background information

A data table (clDataTable) is basically an array of data series. The base class for a data serie is clAbstractDataSerie. It does not store anything, it provides all methods that do not depend on the type of data stored in the column. 

When using a method or an operator specific to a column type, you have to type cast the results of GetColumn(), as seen above.

For example, the ‘*’ operator is overloaded for numeric data columns (clIntegerDataSerie and clNumberDataSerie) but does not make a lot of sense for a clDateDataSerie.



