#tag Class
Protected Class clLibDataExample02
Inherits clLibDataExample
	#tag Method, Flags = &h0
		Function describe() As string()
		  // Calling the overridden superclass method.
		  Dim returnValue() as string = Super.describe()
		  
		  
		  returnValue.append("Example_002")
		  returnValue.append("- create a small table")
		  returnValue.append("- aggregate using 0, 1 and 2 dimensions")
		  
		  return returnValue
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function id() As integer
		  // Calling the overridden superclass method.
		  
		  return 2
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function run() As itf_table_reader()
		  
		  //  Example_002
		  //  - create a small table
		  //  - aggregate using 0, 1 and 2 dimensions
		  //  
		  
		  
		  System.DebugLog("START "+CurrentMethodName)
		  
		  
		  Dim table0 As New clDataTable("mytable", serie_array( _
		  New clDataSerie("City",  "Paris","Lyon","Namur","Paris","Charleroi","Milan") _
		  , New clDataSerie("Country", "FR","FR","BE","FR","BE","IT") _
		  , New clDataSerie("Year", 2000,2000,2000,2000,2000,2000) _
		  , New clDataSerie("Sales", 100,200,300,400,500,600) _
		  , New clDataSerie("Quantity", 51, 52,53,54, 55,56) _
		  ))
		  
		  
		  Dim table1 As clDataTable = table0.groupby(string_array("Country"), string_array("Sales"), string_array(""))
		  
		  
		  Dim table2 As clDataTable = table0.groupby(string_array, string_array("Sales"), string_array)
		  table2.rename("Grand total")
		  
		  Dim table3 As clDataTable = table0.groupby(string_array("Country","City"), string_array, string_array(""))
		  
		  return array(table0, table1, table2, table3)
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
