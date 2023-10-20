#tag Class
Protected Class cllibdataexample_05
Inherits clLibDataExample
	#tag Method, Flags = &h0
		Function describe() As string()
		  // Calling the overridden superclass method.
		  Dim returnValue() as string = Super.describe()
		  
		  
		  returnValue.append("- create an empty datatable")
		  returnValue.append("- fast append data") 
		  
		  return returnValue
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function id() As integer
		  // Calling the overridden superclass method.
		  
		  return 5
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function run() As itf_table_column_reader()
		  
		  //  Example_005
		  //  - create an empty table
		  //  - fast append data
		  //  
		  
		  System.DebugLog("START "+CurrentMethodName)
		  
		  
		  Dim table0 As New clDataTable("T1")
		  
		  call table0.add_columns(Array("cc1","cc2","cc3"))
		  
		  table0.append_row(Array("aaa0","bbb0","ccc0"))
		  table0.append_row(Array("aaa1","bbb1","ccc1"))
		  table0.append_row(Array("aaa2","bbb2","ccc2"))
		  table0.append_row(Array("aaa3","bbb3","ccc3"))
		  
		  return array(table0)
		  
		  
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
