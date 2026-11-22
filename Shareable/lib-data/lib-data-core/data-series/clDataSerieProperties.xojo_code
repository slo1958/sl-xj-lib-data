#tag Class
Protected Class clDataSerieProperties
	#tag Method, Flags = &h0
		Sub Constructor()
		  
		End Sub
	#tag EndMethod


	#tag Note, Name = Untitled
		
		
	#tag EndNote


	#tag Property, Flags = &h0
		Aliases() As string
	#tag EndProperty

	#tag Property, Flags = &h0
		DataType As String
	#tag EndProperty

	#tag Property, Flags = &h0
		DefaultValue As variant
	#tag EndProperty

	#tag Property, Flags = &h0
		FormatStr As String
	#tag EndProperty

	#tag Property, Flags = &h0
		MetaData As clMetadata
	#tag EndProperty

	#tag Property, Flags = &h0
		SerieTitle As String
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
		#tag ViewProperty
			Name="SerieTitle"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="FormatStr"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="DataType"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
