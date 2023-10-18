#tag Class
Protected Class clLibDataExample09
Inherits clLibDataExample
	#tag CompatibilityFlags = ( TargetConsole and ( Target32Bit or Target64Bit ) ) or ( TargetWeb and ( Target32Bit or Target64Bit ) ) or ( TargetDesktop and ( Target32Bit or Target64Bit ) ) or ( TargetIOS and ( Target64Bit ) ) or ( TargetAndroid and ( Target64Bit ) )
	#tag Method, Flags = &h0
		Function describe() As string()
		  // Calling the overridden superclass method.
		  Dim returnValue() as string = Super.describe()
		  
		  returnValue.append("- create a datatable")
		  returnValue.append("- create a validation table")
		  returnValue.append("- validate, show results of validation")
		  
		  return returnValue
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function id() As integer
		  // Calling the overridden superclass method.
		  
		  return 9
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function run() As itf_table_column_reader()
		  //
		  //  Example_009
		  //  - test basic validation
		  //  
		  
		  System.DebugLog("START "+CurrentMethodName)
		  
		  Dim table0 As New clDataTable("mytable")
		  
		  call table0.add_columns(Array("country","city","sales"))
		  
		  table0.append_row(Array("France","Paris",1100))
		  table0.append_row(Array("","Marseille",1200))
		  table0.append_row(Array("Belgique","",1300))
		  table0.append_row(Array("USA","NewYork",1400))
		  table0.append_row(Array("Belgique","Bruxelles",1500))
		  table0.append_row(Array("USA","Chicago",1600))
		  
		  dim tableValid as new clDataTableValidation("validation",array( _
		  new clDataSerieValidation("country",  False, True) _
		  , new clDataSerieValidation("city", True, true) _
		  , new clDataSerieValidation("zip", True, True) _
		  ))
		  
		  tableValid.validate(table0)
		  
		  Dim table1 As  clDataTable = tableValid.get_results()
		  
		  
		  //  all types not the same, so need to explictely build the returned array
		  dim ret() as itf_table_column_reader
		  ret.append(table0)
		  ret.append(table1)
		  ret.append(tableValid)
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
