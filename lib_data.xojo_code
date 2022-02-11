#tag Module
Protected Module lib_data
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

	#tag Method, Flags = &h0
		Function serie_array(paramarray series as clDataSerie) As clDataSerie()
		  Dim tmp() As clDataSerie
		  
		  For Each c As clDataSerie In series
		    tmp.Append(c)
		    
		  Next
		  
		  Return tmp
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function string_array(paramarray  items as string) As string()
		  Dim ret() As String
		  
		  For Each item As String In items
		    ret.append(item)  
		    
		  Next
		  
		  Return ret
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function variant_array(paramarray  items as variant) As variant()
		  Dim ret() As variant
		  
		  For Each item As variant In items
		    ret.append(item)
		    
		  Next
		  
		  Return ret
		  
		End Function
	#tag EndMethod


	#tag Constant, Name = Version, Type = String, Dynamic = False, Default = \"1.01.000", Scope = Public
	#tag EndConstant


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
