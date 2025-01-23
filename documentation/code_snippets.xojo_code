#tag Module
Protected Module code_snippets
	#tag Method, Flags = &h0
		Sub snippets_readme()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub snippet_readme_001()
		  // Snippet 001
		  
		  dim my_serie As New clDataSerie("some_values")
		  
		  my_serie.AddElement("abcd")
		  my_serie.AddElement("efgh") 
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub snippet_readme_002()
		  // Snippet 002
		  
		  dim my_serie As New clDataSerie("some_values", VariantArray("aaa",123,True))
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub snippet_readme_003()
		  // Snippet 003
		  
		  dim my_serie As New clDataSerie("some_values", "aaa",123,True)
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub snippet_readme_004()
		  // Snippet 004
		  
		  dim fld_file as FolderItem
		  
		  dim my_serie  As  clDataSerie = clDataSerie(append_textfile_to_DataSerie(fld_file, new clDataSerie(""), true))
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub snippet_readme_005()
		  // Snippet 005
		  
		  Dim my_serie1 As New clDataSerie("customer")
		  Dim my_serie2 As New clDataSerie("product")
		  Dim my_serie3 As New clDataSerie("region")
		  
		  
		  // populate the series
		  my_serie1.AddElement("aaa") // (...)
		  
		  my_serie3.AddElement(123.34) // (...)
		  
		  
		  Dim my_table As New clDataTable("mytable1", SerieArray(my_serie1, my_serie2))
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub snippet_readme_006()
		  // Snippet 006
		  
		  Dim my_table As New clDataTable("mytable", SerieArray( _
		  New clDataSerie("City",  "F1","F2","B1","F1","B2","I1") _
		  , New clDataSerie("Country", "FR","FR","BE","FR","BE","IT") _
		  , New clDataSerie("Year", 2000,2000,2000,2000,2000,2000) _
		  , New clDataSerie("Sales", 100,200,300,400,500,600) _
		  , New clDataSerie("Quantity", 51, 52,53,54, 55,56) _
		  ))
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub snippet_readme_007()
		  // Snippet 007
		  
		  Dim my_serie1 As New clDataSerie("customer")
		  Dim my_serie2 As New clDataSerie("product")
		  Dim my_serie3 As New clDataSerie("region")
		  
		  
		  // populate the series
		  my_serie1.AddElement("abc") // (...)
		  
		  
		  Dim my_table1 As New clDataTable("mytable1", SerieArray(my_serie1, my_serie2))
		  
		  Dim my_table2 As New clDataTable("mytable1", SerieArray(my_serie1, my_serie3), True)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub snippet_readme_008()
		  // Snippet 008
		  
		  Dim mytable As New clDataTable("T1")
		  
		  call mytable.AddColumn(new clDataSerie("name"))
		  call mytable.AddColumn(new clNumberDataSerie("quantity"))
		  call mytable.AddColumn(new clNumberDataSerie("unit_price"))
		  
		  // ....
		  
		  // add data to the table
		  
		  //....
		  
		  // Base syntax (the column will be named ‘unit_price*quantity’)
		  call mytable.AddColumn(clNumberDataSerie(mytable.GetColumn("unit_price")) * clNumberDataSerie(mytable.GetColumn("quantity")))
		  
		  
		  // simplified syntax:
		  call mytable.AddColumn(mytable.GetNumberColumn("unit_price") * mytable.GetNumberColumn("quantity"))
		  
		  // If the target column exists in the table
		  call mytable.AddColumn(new clNumberDataSerie("total"))
		  call mytable.SetColumnValues("total", mytable.GetNumberColumn("unit_price") * mytable.GetNumberColumn("quantity"))
		  
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub snippet_readme_009()
		  // Snippet 009
		  
		  Dim mytable As New clDataTable("mytable")
		  
		  call mytable.AddColumns(Array("country","city","sales"))
		  
		  mytable.AddRow(Array("France","Paris",1100))
		  mytable.AddRow(Array("France","Marseille",1200))
		  mytable.AddRow(Array("Belgique","Bruxelles",1300))
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub snippet_readme_010()
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
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub snippet_readme_011()
		  // Snippet 011
		  
		  var mytable As New clDataTable("T1")
		  
		  call mytable.AddColumn(new clDataSerie("name"))
		  call mytable.AddColumn(new clNumberDataSerie("quantity"))
		  call mytable.AddColumn(new clNumberDataSerie("unit_price"))
		  
		  mytable.AddRow(new Dictionary("name": "alpha", "quantity":50, "unit_price": 6))
		  mytable.AddRow(new Dictionary("name": "alpha", "quantity":20, "unit_price": 8))
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub snippet_readme_012()
		  // Snippet 012
		  
		  var mytable As New clDataTable("T1")
		  
		  call mytable.AddColumn(new clDataSerie("name"))
		  call mytable.AddColumn(new clNumberDataSerie("quantity"))
		  call mytable.AddColumn(new clNumberDataSerie("unit_price"))
		  
		  mytable.AddRow("name": "alpha", "quantity":50, "unit_price": 6)
		  mytable.AddRow("name": "alpha", "quantity":20, "unit_price": 8)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub snippet_readme_013()
		  // Snippet 013
		  
		  var data_folder as FolderItem
		  var my_file as FolderItem
		  
		  // Setup data_folder to point to the folder containing the data file
		  
		  my_file  = data_folder.Child("myfile3_10K_comma.txt")
		  
		  
		  Dim my_table As New clDataTable(new clTextReader(my_file, True, new clTextFileConfig(",")))
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub snippet_readme_014()
		  // Snippet 014
		  
		  var myTable1, myTable2, myTable3 as clDataTable
		  
		  mytable1.AddTableData(mytable2, clDataTable.AddRowMode.CreateNewColumn)
		  
		  mytable1.AddTableData(mytable3, clDataTable.AddRowMode.IgnoreNewColumn)
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub snippet_readme_015()
		  // Snippet 015
		  
		  var mytable as clDataTable
		  
		  // add the table data
		  
		  for each row as clDataRow in mytable
		    for each cell as string in row
		      system.DebugLog("field " + cell + "value " + row.GetCell(cell))
		      
		    next
		    
		  next
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub snippet_readme_016()
		  // Snippet 016
		  
		  var table_Customers as clDataTable
		  
		  // Add data to table_customers 
		  
		  Dim table_country As clDataTable = table_customers.groupby(StringArray("Country"), StringArray("Sales"))
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub snippet_readme_017()
		  // Snippet 017
		  
		  Dim MyTable As New clDataTable("mytable")
		  
		  call MyTable.AddColumns(Array("country","city","sales"))
		  
		  MyTable.AddRow(Array("France","Paris",1100))
		  MyTable.AddRow(Array("France","Marseille",1200))
		  MyTable.AddRow(Array("Belgique","Bruxelles",1300))
		  MyTable.AddRow(Array("USA","NewYork",1400))
		  MyTable.AddRow(Array("Belgique","Bruxelles",1500))
		  MyTable.AddRow(Array("USA","Chicago",1600))
		  
		  dim is_france() as variant = MyTable.ApplyFilterFunction(AddressOf BasicFieldFilter,"country","France")
		  dim is_belgium() as variant =  MyTable.ApplyFilterFunction(AddressOf BasicFieldFilter, "country","Belgique")
		  dim is_europe() as variant
		  
		  for i as integer = 0 to is_france.Ubound
		    is_europe.Append(is_france(i).integerValue + is_belgium(i).integerValue)
		    
		  next
		  
		  call MyTable.AddColumn(new clIntegerDataSerie("is_france"))
		  call MyTable.AddColumn(new clIntegerDataSerie("is_belgium"))
		  call MyTable.AddColumn(new clIntegerDataSerie("is_europe"))
		  
		  call MyTable.SetColumnValues("is_france", is_france, false)
		  call MyTable.SetColumnValues("is_belgium", is_belgium, false)
		  call MyTable.SetColumnValues("is_europe", is_europe, false)
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub snippet_readme_018()
		  
		  // Snippet 018
		  
		  Dim MyTable As New clDataTable("mytable")
		  
		  call MyTable.AddColumns(Array("country","city","sales","product"))
		  
		  MyTable.AddRow(Array("France","Paris",1100,"AA"))
		  MyTable.AddRow(Array("","Marseille",1200,"AA"))
		  MyTable.AddRow(Array("Belgique","",1300,"AA"))
		  MyTable.AddRow(Array("USA","NewYork",1400,"AA"))
		  MyTable.AddRow(Array("Belgique","Bruxelles",1500,"BB"))
		  MyTable.AddRow(Array("USA","Chicago",1600,"AA"))
		  
		  dim filter_country as new clBooleanDataSerie("mask_country")
		  for each cell as string in MyTable.GetColumn("Country")
		    filter_country.AddElement(cell = "Belgique")
		    
		  next
		  
		  call MyTable.AddColumn(filter_country)
		  
		  dim filter_product as new clBooleanDataSerie("mask_product")
		  for each cell as string in MyTable.GetColumn("product")
		    filter_product.AddElement(cell = "BB")
		    
		  next
		  
		  call MyTable.AddColumn(not filter_product)
		  
		  MyTable.IndexVisibleWhenIterating(True)
		  
		  // use the name of the boolean serie as parameter to 'filtered_on' 
		  
		  for each row as clDataRow in MyTable.FilteredOn("mask_country")
		    // … do something
		  next
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub snippet_readme_019()
		  // Snippet 019
		  
		  var MyTable as clDataTable
		  
		  // add data to the table  ...
		  
		  dim filter_country as new clBooleanDataSerie("mask_country")
		  for each cell as string in MyTable.GetColumn("Country")
		    filter_country.AddElement(cell = "Belgique")
		    
		  next 
		  
		  dim filter_product as new clBooleanDataSerie("mask_product")
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
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub snippet_readme_020()
		  // Snippet 020
		  
		  dim col_source as new clStringDataSerie("source", "France-Paris","Belgique-","Belgque-Bruxelles", "USA-NewYork", "USA-Chicago", "France-Marseille")
		  dim col_sales as new clNumberDataSerie("sales", 1000,1100, 1200, 1300, 1400, 1500)
		  
		  dim table1 as new clDataTable("source table", SerieArray(col_source, col_sales))
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub snippet_readme_021()
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
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub snippet_readme_022()
		  // Snippet 022
		  
		  // defined in previous snippet:
		  var table2 as clDataTable
		  
		  
		  Dim table4 As clDataTable = table2.GroupBy(StringArray("country"), StringArray("sales"))
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub snippet_readme_023()
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
		  
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub snippet_readme_024()
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
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub snippet_readme_025()
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
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub snippet_readme_026()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub snippet_readme_oneliner()
		  
		  var mytable as clDataTable
		  
		  mytable.IndexVisibleWhenIterating(True)
		  
		  var my_virtual_table as clDataTable = MyTable.SelectColumns(array("customer","product"))
		  
		  
		End Sub
	#tag EndMethod


	#tag Note, Name = About code snippets
		
		Those code snippets are used in the readme file. Included here to detect any changes to the api which may prevent a code snippet to compile.
		
		
	#tag EndNote


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
End Module
#tag EndModule
