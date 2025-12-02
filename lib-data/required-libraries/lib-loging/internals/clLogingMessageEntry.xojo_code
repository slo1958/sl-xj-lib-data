#tag Class
Protected Class clLogingMessageEntry
	#tag Method, Flags = &h0
		Sub Constructor(MessageTextId as string, MessageSeverity as string, MessageText as string)
		  MessageId = MessageTextId
		  MessageSeverity = MessageSeverity
		  MessageText = MessageText
		  
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private MessageId As string
	#tag EndProperty

	#tag Property, Flags = &h21
		Private MessageSeverity As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private MessageText As String
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
	#tag EndViewBehavior
End Class
#tag EndClass
