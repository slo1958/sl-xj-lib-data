#tag Class
Protected Class clDataPoolIterator
Implements Iterator
	#tag Method, Flags = &h0
		Sub Constructor(the_pool as clDataPool)
		  tmp_pool = the_pool
		  last_table_index = -1
		  
		  tables = tmp_pool.GetTableNames()
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MoveNext() As Boolean
		  // Part of the Iterator interface.
		  
		  if last_table_index < tables.LastIndex then
		    last_table_index = last_table_index + 1
		    
		    value_to_return = tmp_pool.GetTable(tables(last_table_index))
		    return True
		    
		  else
		    value_to_return = nil
		    return False
		    
		  end if
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Value() As Variant
		  // Part of the Iterator interface.
		  
		  Return value_to_return
		  
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0
		last_table_index As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		tables() As String
	#tag EndProperty

	#tag Property, Flags = &h0
		tmp_pool As clDataPool
	#tag EndProperty

	#tag Property, Flags = &h0
		value_to_return As clDataTable
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
			Name="last_table_index"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
