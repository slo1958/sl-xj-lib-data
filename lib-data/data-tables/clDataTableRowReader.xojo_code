#tag Class
Protected Class clDataTableRowReader
Implements TableRowReaderInterface
	#tag Method, Flags = &h0
		Function ColumnCount() As integer
		  // Part of the TableRowReaderInterface interface.
		  return table.ColumnCount
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(source_table as clDataTable)
		  table = source_table
		  current_row = 0
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function CurrentRowIndex() As integer
		  // Part of the TableRowReaderInterface interface.
		  return current_row
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function EndOfTable() As boolean
		  // Part of the TableRowReaderInterface interface.
		  
		  return current_row >=  table.RowCount
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetColumnNames() As string()
		  // Part of the TableRowReaderInterface interface.
		  return table.GetColumnNames
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetColumnTypes() As dictionary
		  
		  var d as new Dictionary
		  // todo
		  return d
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetListOfExternalElements() As string()
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Name() As string
		  // Part of the TableRowReaderInterface interface.
		  return table.Name
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function NextRow() As clDataRow
		  // Part of the TableRowReaderInterface interface.
		  
		  if table  = nil then return nil
		  
		  return table.GetRowAt(current_row, false)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function NextRowAsVariant() As variant()
		  // Part of the TableRowReaderInterface interface.
		  var row_value() as variant
		  
		  for column_index as integer = 0 to table.ColumnCount-1
		    row_value.add(table.GetElement(column_index, current_row))
		    
		  next
		  
		  current_row = current_row + 1
		  return row_value
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub UpdateExternalName(new_name as string)
		  
		  return
		  
		End Sub
	#tag EndMethod


	#tag Note, Name = Description
		Implements the row reader interface using a table as source.
		It could be used to read rows from a table to feed another table.
	#tag EndNote


	#tag Property, Flags = &h21
		Private current_row As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private table As clDataTable
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
	#tag EndViewBehavior
End Class
#tag EndClass
