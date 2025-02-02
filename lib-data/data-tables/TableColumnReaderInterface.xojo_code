#tag Interface
Protected Interface TableColumnReaderInterface
	#tag Method, Flags = &h0
		Function ColumnCount() As integer
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetAllColumns() As clAbstractDataSerie()
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetColumn(pColumnName as String, IncludeAlias as boolean = False) As clAbstractDataSerie
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetColumnAt(column_index as integer) As clAbstractDataSerie
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetColumnNames() As string()
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsPersistant() As boolean
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Name() As String
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function RowCount() As integer
		  
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
