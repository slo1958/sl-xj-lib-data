#tag Class
Protected Class clLibDataExample_014
Inherits clLibDataExample
	#tag CompatibilityFlags = ( TargetConsole and ( Target32Bit or Target64Bit ) ) or ( TargetWeb and ( Target32Bit or Target64Bit ) ) or ( TargetDesktop and ( Target32Bit or Target64Bit ) ) or ( TargetIOS and ( Target64Bit ) ) or ( TargetAndroid and ( Target64Bit ) )
	#tag Method, Flags = &h0
		Function describe() As string()
		  
		  var returnValue() as string = Super.describe()
		  
		  returnValue.Add("- create a datatable")
		  returnValue.Add("- calculate sales * 20%  ")
		  returnValue.Add("- Clone the sales column as 'sales base'")
		  returnValue.Add("- apply ClipByRange 1000..2000 on the 'sales base' column")
		  returnValue.Add("- created a new column using ClippedByRange 1100..1500")
		  
		  
		  return returnValue
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function run(log as LogMessageInterface) As TableColumnReaderInterface()
		  
		  //  Example_014
		  //  - test clip and clipped
		  //  
		  
		  
		  log.start_exec(CurrentMethodName)
		  
		  
		  //
		  // Create three data series
		  //
		  var col_country as new clDataSerie("Country", "France", "", "Belgique", "France", "USA")
		  var col_city as new clDataSerie("City", "Paris", "Marseille", "Bruxelles", "Lille", "Chicago")
		  var col_sales as new clNumberDataSerie("sales", 900.0, 1200.0, 1400.0, 1600.0, 2900)
		  
		  //
		  //  Create a table and add the data series
		  //
		  var table0 As New clDataTable("mytable", SerieArray(col_country, col_city, col_sales))
		  
		  //
		  // Add more data row by row
		  //
		  table0.AddRow(Array("France","Paris",1100))
		  table0.AddRow(Array("","Marseille",1200))
		  table0.AddRow(Array("Belgique","",1300))
		  table0.AddRow(Array("France","Paris",2100))
		  table0.AddRow(Array("","Marseille",2200))
		  table0.AddRow(Array("Belgique","",2300))
		  
		  // 
		  // Add a calculated column as 20% of sales
		  //
		  call table0.AddColumn(col_sales * 0.2 )
		  
		  //
		  // Retain the original sales column 
		  //
		  call table0.AddColumn(col_sales.Clone("Sales base"))
		  
		  // 
		  // clip the sales column
		  //
		  call table0.ClipByRange("Sales base",1000, 2000)
		  
		  //
		  // Add a new column with clipped sales
		  call table0.AddColumn(col_sales.ClippedByRange(1100, 1500) )
		  
		  //
		  // Send the tables to the viewer
		  //
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
