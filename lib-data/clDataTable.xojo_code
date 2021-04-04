#tag Class
Protected Class clDataTable
	#tag Method, Flags = &h0
		Function add_column(the_column_name as String) As clDataSerie
		  Dim tmp_column_name As String = the_column_name
		  
		  If columns_map.HasKey(tmp_column_name) Then
		    Return Nil
		    
		  Else
		    
		    Dim tmp_column As clDataSerie
		    
		    If link_to_parent = Nil Then
		      
		      tmp_column = New clDataSerie(tmp_column_name)
		      tmp_column.set_length(row_count)
		      
		      internal_add_logical_column(tmp_column)
		      
		      
		    Else
		      tmp_column = link_to_parent.add_column( tmp_column_name)
		      
		      internal_add_logical_column(tmp_column)
		      
		    End If
		    
		    Return tmp_column
		  End If
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub append_row(the_row as clDataRow, create_columns_flag as boolean=True)
		  
		  Dim tmp_row_count As Integer = Self.row_count
		  
		  Dim columns_to_update() As String
		  
		  For Each column As String In columns_map.Keys
		    columns_to_update.Append(column)
		    
		  Next
		  
		  
		  For Each column As String In the_row
		    Dim tmp_column_exists As Boolean  = columns_map.HasKey(column)
		    
		    If  tmp_column_exists Or create_columns_flag Then
		      Dim tmp_column As  clDataSerie
		      
		      If Not tmp_column_exists Then
		        tmp_column = add_column(column)
		        
		      Else
		        columns_to_update.Remove(columns_to_update.IndexOf(column))
		        tmp_column = columns_map.Value(column)
		        
		      End If
		      
		      Dim tmp_item As variant = the_row.get_cell(column)
		      
		      tmp_column.append_element(tmp_item)
		      
		      
		    Else
		      Raise New clDataException("Adding row with unexpected column " + column)
		      
		    End If
		    
		  Next
		  
		  Self.row_index.append_element("")
		  
		  For Each column As String In columns_to_update
		    clDataSerie(columns_map.Value(column)).set_length(tmp_row_count+1)
		    
		  Next
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub append_table(the_table as clDataTable)
		  
		  For Each src_tmp_column As clDataSerie In the_table.columns
		    Dim column As String = src_tmp_column.name
		    
		    Dim dst_tmp_column As  clDataSerie
		    
		    src_tmp_column = the_table.columns_map.Value(column)
		    If Self.columns_name.IndexOf(column) >= 0 Then
		      dst_tmp_column = Self.columns_map.Value(column)
		      
		    Else
		      dst_tmp_column = Self.add_column(column)
		      
		    End If
		    
		    For row_num As Integer = 0 To src_tmp_column.row_count-1
		      dst_tmp_column.append_element(src_tmp_column.get_element(row_num))
		      
		    Next
		    
		  Next
		  
		  Dim new_size As Integer = Self.row_count + the_table.row_count
		  Self.row_index.set_length(new_size)
		  
		  
		  For Each tmp_column As clDataSerie In Self.columns
		    tmp_column.set_length(new_size)
		    
		  Next
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function clone() As clDataTable
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function column_names() As string()
		  return columns_name
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(the_table_name as string)
		  columns_map = New Dictionary
		  table_name = the_table_name
		  row_index = New clDataSerieIndex("index")
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub debug_dump()
		  
		  Dim tmp_item() As String
		  
		  System.DebugLog("----START " + Self.table_name+" --------")
		  
		  tmp_item.Append("index")
		  For Each column As String In column_names
		    tmp_item.Append(column)
		    
		  Next
		  
		  System.DebugLog(Join(tmp_item, ";"))
		  
		  For row As Integer = 0 To row_count-1
		    Redim tmp_item(-1)
		    
		    tmp_item.Append(Self.row_index.get_element(row))
		    For Each column As String In column_names
		      Dim tmp_column As clDataSerie = clDataSerie(columns_map.Value(column))
		      
		      tmp_item.Append(tmp_column.get_element(row))
		      
		    Next
		    System.DebugLog(Join(tmp_item, ";"))
		    
		  Next
		  
		  System.DebugLog("----END " + Self.table_name+" --------")
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function get_columns(column_names() as string) As clDataSerie()
		  Dim ret() As clDataSerie
		  
		  For Each column As String In column_names
		    Dim idx As Integer = Self.column_names.IndexOf(column)
		    
		    If idx <0 Then
		      ret.Append(Nil)
		      
		    Else
		      ret.Append(Self.columns_map.value(column))
		      
		    End If
		    
		  Next
		  
		  Return ret
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function get_columns(paramarray column_names as string) As clDataSerie()
		  
		  Return get_columns(column_names)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub internal_add_logical_column(the_column as clDataSerie)
		  Dim tmp_column As clDataSerie = the_column
		  Dim tmp_column_name As String = the_column.name
		  
		  Self.columns.Append(tmp_column)
		  Self.columns_map.Value(tmp_column_name) = tmp_column
		  Self.column_names.Append(tmp_column_name)
		  
		  
		  Dim tmp() As String
		  tmp.Append("aaa")
		  
		  call get_columns(tmp)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function row_count() As integer
		  If Self.row_index = Nil Then
		    Return -1
		    
		  Else
		    Return Self.row_index.row_count
		    
		  End If
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function select_columns(column_names() as string) As clDataTable
		  Dim res As New clDataTable("select " + Self.table_name)
		  
		  res.row_index = Self.row_index
		  
		  For Each column As String In column_names
		    If Self.columns_name.IndexOf(column) >= 0 Then 
		      Dim src_column As clDataSerie = Self.columns_map.value(column)
		      res.internal_add_logical_column(src_column)
		      
		    End If
		    
		  Next
		  
		  res.link_to_parent = Self
		  
		  Return res
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function select_columns(paramarray column_names as string) As clDataTable
		  Return select_columns(column_names)
		End Function
	#tag EndMethod


	#tag Property, Flags = &h1
		Protected columns() As clDataSerie
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected columns_map As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected columns_name() As String
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected link_to_parent As clDataTable
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected row_index As clDataSerie
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected table_name As String
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="name"
			Group="Behavior"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
