#tag Module
Protected Module datatable_examples
	#tag Method, Flags = &h0
		Function describe_001() As string()
		  dim tmp() as string
		  
		  tmp.append("Example_001")
		  tmp.append("- create an empty datatable")
		  tmp.append("- add three rows")
		  
		  return tmp
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function describe_002() As string()
		  dim tmp() as string
		  
		  tmp.append("Example_002")
		  tmp.append("- create a small table")
		  tmp.append("- aggregate using 0, 1 and 2 dimensions")
		  
		  return tmp
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function describe_003() As string()
		  dim tmp() as string
		  
		  tmp.append("Example_003")
		  tmp.append("- create two datatables")
		  tmp.append("- concatentate the tables")
		  
		  return tmp
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function describe_004() As string()
		  dim tmp() as string
		  
		  tmp.append("Example_004")
		  tmp.append("- create a  datatable")
		  tmp.append("- create a view on the table")
		  
		  return tmp
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function describe_005() As string()
		  dim tmp() as string
		  
		  tmp.append("Example_005")
		  tmp.append("- create an empty datatable")
		  tmp.append("- fast append data")
		  
		  return tmp
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function describe_006() As string()
		  dim tmp() as string
		  
		  tmp.append("Example_006")
		  tmp.append("- create an empty datatable")
		  tmp.append("- fast append data")
		  tmp.append("- apply filter function to create a dataserie")
		  
		  
		  return tmp
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function describe_007() As string()
		  dim tmp() as string
		  
		  tmp.append("Example_007")
		  tmp.append("- create an empty datatable")
		  tmp.append("- fast append data")
		  tmp.append("- create a dataserie  by applying a simple operation between columns")
		  
		  return tmp
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function describe_008() As string()
		  dim tmp() as string
		  
		  tmp.append("Example_008")
		  tmp.append("- create an empty datatable")
		  tmp.append("- fast append data")
		  tmp.append("- apply filter functions to create two dataseries")
		  tmp.append("- operation on dataseries to create a new dataserie")
		  
		  return tmp
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function describe_009() As string()
		  dim tmp() as string
		  
		  tmp.append("Example_009")
		  tmp.append("- create a datatable")
		  tmp.append("- create a validation table")
		  tmp.append("- validate, show results of validation")
		  
		  return tmp
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function describe_010() As string()
		  dim tmp() as string
		  
		  tmp.append("Example_010")
		  tmp.append("- create a datatable")
		  tmp.append("- test the 'get_row' method")
		  
		  
		  return tmp
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub example_001()
		  '
		  ' Example_001 
		  ' - create an empty datatable
		  ' - add three rows
		  '
		  
		  System.DebugLog("START "+CurrentMethodName)
		  
		  Dim row As clDataRow
		  
		  Dim table As New clDataTable("mytable")
		  
		  
		  row = New clDataRow
		  row.set_cell("aaa",1234)
		  row.set_cell("bbb","abcd")
		  row.set_cell("ccc",123.4)
		  table.append_row(row)
		  
		  row = New clDataRow
		  row.set_cell("aaa",1235)
		  row.set_cell("bbb","abce")
		  row.set_cell("ddd",987.654)
		  table.append_row(row)
		  
		  row = New clDataRow
		  row.set_cell("aaa",1234)
		  row.set_cell("bbb","abcd")
		  row.set_cell("ccc",456.1)
		  row.set_cell("ddd",789.2)
		  table.append_row(row)
		  
		  
		  dim wnd as new wnd_table_viewer
		  wnd.add_table(table)
		  
		  wnd.Show
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub example_002()
		  
		  ' Example_002
		  ' - create a small table
		  ' - aggregate using 0, 1 and 2 dimensions
		  '
		  
		  
		  System.DebugLog("START "+CurrentMethodName)
		  
		  
		  Dim table0 As New clDataTable("mytable", serie_array( _
		  New clDataSerie("City",  "F1","F2","B1","F1","B2","I1") _
		  , New clDataSerie("Country", "FR","FR","BE","FR","BE","IT") _
		  , New clDataSerie("Year", 2000,2000,2000,2000,2000,2000) _
		  , New clDataSerie("Sales", 100,200,300,400,500,600) _
		  , New clDataSerie("Quantity", 51, 52,53,54, 55,56) _
		  ))
		  
		  
		  Dim table1 As clDataTable = table0.groupby(string_array("Country"), string_array("Sales"), string_array(""))
		  
		  
		  Dim table2 As clDataTable = table0.groupby(string_array, string_array("Sales"), string_array)
		  table2.rename("Grand total")
		  
		  Dim table3 As clDataTable = table0.groupby(string_array("Country","City"), string_array, string_array(""))
		  
		  dim wnd as new wnd_table_viewer
		  
		  wnd.reset_viewer
		  
		  wnd.add_table(table0)
		  wnd.add_table(table1)
		  wnd.add_table(table2)
		  wnd.add_table(table3)
		  
		  wnd.Show
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub example_003()
		  System.DebugLog("START "+CurrentMethodName)
		  
		  
		  Dim table1 As New clDataTable("mytable1", serie_array( _
		  New clDataSerie("aaa",  123, 456, 789) _
		  , New clDataSerie("bbb",  "abc", "def","ghi") _
		  , New clDataSerie("ccc",  123.4,234.5,345.6) _
		  ))
		  
		  Dim table2 As New clDataTable("mytable2", serie_array( _
		  New clDataSerie("aaa",  123, 456, 789) _
		  , New clDataSerie("bbb",  "abc", "def","ghi") _
		  , New clDataSerie("zzz",  987.6,876.5, 765.4) _
		  ))
		  
		  dim table3 as clDataTable = table1.clone
		  
		  table3.append_rows_from_table(table2)
		  
		  dim wnd as new wnd_table_viewer
		  
		  wnd.reset_viewer
		  
		  wnd.add_table(table1)
		  wnd.add_table(table2)
		  wnd.add_table(table3)
		  
		  wnd.Show
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub example_004()
		  
		  ' Example_004
		  ' - create a small table
		  ' - create a view on the table
		  '
		  
		  
		  System.DebugLog("START "+CurrentMethodName)
		  
		  
		  Dim table0 As New clDataTable("mytable", serie_array( _
		  New clDataSerie("City",  "F1","F2","B1","F1","B2","I1") _
		  , New clDataSerie("Country", "FR","FR","BE","FR","BE","IT") _
		  , New clDataSerie("Year", 2000,2000,2000,2000,2000,2000) _
		  , New clDataSerie("Sales", 100,200,300,400,500,600) _
		  , New clDataSerie("Quantity", 51, 52,53,54, 55,56) _
		  ))
		  
		  
		  Dim view1 As clDataTable = table0.select_columns(array("Country", "City", "Sales"))
		  
		  
		  dim wnd as new wnd_table_viewer
		  
		  wnd.reset_viewer
		  
		  wnd.add_table(table0)
		  wnd.add_table(view1)
		  
		  wnd.Show
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub example_005()
		  
		  ' Example_005
		  ' - create an empty table
		  ' - fast append data
		  '
		  
		  System.DebugLog("START "+CurrentMethodName)
		  
		  
		  Dim table0 As New clDataTable("T1")
		  
		  call table0.add_columns(Array("cc1","cc2","cc3"))
		  
		  table0.append_row(Array("aaa0","bbb0","ccc0"))
		  table0.append_row(Array("aaa1","bbb1","ccc1"))
		  table0.append_row(Array("aaa2","bbb2","ccc2"))
		  table0.append_row(Array("aaa3","bbb3","ccc3"))
		  
		  dim wnd as new wnd_table_viewer
		  
		  wnd.reset_viewer
		  
		  wnd.add_table(table0) 
		  wnd.Show
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub example_006()
		  
		  ' Example_006
		  ' - create an empty table
		  ' - fast append data
		  ' - apply filter function to create a dataserie 
		  '
		  
		  System.DebugLog("START "+CurrentMethodName)
		  
		  
		  
		  Dim table0 As New clDataTable("mytable")
		  
		  call table0.add_columns(Array("country","city","sales"))
		  
		  table0.append_row(Array("France","Paris",1100))
		  table0.append_row(Array("France","Marseille",1200))
		  table0.append_row(Array("Belgique","Bruxelles",1300))
		  table0.append_row(Array("Italy","Milan",1400))
		  table0.append_row(Array("Belgique","Bruxelles",1500))
		  table0.append_row(Array("Italy","Rome",1600))
		  
		  dim tmp1() as variant = table0.filter_apply_function(AddressOf field_filter,"country","France")
		  
		  call table0.add_column(new clDataSerie("is_france", tmp1))
		  
		  call table0.add_column(new clDataSerie("is_belgium",  table0.filter_apply_function(AddressOf field_filter, "country","Belgique")))
		  
		  
		  dim wnd as new wnd_table_viewer
		  
		  wnd.reset_viewer
		  
		  wnd.add_table(table0) 
		  wnd.Show
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub example_007()
		  
		  ' Example_007
		  ' - create an empty table
		  ' - fast append data
		  ' - create a dataserie  by applying a simple operation between columns
		  '
		  
		  
		  System.DebugLog("START "+CurrentMethodName)
		  
		  
		  Dim table0 As New clDataTable("mytable")
		  
		  
		  call table0.add_column(new clDataSerie("name"))
		  call table0.add_column(new clNumberDataSerie("quantity"))
		  call table0.add_column(new clNumberDataSerie("unit_price"))
		  
		  table0.append_row(Array("alpha",50, 6.5))
		  table0.append_row(Array("beta", 20, 18))
		  table0.append_row(Array("gamma", 10, 50))
		  
		  
		  dim sr as clAbstractDataSerie = table0.add_column(clNumberDataSerie(table0.get_column("unit_price")) * clNumberDataSerie(table0.get_column("quantity")))
		  
		  
		  dim wnd as new wnd_table_viewer
		  
		  wnd.reset_viewer
		  
		  wnd.add_table(table0) 
		  wnd.Show
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub example_008()
		  
		  ' Example_008
		  ' - create an empty table
		  ' - fast append data
		  ' - apply filter function to create a dataserie 
		  '
		  
		  System.DebugLog("START "+CurrentMethodName)
		  
		  
		  
		  Dim table0 As New clDataTable("mytable")
		  
		  call table0.add_columns(Array("country","city","sales"))
		  
		  table0.append_row(Array("France","Paris",1100))
		  table0.append_row(Array("France","Marseille",1200))
		  table0.append_row(Array("Belgique","Bruxelles",1300))
		  table0.append_row(Array("USA","NewYork",1400))
		  table0.append_row(Array("Belgique","Bruxelles",1500))
		  table0.append_row(Array("USA","Chicago",1600))
		  
		  dim is_france() as variant = table0.filter_apply_function(AddressOf field_filter,"country","France")
		  dim is_belgium() as variant =  table0.filter_apply_function(AddressOf field_filter, "country","Belgique")
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
		  
		  
		  dim wnd as new wnd_table_viewer
		  
		  wnd.reset_viewer
		  
		  wnd.add_table(table0) 
		  wnd.Show
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub example_009()
		  
		  ' Example_009
		  ' - test basic validation
		  '
		  
		  System.DebugLog("START "+CurrentMethodName)
		  
		  
		  
		  Dim table0 As New clDataTable("mytable")
		  
		  call table0.add_columns(Array("country","city","sales"))
		  
		  table0.append_row(Array("France","Paris",1100))
		  table0.append_row(Array("","Marseille",1200))
		  table0.append_row(Array("Belgique","",1300))
		  table0.append_row(Array("USA","NewYork",1400))
		  table0.append_row(Array("Belgique","Bruxelles",1500))
		  table0.append_row(Array("USA","Chicago",1600))
		  
		  dim tableValid as new clDataTableValidation("validation",array( _
		  new clDataSerieValidation("country",  False, True) _
		  , new clDataSerieValidation("city", True, true) _
		  , new clDataSerieValidation("zip", True, True) _
		  ))
		  
		  Dim table1 As  clDataTable = tableValid.validate(table0)
		  
		  dim wnd as new wnd_table_viewer
		  
		  wnd.reset_viewer
		  
		  wnd.add_table(table0) 
		  wnd.add_table(table1)
		  wnd.add_table(tableValid)
		  
		  wnd.Show
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub example_010()
		  
		  '
		  ' Example_010
		  ' - create an empty datatable
		  ' - test the 'get_row' method
		  '
		  
		  System.DebugLog("START "+CurrentMethodName)
		  
		  Dim table0 As New clDataTable("mytable")
		  
		  call table0.add_columns(Array("country","city","sales"))
		  
		  table0.append_row(Array("France","Paris",1100))
		  table0.append_row(Array("","Marseille",1200))
		  table0.append_row(Array("Belgique","",1300))
		  table0.append_row(Array("USA","NewYork",1400))
		  table0.append_row(Array("Belgique","Bruxelles",1500))
		  table0.append_row(Array("USA","Chicago",1600))
		  
		  
		  for row_index as integer = 0 to table0.row_count-1
		    dim tmp_row as clDataRow = table0.get_row(row_index, True)
		    
		  next
		  
		End Sub
	#tag EndMethod


	#tag ViewBehavior
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
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
			Name="Name"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
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
