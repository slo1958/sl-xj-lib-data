#tag Class
Protected Class clLibDataExample_001
Inherits clLibDataExample
	#tag Method, Flags = &h0
		Function describe() As string()
		  // Calling the overridden superclass method.
		  var returnValue() as string = Super.describe()
		  
		  
		  returnValue.Add("- create an empty datatable")
		  returnValue.Add("- add three rows")
		  returnValue.add("- show the impact of the parameters passed to AddRow()")
		  
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
		  
		  var row As clDataRow
		  
		  var table As New clDataTable("mytable")
		  
		  
		  row = New clDataRow
		  row.SetCell("aaa",1234)
		  row.SetCell("bbb","abcd")
		  row.SetCell("ccc",123.4)
		  table.AddRow(row)
		  
		  row = New clDataRow
		  row.SetCell("aaa",1235)
		  row.SetCell("bbb","abce")
		  row.SetCell("ddd",987.654)
		  table.AddRow(row,True, True)
		  
		  row = New clDataRow
		  row.SetCell("aaa",1234)
		  row.SetCell("bbb","abcd")
		  row.SetCell("ccc",456.1)
		  row.SetCell("ddd",789.2)
		  table.AddRow(row)
		  
		  clIntegerDataSerie(table.GetColumn("aaa")).SetWriteFormat("###,##0", False)
		  
		  //var c as new clStringDataSerie(table.GetColumn("aaa"))
		  
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
