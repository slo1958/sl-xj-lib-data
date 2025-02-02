#tag Class
Protected Class clLibDataExample
	#tag Method, Flags = &h0
		Function Example_001(log as LogMessageInterface, Describe as boolean, Description() as string) As clDataTable()
		  
		  //
		  //  Example_001 
		  //
		  
		  if Describe then
		    Description.RemoveAll
		    
		    Description.Add(CurrentMethodName)
		    
		    Description.Add("- create an empty datatable")
		    Description.Add("- add three rows")
		    Description.add("- show the impact of the parameters passed to AddRow()")
		    Description.add("- show impact of different format, extracted as clStringDataSerie")
		    
		    return nil
		    
		  end if
		  
		  
		  log.start_exec(CurrentMethodName)
		  
		  var row As clDataRow
		  
		  var table As New clDataTable("mytable")
		  
		  // when this new row is added, new columns will be created with proper data type:
		  // aaa will be a clIntegerDataSerie
		  // bbb will be a clStringDataSerie
		  // ccc will be a clNumberDataSerie
		  row = New clDataRow
		  row.SetCell("aaa",1234)
		  row.SetCell("bbb","abcd")
		  row.SetCell("ccc",-1234.457)
		  table.AddRow(row)
		  
		  // when this new row is added, a new column will be added for ddd, but the type is forced to be clDataSerie
		  row = New clDataRow
		  row.SetCell("aaa",1235)
		  row.SetCell("bbb","abce")
		  row.SetCell("ddd",23987.654)
		  table.AddRow(row, clDataTable.AddRowMode.CreateNewColumnAsVariant)
		  
		  // when this new row is added, the value for eee is ignored, no new column are be added for eee
		  row = New clDataRow
		  row.SetCell("aaa",1234)
		  row.SetCell("bbb","abcd")
		  row.SetCell("ccc",32456.1)
		  row.SetCell("ddd",789.2)
		  row.SetCell("eee", 123)
		  table.AddRow(row,  clDataTable.AddRowMode.ErrorOnNewColumn)
		  
		  call table.AddColumn(new clDataSerie("ccc copy", Table.GetColumn("ccc").GetElements))
		  
		  clNumberDataSerie(table.GetColumn("ccc")).SetStringFormat("-###,##0.000", False)
		  
		  call table.AddColumn(table.GetColumn("aaa").AsString())
		  call table.AddColumn(table.GetColumn("ccc").AsString()) 
		  
		  clNumberDataSerie(table.GetColumn("ccc")).SetStringFormat("-#####0.#", False)
		  call table.AddColumn(table.GetColumn("ccc").AsString("ccc second format")) 
		  
		  clNumberDataSerie(table.GetColumn("ccc")).SetStringFormat("-###,##0.0#", True)
		  call table.AddColumn(table.GetColumn("ccc").AsString("ccc third format")) 
		  
		  log.end_exec(CurrentMethodName)
		  
		  //
		  // Send the table to the viewer
		  //
		  return array(table)
		  
		  
		  
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Example_002(log as LogMessageInterface, Describe as boolean, Description() as string) As clDataTable()
		  
		  if Describe then
		    Description.RemoveAll
		    
		    Description.Add(CurrentMethodName)
		    
		    Description.Add("- create a small table")
		    Description.Add("- aggregate using 0, 1 and 2 dimensions")
		    
		    return nil
		    
		  end if
		  
		  
		  log.start_exec(CurrentMethodName)
		  
		  //
		  // Create a data table wih some data
		  //
		  var table0 As New clDataTable("mytable", SerieArray( _
		  New clDataSerie("City",  "Paris","Lyon","Namur","Paris","Charleroi","Milan") _
		  , New clDataSerie("Country", "FR","FR","BE","FR","BE","IT") _
		  , New clDataSerie("Year", 2000,2000,2000,2000,2000,2000) _
		  , New clNumberDataSerie("Sales", 100,200,300,400,500,600) _
		  , New clNumberDataSerie("Quantity", 51, 52,53,54, 55,56) _
		  ))
		  
		  //
		  // Add a new column, calculated
		  //
		  var newcol as clAbstractDataSerie =  table0.AddColumn( table0.GetNumberColumn("Sales") / table0.GetNumberColumn("Quantity"))
		  newcol.rename("PPU")
		  
		  //
		  // Aggregate table0 per country, to get total sales, minimum unit price and maximum unit price
		  //
		  var table1 As clDataTable = table0.groupby(Array("Country"), Array( _
		  "Sales": clDataTable.AggSum, _
		  "PPU":clDataTable.AggMin, _
		  "PPU":clDataTable.AggMax _
		  ))
		  
		  //
		  // Calculate total sales
		  // 
		  var table2 As clDataTable = table0.GroupBy(Array(""), Array("Sales"))
		  table2.rename("Grand total")
		  
		  //
		  // Get list of unique combinations of country and city
		  //
		  var table3 As clDataTable = table0.GroupBy(StringArray("Country","City"), StringArray)
		  
		  //
		  // Send the tables to the viewer
		  //
		  return array(table0, table1, table2, table3)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Example_003(log as LogMessageInterface, Describe as boolean, Description() as string) As clDataTable()
		  
		  if Describe then
		    Description.RemoveAll
		    
		    Description.Add(CurrentMethodName)
		    
		    Description.Add("- create two datatables")
		    Description.Add("- append table-2 to table-1 using table-2 as a column source (a table is also a column source)")
		    Description.Add("- append table-2 to table-1 using a row source (clTableRowReader) on table-2.")
		    
		    return nil
		    
		  end if
		  
		  
		  log.start_exec(CurrentMethodName)
		  
		  //
		  // Create two tables with some data
		  //
		  var table1 As New clDataTable("table-1", SerieArray( _
		  New clDataSerie("aaa",  123, 456, 789) _
		  , New clDataSerie("bbb",  "abc", "def","ghi") _
		  , New clDataSerie("ccc",  123.4,234.5,345.6) _
		  ))
		  
		  var table2 As New clDataTable("table-2", SerieArray( _
		  New clDataSerie("aaa",  123, 456, 789) _
		  , New clDataSerie("bbb",  "abc", "def","ghi") _
		  , New clDataSerie("zzz",  987.6,876.5, 765.4) _
		  ))
		  
		  //
		  // Clone table1 and add a column to the cloned table
		  //
		  var table3 as clDataTable = table1.clone
		  table3. AddColumnsData(table2)
		  table3.rename("Using column source")
		  
		  //
		  // Clone table1 and add the rows from table2
		  //
		  var table4 as clDataTable = table1.clone
		  call table4.AddRows(new clDataTableRowReader(table2))
		  table4.rename("Using row source")
		  
		  //
		  // Send the tables to the viewer
		  //
		  return array (table1, table2, table3, table4)
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Example_004(log as LogMessageInterface, Describe as boolean, Description() as string) As clDataTable()
		  
		  if Describe then
		    Description.RemoveAll
		    
		    Description.Add(CurrentMethodName)
		    
		    Description.Add("- create a  datatable")
		    Description.Add("- create a view on the table")
		    
		    return nil
		    
		  end if
		  
		  log.start_exec(CurrentMethodName)
		  
		  
		  var table0 As New clDataTable("mytable", SerieArray( _
		  New clDataSerie("City",  "F1","F2","B1","F1","B2","I1") _
		  , New clDataSerie("Country", "FR","FR","BE","FR","BE","IT") _
		  , New clDataSerie("Year", 2000,2000,2000,2000,2000,2000) _
		  , New clDataSerie("Sales", 100,200,300,400,500,600) _
		  , New clDataSerie("Quantity", 51, 52,53,54, 55,56) _
		  ))
		  
		  
		  var view1 As clDataTable = table0.SelectColumns(array("Country", "City", "Sales"))
		  
		  
		  //
		  // Send the tables to the viewer
		  //
		  return array(table0, view1)
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Example_005(log as LogMessageInterface, Describe as boolean, Description() as string) As clDataTable()
		  
		  if Describe then
		    Description.RemoveAll
		    
		    
		    Description.Add(CurrentMethodName)
		    Description.Add("- create an empty datatable")
		    Description.Add("- fast append data") 
		    
		    
		    return nil
		    
		  end if
		  
		  
		  log.start_exec(CurrentMethodName)
		  
		  //
		  //  Create an empty table
		  //
		  var table0 As New clDataTable("T1")
		  
		  //
		  // Add columns
		  //
		  call table0.AddColumns(Array("cc1","cc2","cc3"))
		  
		  //
		  // Add some data row by row
		  //
		  table0.AddRow(Array("aaa0","bbb0","ccc0"))
		  table0.AddRow(Array("aaa1","bbb1","ccc1"))
		  table0.AddRow(Array("aaa2","bbb2","ccc2"))
		  table0.AddRow(Array("aaa3","bbb3","ccc3"))
		  
		  //
		  // Send the table to the viewer
		  //
		  return array(table0)
		  
		   
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Example_006(log as LogMessageInterface, Describe as boolean, Description() as string) As clDataTable()
		  
		  if Describe then
		    Description.RemoveAll
		    
		    Description.Add(CurrentMethodName)
		    
		    Description.Add("- create an empty datatable")
		    Description.Add("- fast append data")
		    Description.Add("- apply filter function to create a dataserie")
		    
		    return nil
		    
		  end if
		  
		  
		  log.start_exec(CurrentMethodName)
		  
		  //
		  //  Create an empty table
		  //
		  var table0 As New clDataTable("mytable")
		  
		  //
		  // Add columns
		  //
		  call table0.AddColumns(Array("country","city","sales"))
		  
		  //
		  // Add some data row by row
		  //
		  table0.AddRow(Array("France","Paris",1100))
		  table0.AddRow(Array("France","Marseille",1200))
		  table0.AddRow(Array("Belgique","Bruxelles",1300))
		  table0.AddRow(Array("Italy","Milan",1400))
		  table0.AddRow(Array("Belgique","Bruxelles",1500))
		  table0.AddRow(Array("Italy","Rome",1600))
		  
		  //
		  // Apply filter functions to generate some boolean data
		  //
		  var tmp1() as variant = table0.ApplyFilterFunction(AddressOf BasicFieldFilter,"country","France")
		  call table0.AddColumn(new clDataSerie("is_france", tmp1))
		  
		  call table0.AddColumn(new clBooleanDataSerie("is_belgium",  table0.ApplyFilterFunction(AddressOf BasicFieldFilter, "country","Belgique")))
		  
		  //
		  // Send the table to the viewer
		  //
		  return array(table0)
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Example_007(log as LogMessageInterface, Describe as boolean, Description() as string) As clDataTable()
		  
		  if Describe then
		    Description.RemoveAll
		    
		    Description.Add(CurrentMethodName)
		    
		    Description.Add("- create an empty datatable")
		    Description.Add("- fast append data")
		    Description.Add("- create a dataserie  by applying a simple operation between columns")
		    Description.add(" - show behviour with and without explicit name for the new column")
		    
		    return nil
		    
		  end if
		  
		  
		  log.start_exec(CurrentMethodName)
		  
		  //
		  //  Create an empty table
		  //
		  var table0 As New clDataTable("mytable")
		  
		  //
		  // Add columns
		  //
		  call table0.AddColumn(new clDataSerie("name"))
		  call table0.AddColumn(new clNumberDataSerie("quantity"))
		  call table0.AddColumn(new clNumberDataSerie("unit_price"))
		  
		  //
		  // Add some data row by row
		  //
		  table0.AddRow(Array("alpha",50, 6.5))
		  table0.AddRow(Array("beta", 20, 18))
		  table0.AddRow(Array("gamma", 10, 50))
		  
		  //
		  // Add calculated columns
		  //
		  table0.AddColumn(table0.GetNumberColumn("unit_price") * table0.GetNumberColumn("quantity")).rename("sales")
		  
		  call table0.AddColumn(clNumberDataSerie(table0.GetColumn("unit_price")) * clNumberDataSerie(table0.GetColumn("quantity")))
		  
		  //
		  // Send the table to the viewer
		  //
		  return Array(table0)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Example_008(log as LogMessageInterface, Describe as boolean, Description() as string) As clDataTable()
		  
		  if Describe then
		    Description.RemoveAll
		    
		    Description.Add(CurrentMethodName)
		    
		    Description.Add("- create an empty datatable")
		    Description.Add("- fast append data")
		    Description.Add("- apply filter functions to create two dataseries")
		    Description.Add("- operation on dataseries to create a new dataserie")
		    
		    return nil
		    
		  end if
		  
		  log.start_exec(CurrentMethodName)
		  
		  //
		  //  Create an empty table
		  //
		  var table0 As New clDataTable("mytable")
		  
		  //
		  // Add columns
		  //
		  call table0.AddColumns(Array("country","city","sales"))
		  
		  //
		  // Add some data row by row
		  //
		  table0.AddRow(Array("France","Paris",1100))
		  table0.AddRow(Array("France","Marseille",1200))
		  table0.AddRow(Array("Belgique","Bruxelles",1300))
		  table0.AddRow(Array("USA","NewYork",1400))
		  table0.AddRow(Array("Belgique","Bruxelles",1500))
		  table0.AddRow(Array("USA","Chicago",1600))
		  
		  //
		  // Apply filter functions to generate some boolean data
		  //
		  var is_france() as variant = table0.ApplyFilterFunction(AddressOf BasicFieldFilter,"country","France")
		  var is_belgium() as variant =  table0.ApplyFilterFunction(AddressOf BasicFieldFilter, "country","Belgique")
		  
		  //
		  // Add the results as integer data columns
		  //
		  call table0.AddColumn(new clIntegerDataSerie("is_france"))
		  call table0.AddColumn(new clIntegerDataSerie("is_belgium"))
		  
		  call table0.SetColumnValues("is_france", is_france, false)
		  call table0.SetColumnValues("is_belgium", is_belgium, false)
		  
		  //
		  // Add a calculated integer column
		  //
		  call table0.AddColumn(new clIntegerDataSerie("is_europe"))
		  
		  //
		  // Two different ways to get a column of required type, those as not conversion, only type casting, which will generate exception if the column type
		  //  is not of the proper type
		  //
		  call table0.SetColumnValues("is_europe", table0.GetIntegerColumn("is_france") +clIntegerDataSerie( table0.GetColumn("is_belgium")), false)
		  
		  //
		  // Send the table to the viewer
		  //
		  return array(table0)
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Example_009(log as LogMessageInterface, Describe as boolean, Description() as string) As clDataTable()
		  
		  if Describe then
		    Description.RemoveAll
		    
		    Description.Add(CurrentMethodName)
		    
		    Description.Add("- create a datatable")
		    Description.Add("- create a validation table")
		    Description.Add("- validate, show results of validation")
		    
		    return nil
		    
		  end if
		  log.start_exec(CurrentMethodName)
		  
		  //
		  //  Create an empty table
		  //
		  var table0 As New clDataTable("mytable")
		  
		  //
		  // Add columns
		  //
		  call table0.AddColumns(Array("country","city","sales"))
		  
		  //
		  // Add some data row by row
		  //
		  table0.AddRow(Array("France","Paris",1100))
		  table0.AddRow(Array("","Marseille",1200))
		  table0.AddRow(Array("Belgique","",1300))
		  table0.AddRow(Array("USA","NewYork",1400))
		  table0.AddRow(Array("Belgique","Bruxelles",1500))
		  table0.AddRow(Array("USA","Chicago",1600))
		  
		  //
		  // Create validation rules
		  //
		  var tableValid as new clDataTableValidation("validation",array( _
		  new clDataSerieValidation("country",  False, True) _
		  , new clDataSerieValidation("city", True, true) _
		  , new clDataSerieValidation("zip", True, True) _
		  ))
		  
		  //
		  // Apply the rules
		  //
		  tableValid.validate(table0)
		  
		  //
		  // Obtain the validation results as a data table
		  //
		  var table1 As  clDataTable = tableValid.GetResults()
		  
		  //
		  // Send the tables to the viewer
		  //
		  
		  return array(table0, table1, new clDataTable(tableValid))
		  
		  
		  
		  
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Example_010(log as LogMessageInterface, Describe as boolean, Description() as string) As clDataTable()
		  
		  if Describe then
		    Description.RemoveAll
		    
		    Description.Add(CurrentMethodName)
		    
		    Description.Add("- create a datatable")
		    Description.Add("- test the 'get_row' method")
		    
		    return nil
		    
		  end if
		  
		  
		  log.start_exec(CurrentMethodName)
		  
		  //
		  //  Create an empty table
		  //
		  var table0 As New clDataTable("mytable")
		  
		  //
		  // Add columns
		  //
		  call table0.AddColumns(Array("country","city","sales"))
		  
		  //
		  // Add some data row by row
		  //
		  table0.AddRow(Array("France","Paris",1100))
		  table0.AddRow(Array("","Marseille",1200))
		  table0.AddRow(Array("Belgique","",1300))
		  table0.AddRow(Array("USA","NewYork",1400))
		  table0.AddRow(Array("Belgique","Bruxelles",1500))
		  table0.AddRow(Array("USA","Chicago",1600))
		  
		  //
		  // Create another empty table
		  //
		  var table1 as new clDataTable("res")
		  
		  //
		  // Copy the data from table0 row by row
		  //
		  for row_index as integer = 0 to table0.RowCount-1
		    var tmp_row as clDataRow = table0.GetRowAt(row_index, True)
		    table1.AddRow(tmp_row)
		  next
		  
		  //
		  // Send the table to the viewer
		  //
		  return array(table0, table1)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Example_011(log as LogMessageInterface, Describe as boolean, Description() as string) As clDataTable()
		  
		  if Describe then
		    Description.RemoveAll
		    
		    Description.Add(CurrentMethodName)
		    
		    Description.Add("- create a datatable")
		    Description.Add("- create a second table with unique values from the first one")
		    
		    return nil
		    
		  end if
		  
		  log.start_exec(CurrentMethodName)
		  
		  //
		  //  Create an empty table
		  //
		  var table0 As New clDataTable("mytable")
		  
		  //
		  // Add columns
		  //
		  call table0.AddColumns(Array("country","city","sales"))
		  
		  //
		  // Add some data row by row
		  //
		  table0.AddRow(Array("France","Paris",1100))
		  table0.AddRow(Array("","Marseille",1200))
		  table0.AddRow(Array("Belgique","",1300))
		  table0.AddRow(Array("France","Paris",2100))
		  table0.AddRow(Array("","Marseille",2200))
		  table0.AddRow(Array("Belgique","",2300))
		  table0.AddRow(Array("USA","NewYork",2400))
		  table0.AddRow(Array("Belgique","Bruxelles",2500))
		  table0.AddRow(Array("USA","Chicago",2600))
		  table0.AddRow(Array("USA","NewYork",1400))
		  table0.AddRow(Array("Belgique","Bruxelles",1500))
		  table0.AddRow(Array("USA","Chicago",1600))
		  
		  //
		  // Get the distinct combinations of country and city
		  //
		  var table1 As clDataTable = table0.GroupBy(array("country", "city"))
		  
		  //
		  // Send the tables to the viewer
		  //
		  return array(table0, table1)
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Example_012(log as LogMessageInterface, Describe as boolean, Description() as string) As clDataTable()
		  
		  if Describe then
		    Description.RemoveAll
		    
		    Description.Add(CurrentMethodName)
		    
		    Description.Add("- create a datatable")
		    Description.Add("- Text string handling")
		    Description.Add("- split the text field into country and city")
		    Description.Add("- get total sales per country")
		    Description.Add("- get list of unique country/city pairs")
		    
		    return nil
		    
		  end if
		  
		  
		  log.start_exec(CurrentMethodName)
		  
		  //
		  // Create two data series
		  //
		  var col_source as new clStringDataSerie("source", "France-Paris","Belgique-","Belgque-Bruxelles", "USA-NewYork", "USA-Chicago", "France-Marseille")
		  var col_sales as new clNumberDataSerie("sales", 1000,1100, 1200, 1300, 1400, 1500)
		  //
		  //  Create a table and add the data series
		  //
		  var table1 as new clDataTable("source table", SerieArray(col_source, col_sales))
		  
		  //
		  // we split the "source" field to extract country and city
		  //
		  var table2 as new clDataTable("prepared", SerieArray( _
		  col_source, _
		  col_source.TextBefore("-").rename("country"), _
		  col_source.TextAfter("-").rename("city"), _
		  col_sales),_
		  true)
		  
		  //
		  // Get a pointer to the city column
		  //
		  var col_city  as clStringDataSerie = clStringDataSerie(table2.GetColumn("city"))
		  
		  //
		  // Convert to uppercase
		  //
		  call table2.AddColumn(col_city.Uppercase.rename("City UC"))
		  
		  
		  //
		  // Get list of distinct country and city
		  //
		  var table3 As clDataTable = table2.Groupby(array("country", "city"))
		  
		  //
		  // Get the total sales and max sales per country
		  //
		  var table4 as clDataTable  = table2.groupby(array("country"), array("Sales":clDataTable.AggSum,"Sales":clDataTable.AggMax))
		  
		  //
		  // Send the tables to the viewer
		  //
		  return array(table1, table2, table3, table4)
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Example_013(log as LogMessageInterface, Describe as boolean, Description() as string) As clDataTable()
		  
		  if Describe then
		    Description.RemoveAll
		    
		    Description.Add(CurrentMethodName)
		    
		    
		    
		    
		    return nil
		    
		  end if
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Example_014(log as LogMessageInterface, Describe as boolean, Description() as string) As clDataTable()
		  
		  if Describe then
		    Description.RemoveAll
		    
		    Description.Add(CurrentMethodName)
		    
		    Description.Add("- create a datatable")
		    Description.Add("- calculate sales * 20%  ")
		    Description.Add("- Clone the sales column as 'sales base'")
		    Description.Add("- apply ClipByRange 1000..2000 on the 'sales base' column")
		    Description.Add("- created a new column using ClippedByRange 1100..1500")
		    
		    return nil
		    
		  end if
		  
		  
		  
		  log.start_exec(CurrentMethodName)
		  
		  
		  //
		  // Create three data series
		  //
		  var col_country as new clDataSerie("Country", "France", "", "Belgique", "France", "USA")
		  var col_city as new clDataSerie("City", "Paris", "Marseille", "Bruxelles", "Lille", "Chicago")
		  var col_sales as new clNumberDataSerie("sales", 900.0, 1200.0, 1400.0, 1600.0, 2900)
		  
		  //
		  //  Create a table and add the data series
		  //
		  var table0 As New clDataTable("mytable", SerieArray(col_country, col_city, col_sales))
		  
		  //
		  // Add more data row by row
		  //
		  table0.AddRow(Array("France","Paris",1100))
		  table0.AddRow(Array("","Marseille",1200))
		  table0.AddRow(Array("Belgique","",1300))
		  table0.AddRow(Array("France","Paris",2100))
		  table0.AddRow(Array("","Marseille",2200))
		  table0.AddRow(Array("Belgique","",2300))
		  
		  // 
		  // Add a calculated column as 20% of sales
		  //
		  call table0.AddColumn(col_sales * 0.2 )
		  
		  //
		  // Retain the original sales column 
		  //
		  call table0.AddColumn(col_sales.Clone("Sales base"))
		  
		  // 
		  // clip the sales column
		  //
		  call table0.ClipByRange("Sales base",1000, 2000)
		  
		  //
		  // Add a new column with clipped sales
		  call table0.AddColumn(col_sales.ClippedByRange(1100, 1500) )
		  
		  //
		  // Send the tables to the viewer
		  //
		  return array(table0)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Example_015(log as LogMessageInterface, Describe as boolean, Description() as string) As clDataTable()
		  
		  if Describe then
		    Description.RemoveAll
		    
		    Description.Add(CurrentMethodName)
		    
		    Description.Add("- create a datatable with dates")
		    Description.Add("- subtract col1 - col2")
		    Description.Add("- apply different formatting") 
		    
		    return nil
		    
		  end if
		  
		  log.start_exec(CurrentMethodName)
		  
		  var c1 As New clDateDataSerie("ExpiryDate") 
		  var c2 As New clDateDataSerie("CurrentDate") 
		  
		  c1.AddElement("2023-06-01")
		  c1.AddElement("2022-08-12")
		  
		  c2.AddElement("2021-06-01")
		  c2.AddElement("2020-08-01")
		  
		  var c3 as clIntegerDataSerie = c1 - c2
		  
		  var c4 as clIntegerDataSerie = c1 - DateTime.FromString("2020-01-01")
		  
		  var c5 as clStringDataSerie = c1.ToString()
		  
		  var c6 as clStringDataSerie = c1.ToString(DateTime.FormatStyles.Medium)
		  
		  var c7 as clStringDataSerie = c1.ToString("yyyy-MM")
		  
		  var table0 as new clDataTable("output", SerieArray(c1, c2, c3, c4, c5, c6, c7))
		  
		  return array(table0)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Example_016(log as LogMessageInterface, Describe as boolean, Description() as string) As clDataTable()
		  
		  if Describe then
		    Description.RemoveAll
		    
		    Description.Add(CurrentMethodName)
		    Description.Add("- create a datatable with dates")
		    Description.Add("- compare payment date with deadline")
		    Description.Add("- flag late payment")
		    Description.Add("- calculate late payment pernalty")
		    
		    return nil
		    
		  end if
		  
		  
		  
		  log.start_exec(CurrentMethodName)
		  
		  // Build the table, to simulate loading from an external data source
		  var col_country as new clDataSerie("Customer", "C001", "", "C002", "C003", "C004","C005")
		  var col_city as new clDataSerie("City", "Paris", "Marseille", "Bruxelles", "Lille", "Chicago")
		  var col_sales as new clNumberDataSerie("sales", 900.0, 1200.0, 1400.0, 1600.0, 2900)
		  var col_penalty as new clNumberDataSerie("%up", 0.12, 0.12, 0.12 , 0.12, 0.12)
		  var col_expiry as new clDateDataSerie("InvoiceDate", "2023-03-05","2023-03-07","2023-03-12","2023-03-19","2023-04-03")
		  var col_pay as new clDateDataSerie("PaymentDate", "2023-03-08","2023-03-27","2023-03-20","2023-04-05","2023-05-12")
		  
		  col_penalty.SetStringFormat("#%")
		  
		  var table0 as new clDataTable("mytable", SerieArray(col_country, col_city, col_sales, col_expiry, col_pay, col_penalty))
		  
		  // 
		  // Start calculation
		  //
		  // number of days vs expiry date
		  var delay as clIntegerDataSerie = col_pay - col_expiry
		  
		  // flag if number of days > 15 days
		  var flagged as clIntegerDataSerie = new clIntegerDataSerie("late-payment",delay.GetFilterColumnValuesInRange(15,9999))
		  
		  // calculate penalty and give a better name
		  var total_penaty as clNumberDataSerie = col_sales * col_penalty * flagged.ToNumber()
		  total_penaty.rename("penalty")
		  
		  // update table
		  call table0.AddColumns(SerieArray(delay, flagged, total_penaty))
		   
		  return array(table0)
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Example_017(log as LogMessageInterface, Describe as boolean, Description() as string) As clDataTable()
		  
		  if Describe then
		    Description.RemoveAll
		    
		    Description.Add(CurrentMethodName)
		    Description.Add("- load a table from db")
		    Description.Add("- save table to db")
		    Description.Add("- repeat with another table")
		    Description.Add("- merge in memory using clDataTable")
		    Description.Add("- merge in db using DBAppendWriter()")
		    
		    return nil
		    
		  end if
		  log.start_exec(CurrentMethodName)
		  
		  
		  var db as new SQLiteDatabase
		  
		  Try
		    db.Connect
		    
		  Catch error As DatabaseException
		    System.DebugLog("DB Connection Error: " + error.Message)
		    
		  End Try
		  
		  var dbrow as  DatabaseRow
		  
		  //test1
		  db.ExecuteSQL("create table test1(ID INTEGER NOT NULL, aaa varchar(20), bbb integer, ccc float, PRIMARY KEY(ID))")
		  
		  dbrow = new DatabaseRow
		  dbrow.Column("aaa")="Belgium1"
		  dbrow.Column("bbb")= 32
		  dbrow.Column("ccc") = 10.3
		  db.AddRow("test1", dbrow)
		  
		  dbrow = new DatabaseRow
		  dbrow.Column("aaa")="France1"
		  dbrow.Column("bbb")= 3
		  dbrow.Column("ccc") = 14.6
		  db.AddRow("test1", dbrow)
		  
		  dbrow = new DatabaseRow
		  dbrow.Column("aaa")="Italy1"
		  dbrow.Column("bbb")= 39
		  dbrow.Column("ccc") = 12.7
		  db.AddRow("test1", dbrow)
		  
		  //db.CommitTransaction
		  
		  
		  
		  //test3
		  db.ExecuteSQL("create table test3(ID INTEGER NOT NULL, aaa varchar(20), bbb integer, ddd float, PRIMARY KEY(ID))")
		  
		  
		  dbrow = new DatabaseRow
		  dbrow.Column("aaa")="Belgium3"
		  dbrow.Column("bbb")= 32
		  dbrow.Column("ddd") = 30.3
		  db.AddRow("test3", dbrow)
		  
		  dbrow = new DatabaseRow
		  dbrow.Column("aaa")="France3"
		  dbrow.Column("bbb")= 3
		  dbrow.Column("ddd") = 34.6
		  db.AddRow("test3", dbrow)
		  
		  dbrow = new DatabaseRow
		  dbrow.Column("aaa")="Italy3"
		  dbrow.Column("bbb")= 39
		  dbrow.Column("ddd") = 32.7
		  db.AddRow("test3", dbrow)
		  
		  
		  var my_table1 as new clDataTable(new clDBReader(db.SelectSql("select * from test1")))
		  my_table1.rename("test2")
		  my_table1.save(new clDBWriter(new clSqliteDBAccess(db)))
		  
		  var my_table2 as new clDataTable(new clDBReader(db.SelectSql("select * from test2")))
		  
		  call check_table(log,"Test1/Test2", my_table1, my_table2)
		  
		  
		  
		  var my_table3 as new clDataTable(new clDBReader(db.SelectSql("select * from test3")))
		  my_table3.rename("test4")
		  my_table3.save(new clDBAppendWriter(new clSqliteDBAccess(db)))
		  
		  var my_table4 as new clDataTable(new clDBReader(db.SelectSql("select * from test4")))
		  
		  call check_table(log,"Test3/Test4", my_table3, my_table4)
		  
		  
		  var my_table5 as new clDataTable(new clDBReader(db.SelectSQL("select * from test1")))
		  
		  var my_table6 as new clDataTable(new clDBReader(db.SelectSQL("select * from test3")))
		  
		  // create expected ds
		  var my_table7 as clDataTable = my_table5.clone
		  my_table7. AddColumnsData(my_table6)
		  
		  
		  // add rows from test3 to test2
		  my_table6.rename("test2")
		  my_table6.save(new clDBAppendWriter(new clSqliteDBAccess(db)))
		  
		  
		  var my_table8 as new clDataTable(new clDBReader(db.SelectSQL("select * from test2")))
		  
		  call check_table(log,"Test7/Test8", my_table7, my_table8)
		  
		  my_table2.rename("test2:after save/load test1")
		  my_table4.rename("test4:after save/load test3")
		  
		  my_table7.rename("loaded from merged in memory data tables")
		  my_table8.rename("loaded from merged db tables")
		  
		  
		  return array(my_table1, my_table2, my_table3, my_table4, my_table7, my_table8)
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Example_018(log as LogMessageInterface, Describe as boolean, Description() as string) As clDataTable()
		  
		  if Describe then
		    Description.RemoveAll
		    
		    Description.Add(CurrentMethodName)
		    
		    Description.Add("- create a  datatable")
		    Description.Add("- define display titles")
		    Description.Add("- create a table with the structure of the first table")
		    
		    return nil
		    
		  end if
		  
		  
		  log.start_exec(CurrentMethodName)
		  
		  var dct as Dictionary
		  
		  dct = new Dictionary
		  dct.value("Country") = array("France", "", "Belgique", "France", "USA")
		  dct.Value("City") = array("Paris", "Marseille", "Bruxelles", "Lille", "Chicago")
		  dct.Value("Sales") = array(900.0, 1200.0, 1400.0, 1600.0, 2900)
		  
		  var table0 As New clDataTable("mytable", dct ,AddressOf alloc_series_019)
		  
		  table0.GetColumn("City").DisplayTitle = "Ville"
		  table0.GetColumn("Country").DisplayTitle = "Pays"
		  table0.GetColumn("Sales").DisplayTitle="Ventes" 
		  
		  var struc0 as clDataTable = table0.GetStructureAsTable
		  var prop0 as clDataTable = table0.GetPropertiesAsTable
		  
		  return array(table0, struc0, prop0)
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Example_019(log as LogMessageInterface, Describe as boolean, Description() as string) As clDataTable()
		  
		  if Describe then
		    Description.RemoveAll
		    
		    Description.Add(CurrentMethodName)
		    
		    Description.Add("- create a  datatable")
		    Description.Add("- create a view on the table")
		    Description.Add("- define display titles")
		    
		    return nil
		    
		  end if
		  
		  
		  
		  log.start_exec(CurrentMethodName)
		  
		  var table0 As New clDataTable("mytable without display title", SerieArray( _
		  New clDataSerie("City",  "F1","F2","B1","F1","B2","I1") _
		  , New clDataSerie("Country", "FR","FR","BE","FR","BE","IT") _
		  , New clDataSerie("Year", 2000,2000,2000,2000,2000,2000) _
		  , New clDataSerie("Sales", 100,200,300,400,500,600) _
		  , New clDataSerie("Quantity", 51, 52,53,54, 55,56) _
		  ))
		  
		  var table1 As New clDataTable("mytable with display titles", SerieArray( _
		  New clDataSerie("City",  "F1","F2","B1","F1","B2","I1") _
		  , New clDataSerie("Country", "FR","FR","BE","FR","BE","IT") _
		  , New clDataSerie("Year", 2000,2000,2000,2000,2000,2000) _
		  , New clDataSerie("Sales", 100,200,300,400,500,600) _
		  , New clDataSerie("Quantity", 51, 52,53,54, 55,56) _
		  ))
		  
		  
		  table1.GetColumn("City").DisplayTitle = "Ville"
		  table1.GetColumn("Country").DisplayTitle = "Pays"
		  table1.GetColumn("Year").DisplayTitle = "Année"
		  table1.GetColumn("Sales").DisplayTitle="Ventes"
		  table1.GetColumn("Quantity").DisplayTitle="Volume"
		  
		  
		  var view0 As clDataTable = table0.SelectColumns(array("Country", "City", "Sales"))
		  
		  var view1 As clDataTable = table1.SelectColumns(array("Country", "City", "Sales"))
		  
		  return array(table0, table1, view0, view1)
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Example_020(log as LogMessageInterface, Describe as boolean, Description() as string) As clDataTable()
		  
		  if Describe then
		    Description.RemoveAll
		    
		    Description.Add(CurrentMethodName)
		    
		    Description.Add("- add a DataSerie, a NumberDataSerie, a StringDataSerie")
		    Description.Add("- for each serie, add a string, a number, a 'nil' value")
		    Description.Add("- check values returned by get_element, get_element_as_number, is_defined")
		    
		    return nil
		    
		  end if
		  
		  
		  log.start_exec(CurrentMethodName)
		  
		  
		  var c0 as new clDataSerie("Action")
		  var c1 as new clDataSerie("DataSerie")
		  var c2 as new clNumberDataSerie("NumberDataSerie", array(123.45, 123.45, 123.45))
		  var c3 as new clStringDataSerie("StringDataSerie")
		  
		  c0.AddElement("Add 'aaa'")
		  c1.AddElement("aaa")
		  c2.AddElement("aaa")
		  c3.AddElement("aaa")
		  
		  c0.AddElement("Add 123.45")
		  c1.AddElement(123.45)
		  c2.AddElement(123.45)
		  c3.AddElement(123.45)
		  
		  c0.AddElement("Add nil")
		  c1.AddElement(nil)
		  c2.AddElement(nil)
		  c3.AddElement(nil)
		  
		  var ret_tables() as clDataTable
		  
		  for each cc as clAbstractDataSerie in array(c1,c2,c3)
		    
		    var c4 as new clDataSerie("get_element")
		    var c5 as new clDataSerie("ElementIsDefined(")
		    var c6 as new clDataSerie("get_element_as_number")
		    
		    for i as integer = 0 to c1.LastIndex
		      
		      c4.AddElement(cc.GetElement(i))
		      c5.AddElement(str(cc.ElementIsDefined(i)))
		      c6.AddElement(str(c2.GetElementAsNumber(i)))
		      
		    next
		    
		    ret_tables.Add(new clDataTable(cc.name, SerieArray(c0.clone,cc,c4,c5,c6)))
		    
		  next
		  
		  return ret_tables
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Example_021(log as LogMessageInterface, Describe as boolean, Description() as string) As clDataTable()
		  
		  if Describe then
		    Description.RemoveAll
		    
		    Description.Add(CurrentMethodName)
		    
		    Description.Add("- add a DataSerie, a NumberDataSerie, a StringDataSerie")
		    Description.Add("- for each serie, add a string, a number, a 'nil' value")
		    Description.Add("- check values returned by get_element, get_element_as_number, is_defined")
		    
		    return nil
		    
		  end if
		  
		  log.start_exec(CurrentMethodName)
		  
		  var c1 as new clDataSerie("DataSerie")
		  var c2 as new clNumberDataSerie("NumberDataSerie")
		  var c3 as new clStringDataSerie("StringDataSerie")
		  var c4 as new clIntegerDataSerie("IntegerDataSerie")
		  
		  var series() as clAbstractDataSerie = SerieArray(c1, c2, c3, c4)
		  
		  for each cc as clAbstractDataSerie in series
		    cc.AddElement("aaa")
		    cc.AddElement(100)
		    cc.AddElement(119)
		    cc.AddElement(120)
		    cc.AddElement(nil)
		    cc.AddElement(0)
		    
		  next
		  
		  var ret_tables() as clDataTable 
		  
		  var data_table as new clDataTable("data", series)
		  var stat_table as clDataTable = data_table.GetStatisticsAsTable
		  var struc_table as clDataTable = data_table.GetStructureAsTable
		  
		  call stat_table.GetColumn(clDataTable.StatisticsAverageColumn).RoundValues(2)
		  
		  ret_tables.Add(data_table)
		  ret_tables.add(stat_table)
		  ret_tables.Add(struc_table)
		  
		  return ret_tables
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Example_022(log as LogMessageInterface, Describe as boolean, Description() as string) As clDataTable()
		  
		  if Describe then
		    Description.RemoveAll
		    
		    Description.Add(CurrentMethodName)
		    
		    Description.Add("- create an empty datatable")
		    Description.Add("- apply filter functions to create two dataseries")
		    Description.Add("- operation on dataseries to create a new dataserie")
		    Description.Add("- customise formatting of boolean values")
		    Description.Add("- range formatting for number values")
		    
		    
		    return nil
		    
		  end if
		  
		  log.start_exec(CurrentMethodName)
		  
		  
		  
		  var table0 As New clDataTable("mytable")
		  
		  call table0.AddColumns(Array("country","city"))
		  var col_cloned_sales as clNumberDataSerie =  clNumberDataSerie(table0.AddColumn(new clNumberDataSerie("sales")))
		  
		  table0.AddRow(Array("France","Paris",600))
		  table0.AddRow(Array("France","Marseille",1200))
		  table0.AddRow(Array("Belgique","Bruxelles",1300))
		  table0.AddRow(Array("USA","NewYork",2400))
		  table0.AddRow(Array("Belgique","Bruxelles",1500))
		  table0.AddRow(Array("USA","Chicago",1600))
		  
		  col_cloned_sales = col_cloned_sales.Clone()
		  col_cloned_sales.name = "Formatted sales"
		  
		  call table0.AddColumn(col_cloned_sales)
		  
		  col_cloned_sales.SetStringFormat(new clRangeFormatting("",""))
		  col_cloned_sales.AddFormattingRange(0,999.99,"small")
		  col_cloned_sales.AddFormattingRange(1000,1999.99,"medium")
		  col_cloned_sales.AddFormattingRange(2000,2999.99,"big")
		  
		  
		  call table0.AddColumn(new clBooleanDataSerie("is_france", table0.ApplyFilterFunction(AddressOf BasicFieldFilter,"country","France")))
		  call table0.AddColumn(new clBooleanDataSerie("is_belgium", table0.ApplyFilterFunction(AddressOf BasicFieldFilter, "country","Belgique")))
		  call table0.AddColumn(new clBooleanDataSerie("is_europe", table0.ApplyFilterFunction(AddressOf BasicFieldFilter, "country",array("France","Belgique"))))
		  
		  clBooleanDataSerie(table0.GetColumn("is_france")).SetStringFormat("≠ France","= France")
		  
		  return array(table0)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Example_023(log as LogMessageInterface, Describe as boolean, Description() as string) As clDataTable()
		  
		  if Describe then
		    Description.RemoveAll
		    
		    Description.Add(CurrentMethodName)
		    
		    Description.Add("- create an empty datatable")
		    Description.Add("- load from a file with same structure")
		    Description.Add("- append from a file with same column names in different order")
		    Description.Add("- append from a file with different column name + mapping (field 'group' is not mapped)")
		    Description.Add("- load files in individual datatable for comparison")
		    
		    
		    return nil
		    
		  end if
		  
		  log.start_exec(CurrentMethodName)
		  
		  var fld_folder As New FolderItem
		  var fld_file1 As FolderItem
		  var fld_file2 As FolderItem
		  var fld_file3 As FolderItem
		  
		  fld_folder = fld_folder.Child("test-data")
		  
		  fld_file1 = fld_folder.Child("myfile4_A_tab.txt")
		  fld_file2  = fld_folder.Child("myfile4_B_tab.txt") 
		  fld_file3  = fld_folder.Child("myfile4_C_tab.txt") 
		  
		  var my_table as new clDataTable("consolidated")
		  call my_table.AddColumn(new clStringDataSerie("Alpha"))
		  call my_table.AddColumn(new clIntegerDataSerie("Beta"))
		  call my_table.AddColumn(new clNumberDataSerie("Delta"))
		  call my_table.AddColumn(new clNumberDataSerie("Gamma"))
		  call my_table.AddColumn(new clIntegerDataSerie("Group"))
		  call my_table.AddColumn(new clStringDataSerie(clDataTable.LoadedDataSourceColumn))
		  
		  var dct_mapping_file3 as new Dictionary
		  dct_mapping_file3.value("Un") = "Alpha"
		  dct_mapping_file3.value("Deux") = "Beta"
		  dct_mapping_file3.value("Trois") = "Gamma"
		  dct_mapping_file3.value("Quatre") = "Delta"
		  dct_mapping_file3.value("Extra") = "New_col"
		  
		  var source_table1 as new clDataTable(new clTextReader(fld_file1, True, new clTextFileConfig(chr(9))))
		  var source_table2 as new clDataTable(new clTextReader(fld_file2, True, new clTextFileConfig(chr(9))))
		  var source_table3 as new clDataTable(new clTextReader(fld_file3, True, new clTextFileConfig(chr(9))))
		  
		  call my_table.AddRows(new clTextReader(fld_file1, True, new clTextFileConfig(chr(9))))
		  
		  call my_table.AddRows(new clTextReader(fld_file2, True, new clTextFileConfig(chr(9))))
		  
		  call my_table.AddRows(new clTextReader(fld_file3, True, new clTextFileConfig(chr(9))),dct_mapping_file3)
		  
		  log.end_exec(CurrentMethodName)
		  
		  return array(my_table, source_table1, source_table2, source_table3)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Example_024(log as LogMessageInterface, Describe as boolean, Description() as string) As clDataTable()
		  
		  if Describe then
		    Description.RemoveAll
		    
		    Description.Add(CurrentMethodName)
		    
		    Description.Add("- create an empty datatable")
		    Description.Add("- apply filter functions to create two dataseries")
		    Description.Add("- operation on dataseries to create a new dataserie")
		    Description.Add("- customise formatting of boolean values")
		    Description.Add("- range formatting for number values, using another table")
		    
		    
		    
		    return nil
		    
		  end if
		  
		  log.start_exec(CurrentMethodName)
		  
		  
		  
		  var table0 As New clDataTable("mytable")
		  
		  call table0.AddColumns(Array("country","city"))
		  var col_cloned_sales as clNumberDataSerie =  clNumberDataSerie(table0.AddColumn(new clNumberDataSerie("sales")))
		  
		  table0.AddRow(Array("France","Paris",600))
		  table0.AddRow(Array("France","Marseille",3200))
		  table0.AddRow(Array("Belgique","Bruxelles",1300))
		  table0.AddRow(Array("USA","NewYork",2400))
		  table0.AddRow(Array("Belgique","Bruxelles",1500))
		  table0.AddRow(Array("USA","Chicago",1600))
		  table0.AddRow(Array("Italy","Rome",5))
		  
		  
		  col_cloned_sales = col_cloned_sales.Clone()
		  col_cloned_sales.name = "Formatted sales"
		  
		  call table0.AddColumn(col_cloned_sales)
		  
		  var colmin as new clNumberDataSerie("min_value")
		  var colmax as new clNumberDataSerie("max_value")
		  var collabel as new clDataSerie("range_label")
		  
		  var rangeTable as new clDataTable("myranges" , SerieArray( colmin, colmax, collabel))
		  
		  rangeTable.AddRow(new Dictionary("min_value":10, "max_value": 999.999, "range_label":"Small"))
		  rangeTable.AddRow(new Dictionary("min_value":1000, "max_value": 1999.999, "range_label":"Medium"))
		  rangeTable.AddRow(new Dictionary("min_value":2000, "max_value": 2999.999, "range_label":"Big"))
		  
		  col_cloned_sales.SetStringFormat(new clRangeFormatting("",""))
		  col_cloned_sales.AddFormattingRanges(colmin, colmax, collabel)
		  
		  
		  call table0.AddColumn(new clBooleanDataSerie("is_france", table0.ApplyFilterFunction(AddressOf BasicFieldFilter,"country","France")))
		  call table0.AddColumn(new clBooleanDataSerie("is_belgium", table0.ApplyFilterFunction(AddressOf BasicFieldFilter, "country","Belgique")))
		  
		  
		  clBooleanDataSerie(table0.GetColumn("is_france")).SetStringFormat("≠ France","= France")
		  
		  return array(table0, rangeTable)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Example_025(log as LogMessageInterface, Describe as boolean, Description() as string) As clDataTable()
		  
		  if Describe then
		    Description.RemoveAll
		    
		    Description.Add(CurrentMethodName)
		    
		    Description.Add("- create an empty datatable")
		    Description.Add("- apply filter functions to create two dataseries")
		    Description.Add("- operation on dataseries to create a new dataserie")
		    Description.Add("- customise formatting of boolean values")
		    Description.Add("- range formatting for number values, using another table")
		    
		    
		    
		    return nil
		    
		  end if
		  
		  log.start_exec(CurrentMethodName)
		  
		  var c1 as new clStringDataSerie("Alpha")
		  
		  var baselist() as string = array(".123","123", "12.3", "1,23.4","1.23,4", "1,234,56.7")
		  
		  for each base as string in baselist
		    c1.AddElement(base)
		    c1.AddElement(base+"-")
		    c1.AddElement(base+"+")
		    c1.AddElement("-"+base)
		    c1.AddElement("+"+base)
		    
		  next
		  
		  c1.SetNumberParser(new clNumberParser)
		  var c2 as clNumberDataSerie = c1.ToNumber()
		  c2.Rename("C2")
		  var expected_c2 as  new clNumberDataSerie("Expected C2", array(0.123, -0.123, 0.123, -0.123, 0.123, 123.0, -123.0, 123.0, -123.0, 123.0, 12.3, -12.3, 12.3, -12.3, 12.3, 123.4, -123.4,123.4,-123.4,123.4, 0,0,0,0,0,123456.7,-123456.7,123456.7,-123456.7,123456.7))
		  
		  c1.SetNumberParser(new clNumberLocalParser)
		  var c3 as clNumberDataSerie = c1.ToNumber()
		  c3.Rename("C3")
		  var expected_c3 as new clNumberDataSerie("Expected C3", array(123.0, 123.0, 123.0, 123.0, 123.0, 123.0, 123.0, 123.0, 123.0, 123.0, 123.0, 123.0, 123.0, 123.0, 123.0, 0.0, 0.0, 0.0, 0.0, 0.0, 123.4, 123.4, 123.4, 123.4, 123.4, 0.0, 0.0, 0.0, 0.0, 0.0))
		  
		  var table0 as new clDataTable("Example", SerieArray(c1, c2, expected_c2, c3, expected_c3))
		  
		  
		  return array(table0)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Example_026(log as LogMessageInterface, Describe as boolean, Description() as string) As clDataTable()
		  
		  if Describe then
		    Description.RemoveAll
		    
		    Description.Add(CurrentMethodName)
		    
		    Description.Add("- create a datatable with order quantity of unit price per city")
		    Description.Add(" - calculate sales as unit price x quantity in a new column")
		    Description.Add("- lookup the country name")
		    Description.Add("- get list of distinct country/city")
		    Description.Add("- get total sales and total quantity per country")
		    
		    return nil
		    
		  end if
		  
		  log.start_exec(CurrentMethodName)
		  
		  
		  var tcountries as new clDataTable("Countries")
		  call  tcountries.AddColumn(new clStringDataSerie("Country"))
		  call  tcountries.AddColumn(new clStringDataSerie("City"))
		  tcountries.AddRow(new Dictionary("Country":"Belgium","City":"Brussels"))
		  tcountries.AddRow(new Dictionary("Country":"Belgium","City":"Liege"))
		  tcountries.AddRow(new Dictionary("Country":"France","City":"Paris"))
		  tcountries.AddRow(new Dictionary("Country":"USA","City":"NewYork"))
		  tcountries.AddRow(new Dictionary("City":"London"))
		  
		  
		  
		  var tsales as new clDataTable("Sales")
		  
		  var ccity As clAbstractDataSerie =  tsales.AddColumn(new clStringDataSerie("City"))
		  var cqtt as clAbstractDataSerie =  tsales.AddColumn(new clNumberDataSerie("Quantity"))
		  var cup as clAbstractDataSerie = tsales.AddColumn(new clNumberDataSerie("UnitPrice"))
		  
		  call tsales.AddColumn(new clBooleanDataSerie("LookupStatus"))
		  
		  tsales.AddRow(new Dictionary("City":"Brussels", "Quantity":12, "Unitprice": 21))
		  tsales.AddRow(new Dictionary("City":"Liege", "Quantity":12, "Unitprice": 22))
		  tsales.AddRow(new Dictionary("City":"Brussels", "Quantity":12, "Unitprice": 23))
		  tsales.AddRow(new Dictionary("City":"Brussels", "Quantity":12, "Unitprice": 24))
		  tsales.AddRow(new Dictionary("City":"Liege", "Quantity":12, "Unitprice": 25))
		  tsales.AddRow(new Dictionary("City":"Paris", "Quantity":12, "Unitprice": 26))
		  tsales.AddRow(new Dictionary("City":"Liege", "Quantity":12, "Unitprice": 27))
		  tsales.AddRow(new Dictionary("City":"Paris", "Quantity":12, "Unitprice": 28))
		  tsales.AddRow(new Dictionary("City":"London", "Quantity":14, "Unitprice": 30))
		  tsales.AddRow(new Dictionary("City":"Rome", "Quantity":10, "Unitprice": 25))
		  
		  tsales.AddColumn(clNumberDataSerie(cqtt) * clNumberDataSerie(cup)).Rename("Sales") 
		  
		  var join_results as Boolean = tsales.Lookup(tcountries, array("City"), array("Country"), "LookupStatus")
		  
		  var tdistinct as clDataTable = tsales.GroupBy(StringArray("Country", "City"))
		  
		  var tDistinct_expected As New clDataTable("mytable", SerieArray( _
		  new clStringDataSerie("Country", array("Belgium","Belgium", "France","")), _
		  new clStringDataSerie("City", array("Brussels","Liege", "Paris","Rome")) _
		  ))
		  
		  
		  var tSumSales1 as clDataTable = tsales.GroupBy(StringArray("Country"), StringArray("Sales","Quantity"))
		  
		  
		  var tSumSales2 as clDataTable = tsales.GroupBy(StringArray("Country","Zorglub","City"), StringArray("Sales","Quantity"))
		  tSumSales2.Rename("Sum sales 2")
		  
		  return array(tsales, tcountries, tDistinct, tSumSales1, tSumSales2)
		  
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Example_027(log as LogMessageInterface, Describe as boolean, Description() as string) As clDataTable()
		  
		  if Describe then
		    Description.RemoveAll
		    
		    Description.Add(CurrentMethodName)
		    
		    Description.Add("- create a datatable with order quantity of unit price per city")
		    Description.Add(" - calculate sales as unit price x quantity in a new column")
		    Description.Add("- sort on country and city")
		    Description.Add("- sort on city and unit price")
		    Description.Add("- get total sales per country, sorted by total sales")
		    
		    
		    return nil
		    
		  end if
		  
		  log.start_exec(CurrentMethodName)
		  
		  var t1 as new clDataTable("t")
		  
		  var ccnt As clAbstractDataSerie =  t1.AddColumn(new clStringDataSerie("Country"))
		  var ccity As clAbstractDataSerie =  t1.AddColumn(new clStringDataSerie("City"))
		  var cqtt as clAbstractDataSerie =  t1.AddColumn(new clNumberDataSerie("Quantity"))
		  var cup as clAbstractDataSerie = t1.AddColumn(new clNumberDataSerie("UnitPrice"))
		  
		  t1.AddRow(new Dictionary("Country":"Italy","City":"Rome", "Quantity":12, "Unitprice": 23))
		  t1.AddRow(new Dictionary("Country":"Belgium","City":"Brussels", "Quantity":12, "Unitprice": 21))
		  t1.AddRow(new Dictionary("Country":"Belgium","City":"Liege", "Quantity":12, "Unitprice": 5))
		  t1.AddRow(new Dictionary("Country":"Belgium","City":"Liege", "Quantity":12, "Unitprice": 26))
		  t1.AddRow(new Dictionary("Country":"France","City":"Paris", "Quantity":12, "Unitprice": 4))
		  t1.AddRow(new Dictionary("Country":"Belgium","City":"Liege", "Quantity":12, "Unitprice": 28))
		  t1.AddRow(new Dictionary("Country":"Italy","City":"MIlano", "Quantity":12, "Unitprice": 29))
		  t1.AddRow(new Dictionary("Country":"France","City":"Paris", "Quantity":12, "Unitprice": 30))
		  t1.AddRow(new Dictionary("Country":"Belgium","City":"Brussels", "Quantity":12, "Unitprice": 24))
		  t1.AddRow(new Dictionary("Country":"Belgium","City":"Antwerpen", "Quantity":12, "Unitprice": 25))
		  
		  t1.AddColumn(clNumberDataSerie(cqtt) * clNumberDataSerie(cup)).Rename("Sales")
		  
		  var sort11 as clDataTable = t1.Sort(array("Country","City"))
		  //sort1.Rename("Sorted on country and city")
		  
		  var sort12 as clDataTable = t1.Sort(array("Country","UnitPrice"))
		  //sort2.Rename("Sorted on country and unit price")
		  
		  var sort13 as clDataTable = t1.Sort(array("Sales"),clDataTable.SortOrder.Descending)
		  //sort3.Rename("Sorted on Sales descending")
		  
		  var t2 as clDataTable = t1.Groupby(array("Country"), array("Sales"))
		  
		  var sort21 as clDataTable = t2.Sort(array("Sum of Sales"), clDataTable.SortOrder.Descending)
		  
		  var sort22 as clDataTable = t2.Sort(array("Country"))
		  
		  log.end_exec(CurrentMethodName)
		  
		  return  array(t1, sort11, sort12, sort13, t2, sort21, sort22)
		  
		  
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Example_028(log as LogMessageInterface, Describe as boolean, Description() as string) As clDataTable()
		  
		  if Describe then
		    Description.RemoveAll
		    
		    Description.Add(CurrentMethodName)
		    
		    Description.Add("- create a datatable with order quantity of unit price per city")
		    Description.Add(" - inner and outer full join with a country table")
		    
		    return nil
		    
		  end if
		  
		  log.start_exec(CurrentMethodName)
		  
		  var tcountries1 as new clDataTable("Countries1")
		  call  tcountries1.AddColumn(new clStringDataSerie("Country"))
		  call  tcountries1.AddColumn(new clStringDataSerie("City"))
		  tcountries1.AddRow(new Dictionary("Country":"Belgium","City":"Brussels"))
		  tcountries1.AddRow(new Dictionary("Country":"Belgium","City":"Liege"))
		  tcountries1.AddRow(new Dictionary("Country":"France","City":"Paris"))
		  tcountries1.AddRow(new Dictionary("Country":"USA","City":"NewYork"))
		  tcountries1.AddRow(new Dictionary("City":"London"))
		  
		  
		  var tcountries2 as new clDataTable("Countries2")
		  call  tcountries2.AddColumn(new clStringDataSerie("Country"))
		  call  tcountries2.AddColumn(new clStringDataSerie("City"))
		  tcountries2.AddRow(new Dictionary("Country":"USA","City":"NewYork"))
		  tcountries2.AddRow(new Dictionary("Country":"France","City":"Lyon"))
		  tcountries2.AddRow(new Dictionary("Country":"Spain","City":"Madrid"))
		  
		  var tcountries3 as new clDataTable("Countries3")
		  call  tcountries3.AddColumn(new clStringDataSerie("Country"))
		  call  tcountries3.AddColumn(new clStringDataSerie("City"))
		  call tcountries3.AddColumn(new clStringDataSerie("Something"))
		  
		  tcountries3.AddRow(new Dictionary("Country":"Belgium","City":"Brussels","Something":"Alpha"))
		  tcountries3.AddRow(new Dictionary("Country":"Belgium","City":"Liege","Something":"Beta"))
		  tcountries3.AddRow(new Dictionary("Country":"Belgium","City":"Liege","Something":"Gamma"))
		  tcountries3.AddRow(new Dictionary("Country":"France","City":"Paris","Something":"Delta"))
		  tcountries3.AddRow(new Dictionary("Country":"France","City":"Lille","Something":"Omega"))
		  tcountries3.AddRow(new Dictionary("Country":"USA","City":"NewYork","Something":"Zeta"))
		  tcountries3.AddRow(new Dictionary("City":"London"))
		  
		  var tsales as new clDataTable("Sales")
		  
		  var ccity As clAbstractDataSerie =  tsales.AddColumn(new clStringDataSerie("City"))
		  var cqtt as clAbstractDataSerie =  tsales.AddColumn(new clNumberDataSerie("Quantity"))
		  var cup as clAbstractDataSerie = tsales.AddColumn(new clNumberDataSerie("UnitPrice")) 
		  
		  tsales.AddRow(new Dictionary("City":"Brussels", "Quantity":12, "Unitprice": 21))
		  tsales.AddRow(new Dictionary("City":"Liege", "Quantity":12, "Unitprice": 22))
		  tsales.AddRow(new Dictionary("City":"Brussels", "Quantity":12, "Unitprice": 23))
		  tsales.AddRow(new Dictionary("City":"Brussels", "Quantity":12, "Unitprice": 24))
		  tsales.AddRow(new Dictionary("City":"Liege", "Quantity":12, "Unitprice": 25))
		  tsales.AddRow(new Dictionary("City":"Paris", "Quantity":12, "Unitprice": 26))
		  tsales.AddRow(new Dictionary("City":"Liege", "Quantity":12, "Unitprice": 27))
		  tsales.AddRow(new Dictionary("City":"Paris", "Quantity":12, "Unitprice": 28))
		  tsales.AddRow(new Dictionary("City":"London", "Quantity":14, "Unitprice": 30))
		  tsales.AddRow(new Dictionary("City":"Rome", "Quantity":10, "Unitprice": 25))
		  
		  
		  var tjoin1 as clDataTable = tsales.FullJoin(tcountries1, clDataTable.JoinMode.InnerJoin, array("City"))
		  
		  var tjoin2 as clDataTable = tsales.FullJoin(tcountries1, clDataTable.JoinMode.OuterJoin, array("City"))
		  
		  var tjoin3 as clDataTable = tsales.FullJoin(tcountries2, clDataTable.JoinMode.InnerJoin, array("City"))
		  
		  var tjoin4 as clDataTable = tsales.FullJoin(tcountries2, clDataTable.JoinMode.OuterJoin, array("City"))
		  
		  var tjoin5 as clDataTable = tsales.FullJoin(tcountries3, clDataTable.JoinMode.InnerJoin, array("City"))
		  
		  var tjoin6 as clDataTable = tsales.FullJoin(tcountries3, clDataTable.JoinMode.OuterJoin, array("City"))
		  
		  log.end_exec(CurrentMethodName)
		  
		  return  array(tsales, tcountries1, tcountries2, tcountries3, tjoin1, tjoin2, tjoin3, tjoin4, tjoin5, tjoin6)
		  
		  
		  
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Example_029(log as LogMessageInterface, Describe as boolean, Description() as string) As clDataTable()
		  
		  if Describe then
		    Description.RemoveAll
		    
		    Description.Add(CurrentMethodName)
		    
		    Description.Add("- create a datatable with order quantity of unit price per city")
		    Description.Add(" - calculate sales as unit price x quantity in a new column")
		    Description.Add("- lookup the country name")
		    Description.Add("- get list of distinct country/city using a transformer")
		    Description.Add("- get total sales and total quantity per country using a transformer")
		    
		    
		    return nil
		    
		  end if
		  
		  
		  log.start_exec(CurrentMethodName)
		  
		  
		  
		  var tcountries as new clDataTable("Countries")
		  call  tcountries.AddColumn(new clStringDataSerie("Country"))
		  call  tcountries.AddColumn(new clStringDataSerie("City"))
		  tcountries.AddRow(new Dictionary("Country":"Belgium","City":"Brussels"))
		  tcountries.AddRow(new Dictionary("Country":"Belgium","City":"Liege"))
		  tcountries.AddRow(new Dictionary("Country":"France","City":"Paris"))
		  tcountries.AddRow(new Dictionary("Country":"USA","City":"NewYork"))
		  tcountries.AddRow(new Dictionary("City":"London"))
		  
		  
		  
		  var tsales as new clDataTable("Sales")
		  
		  var ccity As clAbstractDataSerie =  tsales.AddColumn(new clStringDataSerie("City"))
		  var cqtt as clAbstractDataSerie =  tsales.AddColumn(new clNumberDataSerie("Quantity"))
		  var cup as clAbstractDataSerie = tsales.AddColumn(new clNumberDataSerie("UnitPrice"))
		  
		  call tsales.AddColumn(new clBooleanDataSerie("LookupStatus"))
		  
		  tsales.AddRow(new Dictionary("City":"Brussels", "Quantity":12, "Unitprice": 21))
		  tsales.AddRow(new Dictionary("City":"Liege", "Quantity":12, "Unitprice": 22))
		  tsales.AddRow(new Dictionary("City":"Brussels", "Quantity":12, "Unitprice": 23))
		  tsales.AddRow(new Dictionary("City":"Brussels", "Quantity":12, "Unitprice": 24))
		  tsales.AddRow(new Dictionary("City":"Liege", "Quantity":12, "Unitprice": 25))
		  tsales.AddRow(new Dictionary("City":"Paris", "Quantity":12, "Unitprice": 26))
		  tsales.AddRow(new Dictionary("City":"Liege", "Quantity":12, "Unitprice": 27))
		  tsales.AddRow(new Dictionary("City":"Paris", "Quantity":12, "Unitprice": 28))
		  tsales.AddRow(new Dictionary("City":"London", "Quantity":14, "Unitprice": 30))
		  tsales.AddRow(new Dictionary("City":"Rome", "Quantity":10, "Unitprice": 25))
		  
		  tsales.AddColumn(clNumberDataSerie(cqtt) * clNumberDataSerie(cup)).Rename("Sales") 
		  
		  Call tsales.Lookup(tcountries, array("City"), array("Country"), "LookupStatus")
		  
		  var gTransfomer1 as new clGroupByTransformer(tsales, StringArray("Country", "City"))
		  
		  call gTransfomer1.Transform
		  
		  var tDistinct as clDataTable = gTransfomer1.GetOutputTable()
		  
		  
		  var gTransformer2 as new clGroupByTransformer(tsales, StringArray("Country"), StringArray("Sales","Quantity"))
		  
		  call gTransformer2.Transform
		  
		  var tSumSales1 as clDataTable = gTransformer2.GetOutputTable()
		  
		  
		  var tSumSales2 as clDataTable = tsales.GroupBy(StringArray("Country","Zorglub","City"), StringArray("Sales","Quantity"))
		  tSumSales2.Rename("Sum sales 2")
		  
		  return array(tsales, tcountries, tDistinct, tSumSales1, tSumSales2)
		  
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Example_030(log as LogMessageInterface, Describe as boolean, Description() as string) As clDataTable()
		  
		  if Describe then
		    Description.RemoveAll
		    
		    Description.Add(CurrentMethodName)
		    
		    Description.Add("(Found on Xojo Forum)")
		    Description.Add("I have 2 related arrays of data. I would like to list the sales, grouped by category id.")
		    Description.Add("I can figure out how to group the categories on 3 lines, but I can’t determine how to group the sales with the categories.")
		    
		    return nil
		    
		  end if
		  
		  log.start_exec(CurrentMethodName)
		  
		  var SourceTable as new clDataTable("MyTable")
		  
		  call SourceTable.AddColumn(new clStringDataSerie("Category", Array("3", "1", "3", "2", "1", "2", "3", "2") ))
		  call SourceTable.AddColumn(new clNumberDataSerie("Sales", Array(20.00, 10.00, 30.00, 25.00, 15.00, 10.00, 20.00, 8.00) ))
		  
		  var GroupedTable as clDataTable = SourceTable.Groupby(array("Category"), array("Sales"))
		  
		  for each row as clDataRow in GroupedTable
		    
		    System.DebugLog("CategoryGroup=" + row.GetCell("Category") + " Sales = " + format(row.GetCell("Sum of Sales").DoubleValue, "-####0.###"))
		    
		  next
		  
		  return array(SourceTable, GroupedTable)
		  
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Example_031(log as LogMessageInterface, Describe as boolean, Description() as string) As clDataTable()
		  
		  if Describe then
		    Description.RemoveAll
		    
		    Description.Add(CurrentMethodName)
		    
		    Description.Add("(Found on Xojo Forum)")
		    Description.Add("I have 2 related arrays of data. I would like to list the sales, grouped by category id.")
		    Description.Add("I can figure out how to group the categories on 3 lines, but I can’t determine how to group the sales with the categories.")
		    
		    
		    
		    return nil
		    
		  end if
		  
		  log.start_exec(CurrentMethodName)
		  
		  var SourceTable as new clDataTable("MyTable")
		  
		  call SourceTable.AddColumn(new clStringDataSerie("Category", Array("3", "1", "3", "2", "1", "2", "3", "2") ))
		  
		  var qtt as clNumberDataSerie  = new clNumberDataSerie("Quantity", array(2,1,3,5,3,1,2,4))
		  var price as clNumberDataSerie =  new clNumberDataSerie("UnitPrice", array(10,10,10,5,5,10,20,2))
		  
		  call SourceTable.AddColumn(qtt)
		  call SourceTable.AddColumn(price)
		  
		  call  SourceTable.AddColumn(qtt * price)
		  
		  var GroupedTable as clDataTable = SourceTable.Groupby(array("Category"), array("Quantity*UnitPrice"))
		  
		  for each row as clDataRow in GroupedTable
		    
		    System.DebugLog("CategoryGroup=" + row.GetCell("Category") + " Sales = " + format(row.GetCell("Sum of Quantity*UnitPrice").DoubleValue, "-####0.###"))
		    
		  next
		  
		  return array(SourceTable, GroupedTable)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Example_032(log as LogMessageInterface, Describe as boolean, Description() as string) As clDataTable()
		  
		  if Describe then
		    Description.RemoveAll
		    
		    Description.Add(CurrentMethodName)
		    
		    Description.Add("- create an empty table")
		    Description.Add("- append data for category, price and quantity")
		    Description.Add("- add sales defined as price x quantity")
		    Description.Add("- add taxes, defined as 20% on sales")
		    
		    return nil
		    
		  end if
		  
		  log.start_exec(CurrentMethodName)
		  
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
		  
		  return array(SourceTable, GroupedTable)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Example_033(log as LogMessageInterface, Describe as boolean, Description() as string) As clDataTable()
		  
		  if Describe then
		    Description.RemoveAll
		    
		    Description.Add(CurrentMethodName)
		    
		    
		    
		    
		    return nil
		    
		  end if
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function GetAllExamples() As Dictionary
		  
		  
		  Var t As Introspection.TypeInfo
		  
		  var mask as string = "Example_"
		  
		  var d as new Dictionary
		  t = Introspection.GetType(new clLibDataExample)
		  
		  for each met as Introspection.MethodInfo in t.GetMethods
		    if met.name.left(mask.Length) = mask then
		      d.value(met.name) = met
		      
		    end if
		    
		  next
		  
		  return d
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function GetDescription(m as Introspection.MethodInfo) As string()
		  
		  //
		  // Invoke the example method to get the description
		  //
		  
		  var t1() as string
		  
		  var vParams() as Variant
		  
		  vParams.Add(nil)
		  vParams.Add(True)
		  vParams.Add(t1)
		  
		  var v1 as variant
		  
		  v1 = m.Invoke(new clLibDataExample, vParams)
		  
		  return t1
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function RunExample(log as LogMessageInterface, m as Introspection.MethodInfo) As TableColumnReaderInterface()
		  
		  //
		  // Run the example method 
		  //
		  
		  var t1() as string
		  
		  var vParams() as Variant
		  
		  if log = nil then
		    vParams.add(new clLibDataExample)
		    
		  else
		    vParams.Add(log)
		    
		  end if
		  
		  vParams.Add(False)
		  vParams.Add(t1)
		  
		  var v1 as variant
		  
		  v1 = m.Invoke(new clLibDataExample, vParams)
		  
		  
		  var results() as TableColumnReaderInterface
		  
		  if v1 = nil then return results
		  
		  var r() as  clDataTable
		  r = v1
		  
		  for each item as clDataTable in r
		    results.Add(item)
		    
		  next
		  
		  
		  return results
		  
		   
		End Function
	#tag EndMethod


	#tag ViewBehavior
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
