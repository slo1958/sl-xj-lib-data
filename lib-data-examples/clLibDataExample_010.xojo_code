#tag Class
Protected Class clLibDataExample_010
Inherits clLibDataExample
	#tag CompatibilityFlags = ( TargetConsole and ( Target32Bit or Target64Bit ) ) or ( TargetWeb and ( Target32Bit or Target64Bit ) ) or ( TargetDesktop and ( Target32Bit or Target64Bit ) ) or ( TargetIOS and ( Target64Bit ) ) or ( TargetAndroid and ( Target64Bit ) )
	#tag Method, Flags = &h0
		Function describe() As string()
		  // Calling the overridden superclass method.
		  Dim returnValue() as string = Super.describe()
		  
		  
		  returnValue.Add("- create a datatable")
		  returnValue.Add("- test the 'get_row' method")
		  
		  
		  return returnValue
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function run(log as itf_logmessage_writer) As itf_table_column_reader()
		  //  
		  //  Example_010
		  //  - create an empty datatable
		  //  - test the 'get_row/' method
		  //  
		  
		  
		  log.start_exec(CurrentMethodName)
		  
		  Dim table0 As New clDataTable("mytable")
		  
		  call table0.add_columns(Array("country","city","sales"))
		  
		  table0.append_row(Array("France","Paris",1100))
		  table0.append_row(Array("","Marseille",1200))
		  table0.append_row(Array("Belgique","",1300))
		  table0.append_row(Array("USA","NewYork",1400))
		  table0.append_row(Array("Belgique","Bruxelles",1500))
		  table0.append_row(Array("USA","Chicago",1600))
		  
		  
		  dim table1 as new clDataTable("res")
		  
		  for row_index as integer = 0 to table0.row_count-1
		    dim tmp_row as clDataRow = table0.get_row(row_index, True)
		    table1.append_row(tmp_row)
		  next
		  
		  
		  return array(table0, table1)
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
