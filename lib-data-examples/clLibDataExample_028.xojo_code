#tag Class
Protected Class clLibDataExample_028
Inherits clLibDataExample
	#tag CompatibilityFlags = ( TargetConsole and ( Target32Bit or Target64Bit ) ) or ( TargetWeb and ( Target32Bit or Target64Bit ) ) or ( TargetDesktop and ( Target32Bit or Target64Bit ) ) or ( TargetIOS and ( Target64Bit ) ) or ( TargetAndroid and ( Target64Bit ) )
	#tag Method, Flags = &h0
		Function describe() As string()
		  // Calling the overridden superclass method.
		  var returnValue() as string = Super.describe()
		  
		  
		  returnValue.Add("- create a datatable with order quantity of unit price per city")
		  returnValue.Add(" - inner and outer full join with a country table")
		  
		  return returnValue
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function run(log as LogMessageInterface) As TableColumnReaderInterface()
		  
		  //  Example_028
		  //  - create a datatable
		  //  - apply joins
		  //  
		  
		  log.start_exec(CurrentMethodName)
		  
		  var tcountries1 as new clDataTable("Countries1")
		  call  tcountries1.AddColumn(new clStringDataSerie("Country"))
		  call  tcountries1.AddColumn(new clStringDataSerie("City"))
		  tcountries1.AddRow(new Dictionary("Country":"Belgium","City":"Brussels"))
		  tcountries1.AddRow(new Dictionary("Country":"Belgium","City":"Liege"))
		  tcountries1.AddRow(new Dictionary("Country":"France","City":"Paris"))
		  tcountries1.AddRow(new Dictionary("Country":"USA","City":"NewYork"))
		  tcountries1.AddRow(new Dictionary("City":"London"))
		  
		  
		  var tcountries2 as new clDataTable("Countries2")
		  call  tcountries2.AddColumn(new clStringDataSerie("Country"))
		  call  tcountries2.AddColumn(new clStringDataSerie("City"))
		  tcountries2.AddRow(new Dictionary("Country":"USA","City":"NewYork"))
		  tcountries2.AddRow(new Dictionary("Country":"France","City":"Lyon"))
		  tcountries2.AddRow(new Dictionary("Country":"Spain","City":"Madrid"))
		  
		  var tcountries3 as new clDataTable("Countries3")
		  call  tcountries3.AddColumn(new clStringDataSerie("Country"))
		  call  tcountries3.AddColumn(new clStringDataSerie("City"))
		  call tcountries3.AddColumn(new clStringDataSerie("Something"))
		  
		  tcountries3.AddRow(new Dictionary("Country":"Belgium","City":"Brussels","Something":"Alpha"))
		  tcountries3.AddRow(new Dictionary("Country":"Belgium","City":"Liege","Something":"Beta"))
		  tcountries3.AddRow(new Dictionary("Country":"Belgium","City":"Liege","Something":"Gamma"))
		  tcountries3.AddRow(new Dictionary("Country":"France","City":"Paris","Something":"Delta"))
		  tcountries3.AddRow(new Dictionary("Country":"France","City":"Lille","Something":"Omega"))
		  tcountries3.AddRow(new Dictionary("Country":"USA","City":"NewYork","Something":"Zeta"))
		  tcountries3.AddRow(new Dictionary("City":"London"))
		  
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
		  tsales.AddRow(new Dictionary("City":"London", "Quantity":14, "Unitprice": 30))
		  tsales.AddRow(new Dictionary("City":"Rome", "Quantity":10, "Unitprice": 25))
		  
		  
		  var tjoin1 as clDataTable = tsales.FullJoin(tcountries1, clDataTable.JoinMode.InnerJoin, array("City"))
		  
		  var tjoin2 as clDataTable = tsales.FullJoin(tcountries1, clDataTable.JoinMode.OuterJoin, array("City"))
		  
		  var tjoin3 as clDataTable = tsales.FullJoin(tcountries2, clDataTable.JoinMode.InnerJoin, array("City"))
		  
		  var tjoin4 as clDataTable = tsales.FullJoin(tcountries2, clDataTable.JoinMode.OuterJoin, array("City"))
		  
		  var tjoin5 as clDataTable = tsales.FullJoin(tcountries3, clDataTable.JoinMode.InnerJoin, array("City"))
		  
		  var tjoin6 as clDataTable = tsales.FullJoin(tcountries3, clDataTable.JoinMode.OuterJoin, array("City"))
		  
		  log.end_exec(CurrentMethodName)
		  
		  return  array(tsales, tcountries1, tcountries2, tcountries3, tjoin1, tjoin2, tjoin3, tjoin4, tjoin5, tjoin6)
		  
		  
		  
		  
		  
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
