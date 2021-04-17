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
		      tmp_column.link_to_table(Self)
		      
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
		Sub add_columns(the_column_names() as string)
		  For Each name As String In the_column_names
		    call add_column(name)
		    
		  Next
		  
		End Sub
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
		Sub append_row(the_values() as string)
		  
		  For i As Integer = 0 To columns.Ubound
		    If i <= the_values.Ubound Then
		      columns(i).append_element(the_values(i))
		      
		    Else
		      columns(i).append_element("")
		      
		    End If
		    
		  Next
		  
		  Self.row_index.append_element("")
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub append_row(the_values() as variant)
		  
		  For i As Integer = 0 To columns.Ubound
		    If i <= the_values.Ubound Then
		      columns(i).append_element(the_values(i))
		      
		    Else
		      columns(i).append_element("")
		      
		    End If
		    
		  Next
		  
		  Self.row_index.append_element("")
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub append_table(the_table as clDataTable)
		  
		  For Each src_tmp_column As clDataSerie In the_table.columns
		    Dim column As String = src_tmp_column.name
		    
		    Dim dst_tmp_column As  clDataSerie
		    
		    src_tmp_column = the_table.columns_map.Value(column)
		    
		    if self.columns_map.HasKey(column) then
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
		Function apply_filter(the_filter_function as filter_row, paramarray function_param as variant) As variant()
		  Dim return_boolean() As Variant
		  
		  Dim column_names() As String
		  
		  //For i As Integer=0 To items.Ubound
		  //return_boolean.Append(the_filter_function.Invoke(i,  items.Ubound, name, items(i), function_param))
		  
		  //Next
		  
		  Return return_boolean
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function clone() As clDataTable
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function column_names() As string()
		  Dim ret_str() As String
		  For Each column As clDataSerie In columns
		    ret_str.Append(column.name)
		    
		  Next
		  
		  Return ret_str
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(the_source_file as FolderItem)
		  Dim tmp_table_name As String
		  
		  If the_source_file = Nil Then
		    tmp_table_name = "noname"
		    
		  Else
		    tmp_table_name = the_source_file.Name
		    
		  End If
		  
		  internal_new_table(tmp_table_name)
		  
		  If the_source_file = Nil Then
		    Return
		    
		  End If
		  
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(the_table_name as string)
		  Dim tmp_table_name As String
		  
		  tmp_table_name = the_table_name
		  
		  internal_new_table(tmp_table_name)
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(the_table_name as string, the_columns() as clDataSerie, auto_clone_columns as boolean = false)
		  //
		  // create a table from a set of columns
		  // columns cannot be part of another table, use select_columns to create a virtual table if you want to retain the relationship
		  // 
		  
		  Dim tmp_columns() As clDataSerie = the_columns
		  
		  For i As Integer = 0 To tmp_columns.Ubound
		    If tmp_columns(i) = Nil Then
		      Raise New clDataException("Internal error")
		      
		    Elseif tmp_columns(i).is_linked_to_table And  auto_clone_columns Then
		      tmp_columns(i) = tmp_columns(i).clone
		      
		    Elseif tmp_columns(i).is_linked_to_table And Not auto_clone_columns Then
		      Raise New clDataException("Cannot add a linked serie to a new table.")
		      
		    Else
		      
		    End If
		    
		  Next
		  
		  internal_new_table(the_table_name)
		  Dim max_item_count As Integer=0
		  
		  For Each c As clDataSerie In tmp_columns
		    If max_item_count < c.row_count Then
		      max_item_count = c.row_count
		      
		    End If
		    
		    internal_add_logical_column(c)
		    c.link_to_table(Self)
		    
		  Next
		  
		  For Each c As clDataSerie In columns
		    c.set_length(max_item_count)
		    
		  Next
		  
		  row_index.set_length(max_item_count)
		  
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

	#tag DelegateDeclaration, Flags = &h0
		Delegate Function filter_row(the_row_index as integer, the_row_count as integer, the_column_names() as string, the_cell_values() as variant, paramarray function_param as variant) As Boolean
	#tag EndDelegateDeclaration

	#tag Method, Flags = &h0
		Function find_first_matching_row(the_column_name as string, the_column_value as string) As integer
		  Dim tmp_column As clDataSerie
		  
		  If Not columns_map.HasKey(the_column_name) Then
		    Return -2
		    
		  End If
		  
		  tmp_column = columns_map.Value(the_column_name)
		  
		  For i As Integer = 0 To tmp_column.row_count-1
		    If tmp_column.get_element(i) = the_column_value Then
		      Return i
		      
		    End If
		    
		  Next
		  
		  Return -1
		  
		  
		End Function
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
		  
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub internal_add_row(the_row_data() as variant)
		  
		  If the_row_data.Ubound <> columns.Ubound Then
		    Raise new clDataException("Invalid row in internal_add_row")
		    
		  End If
		  
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub internal_new_table(the_table_name as string)
		  columns_map = New Dictionary
		  table_name = the_table_name
		  row_index = New clDataSerieIndex("index")
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub load_from_text(the_source as FolderItem, the_line_parser as clRowParser_generic, has_header  as Boolean)
		  //
		  // Load the serie from a text file, each line is loaded into one element, without further processing
		  // The method returns the header if the 'has_header' flag is set to true, otherwise it returns an empty string
		  //
		  
		  Dim got_header As Boolean
		  Dim text_file  As TextInputStream
		  Dim return_header As String
		  
		  Dim time_start As Double = Microseconds
		  System.DebugLog "Loading " + the_source.Name
		  
		  
		  If the_source = Nil Then
		    Return 
		    
		  End If
		  
		  text_file = TextInputStream.Open(the_source)
		  
		  got_header = Not has_header
		  
		  While Not text_file.EOF
		    Dim tmp_source_line As String = text_file.ReadLine
		    Dim tmp_items() As String
		    
		    tmp_items = the_line_parser.parse_line(tmp_source_line)
		    
		    If got_header Then
		      For i As Integer = 0 To Self.columns.Ubound
		        If i <= tmp_items.Ubound Then
		          Self.columns(i).append_element(tmp_items(i))
		          
		        Else
		          Self.columns(i).append_element("")
		          
		        End If
		        
		      Next
		      
		      
		      Self.row_index.append_element("")
		      
		    Else
		      For i As Integer = 0 To tmp_items.Ubound
		        Call Self.add_column(tmp_items(i))
		        
		      Next
		      got_header = True
		      
		    End If
		    
		    
		  Wend
		  
		  text_file.close
		  
		  Dim time_end As Double = Microseconds
		  
		  System.DebugLog "Completed after " + Str((time_end - time_start)/1000000)
		  Return  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function name() As string
		  Return table_name
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub rename(the_new_name as string)
		  If the_new_name.Len = 0 Then
		    Self.table_name = "noname"
		    
		  Else
		    Self.table_name = the_new_name
		    
		  End If
		  
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
		Sub save_as_text(the_destination as FolderItem,the_line_parser as clRowParser_generic, with_header  as Boolean)
		  Dim text_file  As TextOutputStream 
		  
		  If the_destination = Nil Then
		    Return 
		    
		  End If
		  
		  text_file = TextOutputStream.Create(the_destination)
		  
		  Dim column_index() As clDataSerie
		  
		  For Each column As clDataSerie In columns
		    column_index.Append(column)
		    
		  Next
		  
		  
		  If with_header Then
		    Dim tmp_work_record As String
		    Dim tmp_work_area() As String
		    
		    For Each column As clDataSerie In column_index
		      tmp_work_area.Append(column.name)
		      
		    Next
		    
		    tmp_work_record = the_line_parser.serialize_line(tmp_work_area)
		    System.DebugLog(tmp_work_record)
		    
		    text_file.WriteLine(tmp_work_record)
		    
		  End 
		  
		  For row_index As Integer = 0 To Self.row_index.row_count-1
		    Dim tmp_work_record As String
		    Dim tmp_work_area() As String
		    
		    For Each column As clDataSerie In column_index
		      tmp_work_area.Append(column.get_element(row_index))
		      
		    Next
		    
		    tmp_work_record = the_line_parser.serialize_line(tmp_work_area)
		    System.DebugLog(tmp_work_record)
		    
		    text_file.WriteLine(tmp_work_record)
		    
		    
		    
		  Next
		  
		  
		  
		  text_file.Close
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function select_columns(column_names() as string) As clDataTable
		  Dim res As New clDataTable("select " + Self.table_name)
		  
		  res.row_index = Self.row_index
		  
		  For Each column As String In column_names
		    If Self.columns_map.HasKey(column) Then
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

	#tag Method, Flags = &h0
		Sub synch_columns()
		  Dim dic_remove() As String
		  Dim dic_add_key() As String
		  Dim dic_add_serie() As clDataSerie
		  
		  For Each key As String In Self.columns_map.keys
		    Dim old_name As String = key
		    Dim tmp_serie As clDataSerie = clDataSerie(Self.columns_map.value(key))
		    Dim new_name As String = tmp_serie.name
		    
		    If old_name <> new_name Then
		      
		      dic_remove.Append(old_name)
		      dic_add_key.Append(new_name)
		      dic_add_serie.Append(tmp_serie)
		      
		    End If
		    
		  Next
		  
		  
		  For i As Integer = 0 To dic_remove.Ubound
		    Self.columns_map.Remove(dic_remove(i))
		    
		  Next
		  
		  For i As Integer = 0 To dic_add_key.Ubound
		    Self.columns_map.Value(dic_add_key(i)) = dic_add_serie(i)
		    
		  Next
		  
		  
		  
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h1
		Protected columns() As clDataSerie
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected columns_map As Dictionary
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
