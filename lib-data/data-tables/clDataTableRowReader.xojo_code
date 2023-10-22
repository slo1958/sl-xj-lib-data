#tag Class
Protected Class clDataTableRowReader
Implements itf_table_row_reader
	#tag Method, Flags = &h0
		Function column_count() As integer
		  // Part of the itf_table_row_reader interface.
		  return table.column_count
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(source_table as clDataTable)
		  table = source_table
		  current_row = 0
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function current_row_number() As integer
		  // Part of the itf_table_row_reader interface.
		  return current_row
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function end_of_table() As boolean
		  // Part of the itf_table_row_reader interface.
		  
		  return current_row >=  table.row_count
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetColumnNames() As string()
		  // Part of the itf_table_row_reader interface.
		  return table.GetColumnNames
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function name() As string
		  // Part of the itf_table_row_reader interface.
		  return table.name
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function next_row() As variant()
		  // Part of the itf_table_row_reader interface.
		  dim row_value() as variant
		  
		  for column_index as integer = 0 to table.column_count-1
		    row_value.add(table.get_element(column_index, current_row))
		    
		  next
		  
		  current_row = current_row + 1
		  return row_value
		End Function
	#tag EndMethod


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
