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
		  returnValue.add("- show impact of different format, extracted as clStringDataSerie")
		  
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
		  
		  
		  //
		  // Send the table to the viewer
		  //
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
