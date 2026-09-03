#tag Interface
Protected Interface TableRowWriterInterface
	#tag Method, Flags = &h0
		Sub AddRow(row_data() as variant)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AllDone()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub DefineColumns(name as string, columns() as string, column_type() as string)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub DoneWithTable()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub UpdateExternalName(new_name as string)
		  
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
