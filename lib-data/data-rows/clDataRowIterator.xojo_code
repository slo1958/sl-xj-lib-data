#tag Class
Protected Class clDataRowIterator
Implements Iterator
	#tag Method, Flags = &h0
		Sub Constructor(the_keys() as string)
		  iteration_keys = the_keys
		  iteration_next_key = ""
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MoveNext() As Boolean
		  // Part of the Iterator interface.
		  
		  If iteration_keys.LastIndex>=0 Then
		    iteration_next_key = iteration_keys(0)
		    iteration_keys.remove(0)
		    Return True
		    
		  Else
		    iteration_next_key="?"
		    Return False
		    
		  End If
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Value() As Variant
		  // Part of the Iterator interface.
		  //  return name of next field
		  Return iteration_next_key
		  
		End Function
	#tag EndMethod


	#tag Note, Name = Description
		Iterates all fields in a data row
		
		
		
		
	#tag EndNote

	#tag Note, Name = Version
		0.0.1 - 2023-04-16
		First version
		
		
	#tag EndNote


	#tag Property, Flags = &h1
		Protected iteration_keys() As string
	#tag EndProperty

	#tag Property, Flags = &h0
		iteration_next_key As String
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
			Name="iteration_next_key"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
