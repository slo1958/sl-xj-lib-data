#tag Class
Protected Class clDataSerie
	#tag Method, Flags = &h0
		Sub append_element(the_item as Variant)
		  items.Append(the_item)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(the_label as string)
		  serie_name = the_label
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function get_element(the_element_index as integer) As Variant
		  If items.Ubound >= the_element_index Then
		    Return items(the_element_index)
		    
		  Else
		    Return ""
		    
		  End If
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function name() As String
		  Return serie_name
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function row_count() As integer
		  Return items.Ubound+1
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub set_element(the_element_index as integer, the_item as Variant)
		  If items.Ubound <= the_element_index Then
		    items(the_element_index) = the_item
		    
		  End If
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub set_length(the_length as integer)
		  While items.Ubound < the_length-1
		    items.Append("")
		    
		  Wend
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h1
		Protected items() As Variant
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected serie_name As string
	#tag EndProperty


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
			Name="name"
			Group="Behavior"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="serie_name"
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
End Class
#tag EndClass
