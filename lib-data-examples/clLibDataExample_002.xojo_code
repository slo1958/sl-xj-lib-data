#tag Class
Protected Class clLibDataExample_002
Inherits clLibDataExample
	#tag CompatibilityFlags = ( TargetConsole and ( Target32Bit or Target64Bit ) ) or ( TargetWeb and ( Target32Bit or Target64Bit ) ) or ( TargetDesktop and ( Target32Bit or Target64Bit ) ) or ( TargetIOS and ( Target64Bit ) ) or ( TargetAndroid and ( Target64Bit ) )
	#tag Method, Flags = &h0
		Function describe() As string()
		  // Calling the overridden superclass method.
		  var returnValue() as string = Super.describe()
		  
		  returnValue.Add("- create a small table")
		  returnValue.Add("- aggregate using 0, 1 and 2 dimensions")
		  
		  return returnValue
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function run(log as LogMessageInterface) As TableColumnReaderInterface()
		  
		  //  Example_002
		  //  - create a small table
		  //  - aggregate using 0, 1 and 2 dimensions
		  //  
		  
		  
		  
		  log.start_exec(CurrentMethodName)
		  
		  
		  var table0 As New clDataTable("mytable", SerieArray( _
		  New clDataSerie("City",  "Paris","Lyon","Namur","Paris","Charleroi","Milan") _
		  , New clDataSerie("Country", "FR","FR","BE","FR","BE","IT") _
		  , New clDataSerie("Year", 2000,2000,2000,2000,2000,2000) _
		  , New clNumberDataSerie("Sales", 100,200,300,400,500,600) _
		  , New clNumberDataSerie("Quantity", 51, 52,53,54, 55,56) _
		  ))
		  
		  var newcol as clAbstractDataSerie =  table0.AddColumn( table0.GetNumberColumn("Sales") / table0.GetNumberColumn("Quantity"))
		  newcol.rename("PPU")
		  
		  var table1 As clDataTable = table0.groupby(Array("Country"), Array( _
		  "Sales": clDataTable.AggSum, _
		  "PPU":clDataTable.AggMin, _
		  "PPU":clDataTable.AggMax _
		  ))
		  
		  var table2 As clDataTable = table0.GroupBy(Array(""), Array("Sales"))
		  table2.rename("Grand total")
		  
		  var table3 As clDataTable = table0.GroupBy(StringArray("Country","City"), StringArray)
		  
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
