#tag Class
Protected Class clJSONFileConfig
	#tag Method, Flags = &h0
		Sub Constructor()
		  
		  SetDefaultValues
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub SetDefaultValues()
		  
		  self.KeyForHeader = DefaultKeyForHeader
		  self.KeyForData = DefaultKeyForData
		  
		  self.KeyForDatasetName = DefaultKeyForDatasetName
		  self.KeyForListOfColumns = DefaultKeyForListOfColumns
		  self.KeyforFieldName = DefaultKeyforFieldName
		  self.KeyForFieldType = DefaultKeyForFieldType
		  
		  self.KeyForManifest = DefaultKeyForManifest
		  self.KeyForTables = DefaultKeyForTables
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		KeyForData As string
	#tag EndProperty

	#tag Property, Flags = &h0
		KeyForDatasetName As string
	#tag EndProperty

	#tag Property, Flags = &h0
		KeyforFieldName As String
	#tag EndProperty

	#tag Property, Flags = &h0
		KeyForFieldType As string
	#tag EndProperty

	#tag Property, Flags = &h0
		KeyForHeader As string
	#tag EndProperty

	#tag Property, Flags = &h0
		KeyForListOfColumns As string
	#tag EndProperty

	#tag Property, Flags = &h0
		KeyForManifest As string
	#tag EndProperty

	#tag Property, Flags = &h0
		KeyForTables As string
	#tag EndProperty


	#tag Constant, Name = DefaultKeyForData, Type = String, Dynamic = False, Default = \"data", Scope = Public
	#tag EndConstant

	#tag Constant, Name = DefaultKeyForDatasetName, Type = String, Dynamic = False, Default = \"name", Scope = Public
	#tag EndConstant

	#tag Constant, Name = DefaultKeyforFieldName, Type = String, Dynamic = False, Default = \"name", Scope = Public
	#tag EndConstant

	#tag Constant, Name = DefaultKeyForFieldType, Type = String, Dynamic = False, Default = \"type", Scope = Public
	#tag EndConstant

	#tag Constant, Name = DefaultKeyForHeader, Type = String, Dynamic = False, Default = \"header", Scope = Public
	#tag EndConstant

	#tag Constant, Name = DefaultKeyForListOfColumns, Type = String, Dynamic = False, Default = \"columns", Scope = Public
	#tag EndConstant

	#tag Constant, Name = DefaultKeyForManifest, Type = String, Dynamic = False, Default = \"manifest", Scope = Public
	#tag EndConstant

	#tag Constant, Name = DefaultKeyForTables, Type = String, Dynamic = False, Default = \"tables", Scope = Public
	#tag EndConstant


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
			Name="KeyForData"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="string"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="KeyForDatasetName"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="string"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="KeyforFieldName"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="KeyForFieldType"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="string"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="KeyForHeader"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="string"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="KeyForListOfColumns"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="string"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="KeyForManifest"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="string"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="KeyForTables"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="string"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
