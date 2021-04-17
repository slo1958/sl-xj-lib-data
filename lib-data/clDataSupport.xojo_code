#tag Module
Protected Module clDataSupport
	#tag Method, Flags = &h0
		Function make_serie_array(paramarray series as clDataSerie) As clDataSerie()
		  Dim tmp() As clDataSerie
		  
		  For Each c As clDataSerie In series
		    tmp.Append(c)
		    
		  Next
		  
		  Return tmp
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function make_variant_array(paramarray items as variant) As variant()
		  Dim ret() As variant
		  
		  For Each item As variant In items
		    ret.append(item)
		    
		  Next
		  
		  Return ret
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function to_string(extends v as variant) As String
		  Try
		    
		    Return v.StringValue
		    
		  Catch TypeMismatchException
		    
		    
		  End Try
		  
		  If v IsA itf_string_able Then
		    Return itf_string_able(v).to_string
		    
		  End If
		  
		  Return "?"
		  
		  
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
