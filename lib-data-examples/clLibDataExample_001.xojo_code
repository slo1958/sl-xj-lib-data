#tag Class
Protected Class clLibDataExample_001
Inherits clLibDataExample
	#tag Method, Flags = &h0
		Function describe() As string()
		  // Calling the overridden superclass method.
		  Dim returnValue() as string = Super.describe()
		  
		  
		  returnValue.Add("- create an empty datatable")
		  returnValue.Add("- add three rows")
		  
		  return returnValue
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function run(log as LogMessageInterface) As TableColumnReaderInterface()
		  
		  //  Example_001 
		  //  - create an empty datatable
		  //  - add three rows
		  //  
		  
		  
		  log.start_exec(CurrentMethodName)
		  
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
		  
		  
		  return array(table)
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
