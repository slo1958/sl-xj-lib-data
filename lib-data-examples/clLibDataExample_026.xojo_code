#tag Class
Protected Class clLibDataExample_026
Inherits clLibDataExample
	#tag CompatibilityFlags = ( TargetConsole and ( Target32Bit or Target64Bit ) ) or ( TargetWeb and ( Target32Bit or Target64Bit ) ) or ( TargetDesktop and ( Target32Bit or Target64Bit ) ) or ( TargetIOS and ( Target64Bit ) ) or ( TargetAndroid and ( Target64Bit ) )
	#tag Method, Flags = &h0
		Function describe() As string()
		  // Calling the overridden superclass method.
		  var returnValue() as string = Super.describe()
		  
		  
		  returnValue.Add("- create a datatable with order quantity of unit price per city")
		  returnValue.Add(" - calculate sales as unit price x quantity in a new column")
		  returnValue.Add("- lookup the country name")
		  returnValue.Add("- get list of distinct country/city")
		  returnValue.Add("- get total sales and total quantity per country")
		  
		  return returnValue
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function run(log as LogMessageInterface) As TableColumnReaderInterface()
		  
		  //  Example_026
		  //  - create an empty table
		  //  - fast append data
		  //  - apply filter function to create a dataserie 
		  //  
		  
		  
		  log.start_exec(CurrentMethodName)
		  
		  
		  log.start_exec(CurrentMethodName)
		  
		  
		  var tcountries as new clDataTable("Countries")
		  call  tcountries.AddColumn(new clStringDataSerie("Country"))
		  call  tcountries.AddColumn(new clStringDataSerie("City"))
		  tcountries.AddRow(new Dictionary("Country":"Belgium","City":"Brussels"))
		  tcountries.AddRow(new Dictionary("Country":"Belgium","City":"Liege"))
		  tcountries.AddRow(new Dictionary("Country":"France","City":"Paris"))
		  tcountries.AddRow(new Dictionary("Country":"USA","City":"NewYork"))
		  
		  call check_table(log, "tcountries table integrity", nil, tcountries) 
		  
		  
		  var tsales as new clDataTable("Sales")
		  
		  var ccity As clAbstractDataSerie =  tsales.AddColumn(new clStringDataSerie("City"))
		  var cqtt as clAbstractDataSerie =  tsales.AddColumn(new clNumberDataSerie("Quantity"))
		  var cup as clAbstractDataSerie = tsales.AddColumn(new clNumberDataSerie("UnitPrice"))
		  
		  tsales.AddRow(new Dictionary("City":"Brussels", "Quantity":12, "Unitprice": 21))
		  tsales.AddRow(new Dictionary("City":"Liege", "Quantity":12, "Unitprice": 22))
		  tsales.AddRow(new Dictionary("City":"Brussels", "Quantity":12, "Unitprice": 23))
		  tsales.AddRow(new Dictionary("City":"Brussels", "Quantity":12, "Unitprice": 24))
		  tsales.AddRow(new Dictionary("City":"Liege", "Quantity":12, "Unitprice": 25))
		  tsales.AddRow(new Dictionary("City":"Paris", "Quantity":12, "Unitprice": 26))
		  tsales.AddRow(new Dictionary("City":"Liege", "Quantity":12, "Unitprice": 27))
		  tsales.AddRow(new Dictionary("City":"Paris", "Quantity":12, "Unitprice": 28))
		  tsales.AddRow(new Dictionary("City":"Rome", "Quantity":10, "Unitprice": 25))
		  
		  tsales.AddColumn(clNumberDataSerie(cqtt) * clNumberDataSerie(cup)).Rename("Sales")
		   
		  
		  call check_table(log, "tsales table integrity", nil, tsales) 
		  
		  var join_results as Boolean = tsales.Lookup(tcountries, array("City"), array("Country"))
		  
		  var tdistinct as clDataTable = tsales.GroupBy(StringArray("Country", "City"))
		  
		  var tDistinct_expected As New clDataTable("mytable", SerieArray( _
		  new clStringDataSerie("Country", array("Belgium","Belgium", "France","")), _
		  new clStringDataSerie("City", array("Brussels","Liege", "Paris","Rome")) _
		  ))
		  
		  call check_table(log,"get distinct values", tDistinct_expected, tDistinct )
		  
		  var tSumSales as clDataTable = tsales.GroupBy(StringArray("Country"), StringArray("Sales","Quantity"))
		  //var gSumSales as new clGrouper(tsales))
		  
		  //var tSumSales as clDataTable = new clDataTable("group", gSumSales.Flattened)
		  
		  var tSumSales_expected As New clDataTable("mytable", SerieArray( _
		  new clStringDataSerie("Country", array("Belgium","France","")), _
		  new clNumberDataSerie("Sum of Sales", array(1704, 648,250)), _
		  new clNumberDataSerie("Sum of Quantity", array (72,24, 10)) _
		  ))
		  
		  call check_table(log,"Check total sales", tSumSales_expected, tSumSales )
		  
		  
		  return array(tsales, tcountries, tDistinct, tSumSales)
		  
		  
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
