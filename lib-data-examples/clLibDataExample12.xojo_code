#tag Class
Protected Class clLibDataExample12
Inherits clLibDataExample
	#tag CompatibilityFlags = ( TargetConsole and ( Target32Bit or Target64Bit ) ) or ( TargetWeb and ( Target32Bit or Target64Bit ) ) or ( TargetDesktop and ( Target32Bit or Target64Bit ) ) or ( TargetIOS and ( Target64Bit ) ) or ( TargetAndroid and ( Target64Bit ) )
	#tag Method, Flags = &h0
		Function describe() As string()
		  
		  Dim returnValue() as string = Super.describe()
		  
		  returnValue.Add("- create a datatable")
		  returnValue.Add("- Text string handling")
		  returnValue.Add("- split the text field into country and city")
		  returnValue.add("- get total sales per country")
		  returnValue.Add("- get list of unique country/city pairs")
		  
		  return returnValue
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function id() As integer
		  return 12
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function run() As itf_table_reader()
		  
		  //  Example_012
		  //  - test string handling
		  //  - test basic 'unique'
		  //  
		  
		  System.DebugLog("START "+CurrentMethodName)
		  
		  
		  dim col_source as new clStringDataSerie("source", "France-Paris","Belgique-","Belgque-Bruxelles", "USA-NewYork", "USA-Chicago", "France-Marseille")
		  dim col_sales as new clNumberDataSerie("sales", 1000,1100, 1200, 1300, 1400, 1500)
		  
		  dim table1 as new clDataTable("source table", serie_array(col_source, col_sales))
		  
		  
		  // we split the "source" field to extract country and city
		  
		  dim table2 as new clDataTable("prepared", serie_array( _
		  col_source, _
		  col_source.text_before("-").rename("country"), _
		  col_source.text_after("-").rename("city"), _
		  col_sales),_
		  true)
		  
		  
		  dim col_city  as clStringDataSerie = clStringDataSerie(table2.get_column("city"))
		  
		  call table2.add_column(col_city.Uppercase.rename("City UC"))
		  
		  Dim table3 As clDataTable = table2.unique(array("country", "city"))
		  
		  
		  dim table4 as clDataTable  = table2.groupby(array("country"), array("Sales"), array(""))
		  
		  dim ret() as itf_table_reader
		  ret.Add(table1)
		  ret.Add(table2)
		  ret.Add(table3)
		  ret.add(table4)
		  
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
