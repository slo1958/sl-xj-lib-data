#tag Class
Protected Class clBooleanParser
Implements BooleanParserInterface
	#tag Method, Flags = &h0
		Sub Constructor(str_for_true() as string)
		  
		  self.StringsAsTrue = str_for_true
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetInfo() As string
		  
		  Return "Is any of (" + string.FromArray(self.StringsAsTrue,";") + ")"
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ParseToBoolean(the_value as string) As Boolean
		  // Part of the BooleanParserInterface interface.
		  
		  return StringsAsTrue.IndexOf(the_value.trim) >= 0
		  
		End Function
	#tag EndMethod


	#tag Property, Flags = &h1
		Protected StringsAsTrue() As String
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
