#tag Module
Protected Module clDataSerie_tests_helper
	#tag Method, Flags = &h0
		Function filter_for_test_calc_006(the_row as integer, pRowCount as integer, the_column as string, the_value as variant, paramarray pFunctionParameters as variant) As Boolean
		  Return True
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function filter_for_test_calc_010(the_row as integer, pRowCount as integer, the_column as string, the_value as variant, paramarray pFunctionParameters as variant) As Boolean
		  Return the_value <> "aaa"
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function filter_for_test_calc_017(the_row as integer, pRowCount as integer, the_column as string, the_value as variant, paramarray pFunctionParameters as variant) As Boolean
		  try
		    Return the_value = pFunctionParameters(0)
		    
		  Catch
		    return False
		    
		  end Try
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
End Module
#tag EndModule
