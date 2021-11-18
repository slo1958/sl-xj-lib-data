#tag Class
Protected Class clDataRowIterator
Implements Xojo.Core.Iterator
	#tag Method, Flags = &h0
		Sub Constructor(the_keys() as string)
		  iteration_keys = the_keys
		  iteration_next_value = ""
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MoveNext() As Boolean
		  // Part of the Xojo.Core.Iterator interface.
		  
		  If iteration_keys.Ubound>=0 Then
		    iteration_next_value = iteration_keys(0)
		    iteration_keys.remove(0)
		    Return True
		    
		  Else
		    iteration_next_value="?"
		    Return False
		    
		  End If
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Value() As Auto
		  // Part of the Xojo.Core.Iterator interface.
		  
		  Return iteration_next_value
		End Function
	#tag EndMethod


	#tag Property, Flags = &h1
		Protected iteration_keys() As string
	#tag EndProperty

	#tag Property, Flags = &h0
		iteration_next_value As String
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
			Name="iteration_next_value"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
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
End Class
#tag EndClass
