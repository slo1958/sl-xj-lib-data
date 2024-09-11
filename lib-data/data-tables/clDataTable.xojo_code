#tag Class
Protected Class clDataTable
Implements TableColumnReaderInterface,Iterable
	#tag Method, Flags = &h0
		Function AddColumn(the_column as clAbstractDataSerie) As clAbstractDataSerie
		  //  
		  //  Add a data serie as a column to the table
		  //  
		  //  Parameters:
		  //  - the data serie
		  //  
		  //  Returns:
		  //  - the data serie 
		  //  
		  var tmp_column As clAbstractDataSerie = the_column
		  
		  var tmp_column_name As String = tmp_column.name
		  
		  If Self.GetColumn(tmp_column_name) <> Nil Then
		    System.DebugLog("column " + tmp_column_name + " already defined in table.")
		    Return Nil
		    
		  end if
		  
		  
		  
		  //  physical table and column not yet linked
		  if not self.IsVirtual and not tmp_column.IsLinkedToTable then
		    var max_RowCount as integer = self.IncreaseLength(tmp_column.RowCount)
		    tmp_column.SetLength(max_RowCount)
		    
		    tmp_column.SetLinkToTable(Self)
		    Self.columns.Append(tmp_column)
		    
		    return tmp_column
		    
		  end if
		  
		  //  adding a physical column to a virtual table (when permitted)
		  if self.IsVirtual and not tmp_column.IsLinkedToTable and self.allow_local_columns then
		    var max_RowCount as integer = self.IncreaseLength(tmp_column.RowCount)
		    tmp_column.SetLength(max_RowCount)
		    
		    tmp_column.SetLinkToTable(Self)
		    Self.columns.Append(tmp_column)
		    
		    return tmp_column
		    
		  end if
		  
		  //  we add a column from another table to a virtual table
		  if self.IsVirtual and tmp_column.IsLinkedToTable then
		    tmp_column.SetLength(RowCount)
		    Self.columns.Append(tmp_column)
		    return tmp_column
		    
		  end if
		  
		  Return nil
		  
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function AddColumn(the_column_name as String) As clAbstractDataSerie
		  //  
		  //  Add  an empty column to the table
		  //  
		  //  Parameters:
		  //  - the name of the column
		  //  
		  //  Returns:
		  //  - the new data serie
		  //  
		  var v as variant
		  
		  return AddColumn(the_column_name, v)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function AddColumn(the_column_name as String, default_value as variant) As clAbstractDataSerie
		  //  
		  //  Add  an constant column to the table
		  //  
		  //  Parameters:
		  //  - the name of the column
		  //  - the initial value for every cell
		  //  
		  //  Returns:
		  //  - the new data serie
		  //  
		  var tmp_column_name As String = the_column_name.trim
		  
		  if tmp_column_name.len() = 0 then
		    tmp_column_name = "Untitled " + str(self.ColumnCount)
		    
		  end if
		  
		  If Self.GetColumn(tmp_column_name) <> Nil Then
		    System.DebugLog("column " + tmp_column_name + " already defined in table.")
		    Return Nil
		    
		  end if
		  
		  var tmp_column As clAbstractDataSerie
		  
		  If not self.IsVirtual then
		    tmp_column = New clDataSerie(tmp_column_name)
		    tmp_column.SetLinkToTable(Self)
		    tmp_column.SetLength(RowCount, default_value)
		    
		  Elseif allow_local_columns Then
		    tmp_column = New clDataSerie(tmp_column_name)
		    tmp_column.SetLinkToTable(Self)
		    tmp_column.SetLength(RowCount, default_value)
		    
		  Else
		    //  could be nil if the column exists in the parent datatable
		    tmp_column = link_to_parent.AddColumn( tmp_column_name)
		    
		  End If
		  
		  If tmp_column <> Nil Then
		    Self.columns.Append(tmp_column)
		    
		  End If
		  
		  Return tmp_column
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function AddColumns(the_columns() as clAbstractDataSerie) As clAbstractDataSerie()
		  //  
		  //  Add  a set of  empty columns to the table
		  //  
		  //  Parameters:
		  //  - the list  of  columns
		  //  
		  //  Returns:
		  //  - an array with the new data series
		  //  
		  
		  var return_array() As clAbstractDataSerie
		  
		  for each col as clAbstractDataSerie in the_columns
		    return_array.add( self.AddColumn(col))
		    
		  next
		  
		  return return_array
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function AddColumns(the_column_names() as string) As clAbstractDataSerie()
		  //  
		  //  Add  a set of  empty columns to the table
		  //  
		  //  Parameters:
		  //  - the name of the column
		  //  
		  //  Returns:
		  //  - an array with the new data series
		  //  
		  
		  
		  var return_array() As clAbstractDataSerie
		  var v as variant 
		  For Each name As String In the_column_names
		    return_array.append(AddColumn(name, v))
		    
		  Next
		  
		  return return_array
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AddColumns(the_source as TableColumnReaderInterface, create_missing_columns as boolean = True)
		  //  
		  //  Add  the data row from column source. New columns may be added to the current table
		  //  
		  //  For example, 
		  //  - with the current table containing columns A, B, C 
		  //  - with  the flag create_missing_column set to true
		  //  - appending from a table with columns A, B, D 
		  //  the values from A, and B are appended to the existing columns A and B
		  //  a new column is created to store the values for D 
		  
		  //  Parameters:
		  //  - the source , providing data column by column
		  //  - flag allow the creation of missing columns
		  //  
		  //  Returns:
		  //  (nothing)
		  //  
		  var length_before as integer = self.RowCount
		  
		  For Each src_tmp_column As clAbstractDataSerie In the_source.GetAllColumns
		    var column_name As String = src_tmp_column.name
		    
		    var dst_tmp_column As  clAbstractDataSerie = Self.GetColumn(column_name)
		    
		    If dst_tmp_column <> Nil Then
		      dst_tmp_column.AddSerie(src_tmp_column)
		      
		    elseif create_missing_columns then
		      dst_tmp_column = Self.AddColumn(column_name)
		      dst_tmp_column.SetLength(length_before)
		      
		      dst_tmp_column.AddSerie(src_tmp_column)
		      
		    else
		      AddError("append_row_from_table","Ignoring column " + column_name)
		      
		    End If
		    
		    
		    
		  Next
		  
		  var new_size As Integer = Self.RowCount + the_source.RowCount
		  
		  Self.row_index.SetLength(new_size)
		  
		  For Each tmp_column As clAbstractDataSerie In Self.columns
		    tmp_column.SetLength(new_size)
		    
		  Next
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AddError(source_fct as string, error_msg as string)
		  System.DebugLog(source_fct + " " + error_msg)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AddMetaData(type as string, message as string)
		  //  
		  //  Add  meta data to the table
		  //  
		  //  Parameters:
		  //  - the meta data type
		  //  - the meta data value
		  //  
		  //  Returns:
		  //  (nothing)
		  //  
		  
		  meta_dict.AddMetadata(type, message)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AddRow(the_row as clDataRow, create_columns_flag as boolean = True)
		  //  
		  //  Add  a data row to the table
		  //  
		  //  Parameters:
		  //  - the data row
		  //  - flag allow the creation of missing columns
		  //  
		  //  Returns:
		  //  (nothing)
		  //  
		  var tmp_RowCount As Integer = Self.RowCount
		  
		  if the_row.name.Trim = "" or not row_name_as_column then
		    
		  else
		    var tmp_column as clAbstractDataSerie = self.GetColumn(row_name_column)
		    
		    If tmp_column = Nil And create_columns_flag Then
		      tmp_column = AddColumn(row_name_column)
		      
		    End If
		    
		    if tmp_column <> nil then
		      tmp_column.AddElement(the_row.name)
		      
		    end if
		    
		  end if
		  
		  For Each column As String In the_row
		    var tmp_column As clAbstractDataSerie = Self.GetColumn(column)
		    
		    If tmp_column = Nil And create_columns_flag Then
		      tmp_column = AddColumn(column)
		      
		    End If
		    
		    If tmp_column = Nil Then
		      Raise New clDataException("Adding row with unexpected column " + column)
		      
		    Else
		      var tmp_item As variant = the_row.get_cell(column)
		      tmp_column.AddElement(tmp_item)
		      
		    End If
		    
		  Next
		  
		  Self.row_index.AddElement("")
		  
		  For Each column As clAbstractDataSerie In Self.columns
		    column.SetLength(tmp_RowCount+1)
		    
		  Next
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AddRow(the_values as Dictionary)
		  
		  //  Add  a data row to the table using the passed dictionary. Does not create new columns.
		  //  
		  //  Parameters:
		  //  - dictionary with key(field name) / value (field value)
		  //  
		  //  Returns:
		  //  (nothing)
		  //  
		  
		  if the_values = nil then 
		    return
		    
		  end if
		  
		  for each column as clAbstractDataSerie in self.columns
		    if the_values.HasKey(column.name) then
		      column.AddElement(the_values.value(column.name))
		      
		    else
		      column.AddElement("")
		      
		    end if
		    
		  next
		  
		  Self.row_index.AddElement("")
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AddRow(SourceObject as object)
		  
		  //  Add  a data row to the table using the passed dictionary. Does not create new columns.
		  //  
		  //  Parameters:
		  //  - an instance of a class
		  //
		  //  Returns:
		  //  (nothing)
		  //  
		  
		  
		  
		  if SourceObject = nil then return
		  
		  var d as new Dictionary
		  var t as Introspection.TypeInfo = Introspection.GetType(SourceObject)
		  
		  
		  for each p as Introspection.PropertyInfo in t.GetProperties
		    
		    if  p.PropertyType.IsPrimitive and  p.IsPublic and p.CanRead then
		      var name as string = p.Name
		      
		      d.value(name) = p.Value(SourceObject)
		      
		    end if
		    
		  next
		  
		  for each column as clAbstractDataSerie in self.columns
		    if d.HasKey(column.name) then
		      column.AddElement(d.value(column.name))
		      
		    else
		      column.AddElement("")
		      
		    end if
		    
		  next
		  
		  Self.row_index.AddElement("")
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AddRow(the_values() as string)
		  
		  //  Add  a data row to the table
		  //  
		  //  Parameters:
		  //  - the data row (values as string), it is assumed the values are ordered according to the current column order in the table
		  //  //  
		  //  Returns:
		  //  (nothing)
		  //  
		  For i As Integer = 0 To columns.LastIndex
		    If i <= the_values.LastIndex Then
		      columns(i).AddElement(the_values(i))
		      
		    Else
		      columns(i).AddElement("")
		      
		    End If
		    
		  Next
		  
		  Self.row_index.AddElement("")
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AddRow(the_values() as variant)
		  
		  //  Add  a data row to the table
		  //  
		  //  Parameters:
		  //  - the data row (values as variant), it is assumed the values are ordered according to the current column order in the table
		  //  
		  //  Returns:
		  //  (nothing)
		  //  
		  For i As Integer = 0 To columns.LastIndex
		    If i <= the_values.LastIndex Then
		      columns(i).AddElement(the_values(i))
		      
		    Else
		      columns(i).AddElement("")
		      
		    End If
		    
		  Next
		  
		  Self.row_index.AddElement("")
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AddRows(source_rows() as clDataRow, create_columns_flag as boolean = True)
		  //  
		  //  Add  data rows to the table
		  //  
		  //  Parameters:
		  //  - the data rows as an array
		  //  - flag allow the creation of missing columns
		  //  
		  //  Returns:
		  //  (nothing)
		  //  
		  for each row as clDataRow in source_rows
		    self.AddRow(row, create_columns_flag)
		    
		  next
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AddRows(source_dictionaries() as Dictionary)
		  //  
		  //  Add  data rows to the table
		  //  
		  //  Parameters:
		  //  - the data rows as an array
		  //
		  //  Returns:
		  //  (nothing)
		  //  
		  for each dict as Dictionary in source_dictionaries
		    self.AddRow(dict)
		    
		  next
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AddRows(source_objects() as object)
		  //  
		  //  Add  data rows to the table
		  //  
		  //  Parameters:
		  //  - the data rows as an array
		  //
		  //  Returns:
		  //  (nothing)
		  //  
		  for each obj as object in source_objects
		    self.AddRow(obj)
		    
		  next
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AddRows(the_source as TableRowReaderInterface, create_missing_columns as boolean = True)
		  //  
		  //  Add  the data row from column source. New columns may be added to the current table
		  //  
		  //  For example, 
		  //  - with the current table containing columns A, B, C 
		  //  - with  the flag create_missing_column set to true
		  //  - appending from a table with columns A, B, D 
		  //  the values from A, and B are appended to the existing columns A and B
		  //  a new column is created to store the values for D 
		  
		  //  Parameters:
		  //  - the source , providing data column by column
		  //  - flag allow the creation of missing columns
		  //  
		  //  Returns:
		  //  (nothing)
		  //  
		  var length_before as integer = self.RowCount
		  
		  var tmp_columns() as clAbstractDataSerie
		  
		  for each column_name as string in the_source.GetColumnNames
		    var tmp_col as clAbstractDataSerie = self.GetColumn(column_name)
		    
		    if tmp_col = nil then
		      if create_missing_columns then
		        tmp_col = new clDataSerie(column_name)
		        tmp_col.SetLength(length_before)
		        call self.AddColumn(tmp_col)
		        
		      else
		        AddError("append_row_from_table","Ignoring column " + column_name)
		        
		      end if 
		    end if
		    
		    tmp_columns.add(tmp_col)
		    
		  next
		  
		  call self.internal_AddRows(the_source, tmp_columns, the_source.name)
		  
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AddRows(the_source as TableRowReaderInterface, mapping_dict as dictionary)
		  //  
		  //  Add  the data row from column source. New columns may be added to the current table
		  //  
		  //  For example, 
		  //  - with the current table containing columns A, B, C 
		  //  - appending from the_source,  a table with columns X, Y, Z
		  //  - mapping dictionary X:A, Y:B, Z:D
		  //  the values from X, and Y are appended to the existing columns A and B
		  //  a new column D is created to store the values from Z
		  
		  //  Parameters:
		  //  - the source , providing data column by column
		  //  - mapping dictionary, key is field name in the_source, value is the field name in the clDataTable
		  //  
		  //  Returns:
		  //  (nothing)
		  //  
		  var length_before as integer = self.RowCount
		  
		  var tmp_columns() as clAbstractDataSerie
		  
		  for each source_column_name as string in the_source.GetColumnNames
		    var tmp_col as clAbstractDataSerie = nil
		    
		    if mapping_dict.HasKey(source_column_name) then
		      var tarGetColumn_name as string = mapping_dict.value(source_column_name)
		      
		      tmp_col = self.GetColumn(tarGetColumn_name)
		      
		      if tmp_col = nil then
		        tmp_col = new clDataSerie(tarGetColumn_name)
		        tmp_col.SetLength(length_before)
		        call self.AddColumn(tmp_col)
		        
		      end if
		    end if
		    
		    tmp_columns.add(tmp_col)
		    
		  next
		  
		  call self.internal_AddRows(the_source, tmp_columns, the_source.name)
		  
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AdjustLength()
		  //  
		  //   adjust  the length of each data serie in the table, to match the longest data serie
		  //  to use after directly inserting in columns 
		  //  In normal case, all columns have the same length.
		  //  
		  //  Parameters:
		  // 
		  //  
		  //  Returns:
		  //  - (nothing)
		  //  
		  
		  var max_RowCount as integer=-1
		  
		  
		  for each c as clAbstractDataSerie in self.columns
		    if max_RowCount < c.RowCount then max_RowCount = c.RowCount
		    
		  next
		  
		  row_index.SetLength(max_RowCount)
		  
		  for each c as clAbstractDataSerie in self.columns
		    c.SetLength(max_RowCount)
		    
		  next
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ClipByRange(column as clAbstractDataSerie, low_value_column as clAbstractDataSerie, high_value_column as clAbstractDataSerie) As integer
		  
		  if column = nil then return 0
		  if low_value_column = nil then return 0
		  if high_value_column = nil then return 0
		  
		  var last_index as integer = column.RowCount
		  var count_changes as integer = 0
		  
		  
		  for index as integer = 0 to last_index
		    var tmp as variant = column.GetElement(index)
		    var low_value as Variant = low_value_column.GetElement(index)
		    var high_value as Variant = high_value_column.GetElement(index)
		    
		    
		    if low_value > tmp then
		      column.SetElement(index, low_value)
		      count_changes = count_changes + 1
		      
		    elseif  tmp > high_value then
		      column.SetElement(index, high_value)
		      count_changes = count_changes + 1
		      
		    end if
		    
		  next
		  
		  Return count_changes
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ClipByRange(column_name as string, low_value_column_name as string, high_value_column_name as String) As integer
		  
		  var column as clAbstractDataSerie = self.GetColumn(column_name)
		  var high_column as clAbstractDataSerie = self.GetColumn(high_value_column_name)
		  var low_column as clAbstractDataSerie = self.GetColumn(low_value_column_name)
		  
		  if column = nil then return 0
		  if high_column = nil then return 0
		  if low_column = nil then return 0
		  
		  return self.ClipByRange(column, low_column, high_column)
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ClipByRange(column_name as string, low_value as variant, high_value as variant) As integer
		  
		  var column as clAbstractDataSerie = self.GetColumn(column_name)
		  
		  if column = nil then return 0
		  
		  return column.ClipByRange(low_value, high_value)
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ClipHighValues(column as clAbstractDataSerie, high_value_column as clAbstractDataSerie) As integer
		  
		  if column = nil then return 0
		  if high_value_column = nil then return 0
		  
		  var last_index as integer = column.RowCount
		  var count_changes as integer = 0
		  
		  for index as integer = 0 to last_index
		    var tmp as variant = column.GetElement(index)
		    var high_value as Variant = high_value_column.GetElement(index)
		    
		    if  tmp > high_value then
		      column.SetElement(index, high_value)
		      count_changes = count_changes + 1
		      
		    end if
		    
		  next
		  
		  Return count_changes
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ClipHighValues(column_name as string, high_value_column_name as String) As integer
		  
		  var column as clAbstractDataSerie = self.GetColumn(column_name)
		  var high_column as clAbstractDataSerie = self.GetColumn(high_value_column_name)
		  
		  if column = nil then return 0
		  if high_column = nil then return 0
		  
		  return self.ClipHighValues(column, high_column)
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ClipHighValues(column_name as string, high_value as variant) As integer
		  
		  var column as clAbstractDataSerie = self.GetColumn(column_name)
		  
		  if column = nil then return 0
		  
		  return column.ClipHighValues(high_value)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ClipLowValues(column as clAbstractDataSerie, low_value_column as clAbstractDataSerie) As integer
		  
		  if column = nil then return 0
		  if low_value_column = nil then return 0
		  
		  var last_index as integer = column.RowCount
		  var count_changes as integer = 0
		  
		  for index as integer = 0 to last_index
		    var tmp as variant = column.GetElement(index)
		    var low_value as Variant = low_value_column.GetElement(index)
		    
		    if  tmp < low_value then
		      column.SetElement(index, low_value)
		      count_changes = count_changes + 1
		      
		    end if
		    
		  next
		  
		  Return count_changes
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ClipLowValues(column_name as string, low_value_column_name as String) As integer
		  
		  var column as clAbstractDataSerie = self.GetColumn(column_name)
		  var low_column as clAbstractDataSerie = self.GetColumn(low_value_column_name)
		  
		  if column = nil then return 0
		  if low_column = nil then return 0
		  
		  return self.ClipLowValues(column, low_column)
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ClipLowValues(column_name as string, low_value as Variant) As integer
		  
		  var column as clAbstractDataSerie = self.GetColumn(column_name)
		  
		  if column = nil then return 0
		  
		  return column.ClipLowValues(low_value)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Clone() As clDataTable
		  
		  //  Duplicate the table and all its columns
		  //  
		  //  Parameters:
		  //  - None
		  //  
		  //  Returns:
		  //  - Nothing
		  //  
		  var output_table as new clDataTable(self.name+" copy")
		  
		  for each col as clAbstractDataSerie in self.columns
		    var new_col as clAbstractDataSerie = col.Clone()
		    
		    call output_table.AddColumn(new_col)
		    
		  next
		  
		  Return output_table
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ColumnCount() As integer
		  
		  //  Return the number of columns in a table
		  //  
		  //  Parameters:
		  //  - none
		  //  
		  //  Returns:
		  //  - the number of columns as an integer
		  //  
		  Return columns.LastIndex + 1
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ColumnNameAt(index as integer) As String
		  //  
		  //  returns a column
		  //  
		  //  Parameters:
		  //  - the index of the column
		  //  
		  //  Returns:
		  //  - the name if the column at specified index
		  //  
		  
		  try
		    return columns(index).name
		    
		  catch
		    return ""
		    
		  end try
		End Function
	#tag EndMethod

	#tag DelegateDeclaration, Flags = &h0
		Delegate Function column_allocator(column_name as String, column_type_info as string) As clAbstractDataSerie
	#tag EndDelegateDeclaration

	#tag Method, Flags = &h0
		Sub Constructor(the_table_name as string)
		  //
		  //  Creates a datatable
		  //  
		  //  Parameters:
		  //  - the name of the data table
		  //
		  //  Returns:
		  //  - 
		  //
		  meta_dict = new clMetadata
		  
		  var tmp_table_name As String
		  
		  tmp_table_name = the_table_name
		  
		  internal_new_table(tmp_table_name)
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(the_table_name as string, the_columns() as clabstractDataSerie, AutoCloneColumns as boolean = false)
		  //
		  // Creates a new data table from a set of columns. Columns cannot be part of another table. If AutoCloneColumn is true, a column 
		  //  that is already used in another table will be cloned. If the parameter is false (default), an exception is generated if the column is already
		  //  linked to another table
		  //  
		  //  Parameters:
		  //  - the name of the data table
		  // - the columns as an array of data series
		  // - an option to clone a data serie (column) if it is already used in another table
		  //
		  //  Returns:
		  //  -  
		  //
		  
		  meta_dict = new clMetadata
		  
		  var tmp_columns() As clAbstractDataSerie = the_columns
		  
		  if the_columns = nil then return
		  
		  For i As Integer = 0 To tmp_columns.LastIndex
		    If tmp_columns(i) = Nil Then
		      Raise New clDataException("Internal error")
		      
		    Elseif tmp_columns(i).IsLinkedToTable And  AutoCloneColumns Then
		      tmp_columns(i) = tmp_columns(i).clone
		      
		    Elseif tmp_columns(i).IsLinkedToTable And Not AutoCloneColumns Then
		      Raise New clDataException("Cannot add a linked serie to a new table, use SelectColumns() method instead.")
		      
		    Else
		      
		    End If
		    
		  Next
		  
		  internal_new_table(the_table_name)
		  
		  For Each c As clAbstractDataSerie In tmp_columns
		    //  add column takes care of adjusting the length
		    call Self.AddColumn(c)
		    
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(the_table_name as string, the_columns as Dictionary, allocator as column_allocator = nil)
		  //
		  // Creates a new data table from a set of columns. Columns are passed as a dictionary with column name as key and an array of values as value
		  //  
		  //  Parameters:
		  //  - the name of the data table
		  // - the columns as a dictionary
		  // - an option to clone a data serie (column) if it is already used in another table
		  //
		  //  Returns:
		  //  -  
		  //
		  
		  meta_dict = new clMetadata
		  
		  if the_columns = nil then return
		  
		  var tmp_columns() as clAbstractDataSerie
		  
		  for each tmp_column_name as string in the_columns.Keys
		    var v() as variant = MakeVariantArray(the_columns.value(tmp_column_name))
		    
		    if allocator = nil then
		      tmp_columns.Add(new clDataSerie(tmp_column_name, v))
		      
		    else
		      var tmp_column as clAbstractDataSerie = allocator.Invoke(tmp_column_name,"")
		      tmp_column.AddElements(v)
		      
		      tmp_columns.Add(tmp_column)
		      
		    end if
		  next
		  
		  internal_new_table(the_table_name)
		  
		  For Each c As clAbstractDataSerie In tmp_columns
		    //  add column takes care of adjusting the length
		    call Self.AddColumn(c)
		    
		  Next
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(the_table_name as string, column_names() as string)
		  //  
		  //  Creates a data table from a list of column names
		  //  
		  //  Parameters:
		  //  - the name of the table
		  //  -  a string array with the list of names for columns
		  //  
		  //  Returns:
		  //  -  
		  //  
		  meta_dict = new clMetadata
		  
		  var tmp_table_name As String
		  
		  tmp_table_name = the_table_name
		  
		  internal_new_table(tmp_table_name)
		  
		  
		  For Each name As string In column_names
		    var temp_name as string = name.Trim
		    call Self.AddColumn(temp_name)
		    
		  Next
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(table_name as string, table_source as TableRowReaderInterface, allocator as column_allocator = nil)
		  //
		  //  Creates a datatable from a table row reader
		  //  
		  //  Parameters:
		  //  - the table reader
		  //
		  //  Returns:
		  //  - 
		  //
		  
		  meta_dict = new clMetadata
		  
		  self.allow_local_columns = False
		  
		  var tmp_table_name As String = table_name.Trim
		  
		  if tmp_table_name.Length = 0 then
		    tmp_table_name = "Noname"
		    
		  end if 
		  
		  AddMetadata("source", tmp_table_name)
		  
		  internal_new_table(tmp_table_name)
		  
		  // var columns() as clAbstractDataSerie
		  
		  var tmp_column_names() as string = table_source.GetColumnNames
		  var tmp_column_types as Dictionary = table_source.GetColumnTypes
		  
		  for each tmp_column_name as string in tmp_column_names
		    
		    if allocator = nil or tmp_column_types = nil then
		      columns.Add(new clDataSerie(tmp_column_name))
		      
		    else
		      columns.Add(allocator.Invoke(tmp_column_name, tmp_column_types.value(tmp_column_name)))
		      
		    end if
		    
		  next
		  
		  
		  while not table_source.EndOfTable
		    var tmp_row() as variant
		    
		    tmp_row  = table_source.NextRow
		    
		    if tmp_row <> nil then
		      
		      for i as integer=0 to tmp_column_names.LastIndex
		        columns(i).AddElement(tmp_row(i))
		        
		      next 
		      
		    end if
		    
		  wend
		  
		  
		  self.AdjustLength()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(table_source as TableColumnReaderInterface, materialize as boolean = False)
		  //
		  //  Creates a datatable from a table column reader
		  //  The function creates a virtual table if the 'materalize' flag is False and the source table is 'persistant', for example another data_table
		  //  The function clones the columnw otherwise
		  //  
		  //  Parameters:
		  //  - the table reader
		  //  - materialize flag
		  //
		  //  Returns:
		  //  - 
		  //
		  
		  meta_dict = new clMetadata 
		  
		  self.allow_local_columns = False
		  
		  var tmp_table_name As String = table_source.name.Trim
		  
		  if tmp_table_name.Length = 0 then
		    tmp_table_name = "Noname"
		    
		  end if 
		  
		  AddMetadata("source", tmp_table_name)
		  
		  internal_new_table("from " + tmp_table_name)
		  
		  if table_source.IsPersistant and not materialize then
		    // 
		    // we create a virtual table
		    //
		    self.link_to_source = table_source
		    
		    For Each column_name As String In table_source.GetColumnNames
		      var tmp_column As clAbstractDataSerie = table_source.GetColumn(column_name)
		      
		      If tmp_column <> Nil Then
		        call self.AddColumn(tmp_column)
		        
		      else
		        AddError("select_column","cannot find column " + column_name)
		        
		      End If
		      
		    next
		  else
		    
		    For Each column_name As String In table_source.GetColumnNames
		      var tmp_column As clAbstractDataSerie = table_source.GetColumn(column_name)
		      
		      If tmp_column <> Nil Then
		        call self.AddColumn(tmp_column.clone)
		        
		      else
		        AddError("select_column","cannot find column " + column_name)
		        
		      End If
		      
		    next
		    
		    
		  end if
		  
		  self.AdjustLength()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(table_source as TableRowReaderInterface, allocator as column_allocator = nil)
		  //
		  //  Creates a datatable from a table row reader
		  //  
		  //  Parameters:
		  //  - the table reader
		  //
		  //  Returns:
		  //  - 
		  //
		  
		  meta_dict = new clMetadata
		  
		  self.allow_local_columns = False
		  
		  var tmp_table_name As String = table_source.name.Trim
		  
		  if tmp_table_name.Length = 0 then
		    tmp_table_name = "Noname"
		    
		  end if 
		  
		  AddMetadata("source", tmp_table_name)
		  
		  internal_new_table("from " + tmp_table_name)
		  
		  // var columns() as clAbstractDataSerie
		  
		  var tmp_column_names() as string = table_source.GetColumnNames
		  var tmp_column_types as Dictionary = table_source.GetColumnTypes
		  
		  for each tmp_column_name as string in tmp_column_names
		    
		    if allocator = nil or tmp_column_types = nil then
		      columns.Add(new clDataSerie(tmp_column_name))
		      
		    else
		      columns.Add(allocator.Invoke(tmp_column_name, tmp_column_types.value(tmp_column_name)))
		      
		    end if
		    
		  next
		  
		  
		  call self.internal_AddRows(table_source, columns, "")
		  
		  self.AdjustLength()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function CreateTableFromStructure(new_table_name as String) As clDataTable
		  
		  var tbl as new clDataTable(new_table_name)
		  
		  for each row as clDataRow in self
		    var col_name as string = row.get_cell(structure_name_column)
		    var col_type as string = row.get_cell(structure_type_column)
		    var col_title as string  = row.get_cell(structure_title_column)
		    
		    var column as clAbstractDataSerie = tbl.AddColumn(clDataType.CreateDataSerie(col_name, col_type))
		    
		    if col_title.Length > 0 then
		      column.display_title = col_title
		      
		    end if
		    
		  next
		  
		  return tbl
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub debug_dump()
		  
		  var tmp_item() As String
		  
		  System.DebugLog("----START " + Self.table_name+" --------")
		  
		  System.DebugLog("#rows : " + str(self.RowCount))
		  System.DebugLog("#columns : " + str(self.columns.LastIndex+1))
		  
		  tmp_item.Append("index")
		  For Each tmp_column As clAbstractDataSerie In columns
		    tmp_item.Append(tmp_column.name)
		    
		  Next
		  
		  System.DebugLog(Join(tmp_item, ";"))
		  
		  For row As Integer = 0 To RowCount-1
		    redim tmp_item(-1)
		    
		    tmp_item.Append(Self.row_index.GetElement(row))
		    
		    For Each tmp_column As clAbstractDataSerie In columns
		      tmp_item.Append(tmp_column.GetElement(row))
		      
		    Next
		    System.DebugLog(Join(tmp_item, ";"))
		    
		  Next
		  
		  System.DebugLog("----END " + Self.table_name+" --------")
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function FilteredOn(boolean_serie as clBooleanDataSerie) As clDataTableFilter
		  //  
		  //  Creates a data table filter (iterable) using a column as a mask,  the column (data serie)  is passed as parameter. 
		  //  The data serie does not need to belong to any data table
		  //  
		  //  Parameters:
		  //  - a boolean data serie used as mask
		  //  
		  //  Returns:
		  //  - a data table filter
		  //  
		  var retval as new clDataTableFilter(self, boolean_serie)
		  
		  return retval
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function FilteredOn(boolean_field_name as string) As clDataTableFilter
		  //  
		  //  Creates a data table filter (iterable) using a column as a mask, the name fof the column is passed as parameter. The column must be defined
		  //  in the table
		  //  
		  //  Parameters:
		  //  - the name of the column
		  //  
		  //  Returns:
		  //  - a data table filter
		  //  
		  var retval as new clDataTableFilter(self, boolean_field_name)
		  
		  return retval
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function FilterWithFunction(the_filter_function as filter_row, paramarray function_param as variant) As variant()
		  //  
		  //  Applies a filter function to each data row of the table, returns a boolean data serie
		  //  
		  //  Parameters:
		  //  - the address of the filter function
		  //  - the parameters to pass to the function
		  //  
		  //  Returns:
		  //  - a boolean data serie
		  //  
		  
		  var return_boolean() As Variant
		  
		  var column_names() As String
		  var column_values() as Variant
		  
		  for each column as clAbstractDataSerie in self.columns
		    column_names.Append(column.name)
		    
		  next
		  
		  var RowCount as integer = self.RowCount
		  
		  For i As Integer=0 To RowCount-1
		    redim column_values(-1)
		    
		    for each column as clAbstractDataSerie in self.columns
		      column_values.Append(column.GetElement(i))
		      
		    next
		    
		    return_boolean.Append(the_filter_function.Invoke(i,  RowCount, column_names, column_values, function_param))
		    
		  Next
		  
		  Return return_boolean
		  
		End Function
	#tag EndMethod

	#tag DelegateDeclaration, Flags = &h0
		Delegate Function filter_row(the_row_index as integer, the_RowCount as integer, the_column_names() as string, the_cell_values() as variant, paramarray function_param as variant) As Boolean
	#tag EndDelegateDeclaration

	#tag Method, Flags = &h0
		Function FindAllMatchingRowIndexes(the_column_names() as string, the_column_values() as string, limit as integer = -1) As integer()
		  //  
		  //  returns the index of the data rows where the value each columns matches the constants
		  //  
		  //  Parameters:
		  //  - the name of the columns as an array of string
		  //  - the value searched as a array of string
		  // - the maximum number of indexes to return, -1 means no limit
		  //  
		  //  Returns:
		  //  - an array with the index of all matching data row as an integer or nill if the referenced column does not exist
		  //  
		  
		  var MatchingIndexes() as integer
		  var tmp_columns() As clAbstractDataSerie
		  
		  for each name as string in the_column_names
		    var tmp_column as clAbstractDataSerie = GetColumn(name)
		    
		    If tmp_column = Nil Then
		      Return nil
		      
		    End If
		    
		    tmp_columns.Append(tmp_column)
		  next
		  
		  
		  For row_index As Integer = 0 To tmp_columns(0).RowCount-1
		    
		    var ok_row as Boolean = True
		    var col_index as integer =  0
		    
		    while ok_row and col_index <= tmp_columns.LastIndex
		      
		      If tmp_columns(col_index).GetElement(row_index) <> the_column_values(col_index) Then
		        ok_row = False
		        
		      else
		        col_index = col_index + 1
		        
		      End If
		      
		    wend
		    
		    if ok_row and (MatchingIndexes.Count < limit or limit <0) then
		      MatchingIndexes.Add(row_index)
		      
		    end if
		  Next
		  
		  Return MatchingIndexes
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function FindAllMatchingRowIndexes(the_column_name as string, the_column_value as string, limit as integer = -1) As integer()
		  //  
		  //  returns the index of the data rows where the value in column matches the constant
		  //  
		  //  Parameters:
		  //  - the name of the column
		  //  - the value searched as a string
		  // - the maximum number of indexes to return, -1 means no limit
		  //  
		  //  Returns:
		  //  - an array with the index of all matching data row as an integer or nill if the referenced column does not exist
		  //
		  
		  var MatchingIndexes() as integer
		  
		  var tmp_column As clAbstractDataSerie
		  
		  tmp_column = GetColumn(the_column_name)
		  
		  If tmp_column = Nil Then
		    Return nil
		    
		  End If
		  
		  For i As Integer = 0 To tmp_column.RowCount-1
		    If tmp_column.GetElement(i) = the_column_value Then
		      if MatchingIndexes.Count < limit and limit>0 then
		        MatchingIndexes.Add(i)
		        
		      end if
		      
		    End If
		    
		  Next
		  
		  Return MatchingIndexes
		  
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function FindFirstMatchingRow(the_column_name as string, the_column_value as string, include_index as Boolean) As clDataRow
		  //  
		  //  returns the first data row where the value in column matches the constant
		  //  
		  //  Parameters:
		  //  - the name of the column
		  //  - the value searched as a string
		  //  
		  //  Returns:
		  //  - a data row if found or nil
		  //  
		  var tmp_row_index as integer = self.FindFirstMatchingRowIndex(the_column_name, the_column_value)
		  
		  if tmp_row_index <0 then
		    return nil
		    
		  end if
		  
		  return self.GetRowAt(tmp_row_index, include_index)
		  
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function FindFirstMatchingRowIndex(the_column_names() as string, the_column_values() as string) As integer
		  //  
		  //  returns the index of the data row where the value each columns matches the constants
		  //  
		  //  Parameters:
		  //  - the name of the columns as an array of string
		  //  - the value searched as a array of string
		  //  
		  //  Returns:
		  //  - the index of the first matching data row as an integer, set to -1 if not found
		  //  
		  
		  var tmp_columns() As clAbstractDataSerie
		  
		  for each name as string in the_column_names
		    var tmp_column as clAbstractDataSerie = GetColumn(name)
		    
		    If tmp_column = Nil Then
		      Return -2
		      
		    End If
		    
		    tmp_columns.Append(tmp_column)
		  next
		  
		  
		  For row_index As Integer = 0 To tmp_columns(0).RowCount-1
		    
		    var ok_row as Boolean = True
		    var col_index as integer =  0
		    
		    while ok_row and col_index <= tmp_columns.LastIndex
		      
		      If tmp_columns(col_index).GetElement(row_index) <> the_column_values(col_index) Then
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
		Function FindFirstMatchingRowIndex(the_column_name as string, the_column_value as string) As integer
		  //  
		  //  returns the index of the data row where the value in column matches the constant
		  //  
		  //  Parameters:
		  //  - the name of the column
		  //  - the value searched as a string
		  //  
		  //  Returns:
		  //  - the index of the first matching data row as an integer, set to -1 if not found
		  //  
		  
		  var tmp_column As clAbstractDataSerie
		  
		  tmp_column = GetColumn(the_column_name)
		  
		  If tmp_column = Nil Then
		    Return -2
		    
		  End If
		  
		  For i As Integer = 0 To tmp_column.RowCount-1
		    If tmp_column.GetElement(i) = the_column_value Then
		      Return i
		      
		    End If
		    
		  Next
		  
		  Return -1
		  
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetAllColumns() As clAbstractDataSerie()
		  return columns
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetColumn(the_column_name as String) As clAbstractDataSerie
		  //  
		  //  returns a column
		  //  
		  //  Parameters:
		  //  - the name of the column
		  //  
		  //  Returns:
		  //  - the column matching the name or nil
		  //  
		  
		  return self.GetColumn(the_column_name, false)
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetColumn(the_column_name as String, include_alias as boolean) As clAbstractDataSerie
		  //  
		  //  returns a column
		  //  
		  //  Parameters:
		  //  - the name of the column
		  //  
		  //  Returns:
		  //  - the column matching the name or nil
		  //  
		  
		  For Each column As clAbstractDataSerie In Self.columns
		    If column.name = the_column_name Then
		      Return column
		      
		    End If
		    
		  Next
		  
		  if not include_alias then return nil
		  
		  For Each column As clAbstractDataSerie In Self.columns
		    if column.HasAlias(the_column_name) then
		      return column
		      
		    end if
		    
		  Next
		  
		  Return Nil
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetColumnAt(column_index as integer) As clAbstractDataSerie
		  //  
		  //  returns a column
		  //  
		  //  Parameters:
		  //  - the index of the column
		  //  
		  //  Returns:
		  //  - the column at specified index
		  //  
		  
		  try
		    return self.columns(column_index)
		    
		  catch
		    return nil
		    
		  end try
		  
		  
		  Return Nil
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetColumnNames() As string()
		  //  
		  //  Return the name of all columns
		  //  
		  //  Parameters:
		  //  - none
		  //  
		  //  Returns:
		  //  - a string array with the name of the columns
		  //  
		  var ret_str() As String
		  For Each column As clAbstractDataSerie In columns
		    ret_str.Append(column.name)
		    
		  Next
		  
		  Return ret_str
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetColumns(column_names() as string) As clAbstractDataSerie()
		  //  
		  //  returns selected columns
		  //  
		  //  Parameters:
		  //  - the name of the columns as an array of string
		  //  
		  //  Returns:
		  //  - the columns matching the name or nil, as an array
		  //  
		  var ret() As clAbstractDataSerie
		  
		  
		  For Each column_name As String In column_names
		    var tmp_column As clAbstractDataSerie = Self.GetColumn(column_name)
		    
		    ret.Append(tmp_column)
		    
		    
		  Next
		  
		  Return ret
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetColumns(paramarray column_names as string) As clAbstractDataSerie()
		  
		  //  returns selected columns
		  //  
		  //  Parameters:
		  //  - the name of the columns as string parameters
		  //  
		  //  Returns:
		  //  - the columns matching the name or nil, as an array
		  //  
		  
		  Return GetColumns(column_names)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetElement(the_column_index as integer, the_element_index as integer) As variant
		  //  
		  //  returns a specific cell based on column name and row number
		  //  
		  //  Parameters:
		  //  - the index of the column 
		  //  - the row index
		  //  
		  //  Returns:
		  //  - the value of the matching cell or nil
		  //  
		  var tmp_col as clAbstractDataSerie = self.GetColumnAt(the_column_index)
		  
		  if tmp_col = nil then return nil
		  
		  return tmp_col.GetElement(the_element_index)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetElement(the_column_name as String, the_element_index as integer) As variant
		  //  
		  //  returns a specific cell based on column name and row number
		  //  
		  //  Parameters:
		  //  - the name of the columns 
		  //  - the row index
		  //  
		  //  Returns:
		  //  - the value of the matching cell or nil
		  //  
		  var tmp_col as clAbstractDataSerie = self.GetColumn(the_column_name)
		  
		  if tmp_col = nil then return nil
		  
		  return tmp_col.GetElement(the_element_index)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetMetadata() As clMetaData
		  Return self.meta_dict
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetNumberColumn(the_column_name as string) As clNumberDataSerie
		  
		  
		  var tmp as clAbstractDataSerie =  self.GetColumn(the_column_name, false)
		  
		  return clNumberDataSerie(tmp)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetRowAt(the_row_index as integer, include_index as Boolean) As clDataRow
		  //  
		  //  returns a specific data row
		  //  
		  //  Parameters:
		  //  - the  index of the data row
		  //  
		  //  Returns:
		  //  - a data row with the value of the cell in each column at the specified index
		  //  
		  var tmp_row as new clDataRow
		  
		  if not include_index then
		    
		  elseif row_index = nil then
		    tmp_row.set_cell("row_index",  the_row_index)
		    
		  else
		    tmp_row.set_cell("row_index",  row_index.GetElement(the_row_index))
		    
		  end if
		  
		  for each column as clAbstractDataSerie in self.columns
		    var col_name as string = column.name
		    var col_val as Auto = column.GetElement(the_row_index)
		    tmp_row.set_cell(col_name, col_val)
		    
		  next
		  
		  return tmp_row
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetRowReader() As clDataTableRowReader
		  return new clDataTableRowReader(self)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetStatisticsAsTable() As clDataTable
		  
		  var col_name() as string
		  var col_ubound() as integer
		  var col_Count() as integer
		  var col_count_nz() as double
		  var col_sum() as Double
		  var col_average() as Double
		  var col_average_nz() as Double
		  var col_stdev() as Double
		  var col_stdev_nz() as Double
		  
		  
		  for i as integer = 0 to columns.LastIndex
		    col_name.Add(columns(i).name)
		    
		    col_ubound.Add(columns(i).LastIndex)
		    
		    col_count.Add(columns(i).count)
		    col_count_nz.Add(columns(i).CountNonZero)
		    
		    col_sum.add(columns(i).sum)
		    col_average.Add(columns(i).average)
		    col_average_nz.Add(columns(i).AverageNonZero)
		    
		    col_stdev.Add(columns(i).StandardDeviation)
		    col_stdev_nz.Add(columns(i).StandardDeviationNonZero)
		    
		  next
		  
		  var series() as clAbstractDataSerie
		  series.Add(new clDataSerie(statistics_name_column, col_name))
		  series.add(new clIntegerDataSerie(statistics_ubound_column, col_ubound))
		  series.Add(new clIntegerDataSerie(statistics_count_column, col_count))
		  series.Add(new clIntegerDataSerie(statistics_count_nz_column, col_count_nz))
		  
		  series.Add(new clNumberDataSerie(statistics_sum_column, col_sum))
		  series.Add(new clNumberDataSerie(statistics_average_column, col_average))
		  series.Add(new clNumberDataSerie(statistics_average_nz_column, col_average_nz))
		  
		  series.Add(new clNumberDataSerie(statistics_std_dev_column, col_stdev))
		  series.Add(new clNumberDataSerie(statistics_std_dev_nz_column, col_stdev_nz))
		  
		  return new clDataTable(self.statistics_name_prefix + self.name, series)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetStructureAsTable() As clDataTable
		  
		  var col_name() as string
		  var col_type() as string
		  var col_title() as String
		  
		  for i as integer = 0 to columns.LastIndex
		    col_name.Add(columns(i).name)
		    col_type.add(columns(i).GetType)
		    col_title.add(columns(i).display_title)
		    
		  next
		  
		  var dct as new Dictionary
		  dct.Value(structure_name_column) = col_name
		  dct.Value(structure_type_column) = col_type
		  dct.Value(structure_title_column) = col_title
		  
		  return new clDataTable(self.structure_name_prefix + self.name, dct)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GroupBy(grouping_dimensions() as string, aggregate_measures() as string, aggregate_mode() as string) As clDataTable
		  //  
		  //  returns a new data table with the results of the aggregation
		  //  
		  //  Parameters:
		  //  - the list of columns to group by as an array of string
		  //  - the list of columns to aggregated as an array of string
		  //  - the list of type aggregation (current version: ignored, always do 'sum')
		  //  
		  //  Returns:
		  //  - aggregated data table
		  //  
		  
		  var input_dimensions() As clAbstractDataSerie
		  var input_measures() As clAbstractDataSerie
		  var any_error as Boolean = false
		  
		  For Each item As String In grouping_dimensions
		    If Len(Trim(item)) > 0 Then
		      var tmp_serie as clAbstractDataSerie = self.GetColumn(item)
		      if tmp_serie <> nil then
		        input_dimensions.Append(tmp_serie)
		        
		      else
		        AddError("GroupBy","cannot find column " + item)
		        any_error = True
		      end if
		      
		    End If
		  Next
		  
		  For Each item As String In aggregate_measures
		    If Len(Trim(item)) > 0 Then
		      var tmp_serie as clAbstractDataSerie = self.GetColumn(item)
		      if tmp_serie <> nil then
		        input_measures.Append(tmp_serie)
		        
		      else
		        AddError("GroupBy","cannot find column " + item)
		        any_error = True
		      End If
		    end if
		  Next
		  
		  if any_error then
		    return nil
		    
		  end if
		  
		  
		  var has_grouping As Boolean = input_dimensions.LastIndex >=0
		  var has_measures As Boolean = input_measures.LastIndex >= 0
		  
		  
		  var dct_lookup As New Dictionary
		  
		  
		  var output_RowCount As New clIntegerDataSerie("RowCount")
		  
		  //  
		  //  Prepare output space for grouped dimensions
		  //  
		  var output_dimensions() As clDataSerie
		  For idx_dim As Integer = 0 To input_dimensions.LastIndex
		    output_dimensions.Append(New clDataSerie(input_dimensions(idx_dim).name))
		    
		  Next
		  
		  //  
		  //  Prepare temporary space for aggregated measures
		  //  
		  var temp_measures() As clDataSerie
		  
		  For idx_mea As Integer = 0 To input_measures.LastIndex
		    temp_measures.Append(New clDataSerie(input_measures(idx_mea).name))
		    If Not has_grouping Then
		      temp_measures(idx_mea).AddElement(New clDataSerie("x"))
		      output_RowCount.AddElement(0)
		    End If
		    
		  Next
		  
		  
		  var cnt As Integer = Self.RowCount - 1
		  
		  
		  For idx_row As Integer = 0 To cnt
		    var idx_output As Integer = -1
		    
		    
		    If has_grouping Then
		      var tmp_key() As String
		      
		      For idx_dim As Integer = 0 To input_dimensions.LastIndex
		        tmp_key.Append(input_dimensions(idx_dim).GetElement(idx_row))
		        
		      Next
		      
		      var tmp_key_flat As String = Join(tmp_key,Chr(4))
		      
		      
		      If dct_lookup.HasKey(tmp_key_flat) Then
		        idx_output = dct_lookup.Value(tmp_key_flat)
		        
		      Else
		        For idx_dim As Integer = 0 To input_dimensions.LastIndex
		          output_dimensions(idx_dim).AddElement(tmp_key(idx_dim))
		          
		        Next
		        idx_output = output_dimensions(0).RowCount - 1
		        
		        output_RowCount.AddElement(0)
		        
		        For idx_mea As Integer = 0 To input_measures.LastIndex
		          temp_measures(idx_mea).AddElement(New clDataSerie("x"))
		          
		        Next
		        
		        dct_lookup.Value(tmp_key_flat) = idx_output
		        
		        
		      End If
		    Else
		      idx_output = 0
		      
		    End If
		    
		    output_RowCount.SetElement(idx_output, output_RowCount.GetElement(idx_output)+1)
		    
		    For idx_mea As Integer = 0 To input_measures.LastIndex
		      var tmp_serie As clDataSerie = temp_measures(idx_mea).GetElementAsDataSerie(idx_output)
		      tmp_serie.AddElement(input_measures(idx_mea).GetElement(idx_row))
		      
		    Next
		    
		  Next
		  
		  var output_series() As clAbstractDataSerie
		  
		  For idx_dim As Integer = 0 To output_dimensions.LastIndex
		    output_series.Append(output_dimensions(idx_dim))
		    
		  Next
		  
		  
		  For idx_mea As Integer = 0 To temp_measures.LastIndex
		    var tmp_serie As New clNumberDataSerie("sum_" + input_measures(idx_mea).name)
		    
		    For idx_item As Integer = 0 To temp_measures(idx_mea).RowCount-1
		      tmp_serie.AddElement(temp_measures(idx_mea).GetElementAsDataSerie(idx_item).sum)
		      
		    Next
		    
		    output_series.Append(tmp_serie)
		    
		  Next
		  
		  output_series.Append(output_RowCount)
		  
		  //  
		  //  output table name
		  //  
		  var tmp_name as string = self.name.trim
		  if tmp_name.len = 0 then
		    tmp_name = "results"
		    
		  end if
		  
		  
		  if grouping_dimensions.LastIndex < 0 then
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
		Function IncreaseLength(the_length as integer) As integer
		  //  
		  //   increases the length of each data serie in the table. If the current length is greater than the parameter, the maximum current length is used
		  //  In normal case, all columns have the same length.
		  //  
		  //  Parameters:
		  //  - the new length
		  //  
		  //  Returns:
		  //  - (nothing)
		  //  
		  
		  var max_RowCount as integer
		  
		  if self.RowCount > the_length then
		    max_RowCount = self.RowCount
		    
		  else
		    max_RowCount = the_length
		    
		  end if
		  
		  row_index.SetLength(max_RowCount)
		  
		  for each c as clAbstractDataSerie in self.columns
		    c.SetLength(max_RowCount)
		    
		  next
		  
		  return max_RowCount
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub IndexVisibleWhenIterating(status as Boolean)
		  self.index_explicit_when_iterate = status
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub internal_AddRow(the_row_data() as variant)
		  
		  If the_row_data.LastIndex <> columns.LastIndex Then
		    Raise new clDataException("Invalid row in internal_AddRow")
		    
		  End If
		  
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function internal_AddRows(the_source as TableRowReaderInterface, tarGetColumns() as clAbstractDataSerie, source_name as string) As integer
		  var added_rows as integer
		  
		  var source_name_col as clAbstractDataSerie
		  
		  if source_name.Length > 0 then
		    source_name_col = self.GetColumn(loaded_data_source_column)
		    
		  end if
		  
		  while not the_source.EndOfTable
		    var tmp_row() as variant
		    added_rows = added_rows + 1
		    
		    tmp_row  = the_source.NextRow
		    
		    if tmp_row <> nil then 
		      
		      for i as integer=0 to tarGetColumns.LastIndex
		        if tarGetColumns(i) <> nil then
		          if i <= tmp_row.LastIndex then
		            tarGetColumns(i).AddElement(tmp_row(i))
		            
		          else
		            tarGetColumns(i).AddElement(tarGetColumns(i).GetDefaultValue)
		            
		          end if
		        end if
		      next
		      
		      if source_name_col <> nil then source_name_col.AddElement(source_name)
		      
		    end if
		    
		  wend
		  
		  // make sure all columns have the same length
		  self.AdjustLength
		  
		  return added_rows
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function internal_join(the_table as clDataTable, own_keys() as string, alt_keys() as string) As Boolean
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub internal_new_table(the_table_name as string)
		  
		  self.statistics_name_prefix = "statistics of "
		  self.structure_name_prefix = "structure of "
		  
		  if the_table_name.trim.Length = 0 then 
		    table_name = "Unnamed"
		    
		  else
		    table_name = the_table_name.Trim
		    
		  end if
		  
		  row_index = New clDataSerieRowID("row_id")
		  
		  
		  allow_local_columns =  False
		  index_explicit_when_iterate = False
		  row_name_as_column = False
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsIndexVisibleWhenIterating() As Boolean
		  return self.index_explicit_when_iterate 
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsPersistant() As boolean
		  return not IsVirtual
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsVirtual() As Boolean
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
		Function JoinWith(table_to_join as clDataTable, key_mapping as Dictionary) As Boolean
		  
		  var tmp_key1() as string
		  var tmp_key2() as String
		  
		  for each key as string in key_mapping.Keys
		    
		    tmp_key1.Add(key)
		    
		    tmp_key2.Add(key_mapping.Value(key))
		    
		  next
		  
		  return internal_join(table_to_join, tmp_key1, tmp_key2)
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function JoinWith(table_to_join as clDataTable, keys() as string) As Boolean
		  
		  var tmp_key1() as string
		  var tmp_key2() as String
		  
		  for each key as string in keys
		    tmp_key1.Add(key)
		    
		    tmp_key2.Add(key)
		    
		  next
		  
		  return internal_join(table_to_join, tmp_key1, tmp_key2)
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Name() As string
		  Return self.table_name
		End Function
	#tag EndMethod

	#tag DelegateDeclaration, Flags = &h0
		Delegate Function object_allocator(name as string) As object
	#tag EndDelegateDeclaration

	#tag Method, Flags = &h0
		Sub Rename(the_new_name as string)
		  
		  If the_new_name.Trim.Len = 0 Then
		    Self.table_name = "noname"
		    
		  Else
		    Self.table_name = the_new_name.Trim
		    
		  End If
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RenameColumn(the_column_name as string, the_new_name as string)
		  
		  For idx As Integer = 0 To columns.LastIndex
		    
		    If columns(idx).name = the_column_name Then
		      columns(idx).rename(the_new_name)
		      Return
		      
		    End If
		    
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RenameColumns(the_renaming_dict as Dictionary)
		  
		  For idx As Integer = 0 To columns.LastIndex
		    
		    var tmp_column_name As String = columns(idx).name
		    
		    If the_renaming_dict.HasKey(tmp_column_name) Then
		      var tmp_new_name As String  = the_renaming_dict.value(tmp_column_name)
		      
		      columns(idx).rename(tmp_new_name)
		      
		      
		    End If
		    
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function RowCount() As integer
		  If Self.row_index = Nil Then
		    Return -1
		    
		  Else
		    Return Self.row_index.RowCount
		    
		  End If
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Save(write_to as TableRowWriterInterface)
		  var col() as string = self.GetColumnNames
		  
		  write_to.DefineMetadata(name, col)
		  
		  for each row as clDataRow in self
		    
		    write_to.AddRow(row.get_cells(col))
		    
		  next
		  
		  write_to.done
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SelectColumns(column_names() as string) As clDataTable
		  var res As New clDataTable("select " + Self.table_name)
		  
		  res.AddMetadata("source", self.table_name)
		  res.row_index = Self.row_index
		  //  
		  //  link to parent must be called BEFORE adding logical columns
		  //  
		  res.link_to_parent = Self
		  
		  For Each column_name As String In column_names
		    var tmp_column As clAbstractDataSerie = Self.GetColumn(column_name)
		    
		    If tmp_column <> Nil Then
		      call res.AddColumn(tmp_column)
		      
		    else
		      AddError("GetColumns","cannot find column " + column_name)
		      
		    End If
		    
		  Next
		  
		  Return res
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SelectColumns(paramarray column_names as string) As clDataTable
		  Return SelectColumns(column_names)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SetColumnValues(the_column_name as string, the_values() as variant, can_create as boolean) As clAbstractDataSerie
		  
		  var temp_column as clAbstractDataSerie = self.GetColumn(the_column_name)
		  
		  if temp_column = nil then
		    
		    if can_create then
		      temp_column = new clDataSerie(the_column_name, the_values)
		      call self.AddColumn(temp_column)
		      
		      return temp_column
		      
		    else
		      return nil
		      
		    end if
		    
		  else
		    temp_column.SetElements(the_values)
		    
		  end if
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Unique(column_names() as string) As clDataTable
		  
		  var selected_columns() as clAbstractDataSerie = self.GetColumns(column_names)
		  
		  var grp as new clGrouper(selected_columns)
		  
		  var res() as clAbstractDataSerie = grp.Flattened()
		  
		  return new clDataTable("unique", res)
		  
		  
		End Function
	#tag EndMethod


	#tag Note, Name = Description
		Defines a data table
		
		A dataTable is a collection of dataSeries.
		
		Only one dataTable can 'own'  a dataSerie, but the series can be shared by multiple tables.
		
		
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

	#tag Note, Name = License
		MIT License
		
		sl-xj-lib-data Data Handling Library
		Copyright (c) 2021-2024 Serge Louvet
		
		Permission is hereby granted, free of charge, to any person obtaining a copy
		of this software and associated documentation files (the "Software"), to deal
		in the Software without restriction, including without limitation the rights
		to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
		copies of the Software, and to permit persons to whom the Software is
		furnished to do so, subject to the following conditions:
		
		The above copyright notice and this permission notice shall be included in all
		copies or substantial portions of the Software.
		
		THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
		IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
		FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
		AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
		LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
		OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
		SOFTWARE.
		
		
	#tag EndNote


	#tag ComputedProperty, Flags = &h1
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
		Protected allow_local_columns As Boolean
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

	#tag Property, Flags = &h1
		Protected link_to_source As TableColumnReaderInterface
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected meta_dict As clMetadata
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected row_index As clDataSerieRowID
	#tag EndProperty

	#tag Property, Flags = &h0
		row_name_as_column As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private statistics_name_prefix As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private structure_name_prefix As String
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected table_name As String
	#tag EndProperty


	#tag Constant, Name = loaded_data_source_column, Type = String, Dynamic = False, Default = \"loaded_from", Scope = Public
	#tag EndConstant

	#tag Constant, Name = row_name_column, Type = String, Dynamic = False, Default = \"row_type", Scope = Public
	#tag EndConstant

	#tag Constant, Name = statistics_average_column, Type = String, Dynamic = False, Default = \"average", Scope = Public
	#tag EndConstant

	#tag Constant, Name = statistics_average_nz_column, Type = String, Dynamic = False, Default = \"average_nz", Scope = Public
	#tag EndConstant

	#tag Constant, Name = statistics_count_column, Type = String, Dynamic = False, Default = \"count", Scope = Public
	#tag EndConstant

	#tag Constant, Name = statistics_count_nz_column, Type = String, Dynamic = False, Default = \"count_nz", Scope = Public
	#tag EndConstant

	#tag Constant, Name = statistics_name_column, Type = String, Dynamic = False, Default = \"name", Scope = Public
	#tag EndConstant

	#tag Constant, Name = statistics_std_dev_column, Type = String, Dynamic = False, Default = \"std_dev", Scope = Public
	#tag EndConstant

	#tag Constant, Name = statistics_std_dev_nz_column, Type = String, Dynamic = False, Default = \"std_dev_nz", Scope = Public
	#tag EndConstant

	#tag Constant, Name = statistics_sum_column, Type = String, Dynamic = False, Default = \"sum", Scope = Public
	#tag EndConstant

	#tag Constant, Name = statistics_ubound_column, Type = String, Dynamic = False, Default = \"ubound", Scope = Public
	#tag EndConstant

	#tag Constant, Name = structure_name_column, Type = String, Dynamic = False, Default = \"name", Scope = Public
	#tag EndConstant

	#tag Constant, Name = structure_title_column, Type = String, Dynamic = False, Default = \"title", Scope = Public
	#tag EndConstant

	#tag Constant, Name = structure_type_column, Type = String, Dynamic = False, Default = \"type", Scope = Public
	#tag EndConstant


	#tag ViewBehavior
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
		#tag ViewProperty
			Name="row_name_as_column"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
