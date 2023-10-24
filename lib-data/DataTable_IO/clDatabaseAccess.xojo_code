#tag Class
Protected Class clDatabaseAccess
	#tag Method, Flags = &h0
		Sub AppendFields(table_name as string, field_names() as string, field_types() as string)
		  Raise New clDataException("Unimplemented method " + CurrentMethodName)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function convert_type(source_type as string) As String
		  return source_type
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub create_table(table_name as string, field_names() as string, field_types() as string)
		  Raise New clDataException("Unimplemented method " + CurrentMethodName)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub DropTable(table_name as string)
		  Raise New clDataException("Unimplemented method " + CurrentMethodName)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function get_db() As Database
		  
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mVerbose As Boolean
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return mVerbose
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  mVerbose = value
			End Set
		#tag EndSetter
		verbose As Boolean
	#tag EndComputedProperty


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
