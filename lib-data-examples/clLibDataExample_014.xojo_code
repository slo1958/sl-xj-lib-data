#tag Class
Protected Class clLibDataExample_014
Inherits clLibDataExample
	#tag CompatibilityFlags = ( TargetConsole and ( Target32Bit or Target64Bit ) ) or ( TargetWeb and ( Target32Bit or Target64Bit ) ) or ( TargetDesktop and ( Target32Bit or Target64Bit ) ) or ( TargetIOS and ( Target64Bit ) ) or ( TargetAndroid and ( Target64Bit ) )
	#tag Method, Flags = &h0
		Function describe() As string()
		  
		  var returnValue() as string = Super.describe()
		  
		  returnValue.Add("- create a datatable")
		  returnValue.Add("- calculate sales * 2  BFEORE sales is clipped")
		  returnValue.Add("- apply clip_range 1000..2000 on the sales column")
		  returnValue.Add("- created a new column using clipped_by_range 1100..1500 and multiply results by 2")
		  
		  
		  return returnValue
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function run(log as LogMessageInterface) As TableColumnReaderInterface()
		  
		  //  Example_014
		  //  - test clip and clipped
		  //  
		  
		  
		  log.start_exec(CurrentMethodName)
		  
		  
		  var col_country as new clDataSerie("Country", "France", "", "Belgique", "France", "USA")
		  var col_city as new clDataSerie("City", "Paris", "Marseille", "Bruxelles", "Lille", "Chicago")
		  var col_sales as new clNumberDataSerie("sales", 900.0, 1200.0, 1400.0, 1600.0, 2900)
		  
		  var table0 As New clDataTable("mytable", serie_array(col_country, col_city, col_sales))
		  
		  table0.append_row(Array("France","Paris",1100))
		  table0.append_row(Array("","Marseille",1200))
		  table0.append_row(Array("Belgique","",1300))
		  table0.append_row(Array("France","Paris",2100))
		  table0.append_row(Array("","Marseille",2200))
		  table0.append_row(Array("Belgique","",2300))
		  
		  call table0.AddColumn(col_sales *2 )
		  
		  call table0.clip_range("sales",1000, 2000)
		  
		  call table0.AddColumn(col_sales.clipped_by_range(1100, 1500) * 2)
		  
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
