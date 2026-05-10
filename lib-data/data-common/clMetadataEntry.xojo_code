#tag Class
Protected Class clMetadataEntry
	#tag Method, Flags = &h0
		Function CategoryValue() As string
		  
		  return MetadataCategory
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Clone() As clMetadataEntry
		  
		  
		  return new clMetadataEntry(self.MetadataCategory, self.MetadataType, self.MetadataValue)
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Datatype as string, Datavalue as string)
		  
		  MetadataCategory = ""
		  MetadataType = DataType.ReplaceAll(":","-")
		  MetadataValue = Datavalue.trim()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(DataCategory as string, Datatype as string, Datavalue as string)
		  
		  MetadataCategory = DataCategory
		  MetadataType = DataType.ReplaceAll(":","-")
		  MetadataValue = Datavalue.trim()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function DataValue() As string
		  
		  return MetadataValue
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function TypeValue() As string
		  
		  return MetadataType
		  
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private MetadataCategory As string
	#tag EndProperty

	#tag Property, Flags = &h21
		Private MetadataType As string
	#tag EndProperty

	#tag Property, Flags = &h21
		Private MetadataValue As string
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
			Name="MetadataType"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
