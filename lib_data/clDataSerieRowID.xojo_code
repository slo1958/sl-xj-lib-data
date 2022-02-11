#tag Class
Protected Class clDataSerieRowID
Inherits clDataSerie
	#tag Method, Flags = &h0
		Sub append_element(the_item as Variant)
		  Self.last_index  = Self.last_index  +1
		  Super.append_element(Str(Self.last_index ))
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(the_label as string)
		  // Calling the overridden superclass constructor.
		  Super.Constructor(the_label)
		  Self.last_index = -1
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub set_element(the_element_index as integer, the_item as Variant)
		  Return
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub set_length(the_length as integer)
		  While items.Ubound < the_length-1
		    Self.last_index  = Self.last_index  +1
		    items.Append(Str(Self.last_index ))
		    
		  Wend
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		last_index As Integer
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
			Name="last_index"
			Group="Behavior"
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
