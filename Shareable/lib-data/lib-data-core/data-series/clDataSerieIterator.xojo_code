#tag Class
Protected Class clDataSerieIterator
Implements Iterator
	#tag Method, Flags = &h0
		Sub Constructor(the_serie as clAbstractDataSerie)
		  current_index = -1
		  temp_serie = the_serie
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MoveNext() As Boolean
		  // Part of iterator
		  
		  if temp_serie = nil then
		    iteration_next_value = ""
		    return false
		    
		  elseif current_index >= temp_serie.LastIndex then
		    iteration_next_value = ""
		    return false
		    
		  else
		    current_index = current_index + 1
		    iteration_next_value = temp_serie.GetElement(current_index)
		    Return True
		    
		  end if
		  
		  
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Value() As Variant
		  // Part of the Iterator interface.
		  
		  Return iteration_next_value
		  
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0
		current_index As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		iteration_next_value As variant
	#tag EndProperty

	#tag Property, Flags = &h0
		temp_serie As clAbstractDataSerie
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
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
			Name="Name"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
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
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="current_index"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
