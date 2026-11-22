#tag Class
Protected Class clDataPoolItem
	#tag Method, Flags = &h0
		Sub Constructor()
		  
		  self.source = clDataPool.DatapoolSource.None
		  
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		entry_label As string
	#tag EndProperty

	#tag Property, Flags = &h0
		source As clDataPool.DatapoolSource
	#tag EndProperty

	#tag Property, Flags = &h0
		table As clDataTable
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
			Name="entry_label"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="string"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="source"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="clDataPool.DatapoolSource"
			EditorType="Enum"
			#tag EnumValues
				"0 - None"
				"1 - Loaded"
				"2 - Set"
				"3 - TransformerOutput"
			#tag EndEnumValues
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
