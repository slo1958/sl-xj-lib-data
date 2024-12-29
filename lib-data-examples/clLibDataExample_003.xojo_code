#tag Class
Protected Class clLibDataExample_003
Inherits clLibDataExample
	#tag CompatibilityFlags = ( TargetConsole and ( Target32Bit or Target64Bit ) ) or ( TargetWeb and ( Target32Bit or Target64Bit ) ) or ( TargetDesktop and ( Target32Bit or Target64Bit ) ) or ( TargetIOS and ( Target64Bit ) ) or ( TargetAndroid and ( Target64Bit ) )
	#tag Method, Flags = &h0
		Function describe() As string()
		  // Calling the overridden superclass method.
		  var returnValue() as string = Super.describe()
		  
		  returnValue.Add("- create two datatables")
		  returnValue.Add("- append table-2 to table-1 using table-2 as a column source (a table is also a column source)")
		  returnValue.Add("- append table-2 to table-1 using a row source (clTableRowReader) on table-2.")
		  
		  return returnValue
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function run(log as LogMessageInterface) As TableColumnReaderInterface()
		  //  
		  //  Example 003
		  //  
		  
		  
		  log.start_exec(CurrentMethodName)
		  
		  
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
		  
		  var table3 as clDataTable = table1.clone
		  table3. AddColumnsData(table2)
		  table3.rename("Using column source")
		  
		  var table4 as clDataTable = table1.clone
		  call table4.AddRows(new clDataTableRowReader(table2))
		  table4.rename("Using row source")
		  
		  return array (table1, table2, table3, table4)
		  
		  
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
