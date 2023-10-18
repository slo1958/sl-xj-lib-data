#tag Interface
Protected Interface itf_table_column_reader
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
		Function is_persistant() As boolean
		  
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


	#tag Note, Name = Description
		Interface to scan a table.
		Implemented on clDataTable
		
		Can also be used to present another structure as a table
		
		
		The source is persistant if we can query it at will. 
	#tag EndNote


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
