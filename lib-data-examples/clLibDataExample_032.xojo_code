#tag Class
Protected Class clLibDataExample_032
Inherits clLibDataExample
	#tag CompatibilityFlags = ( TargetConsole and ( Target32Bit or Target64Bit ) ) or ( TargetWeb and ( Target32Bit or Target64Bit ) ) or ( TargetDesktop and ( Target32Bit or Target64Bit ) ) or ( TargetIOS and ( Target64Bit ) ) or ( TargetAndroid and ( Target64Bit ) )
	#tag Method, Flags = &h0
		Function describe() As string()
		  // Calling the overridden superclass method.
		  var returnValue() as string = Super.describe()
		  
		  returnValue.add("(Found on Xojo Forum)")
		  returnValue.add("I have 2 related arrays of data. I would like to list the sales, grouped by category id.")
		  returnValue.add("I can figure out how to group the categories on 3 lines, but I can’t determine how to group the sales with the categories.")
		  
		  return returnValue
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function run(log as LogMessageInterface) As TableColumnReaderInterface()
		  //
		  //  Example_032
		  //  - create an empty table
		  //  - append data
		  //  - groupby the results
		  // - (found on Xojo forum)
		  //  
		  
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
