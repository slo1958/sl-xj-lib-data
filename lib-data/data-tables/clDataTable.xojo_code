#tag Class
Protected Class clDataTable
Implements itf_table_reader,Iterable
	#tag Method, Flags = &h0
		Function add_column(the_column as clAbstractDataSerie) As clAbstractDataSerie
		  Dim tmp_column As clAbstractDataSerie = the_column
		  
		  Dim tmp_column_name As String = tmp_column.name
		  
		  If Self.get_column(tmp_column_name) <> Nil Then
		    Return Nil
		    
		  end if
		  
		  
		  
		  ' physical table and column not yet linked
		  if not self.is_virtual and not tmp_column.linked then
		    dim max_row_count as integer = self.increase_length(tmp_column.row_count)
		    tmp_column.set_length(max_row_count)
		    
		    tmp_column.link_to_table(Self)
		    Self.columns.Append(tmp_column)
		    
		    return tmp_column
		    
		  end if
		  
		  ' adding a physical column to a virtual table (when permitted)
		  if self.is_virtual and not tmp_column.linked and self.allow_local_columns then
		    dim max_row_count as integer = self.increase_length(tmp_column.row_count)
		    tmp_column.set_length(max_row_count)
		    
		    tmp_column.link_to_table(Self)
		    Self.columns.Append(tmp_column)
		    
		    return tmp_column
		    
		  end if
		  
		  ' we add a column from another table to a virtual table
		  if self.is_virtual and tmp_column.linked then
		    tmp_column.set_length(row_count)
		    Self.columns.Append(tmp_column)
		    return tmp_column
		    
		  end if
		  
		  Return nil
		  
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function add_column(the_column_name as String) As clDataSerie
		  dim v as variant
		  
		  return add_column(the_column_name, v)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function add_column(the_column_name as String, default_value as variant) As clDataSerie
		  Dim tmp_column_name As String = the_column_name.trim
		  
		  if tmp_column_name.len() = 0 then
		    tmp_column_name = "Untitled " + str(self.column_count)
		    
		  end if
		  
		  If Self.get_column(tmp_column_name) <> Nil Then
		    Return Nil
		    
		  end if
		  
		  Dim tmp_column As clDataSerie
		  
		  If not self.is_virtual then
		    tmp_column = New clDataSerie(tmp_column_name)
		    tmp_column.link_to_table(Self)
		    tmp_column.set_length(row_count, default_value)
		    
		  Elseif allow_local_columns Then
		    tmp_column = New clDataSerie(tmp_column_name)
		    tmp_column.link_to_table(Self)
		    tmp_column.set_length(row_count, default_value)
		    
		  Else
		    ' could be nil if the column exists in the parent datatable
		    tmp_column = link_to_parent.add_column( tmp_column_name)
		    
		  End If
		  
		  If tmp_column <> Nil Then
		    Self.columns.Append(tmp_column)
		    
		  End If
		  
		  Return tmp_column
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function add_columns(the_column_names() as string) As clDataSerie()
		  Dim return_array() As clDataSerie
		  dim v as variant 
		  For Each name As String In the_column_names
		    return_array.append(add_column(name, v))
		    
		  Next
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub add_meta_data(type as string, message as string)
		  
		  meta_dict.add_meta_data(type, message)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub append_row(the_row as clDataRow, create_columns_flag as boolean=True)
		  
		  Dim tmp_row_count As Integer = Self.row_count
		  
		  Dim columns_to_update() As String
		  
		  For Each column As clAbstractDataSerie In columns
		    columns_to_update.Append(column.name)
		    
		  Next
		  
		  
		  
		  For Each column As String In the_row
		    Dim tmp_column As clAbstractDataSerie = Self.get_column(column)
		    
		    If tmp_column = Nil And create_columns_flag Then
		      tmp_column = add_column(column)
		      
		    End If
		    
		    If tmp_column = Nil Then
		      Raise New clDataException("Adding row with unexpected column " + column)
		      
		    Else
		      Dim tmp_item As variant = the_row.get_cell(column)
		      tmp_column.append_element(tmp_item)
		      
		    End If
		    
		  Next
		  
		  Self.row_index.append_element("")
		  
		  For Each column As clAbstractDataSerie In Self.columns
		    column.set_length(tmp_row_count+1)
		    
		  Next
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub append_row(the_values as Dictionary)
		  if the_values = nil then 
		    return
		    
		  end if
		  
		  for each column as clAbstractDataSerie in self.columns
		    if the_values.HasKey(column.name) then
		      column.append_element(the_values.value(column.name))
		      
		    else
		      column.append_element("")
		      
		    end if
		    
		  next
		  
		  Self.row_index.append_element("")
		  
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
		Sub append_rows_from_table(the_table as clDataTable, create_missing_columns as boolean = True)
		  
		  dim length_before as integer = self.row_count
		  
		  For Each src_tmp_column As clAbstractDataSerie In the_table.columns
		    Dim column_name As String = src_tmp_column.name
		    
		    Dim dst_tmp_column As  clAbstractDataSerie = Self.get_column(column_name)
		    
		    If dst_tmp_column <> Nil Then
		      dst_tmp_column.append_serie(src_tmp_column)
		      
		    elseif create_missing_columns then
		      dst_tmp_column = Self.add_column(column_name)
		      dst_tmp_column.set_length(length_before)
		      
		      dst_tmp_column.append_serie(src_tmp_column)
		      
		    else
		      System.DebugLog("Ignoring column " + column_name)
		      
		    End If
		    
		    
		    
		  Next
		  
		  Dim new_size As Integer = Self.row_count + the_table.row_count
		  
		  Self.row_index.set_length(new_size)
		  
		  For Each tmp_column As clAbstractDataSerie In Self.columns
		    tmp_column.set_length(new_size)
		    
		    system.DebugLog("size="+str(tmp_column.row_count))
		    
		  Next
		  dim k as integer =1
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function clone() As clDataTable
		  
		  dim output_table as new clDataTable(self.name+" copy")
		  
		  for each col as clAbstractDataSerie in self.columns
		    dim new_col as clAbstractDataSerie = col.clone()
		    
		    call output_table.add_column(new_col)
		    
		  next
		  
		  Return output_table
		End Function
	#tag EndMethod

	#tag DelegateDeclaration, Flags = &h0
		Delegate Function column_allocator(column_name as String) As clAbstractDataSerie
	#tag EndDelegateDeclaration

	#tag Method, Flags = &h0
		Function column_count() As integer
		  Return columns.Ubound + 1
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function column_names() As string()
		  Dim ret_str() As String
		  For Each column As clAbstractDataSerie In columns
		    ret_str.Append(column.name)
		    
		  Next
		  
		  Return ret_str
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(the_source_file as FolderItem)
		  meta_dict = new clMetaData
		  
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
		  meta_dict = new clMetaData
		  
		  Dim tmp_table_name As String
		  
		  tmp_table_name = the_table_name
		  
		  internal_new_table(tmp_table_name)
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(the_table_name as string, the_columns() as clabstractDataSerie, auto_clone_columns as boolean = false)
		  //
		  // create a table from a set of columns
		  // columns cannot be part of another table, use select_columns to create a virtual table if you want to retain the relationship
		  // 
		  
		  
		  meta_dict = new clMetaData
		  
		  Dim tmp_columns() As clAbstractDataSerie = the_columns
		  
		  For i As Integer = 0 To tmp_columns.Ubound
		    If tmp_columns(i) = Nil Then
		      Raise New clDataException("Internal error")
		      
		    Elseif tmp_columns(i).is_linked_to_table And  auto_clone_columns Then
		      tmp_columns(i) = tmp_columns(i).clone
		      
		    Elseif tmp_columns(i).is_linked_to_table And Not auto_clone_columns Then
		      Raise New clDataException("Cannot add a linked serie to a new table, use select_columns() method instead.")
		      
		    Else
		      
		    End If
		    
		  Next
		  
		  internal_new_table(the_table_name)
		  
		  For Each c As clAbstractDataSerie In tmp_columns
		    ' add column takes care of adjusting the length
		    call Self.add_column(c)
		    
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(the_table_name as string, column_names() as string)
		  meta_dict = new clMetaData
		  
		  Dim tmp_table_name As String
		  
		  tmp_table_name = the_table_name
		  
		  internal_new_table(tmp_table_name)
		  
		  
		  For Each name As string In column_names
		    dim temp_name as string = name.Trim
		    call Self.add_column(name)
		    
		  Next
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub debug_dump()
		  
		  Dim tmp_item() As String
		  
		  System.DebugLog("----START " + Self.table_name+" --------")
		  
		  System.DebugLog("#rows : " + str(self.row_count))
		  System.DebugLog("#columns : " + str(self.columns.Ubound+1))
		  
		  tmp_item.Append("index")
		  For Each tmp_column As clAbstractDataSerie In columns
		    tmp_item.Append(tmp_column.name)
		    
		  Next
		  
		  System.DebugLog(Join(tmp_item, ";"))
		  
		  For row As Integer = 0 To row_count-1
		    Redim tmp_item(-1)
		    
		    tmp_item.Append(Self.row_index.get_element(row))
		    
		    For Each tmp_column As clAbstractDataSerie In columns
		      tmp_item.Append(tmp_column.get_element(row))
		      
		    Next
		    System.DebugLog(Join(tmp_item, ";"))
		    
		  Next
		  
		  System.DebugLog("----END " + Self.table_name+" --------")
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function filtered_on(s as string) As clDataTableFilter
		  
		  dim retval as new clDataTableFilter(self, s)
		  
		  return retval
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function filter_apply_function(the_filter_function as filter_row, paramarray function_param as variant) As variant()
		  Dim return_boolean() As Variant
		  
		  Dim column_names() As String
		  dim column_values() as Variant
		  
		  for each column as clAbstractDataSerie in self.columns
		    column_names.Append(column.name)
		    
		  next
		  
		  dim row_count as integer = self.row_count
		  
		  For i As Integer=0 To row_count-1
		    redim column_values(-1)
		    
		    for each column as clAbstractDataSerie in self.columns
		      column_values.Append(column.get_element(i))
		      
		    next
		    
		    return_boolean.Append(the_filter_function.Invoke(i,  row_count, column_names, column_values, function_param))
		    
		  Next
		  
		  Return return_boolean
		  
		End Function
	#tag EndMethod

	#tag DelegateDeclaration, Flags = &h0
		Delegate Function filter_row(the_row_index as integer, the_row_count as integer, the_column_names() as string, the_cell_values() as variant, paramarray function_param as variant) As Boolean
	#tag EndDelegateDeclaration

	#tag Method, Flags = &h0
		Function find_first_matching_row(the_column_name as string, the_column_value as string, include_index as Boolean) As clDataRow
		  dim tmp_row_index as integer = self.find_first_matching_row_index(the_column_name, the_column_value)
		  
		  if tmp_row_index <0 then
		    return nil
		    
		  end if
		  
		  return self.get_row(tmp_row_index, include_index)
		  
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function find_first_matching_row_index(the_column_names() as string, the_column_values() as string) As integer
		  Dim tmp_columns() As clAbstractDataSerie
		  
		  for each name as string in the_column_names
		    dim tmp_column as clAbstractDataSerie = get_column(name)
		    
		    If tmp_column = Nil Then
		      Return -2
		      
		    End If
		    
		    tmp_columns.Append(tmp_column)
		  next
		  
		  
		  For row_index As Integer = 0 To tmp_columns(0).row_count-1
		    
		    dim ok_row as Boolean = True
		    dim col_index as integer =  0
		    
		    while ok_row and col_index <= tmp_columns.LastIndex
		      
		      If tmp_columns(col_index).get_element(row_index) <> the_column_values(col_index) Then
		        ok_row = False
		        
		      else
		        col_index = col_index + 1
		        
		      End If
		      
		    wend
		    
		    if ok_row then
		      return row_index
		      
		    end if
		  Next
		  
		  Return -1
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function find_first_matching_row_index(the_column_name as string, the_column_value as string) As integer
		  Dim tmp_column As clAbstractDataSerie
		  
		  tmp_column = get_column(the_column_name)
		  
		  If tmp_column = Nil Then
		    Return -2
		    
		  End If
		  
		  For i As Integer = 0 To tmp_column.row_count-1
		    If tmp_column.get_element(i) = the_column_value Then
		      Return i
		      
		    End If
		    
		  Next
		  
		  Return -1
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function get_column(the_column_name as String) As clAbstractDataSerie
		  
		  For Each column As clAbstractDataSerie In Self.columns
		    If column.name = the_column_name Then
		      Return column
		      
		    End If
		    
		  Next
		  
		  Return Nil
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function get_columns(column_names() as string) As clAbstractDataSerie()
		  '
		  ' Return the selected columns as an array of clDataSerie
		  '
		  
		  Dim ret() As clAbstractDataSerie
		  
		  
		  For Each column_name As String In column_names
		    Dim tmp_column As clAbstractDataSerie = Self.get_column(column_name)
		    
		    ret.Append(tmp_column)
		    
		    
		  Next
		  
		  Return ret
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function get_columns(paramarray column_names as string) As clAbstractDataSerie()
		  '
		  ' Return the selected columns as an array of clDataSerie
		  '
		  
		  Return get_columns(column_names)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function get_element(the_column_name as String, the_element_index as integer) As variant
		  dim tmp_col as clAbstractDataSerie = self.get_column(the_column_name)
		  
		  
		  return tmp_col.get_element(the_element_index)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function get_meta_data() As clMetaData
		  Return self.meta_dict
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function get_row(the_row_index as integer, include_index as Boolean) As clDataRow
		  
		  dim tmp_row as new clDataRow
		  
		  if not include_index then
		    
		  elseif row_index = nil then
		    tmp_row.set_cell("row_index",  the_row_index)
		    
		  else
		    tmp_row.set_cell("row_index",  row_index.get_element(the_row_index))
		    
		  end if
		  
		  for each column as clAbstractDataSerie in self.columns
		    dim col_name as string = column.name
		    dim col_val as Auto = column.get_element(the_row_index)
		    tmp_row.set_cell(col_name, col_val)
		    
		  next
		  
		  return tmp_row
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function groupby(grouping_dimensions() as string, aggregate_measures() as string, aggregate_mode() as string) As clDataTable
		  
		  Dim input_dimensions() As clAbstractDataSerie
		  Dim input_measures() As clAbstractDataSerie
		  
		  For Each item As String In grouping_dimensions
		    If Len(Trim(item)) > 0 Then
		      input_dimensions.Append(Self.get_column(item))
		      
		    End If
		  Next
		  
		  For Each item As String In aggregate_measures
		    If Len(Trim(item)) > 0 Then
		      input_measures.Append(Self.get_column(item))
		      
		    End If
		  Next
		  
		  
		  Dim has_grouping As Boolean = input_dimensions.Ubound >=0
		  Dim has_measures As Boolean = input_measures.Ubound >= 0
		  
		  
		  Dim dct_lookup As New Dictionary
		  
		  
		  Dim output_row_count As New clDataSerie("row_count")
		  
		  '
		  ' Prepare output space for grouped dimensions
		  '
		  Dim output_dimensions() As clDataSerie
		  For idx_dim As Integer = 0 To input_dimensions.Ubound
		    output_dimensions.Append(New clDataSerie(input_dimensions(idx_dim).name))
		    
		  Next
		  
		  '
		  ' Prepare temporary space for aggregated measures
		  '
		  Dim temp_measures() As clDataSerie
		  For idx_mea As Integer = 0 To input_measures.Ubound
		    temp_measures.Append(New clDataSerie(input_measures(idx_mea).name))
		    If Not has_grouping Then
		      temp_measures(idx_mea).append_element(New clDataSerie("x"))
		      output_row_count.append_element(0)
		    End If
		    
		  Next
		  
		  
		  Dim cnt As Integer = Self.row_count - 1
		  
		  
		  For idx_row As Integer = 0 To cnt
		    Dim idx_output As Integer = -1
		    
		    
		    If has_grouping Then
		      Dim tmp_key() As String
		      
		      For idx_dim As Integer = 0 To input_dimensions.Ubound
		        tmp_key.Append(input_dimensions(idx_dim).get_element(idx_row))
		        
		      Next
		      
		      Dim tmp_key_flat As String = Join(tmp_key,Chr(4))
		      
		      
		      If dct_lookup.HasKey(tmp_key_flat) Then
		        idx_output = dct_lookup.Value(tmp_key_flat)
		        
		      Else
		        For idx_dim As Integer = 0 To input_dimensions.Ubound
		          output_dimensions(idx_dim).append_element(tmp_key(idx_dim))
		          
		        Next
		        idx_output = output_dimensions(0).row_count - 1
		        
		        output_row_count.append_element(0)
		        
		        For idx_mea As Integer = 0 To input_measures.Ubound
		          temp_measures(idx_mea).append_element(New clDataSerie("x"))
		          
		        Next
		        
		        dct_lookup.Value(tmp_key_flat) = idx_output
		        
		        
		      End If
		    Else
		      idx_output = 0
		      
		    End If
		    
		    output_row_count.set_element(idx_output, output_row_count.get_element(idx_output)+1)
		    
		    For idx_mea As Integer = 0 To input_measures.Ubound
		      Dim tmp_serie As clDataSerie = temp_measures(idx_mea).get_element_as_data_serie(idx_output)
		      tmp_serie.append_element(input_measures(idx_mea).get_element(idx_row))
		      
		    Next
		    
		  Next
		  
		  Dim output_series() As clDataSerie
		  
		  For idx_dim As Integer = 0 To output_dimensions.Ubound
		    output_series.Append(output_dimensions(idx_dim))
		    
		  Next
		  
		  
		  For idx_mea As Integer = 0 To temp_measures.Ubound
		    Dim tmp_serie As New clDataSerie("sum_" + input_measures(idx_mea).name)
		    
		    For idx_item As Integer = 0 To temp_measures(idx_mea).row_count-1
		      tmp_serie.append_element(temp_measures(idx_mea).get_element_as_data_serie(idx_item).sum)
		      
		    Next
		    
		    output_series.Append(tmp_serie)
		    
		  Next
		  
		  output_series.Append(output_row_count)
		  
		  ' 
		  ' output table name
		  '
		  dim tmp_name as string = self.name.trim
		  if tmp_name.len = 0 then
		    tmp_name = "results"
		    
		  end if
		  
		  
		  if grouping_dimensions.Ubound < 0 then
		    tmp_name = tmp_name + " total"
		  else
		    
		    For Each item As String In grouping_dimensions
		      If Len(Trim(item)) > 0 Then
		        tmp_name = tmp_name + " " + item
		        
		      end if
		      
		    next
		  end if
		  
		  Return New clDataTable(tmp_name, output_series)
		  
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function increase_length(the_length as integer) As integer
		  dim max_row_count as integer
		  
		  if self.row_count > the_length then
		    max_row_count = self.row_count
		    
		  else
		    max_row_count = the_length
		    
		  end if
		  
		  row_index.set_length(max_row_count)
		  
		  for each c as clAbstractDataSerie in self.columns
		    c.set_length(max_row_count)
		    
		  next
		  
		  return max_row_count
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub index_visible_when_iterate(status as Boolean)
		  self.index_explicit_when_iterate = status
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
		Private Function internal_join(the_table as clDataTable, own_keys() as string, alt_keys() as string) As Boolean
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub internal_new_table(the_table_name as string)
		  
		  table_name = the_table_name
		  row_index = New clDataSerieRowID("row_id")
		  
		  
		  allow_local_columns =  False
		  index_explicit_when_iterate = False
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function is_index_visible_when_iterate() As Boolean
		  return self.index_explicit_when_iterate 
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function is_virtual() As Boolean
		  return link_to_parent <> Nil 
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Iterator() As Iterator
		  // Part of the Iterable interface.
		  
		  return new clDataTableIterator(self)
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function join_table(table_to_join as clDataTable, key_mapping as Dictionary) As Boolean
		  
		  dim tmp_key1() as string
		  dim tmp_key2() as String
		  
		  for each key as string in key_mapping.Keys
		    
		    tmp_key1.Add(key)
		    
		    tmp_key2.Add(key_mapping.Value(key))
		    
		  next
		  
		  return internal_join(table_to_join, tmp_key1, tmp_key2)
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function join_table(table_to_join as clDataTable, keys() as string) As Boolean
		  
		  dim tmp_key1() as string
		  dim tmp_key2() as String
		  
		  for each key as string in keys
		    tmp_key1.Add(key)
		    
		    tmp_key2.Add(key)
		    
		  next
		  
		  return internal_join(table_to_join, tmp_key1, tmp_key2)
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub load_from_text(the_source as FolderItem, the_line_parser as clRowParser_generic, has_header  as Boolean, allocator as column_allocator = nil)
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
		        dim column_serie as clAbstractDataSerie
		        
		        if allocator = nil then
		          column_serie = new clDataSerie(tmp_items(i))
		          
		        else
		          column_serie = allocator.Invoke(tmp_items(i))
		          if column_serie = nil then
		            column_serie = new clDataSerie(tmp_items(i))
		            
		          end if
		          
		        end if
		        
		        Call Self.add_column(column_serie)
		        
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
		  Return self.table_name
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub rename(the_new_name as string)
		  
		  If the_new_name.Trim.Len = 0 Then
		    Self.table_name = "noname"
		    
		  Else
		    Self.table_name = the_new_name.Trim
		    
		  End If
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub rename_column(the_column_name as string, the_new_name as string)
		  
		  For idx As Integer = 0 To columns.Ubound
		    If columns(idx).name = the_column_name Then
		      columns(idx).name = the_new_name
		      
		    End If
		    
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub rename_columns(the_renaming_dict as Dictionary)
		  
		  For idx As Integer = 0 To columns.Ubound
		    
		    Dim tmp_column_name As String = columns(idx).name
		    
		    If the_renaming_dict.HasKey(tmp_column_name) Then
		      Dim tmp_new_name As String  = the_renaming_dict.value(tmp_column_name)
		      Self.rename_column(tmp_column_name , tmp_new_name)
		      
		    End If
		    
		  Next
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
		  
		  Dim column_index() As clAbstractDataSerie
		  
		  For Each column As clAbstractDataSerie In columns
		    column_index.Append(column)
		    
		  Next
		  
		  
		  If with_header Then
		    Dim tmp_work_record As String
		    Dim tmp_work_area() As String
		    
		    For Each column As clAbstractDataSerie In column_index
		      tmp_work_area.Append(column.name)
		      
		    Next
		    
		    tmp_work_record = the_line_parser.serialize_line(tmp_work_area)
		    System.DebugLog(tmp_work_record)
		    
		    text_file.WriteLine(tmp_work_record)
		    
		  End 
		  
		  For row_index As Integer = 0 To Self.row_index.row_count-1
		    Dim tmp_work_record As String
		    Dim tmp_work_area() As String
		    
		    For Each column As clAbstractDataSerie In column_index
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
		  '
		  ' link to parent must be called BEFORE adding logical columns
		  '
		  res.link_to_parent = Self
		  
		  For Each column_name As String In column_names
		    Dim tmp_column As clAbstractDataSerie = Self.get_column(column_name)
		    
		    If tmp_column <> Nil Then
		      call res.add_column(tmp_column)
		      
		    End If
		    
		  Next
		  
		  Return res
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function select_columns(paramarray column_names as string) As clDataTable
		  Return select_columns(column_names)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function set_column_values(the_column_name as string, the_values() as variant, can_create as boolean) As clAbstractDataSerie
		  
		  dim temp_column as clAbstractDataSerie = self.get_column(the_column_name)
		  
		  if temp_column = nil then
		    
		    if can_create then
		      temp_column = new clDataSerie(the_column_name, the_values)
		      call self.add_column(temp_column)
		      
		      return temp_column
		      
		    else
		      return nil
		      
		    end if
		    
		  else
		    temp_column.set_values(the_values)
		    
		  end if
		  
		End Function
	#tag EndMethod


	#tag Note, Name = Description
		Defines a data table
		
		A dataTable is a collection of dataSeries.
		
		Only one dataTable can 'own' a dataSerie, but the series can be shared by multiple tables.
		
		
	#tag EndNote

	#tag Note, Name = Group by
		
		option 1
		
		creates a data table with n+1 column, where n is the number of fields to group by 
		
		
		the elements in column n+1 are Data serie
		
		for each data serie
		
		the name of the dataserie is the serialized json from fieldname/fieldvalue from the group by fields
		the elements of the dataserie are record indexes in the parent dataset where we have matching key fields
		!! need to retain the source table and source table structure in order to do operations on the other fields
		
		
		option 2
		creates a data table with n + m columns, where n is the number of fields to group by and m is the number of fields to retain
		
		
		the elements in columns n+1 to n+m are data series
		the name of the dataseries is tdb 
		the elements of the dataserie are values from the fields to retain related to the grouping fields
		
		
		
		
		option 3
		creates a data table with n + m columns, where n is the number of fields to group by and m is the number of results 
		passing four arguments:
		
		- fields to group by
		- fields to count
		- fields to sum
		- fields to average
		
		
		
		 
	#tag EndNote

	#tag Note, Name = Version
		0.0.1 - 2023-04-16
		First version
		
		
	#tag EndNote


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return flag_allow_local_columns
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  flag_allow_local_columns = value
			End Set
		#tag EndSetter
		allow_local_columns As Boolean
	#tag EndComputedProperty

	#tag Property, Flags = &h1
		Protected columns() As clAbstractDataSerie
	#tag EndProperty

	#tag Property, Flags = &h21
		Private flag_allow_local_columns As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private index_explicit_when_iterate As Boolean
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected link_to_parent As clDataTable
	#tag EndProperty

	#tag Property, Flags = &h0
		meta_dict As clMetaData
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected row_index As clDataSerieRowID
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected table_name As String
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="allow_local_columns"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
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
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="name"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
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
