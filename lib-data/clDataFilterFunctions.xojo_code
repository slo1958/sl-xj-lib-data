#tag Module
Protected Module clDataFilterFunctions
	#tag Method, Flags = &h0
		Function retain_serie_head(the_row as integer, the_row_count as integer, the_column as string, the_value as variant, paramarray function_param as variant) As Boolean
		  //
		  // pass the number of head items to flag as 'True' as first parameter
		  // Default value is 10
		  //
		  
		  If function_param.ubound >= 0 Then
		    Dim tmp As Integer = function_param(0)
		    Return the_row < tmp
		    
		  Else
		    Return the_row < 10
		    
		  End If
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function retain_serie_tail(the_row as integer, the_row_count as integer, the_column as string, the_value as variant, paramarray function_param as variant) As Boolean
		  //
		  // pass the number of tail items to flag as 'True' as first parameter
		  // Default value is 10
		  //
		  
		  If function_param.ubound >= 0 Then
		    
		    Dim tmp As Integer = function_param(0)
		    Return the_row > the_row_count - tmp
		    
		  Else
		    Dim tmp As Integer = 10
		    Return  the_row > the_row_count - 10
		    
		  End If
		  
		End Function
	#tag EndMethod


	#tag ViewBehavior
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
	#tag EndViewBehavior
End Module
#tag EndModule
