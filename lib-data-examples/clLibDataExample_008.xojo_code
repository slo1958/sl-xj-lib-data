#tag Class
Protected Class clLibDataExample_008
Inherits clLibDataExample
	#tag CompatibilityFlags = ( TargetConsole and ( Target32Bit or Target64Bit ) ) or ( TargetWeb and ( Target32Bit or Target64Bit ) ) or ( TargetDesktop and ( Target32Bit or Target64Bit ) ) or ( TargetIOS and ( Target64Bit ) ) or ( TargetAndroid and ( Target64Bit ) )
	#tag Method, Flags = &h0
		Function describe() As string()
		  // Calling the overridden superclass method.
		  var returnValue() as string = Super.describe()
		  
		  
		  returnValue.Add("- create an empty datatable")
		  returnValue.Add("- fast append data")
		  returnValue.Add("- apply filter functions to create two dataseries")
		  returnValue.Add("- operation on dataseries to create a new dataserie")
		  
		  return returnValue
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function run(log as LogMessageInterface) As TableColumnReaderInterface()
		  
		  //  Example_008
		  //  - create an empty table
		  //  - fast append data
		  //  - apply filter function to create a dataserie 
		  //  
		  
		  
		  log.start_exec(CurrentMethodName)
		  
		  
		  
		  var table0 As New clDataTable("mytable")
		  
		  call table0.AddColumns(Array("country","city","sales"))
		  
		  table0.AddRow(Array("France","Paris",1100))
		  table0.AddRow(Array("France","Marseille",1200))
		  table0.AddRow(Array("Belgique","Bruxelles",1300))
		  table0.AddRow(Array("USA","NewYork",1400))
		  table0.AddRow(Array("Belgique","Bruxelles",1500))
		  table0.AddRow(Array("USA","Chicago",1600))
		  
		  var is_france() as variant = table0.FilterWithFunction(AddressOf BasicFieldFilter,"country","France")
		  var is_belgium() as variant =  table0.FilterWithFunction(AddressOf BasicFieldFilter, "country","Belgique")
		  var is_europe() as variant
		  
		  call table0.AddColumn(new clIntegerDataSerie("is_france"))
		  call table0.AddColumn(new clIntegerDataSerie("is_belgium"))
		  call table0.AddColumn(new clIntegerDataSerie("is_europe"))
		  
		  call table0.SetColumnValues("is_france", is_france, false)
		  call table0.SetColumnValues("is_belgium", is_belgium, false)
		  call table0.SetColumnValues("is_europe", clIntegerDataSerie(table0.GetColumn("is_france")) +clIntegerDataSerie( table0.GetColumn("is_belgium")), false)
		  
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
