#tag Class
Protected Class clLibDataExample_016
Inherits clLibDataExample
	#tag CompatibilityFlags = ( TargetConsole and ( Target32Bit or Target64Bit ) ) or ( TargetWeb and ( Target32Bit or Target64Bit ) ) or ( TargetDesktop and ( Target32Bit or Target64Bit ) ) or ( TargetIOS and ( Target64Bit ) ) or ( TargetAndroid and ( Target64Bit ) )
	#tag Method, Flags = &h0
		Function describe() As string()
		  
		  var returnValue() as string = Super.describe()
		  
		  returnValue.Add("- create a datatable with dates")
		  returnValue.Add("- compare payment date with deadline")
		  returnValue.Add("- flag late payment")
		  returnValue.Add("- calculate late payment pernalty")
		  
		  return returnValue
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function run(log as LogMessageInterface) As TableColumnReaderInterface()
		  
		  //  Example_016
		  //  - test date 
		  //  
		  
		  
		  log.start_exec(CurrentMethodName)
		  
		  // Build the table, to simulate loading from an external data source
		  var col_country as new clDataSerie("Customer", "C001", "", "C002", "C003", "C004","C005")
		  var col_city as new clDataSerie("City", "Paris", "Marseille", "Bruxelles", "Lille", "Chicago")
		  var col_sales as new clNumberDataSerie("sales", 900.0, 1200.0, 1400.0, 1600.0, 2900)
		  var col_penalty as new clNumberDataSerie("%up", 0.12, 0.12, 0.12 , 0.12, 0.12)
		  var col_expiry as new clDateDataSerie("InvoiceDate", "2023-03-05","2023-03-07","2023-03-12","2023-03-19","2023-04-03")
		  var col_pay as new clDateDataSerie("PaymentDate", "2023-03-08","2023-03-27","2023-03-20","2023-04-05","2023-05-12")
		  
		  col_penalty.SetFormat("#%")
		  
		  var table0 as new clDataTable("mytable", SerieArray(col_country, col_city, col_sales, col_expiry, col_pay, col_penalty))
		  
		  // 
		  // Start calculation
		  //
		  // number of days vs expiry date
		  var delay as clIntegerDataSerie = col_pay - col_expiry
		  
		  // flag if number of days > 15 days
		  var flagged as clIntegerDataSerie = new clIntegerDataSerie("late-payment",delay.GetFilterColumnValuesInRange(15,9999))
		  
		  // calculate penalty and give a better name
		  var total_penaty as clNumberDataSerie = col_sales * col_penalty * flagged.ToDouble()
		  total_penaty.rename("penalty")
		  
		  // update table
		  call table0.AddColumns(SerieArray(delay, flagged, total_penaty))
		  
		  var ret() as TableColumnReaderInterface
		  
		  ret.add(table0)
		  
		  return ret
		  
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
