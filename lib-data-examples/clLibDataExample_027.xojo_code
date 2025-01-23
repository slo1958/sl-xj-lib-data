#tag Class
Protected Class clLibDataExample_027
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
		  
		  //  Example_027
		  //  - create a datatable
		  //  - apply different sort
		  //  
		  
		  log.start_exec(CurrentMethodName)
		  
		  var t1 as new clDataTable("t")
		  
		  var ccnt As clAbstractDataSerie =  t1.AddColumn(new clStringDataSerie("Country"))
		  var ccity As clAbstractDataSerie =  t1.AddColumn(new clStringDataSerie("City"))
		  var cqtt as clAbstractDataSerie =  t1.AddColumn(new clNumberDataSerie("Quantity"))
		  var cup as clAbstractDataSerie = t1.AddColumn(new clNumberDataSerie("UnitPrice"))
		  
		  t1.AddRow(new Dictionary("Country":"Italy","City":"Rome", "Quantity":12, "Unitprice": 23))
		  t1.AddRow(new Dictionary("Country":"Belgium","City":"Brussels", "Quantity":12, "Unitprice": 21))
		  t1.AddRow(new Dictionary("Country":"Belgium","City":"Liege", "Quantity":12, "Unitprice": 5))
		  t1.AddRow(new Dictionary("Country":"Belgium","City":"Liege", "Quantity":12, "Unitprice": 26))
		  t1.AddRow(new Dictionary("Country":"France","City":"Paris", "Quantity":12, "Unitprice": 4))
		  t1.AddRow(new Dictionary("Country":"Belgium","City":"Liege", "Quantity":12, "Unitprice": 28))
		  t1.AddRow(new Dictionary("Country":"Italy","City":"MIlano", "Quantity":12, "Unitprice": 29))
		  t1.AddRow(new Dictionary("Country":"France","City":"Paris", "Quantity":12, "Unitprice": 30))
		  t1.AddRow(new Dictionary("Country":"Belgium","City":"Brussels", "Quantity":12, "Unitprice": 24))
		  t1.AddRow(new Dictionary("Country":"Belgium","City":"Antwerpen", "Quantity":12, "Unitprice": 25))
		  
		  t1.AddColumn(clNumberDataSerie(cqtt) * clNumberDataSerie(cup)).Rename("Sales")
		  
		  var sort11 as clDataTable = t1.Sort(array("Country","City"))
		  //sort1.Rename("Sorted on country and city")
		  
		  var sort12 as clDataTable = t1.Sort(array("Country","UnitPrice"))
		  //sort2.Rename("Sorted on country and unit price")
		  
		  var sort13 as clDataTable = t1.Sort(array("Sales"),clDataTable.SortOrder.Descending)
		  //sort3.Rename("Sorted on Sales descending")
		  
		  var t2 as clDataTable = t1.Groupby(array("Country"), array("Sales"))
		  
		  var sort21 as clDataTable = t2.Sort(array("Sum of Sales"), clDataTable.SortOrder.Descending)
		  
		  var sort22 as clDataTable = t2.Sort(array("Country"))
		  
		  log.end_exec(CurrentMethodName)
		  
		  return  array(t1, sort11, sort12, sort13, t2, sort21, sort22)
		  
		  
		  
		  
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
