#tag Class
Protected Class clDataTableIterator
Implements Iterator
	#tag Method, Flags = &h0
		Sub Constructor(the_table as clDataTable)
		  tmp_table = the_table
		  last_row_index = -1
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MoveNext() As Boolean
		  // Part of the Iterator interface.
		  
		  if last_row_index < tmp_table.RowCount - 1 then
		    last_row_index = last_row_index + 1
		    
		    value_to_return = tmp_table.GetRowAt(last_row_index, tmp_table.IsIndexVisibleWhenIterating)
		    
		    return True
		    
		  else
		    return False
		    
		  end if
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Value() As Variant
		  // Part of the Iterator interface.
		  
		  return value_to_return
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0
		last_row_index As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		tmp_table As clDataTable
	#tag EndProperty

	#tag Property, Flags = &h0
		value_to_return As clDataRow
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
			Name="last_row_index"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
