#tag Class
Protected Class clLibDataExample_015
Inherits clLibDataExample
	#tag CompatibilityFlags = ( TargetConsole and ( Target32Bit or Target64Bit ) ) or ( TargetWeb and ( Target32Bit or Target64Bit ) ) or ( TargetDesktop and ( Target32Bit or Target64Bit ) ) or ( TargetIOS and ( Target64Bit ) ) or ( TargetAndroid and ( Target64Bit ) )
	#tag Method, Flags = &h0
		Function describe() As string()
		  
		  var returnValue() as string = Super.describe()
		  
		  returnValue.Add("- create a datatable with dates")
		  returnValue.Add("- subtract col1 - col2")
		  returnValue.Add("- apply different formatting") 
		  
		  return returnValue
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function run(log as LogMessageInterface) As TableColumnReaderInterface()
		  
		  //  Example_015
		  //  - test date 
		  //  
		  
		  
		  log.start_exec(CurrentMethodName)
		  
		  var c1 As New clDateDataSerie("ExpiryDate") 
		  var c2 As New clDateDataSerie("CurrentDate") 
		  
		  c1.AddElement("2023-06-01")
		  c1.AddElement("2022-08-12")
		  
		  c2.AddElement("2021-06-01")
		  c2.AddElement("2020-08-01")
		  
		  var c3 as clIntegerDataSerie = c1 - c2
		  
		  var c4 as clIntegerDataSerie = c1 - DateTime.FromString("2020-01-01")
		  
		  var c5 as clStringDataSerie = c1.ToString()
		  
		  var c6 as clStringDataSerie = c1.ToString(DateTime.FormatStyles.Medium)
		  
		  var c7 as clStringDataSerie = c1.ToString("yyyy-MM")
		  
		  var table0 as new clDataTable("output", SerieArray(c1, c2, c3, c4, c5, c6, c7))
		  
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
