# Running example from  sl-xj-lib-data

Data handling classes

About Xojo version: tested with Xojo 2024 release 4.1 on Mac.

Latest update this document: 2025-04-18


## How to run the examples ?

Run the test project and select the “see examples” button at the bottom of the main window.
 

![Alt text](assets/MainWindow.png?raw=true "")

Scroll thru the list of examples and press “Run” when you find the example you want to run.

![Alt text](assets/ExamplePicker.png?raw=true "")


When you run an example, the test program opens a table viewer populated with all the tables produced by the selected example. We have the following results for Example_027:

![Alt text](assets/Example_027.png?raw=true "")

The listbox on the left contains the name of all the tables.

The listbox in the middle shows the content of the selected table. Since we need strings, numbers are formatted either using the default format provided by the library or custom format defined by your application. The column headers contain the display name of the selected column. This is a DesktopListboxForTable, which can be used independently.

The listbox on the left shows the metadata of the column under the mouse. At least, the metadata contains the name of the column, the title or display name of the column and the type of the column. Most transformations on a column will add information to the metadata. This is done automatically by the library.


## Using the UI elements from the examples in your application

The following assets defined in “Lib-data-ui-support” are used to build this window and can be used in an application:

- The window wnd\_table\_viewer
- The container control ccDataPool_Viewer used display the tables in a data pool.
- The Listbox DesktopListForTable used to display the data in a table

Each example method returns an array of clDataTable.

### Simple method from the examples 

The code is available in example_000.

```xojo

log.start_exec(CurrentMethodName)

var row As clDataRow

var table As New clDataTable("mytable")

// when this new row is added, new columns will be created with proper data type:

row = New clDataRow
row.SetCell("aaa",1234) // aaa will be a clIntegerDataSerie
row.SetCell("bbb","abcd") // bbb will be a clStringDataSerie
row.SetCell("ccc",-1234.457) // ccc will be a clNumberDataSerie
table.AddRow(row)

// when this new row is added, a new column will be added for ddd, but the type is forced to be clDataSerie
row = New clDataRow(new Dictionary("aaa":1235, "bbb":"abce","ddd":23987.6))
table.AddRow(row, clDataTable.AddRowMode.CreateNewColumnAsVariant)

// when this new row is added, the value for eee is ignored, no new column are be added for eee, an error is logged, execution continues
row = New clDataRow(new Dictionary("aaa":1234, "bbb":"abcd","ccc":4321.9, "ddd":678.9,"eee":123))
table.AddRow(row,  clDataTable.AddRowMode.ErrorOnNewColumn)

call table.AddColumn(Table.GetColumn("ccc").Clone("ccc with format"))

clNumberDataSerie(table.GetColumn("ccc with format")).SetStringFormat("-###,##0.000", False) 

log.end_exec(CurrentMethodName)

//
// Send the table to the viewer
//
return array(table)

```

### Moving the results from the example to wnd\_table\_viewer

The reference of each table from the list returned by the example method is passed to  wnd\_table\_viewer using the AddTable() method, as follow:

```xojo

// item is the example method to be called
var tables() as TableColumnReaderInterface = clLibDataExample.RunExample(nil, item)

var wnd as new wnd_table_viewer

wnd.ResetViewer

for each table as TableColumnReaderInterface in tables
  wnd.AddTable(table)
  
next

wnd.Show

```
The description of the example is passed to  wnd\_table\_viewer as follow before the call to wnd.show():

```xojo

var description() as string = clLibDataExample.GetDescription(item)

wnd.ShowComments(description)

wnd.Show

```


### Using in your code

If you plan to reuse the code, do as follow:

```xojo

var tables() as TableColumnReaderInterface

// Create an instance of the window
var wnd as new wnd_table_viewer

wnd.ResetViewer

// Add your tables (or any other TableColumnReaderInterface)

wnd.AddTable(table1)
wnd.AddTable(table2)
  …
wnd.AddTable(tablen)

// create a string array where you can put any relevant info
var description() as string 
wnd.ShowComments(description)

// Show the window
wnd.Show


```
### Using a data pool

If you have all your tables in a data pool, you can call

```xojo
Var  myDataPool as new clDataPool()

… do something


var wnd as new wnd_table_viewer

wnd.ResetViewer
wnd.AddTablesFromPool(myDataPool)
wnd.Show

```



### About the TableColumnReaderInterface

It is an interface implemented by clDataTable but also some date readers presenting the data as data columns. If a data reader implements the TableColumnReaderInterface, it can be added to the ‘tables’ shown in the viewer without the need to explicitly load the data in actual data table. 

clDataTable implements the TableColumnReaderInterface.





