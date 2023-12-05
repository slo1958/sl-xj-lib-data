#tag Interface
Protected Interface TableRowWriterInterface
	#tag Method, Flags = &h0
		Sub add_row(row_data() as variant)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub alter_external_name(new_name as string)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub define_meta_data(name as string, columns() as string)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub define_meta_data(name as string, columns() as string, column_type() as string)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub done()
		  
		End Sub
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
