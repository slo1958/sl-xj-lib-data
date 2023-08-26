#tag Class
Protected Class clDataTableFilter
Implements Iterable, Iterator
	#tag Method, Flags = &h0
		Sub Constructor(filtered_table as clDataTable, filter_field as string)
		  dim tmp as clBooleanDataSerie
		  
		  tmp = clBooleanDataSerie( filtered_table.get_column(filter_field))
		  
		  if tmp = nil then
		    Return
		    
		  end if
		  
		  self.table_link = filtered_table
		  self.filter_field_name = filter_field
		  
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Iterator() As Iterator
		  // Part of the Iterable interface.
		  
		  Return self
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MoveNext() As Boolean
		  // Part of the Iterator interface.
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Value() As Variant
		  // Part of the Iterator interface.
		  
		  
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0
		filter_field_name As string
	#tag EndProperty

	#tag Property, Flags = &h0
		filter_row_list As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		table_link As clDataTable
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
			Name="filter_field_name"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
