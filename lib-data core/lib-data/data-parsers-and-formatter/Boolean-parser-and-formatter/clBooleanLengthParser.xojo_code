#tag Class
Protected Class clBooleanLengthParser
Implements BooleanParserInterface
	#tag Method, Flags = &h0
		Sub Constructor(min_len as integer)
		  
		  self.MinimumLength = min_len
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetInfo() As string
		  
		  return "Minimum length " + str(MinimumLength)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ParseToBoolean(the_value as string) As Boolean
		  // Part of the BooleanParserInterface interface.
		  
		  return the_value.trim.Length >= MinimumLength
		  
		End Function
	#tag EndMethod


	#tag Property, Flags = &h1
		Protected MinimumLength As integer
	#tag EndProperty


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
