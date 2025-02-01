#tag Interface
Protected Interface TableRowReaderInterface
	#tag Method, Flags = &h0
		Function ColumnCount() As integer
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function CurrentRowIndex() As integer
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function EndOfTable() As boolean
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetColumnNames() As string()
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetColumnTypes() As dictionary
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetListOfExternalElements() As string()
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Name() As string
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function NextRow() As clDataRow
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function NextRowAsVariant() As variant()
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub UpdateExternalName(new_name as string)
		  
		End Sub
	#tag EndMethod


	#tag Note, Name = Untitled
		
		add an iterator to get list of objects
		
		Text file reader:
		= for text file:: list of files if path is a folder
		= for text file: one file if path is a file
		= for text file: add an optional mask, set to '*.csv' by default
		
		DB Reader:
		= for db reader: list of tables
		= for db reader: add an optional mask to filter table names, set to '*' by default
		= for db reader: add an option to include /exclude views
		 
		
		Add method 'get_list_as_table', whoch provides a clDataSourceTable (subclass of clDataTable) to generate a datatable from resulting list
		
		
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
