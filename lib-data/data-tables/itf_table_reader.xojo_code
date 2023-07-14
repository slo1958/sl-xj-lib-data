#tag Interface
Protected Interface itf_table_reader
	#tag Method, Flags = &h0
		Function column_count() As integer
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function column_names() As string()
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function get_column(the_column_name as String) As clAbstractDataSerie
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function get_columns(column_names() as string) As clAbstractDataSerie()
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function get_columns(paramarray column_names as string) As clAbstractDataSerie()
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function name() As String
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function row_count() As integer
		  
		End Function
	#tag EndMethod


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
End Interface
#tag EndInterface
