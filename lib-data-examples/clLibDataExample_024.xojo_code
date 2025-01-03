#tag Class
Protected Class clLibDataExample_024
Inherits clLibDataExample
	#tag CompatibilityFlags = ( TargetConsole and ( Target32Bit or Target64Bit ) ) or ( TargetWeb and ( Target32Bit or Target64Bit ) ) or ( TargetDesktop and ( Target32Bit or Target64Bit ) ) or ( TargetIOS and ( Target64Bit ) ) or ( TargetAndroid and ( Target64Bit ) )
	#tag Method, Flags = &h0
		Function describe() As string()
		  // Calling the overridden superclass method.
		  var returnValue() as string = Super.describe()
		  
		  
		  returnValue.Add("- create an empty datatable")
		  returnValue.Add("- apply filter functions to create two dataseries")
		  returnValue.Add("- operation on dataseries to create a new dataserie")
		  returnValue.Add("- customise formatting of boolean values")
		  returnValue.Add("- range formatting for number values, using another table")
		  
		  return returnValue
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function run(log as LogMessageInterface) As TableColumnReaderInterface()
		  
		  //  Example_024
		  //  - create an empty table
		  //  - fast append data
		  //  - apply filter function to create a dataserie 
		  //  
		  
		  
		  log.start_exec(CurrentMethodName)
		  
		  
		  
		  var table0 As New clDataTable("mytable")
		  
		  call table0.AddColumns(Array("country","city"))
		  var col_cloned_sales as clNumberDataSerie =  clNumberDataSerie(table0.AddColumn(new clNumberDataSerie("sales")))
		  
		  table0.AddRow(Array("France","Paris",600))
		  table0.AddRow(Array("France","Marseille",3200))
		  table0.AddRow(Array("Belgique","Bruxelles",1300))
		  table0.AddRow(Array("USA","NewYork",2400))
		  table0.AddRow(Array("Belgique","Bruxelles",1500))
		  table0.AddRow(Array("USA","Chicago",1600))
		  table0.AddRow(Array("Italy","Rome",5))
		  
		  
		  col_cloned_sales = col_cloned_sales.Clone()
		  col_cloned_sales.name = "Formatted sales"
		  
		  call table0.AddColumn(col_cloned_sales)
		  
		  var colmin as new clNumberDataSerie("min_value")
		  var colmax as new clNumberDataSerie("max_value")
		  var collabel as new clDataSerie("range_label")
		  
		  var rangeTable as new clDataTable("myranges" , SerieArray( colmin, colmax, collabel))
		  
		  rangeTable.AddRow(new Dictionary("min_value":10, "max_value": 999.999, "range_label":"Small"))
		  rangeTable.AddRow(new Dictionary("min_value":1000, "max_value": 1999.999, "range_label":"Medium"))
		  rangeTable.AddRow(new Dictionary("min_value":2000, "max_value": 2999.999, "range_label":"Big"))
		  
		  col_cloned_sales.ActiveRangeFormatting("","")
		  col_cloned_sales.AddFormattingRanges(colmin, colmax, collabel)
		  
		  
		  call table0.AddColumn(new clBooleanDataSerie("is_france", table0.FilterWithFunction(AddressOf BasicFieldFilter,"country","France")))
		  call table0.AddColumn(new clBooleanDataSerie("is_belgium", table0.FilterWithFunction(AddressOf BasicFieldFilter, "country","Belgique")))
		  
		  
		  clBooleanDataSerie(table0.GetColumn("is_france")).SetFormat("≠ France","= France")
		  
		  return array(table0, rangeTable)
		  
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
