#tag Class
Protected Class clLogingWriterEntry
	#tag Method, Flags = &h0
		Sub Constructor(WriterID as String, Writer as itfLogingWriter)
		  
		  self.identity = WriterID
		  self.enabled = True
		  self.log_writer = Writer
		  
		End Sub
	#tag EndMethod


	#tag Note, Name = read me
		Internal class used by clLoging to store log writer information
		
		
	#tag EndNote


	#tag Property, Flags = &h0
		enabled As Boolean
	#tag EndProperty

	#tag Property, Flags = &h0
		identity As String
	#tag EndProperty

	#tag Property, Flags = &h0
		log_writer As itfLogingWriter
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="enabled"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="identity"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
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
