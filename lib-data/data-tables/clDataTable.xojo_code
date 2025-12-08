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
		  
		  If Self.GetColumn(tmp_column_name, True) <> Nil Then
		    self.AddWarningMessage(CurrentMethodName, ErrMsgColumnAlreadyDefined, self.TableName, tmp_column_name)
		    Return Nil
		    
		  end if
		  
		  
		  //  physical table and column not yet linked
		  if not self.IsVirtual and not tmp_column.IsLinkedToTable then
		    var max_RowCount as integer 
		    
		    if tmp_column.RowCount > 0 then
		      max_RowCount = self.IncreaseLength(tmp_column.RowCount)
		      
		    else
		      max_RowCount = self.RowCount
		      
		    end if
		    
		    tmp_column.SetLinkToTable(Self)
		    tmp_column.SetLength(max_RowCount)
		    
		    Self.columns.Add(tmp_column)
		    
		    return tmp_column
		    
		  end if
		  
		  //  adding a physical column to a virtual table (when permitted)
		  if self.IsVirtual and not tmp_column.IsLinkedToTable and self.allow_local_columns then
		    
		    var max_RowCount as integer 
		    
		    if tmp_column.RowCount > 0 then
		      max_RowCount = self.IncreaseLength(tmp_column.RowCount)
		      
		    else
		      max_RowCount = self.RowCount
		      
		    end if
		    
		    tmp_column.SetLinkToTable(Self)
		    tmp_column.SetLength(max_RowCount)
		    
		    Self.columns.Add(tmp_column)
		    
		    return tmp_column
		    
		  end if
		  
		  //  we add a column from another table to a virtual table
		  if self.IsVirtual and tmp_column.IsLinkedToTable then
		    tmp_column.SetLength(RowCount)
		    Self.columns.Add(tmp_column)
		    return tmp_column
		    
		  end if
		  
		  Return nil
		  
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function AddColumn(NewColumnName as String) As clAbstractDataSerie
		  //  
		  //  Add  an empty column to the table
		  //  
		  //  Parameters:
		  //  - NewColumnName: the name of the column
		  //  
		  //  Returns:
		  //  - the new data serie
		  //  
		  var v as variant
		  
		  return AddColumn(NewColumnName, v)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function AddColumn(NewColumnName as String, DefaultValue as variant) As clAbstractDataSerie
		  //  
		  //  Add  an constant column to the table
		  //  
		  //  Parameters:
		  //  - NewColumnName: the name of the column
		  //  - the initial value for every cell
		  //  
		  //  Returns:
		  //  - the new data serie
		  //  
		  var tmp_column_name As String = NewColumnName.trim
		  
		  if tmp_column_name.len() = 0 then
		    tmp_column_name = ReplacePlaceHolders(DefaultColumnNamePattern,  str(self.ColumnCount))
		    
		  end if
		  
		  If Self.GetColumn(tmp_column_name, True) <> Nil Then
		    self.AddWarningMessage(CurrentMethodName, ErrMsgColumnAlreadyDefined, self.TableName, tmp_column_name)
		    Return Nil
		    
		  end if
		  
		  var tmp_column As clAbstractDataSerie
		  
		  If not self.IsVirtual then
		    tmp_column = New clDataSerie(tmp_column_name)
		    tmp_column.SetLinkToTable(Self)
		    tmp_column.SetLength(RowCount, DefaultValue)
		    
		  Elseif allow_local_columns Then
		    tmp_column = New clDataSerie(tmp_column_name)
		    tmp_column.SetLinkToTable(Self)
		    tmp_column.SetLength(RowCount, DefaultValue)
		    
		  Else
		    //  could be nil if the column exists in the parent datatable
		    tmp_column = link_to_parent.AddColumn( tmp_column_name)
		    
		  End If
		  
		  If tmp_column <> Nil Then
		    Self.columns.Add(tmp_column)
		    
		  End If
		  
		  Return tmp_column
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function AddColumns(NewColumns() as clAbstractDataSerie) As clAbstractDataSerie()
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
		  
		  for each col as clAbstractDataSerie in NewColumns
		    return_array.add( self.AddColumn(col))
		    
		  next
		  
		  return return_array
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function AddColumns(paramarray NewColumns as clAbstractDataSerie) As clAbstractDataSerie()
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
		  
		  for each col as clAbstractDataSerie in NewColumns
		    return_array.add( self.AddColumn(col))
		    
		  next
		  
		  return return_array
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function AddColumns(NewColumnNames() as string) As clAbstractDataSerie()
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
		  For Each name As String In NewColumnNames
		    return_array.Add(AddColumn(name, v))
		    
		  Next
		  
		  return return_array
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AddColumnsData(RowSource as TableColumnReaderInterface, CreateMissingColumns as boolean = True)
		  //  
		  //  Add  the data row from column source. New columns may be added to the current table
		  //  
		  //  For example, 
		  //  - with the current table containing columns A, B, C 
		  //  - with  the flag CreateMissingColumn set to true
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
		  
		  For Each src_tmp_column As clAbstractDataSerie In RowSource.GetAllColumns
		    var column_name As String = src_tmp_column.name
		    
		    var dst_tmp_column As  clAbstractDataSerie = Self.GetColumn(column_name)
		    
		    If dst_tmp_column <> Nil Then
		      dst_tmp_column.AddSerie(src_tmp_column)
		      
		    elseif CreateMissingColumns then
		      var vtype as string = src_tmp_column.GetType
		      
		      dst_tmp_column =   self.AddColumn(clDataType.CreateDataSerieFromType(column_name, vtype))
		      
		      dst_tmp_column.SetLength(length_before)
		      
		      dst_tmp_column.AddSerie(src_tmp_column)
		      
		    else
		      AddWarningMessage(CurrentMethodName, ErrMsgIgnoringColumn , column_name)
		      
		    End If
		    
		  Next
		  
		  var new_size As Integer = Self.RowCount + RowSource.RowCount
		  
		  Self.RowIndexColumn.SetLength(new_size)
		  
		  For Each tmp_column As clAbstractDataSerie In Self.columns
		    tmp_column.SetLength(new_size)
		    
		  Next
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AddErrorMessage(SourceFunctionName as string, ErrorMessageTemplate as string, paramarray item as variant)
		  //  
		  //  Add  an error message:
		  //.  - Update the LastErrorMessage property
		  //.  - Send the messge to logging
		  //  
		  //  Parameters:
		  //  - SourceFunctionName: the name of the method where the warning was generated
		  // -  ErrorMessageTemplate: the message with placeholders
		  // -  item: list of values to replace the placeholders in the template
		  //  
		  //  Returns:
		  //  (nothing)
		  //  
		  
		  self.getLogManager.WriteError(SourceFunctionName, ErrorMessageTemplate, item)
		  
		  self.LastErrorMessage = self.getLogManager.GetProcessedMessage(ErrorMessageTemplate, item)
		  
		  return 
		  
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
		  
		  Self.Metadata.Add(type, message)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AddRow(NewRow as clDataRow, Mode as AddRowMode = AddRowMode.CreateNewColumn)
		  //  
		  //  Add  a data row to the table
		  //  
		  //  Parameters:
		  //  - NewRow: the data row
		  // -  Mode: handling of missing columns in table
		  //  
		  //  Returns:
		  //  (nothing)
		  //  
		  var tmp_RowCount As Integer = Self.RowCount
		  
		  // Handling row name
		  if NewRow.name.Trim = "" or not row_name_as_column then
		    
		  else
		    var tmp_column as clAbstractDataSerie = self.GetColumn(RowNameColumn)
		    
		    If tmp_column = Nil And (Mode = AddRowMode.CreateNewColumn or Mode = AddRowMode.CreateNewColumnAsVariant) Then
		      tmp_column = AddColumn(RowNameColumn)
		      
		    End If
		    
		    if tmp_column <> nil then
		      tmp_column.AddElement(NewRow.name)
		      
		    end if
		    
		  end if
		  
		  //Handling data
		  For Each column_name As String In NewRow
		    var tmp_column As clAbstractDataSerie = Self.GetColumn(column_name)
		    var tmp_item As variant = NewRow.GetCell(column_name)
		    
		    if tmp_column = nil then 
		      tmp_column = internal_HandleNewColumn(column_name, "", tmp_item, mode)
		      
		      if tmp_column <> nil then call AddColumn(tmp_column)
		    end if
		    
		    If tmp_column <> Nil Then 
		      tmp_column.AddElement(tmp_item)
		      
		    End If
		    
		  Next
		  
		  Self.RowIndexColumn.AddElement("")
		  
		  For Each column As clAbstractDataSerie In Self.columns
		    column.SetLength(tmp_RowCount+1)
		    
		  Next
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AddRow(NewCellsValue as Dictionary, Mode as AddRowMode = AddRowMode.CreateNewColumn)
		  //
		  //  Add  a data row to the table using the passed dictionary 
		  //  
		  //  Parameters:
		  //  - NewCellsValue: dictionary with key(field name) / value (field value)
		  // -  Mode: handling of missing columns in table
		  //  
		  //  Returns:
		  //  (nothing)
		  //  
		  
		  if NewCellsValue = nil then return
		  
		  var tempRow as new clDataRow(NewCellsValue)
		  
		  self.AddRow(tempRow, mode)
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AddRow(SourceObject as object)
		  //
		  //  Add  a data row to the table using the passed dictionary. Does not create new columns.
		  //  
		  //  Parameters:
		  //  - SourceObject: an instance of a class
		  //
		  //  Returns:
		  //  (nothing)
		  //  
		  
		  if SourceObject = nil then return
		  
		  self.AddRow(new clDataRow(SourceObject), clDataTable.AddRowMode.IgnoreNewColumn)
		  
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AddRow(firstEntry as Pair, ParamArray entries as Pair)
		  //
		  //  Add  a data row to the table using the passed list of pairs. Add an error for new columns
		  //  
		  //  Parameters:
		  //  - first (mandatory) pair
		  //  - remaing pairs 
		  // 
		  // Each pair with fieldn name / field value
		  //  
		  //  Returns:
		  //  (nothing)
		  //  
		  
		  if firstEntry = nil then 
		    return
		    
		  end if
		  
		  var tempRow as new clDataRow(firstEntry, entries)
		  
		  // Do not add missing columns
		  self.AddRow(tempRow, AddRowMode.ErrorOnNewColumn)
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AddRow(NewCellsValue() as string)
		  //
		  //  Add  a data row to the table
		  //  
		  //  Parameters:
		  //  - the data row (values as string), it is assumed the values are ordered according to the current column order in the table
		  //  
		  //  Returns:
		  //  (nothing)
		  //  
		  For i As Integer = 0 To columns.LastIndex
		    If i <= NewCellsValue.LastIndex Then
		      columns(i).AddElement(NewCellsValue(i))
		      
		    Else
		      columns(i).AddElement(columns(i).GetDefaultValue())
		      
		    End If
		    
		  Next
		  
		  Self.RowIndexColumn.AddElement("")
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AddRow(NewCellsValue() as variant)
		  //
		  //  Add  a data row to the table
		  //  
		  //  Parameters:
		  //  - the data row (values as variant), it is assumed the values are ordered according to the current column order in the table
		  //  
		  //  Returns:
		  //  (nothing)
		  //  
		  For i As Integer = 0 To columns.LastIndex
		    If i <= NewCellsValue.LastIndex Then
		      columns(i).AddElement(NewCellsValue(i))
		      
		    Else
		      columns(i).AddElement(columns(i).GetDefaultValue())
		      
		    End If
		    
		  Next
		  
		  Self.RowIndexColumn.AddElement("")
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function AddRows(NewRowsSource() as clDataRow, mode as AddRowMode = AddRowMode.CreateNewColumn) As integer
		  //  
		  //  Add  data rows to the table
		  //  
		  //  Parameters:
		  //  - NewRowSource: the data rows as an array
		  // -  Mode: handling of missing columns in table
		  //  
		  //  Returns:
		  //  - number of rows added
		  //  
		  for each row as clDataRow in NewRowsSource
		    self.AddRow(row, mode)
		    
		  next
		  
		  return NewRowsSource.Count
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function AddRows(SourceTable as clDataTable, Mode as AddRowMode = AddRowMode.CreateNewColumn) As integer
		  //  
		  //  Add  data rows to the table
		  //  
		  //  Parameters:
		  //  - SourceTable: the table containing the data rows to be added
		  // -  Mode: handling of missing columns in table
		  //  
		  //  Returns:
		  //  - number of rows added
		  //  
		  for each row as clDataRow in SourceTable
		    self.AddRow(row, mode)
		    
		  next
		  
		  return SourceTable.RowCount
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function AddRows(NewRowsSource() as Dictionary, mode as AddRowMode = AddRowMode.CreateNewColumn) As integer
		  //  
		  //  Add  data rows to the table
		  //  
		  //  Parameters:
		  //  - NewRowsSource: the data rows as an array of dictionaries
		  // -  Mode: handling of missing columns in table
		  //
		  //  Returns:
		  //  - number of rows added
		  //  
		  for each dict as Dictionary in NewRowsSource
		    self.AddRow(dict, mode)
		    
		  next
		  
		  return NewRowsSource.Count
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function AddRows(SourceObjects() as object) As integer
		  //  
		  //  Add  data rows to the table
		  //  
		  //  Parameters:
		  //  - SourceObjects: the data rows as an array
		  //
		  //  Returns:
		  //  - number of rows added
		  //  
		  for each obj as object in SourceObjects
		    self.AddRow(new clDataRow(obj), clDataTable.AddRowMode.IgnoreNewColumn)
		    
		  next
		  
		  return SourceObjects.Count
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function AddRows(NewRowsSource as TableRowReaderInterface, Mode as AddRowMode = AddRowMode.CreateNewColumn) As integer
		  //  
		  //  Add  the data row from column source. New columns may be added to the current table
		  //  
		  //  For example, 
		  //  - with the current table containing columns A, B, C 
		  //  - with  the flag CreateMissingColumn set to true
		  //  - appending from a table with columns A, B, D 
		  //  the values from A, and B are appended to the existing columns A and B
		  //  a new column is created to store the values for D 
		  
		  //  Parameters:
		  //  - NewRowsSource:  the source , providing data column by column
		  // -  Mode: handling of missing columns in table
		  //
		  //  Returns:
		  //  - number of rows added
		  //  
		  var length_before as integer = self.RowCount
		  
		  var tmp_columns() as clAbstractDataSerie
		  var columns_type as Dictionary = NewRowsSource.GetColumnTypes
		  
		  if columns_type = nil then columns_type = new Dictionary
		  
		  for each column_name as string in NewRowsSource.GetColumnNames
		    
		    var column_type as string = columns_type.lookup(column_name,  clDataType.VariantValue)
		    var tmp_column as clAbstractDataSerie = self.GetColumn(column_name)
		    
		    var v as variant
		    
		    if tmp_column = nil then tmp_column = internal_HandleNewColumn(column_name, column_type, v, mode)
		    
		    if tmp_column <> nil then
		      tmp_column.SetLength(length_before)
		      call self.AddColumn(tmp_column)
		      
		    end if
		    
		    tmp_columns.add(tmp_column)
		    
		  next
		  
		  return self.internal_AddRows(NewRowsSource, tmp_columns, NewRowsSource.name)
		  
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function AddRows(NewRowsSource as TableRowReaderInterface, FieldMapping as dictionary, Mode as AddRowMode = AddRowMode.CreateNewColumn) As integer
		  //  
		  //  Add  the data row from column source. New columns may be added to the current table
		  //  
		  //  For example, 
		  //  - with the current table containing columns A, B, C 
		  //  - appending from RowSource,  a table with columns W, X, Y, Z
		  //  - mapping dictionary X:A, Y:B, Z:D
		  //  the values from W are ignored, since the column is not defined in the mapping dictionary
		  //  the values from X, and Y are appended to the existing columns A and B
		  //  a new column D is created to store the values from Z
		  //
		  //  Parameters:
		  //  - NewRowsSource:  the source , providing data column by column
		  //  - FieldMapping: mapping dictionary, key is field name in RowSource, value is the field name in the clDataTable
		  //  - Mode: handling of missing columns in table
		  //  
		  //  Returns:
		  //  - number of rows added
		  //  
		  var length_before as integer = self.RowCount
		  
		  var tmp_columns() as clAbstractDataSerie
		  var columns_type as Dictionary = NewRowsSource.GetColumnTypes
		  
		  if columns_type = nil then columns_type = new Dictionary
		  
		  for each source_column_name as string in NewRowsSource.GetColumnNames
		    var tmp_col as clAbstractDataSerie = nil
		    var column_type as string = columns_type.lookup(source_column_name,  clDataType.VariantValue)
		    
		    if FieldMapping.HasKey(source_column_name) then
		      var TargetColumn_name as string = FieldMapping.value(source_column_name)
		      var v as variant
		      
		      tmp_col = self.GetColumn(TargetColumn_name)
		      
		      if tmp_col = nil then tmp_col = internal_HandleNewColumn(TargetColumn_name, column_type, v, mode)
		      
		      if tmp_col <> nil then
		        tmp_col.SetLength(length_before)
		        call self.AddColumn(tmp_col)
		        
		      end if
		    end if
		    
		    tmp_columns.add(tmp_col)
		    
		  next
		  
		  
		  return self.internal_AddRows(NewRowsSource, tmp_columns, NewRowsSource.name)
		  
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AddSourceToMetadata(source as string)
		  //  
		  //  Add meta data
		  //  
		  //  Parameters
		  // - type (string) the key for the meta data
		  //  - message (string) the associated message
		  //  
		  //  Returns:
		  //  
		  
		  self.Metadata.AddSource(source)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AddTableData(SourceTable as clDataTable, Mode as AddRowMode = AddRowMode.CreateNewColumn)
		  //  
		  //  Add  data rows to the table
		  //  
		  //  Parameters:
		  //  - SourceTable: the table containing the data rows to be added
		  // -  Mode: handling of missing columns in table
		  //  
		  //  Returns:
		  //  (nothing)
		  //
		  
		  call self.AddRows(SourceTable, Mode)
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AddWarningMessage(SourceFunctionName as string, WarningMessageTemplate as string, paramarray item as variant)
		  //  
		  //  Add  a warning message:
		  //.  - Update the LastWarningMessage property
		  //.  - Send the messge to logging
		  //  
		  //  Parameters:
		  //  - SourceFunctionName: the name of the method where the warning was generated
		  // -  WarningMessageTemplate: the message with placeholders
		  // -  item: list of values to replace the placeholders in the template
		  //  
		  //  Returns:
		  //  (nothing)
		  //  
		  
		  self.getLogManager.WriteWarning(SourceFunctionName, WarningMessageTemplate, item)
		  
		  self.LastWarningMessage = self.getLogManager.GetProcessedMessage(WarningMessageTemplate, item)
		  
		  
		  return 
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AdjustLength()
		  //  
		  //  Adjust  the length of each data serie in the table, to match the longest data serie
		  //  to use after directly inserting in columns 
		  //  In normal case, all columns have the same length.
		  //  
		  //  Parameters:
		  // 
		  //  
		  //  Returns:
		  //   (nothing)
		  //  
		  
		  var max_RowCount as integer=-1
		  
		  
		  for each c as clAbstractDataSerie in self.columns
		    if max_RowCount < c.RowCount then max_RowCount = c.RowCount
		    
		  next
		  
		  RowIndexColumn.SetLength(max_RowCount)
		  
		  for each c as clAbstractDataSerie in self.columns
		    c.SetLength(max_RowCount)
		    
		  next
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ApplyFilterFunction(pFilterFunction as RowFilter, pFunctionParameters() as variant) As variant()
		  //  
		  //  Applies a filter function to each data row of the table, returns an array of boolean
		  //  
		  //  Parameters:
		  //  - the address of the filter function
		  //  - the parameters to pass to the function
		  //  
		  //  Returns:
		  //  - an array of boolean
		  //  
		  
		  var return_boolean() As Variant
		  
		  var column_names() As String
		  var column_values() as Variant
		  
		  for each column as clAbstractDataSerie in self.columns
		    column_names.Add(column.name)
		    
		  next
		  
		  var RowCount as integer = self.RowCount
		  
		  For i As Integer=0 To RowCount-1
		    column_values.RemoveAll
		    
		    for each column as clAbstractDataSerie in self.columns
		      column_values.Add(column.GetElement(i))
		      
		    next
		    
		    return_boolean.Add(pFilterFunction.Invoke(i,  RowCount, column_names, column_values, pFunctionParameters))
		    
		  Next
		  
		  Return return_boolean
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ApplyFilterFunction(pFilterFunction as RowFilter, paramarray pFunctionParameters as variant) As variant()
		  //  
		  //  Applies a filter function to each data row of the table, returns an array of boolean
		  //  
		  //  Parameters:
		  //  - the address of the filter function
		  //  - the parameters to pass to the function
		  //  
		  //  Returns:
		  //  - an array of boolean
		  //  
		  
		  return self.ApplyFilterFunction(pFilterFunction, pFunctionParameters)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ApplyFilterFunction(NewDataSerieName as string, pFilterFunction as RowFilter, paramarray pFunctionParameters as variant) As clBooleanDataSerie
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
		  
		  return new clBooleanDataSerie(NewDataSerieName, self.ApplyFilterFunction(pFilterFunction, pFunctionParameters))
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function CheckIntegrity() As Boolean
		  //
		  // Check integrity of current table
		  //
		  //  
		  //  Parameters:
		  // (none) 
		  //  
		  //  Returns:
		  //  Boolean, set to false if error(s) are detected
		  //
		  
		  var ReturnTableIsOk as boolean = True
		  var baseLength as integer = -10
		  
		  for each col as clAbstractDataSerie in self.columns
		    if baseLength < -1 then
		      baseLength = col.LastIndex
		      
		    elseif baseLength <> col.LastIndex then
		      AddErrorMessage(CurrentMethodName,  ErrMsgInvalidColumnLength, self.Name, col.name, str(baseLength+1), str(col.LastIndex+1))
		      ReturnTableIsOk = False
		      
		    end if
		    
		  next
		  
		  if self.link_to_parent = nil then // physical table
		    
		    
		    for each col as clAbstractDataSerie in self.columns
		      if not col.IsLinkedToTable() then
		        AddErrorMessage(CurrentMethodName, ErrMsgColumnNotLinked, self.Name,  col.name)
		        ReturnTableIsOk = False
		        
		      elseif not col.IsLinkedToTable(self) then
		        AddErrorMessage(CurrentMethodName, ErrMsgColumnWrongLink, self.name, col.name, col.GetLinkedTableName)
		        ReturnTableIsOk = False
		        
		      end if
		      
		    next
		    
		    
		    
		  elseif allow_local_columns then  // this is a view with some local columns
		    for each col as clAbstractDataSerie in self.columns
		      if not col.IsLinkedToTable() then
		        AddErrorMessage(CurrentMethodName,ErrMsgColumnNotLinkedInMixedView, self.Name,  col.name)
		        ReturnTableIsOk = False
		      end if
		      
		    next
		    
		  else // this is a view without local columns
		    for each col as clAbstractDataSerie in self.columns
		      if not col.IsLinkedToTable() then
		        AddErrorMessage(CurrentMethodName,ErrMsgColumnNotLinkedInView, self.Name,  col.name)
		        ReturnTableIsOk = False
		        
		      elseif not col.IsLinkedToTable(self.link_to_parent) then
		        AddErrorMessage(CurrentMethodName, ErrMsgColumnWrongLinkView, self.name, col.name, col.GetLinkedTableName)
		        ReturnTableIsOk = False
		        
		      end if
		      
		    next
		    
		  end if
		  
		  return ReturnTableIsOk
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ClipByRange(column as clAbstractDataSerie, LowValueColumn as clAbstractDataSerie, HighValueColumn as clAbstractDataSerie) As integer
		  //
		  // Clip the values of the column to a given range:
		  // - If the value of the cell is below the minimum, it is set to the minimum
		  // - if the value of the cell is above the maximum, it is set to the maximum
		  //
		  //  
		  //  Parameters:
		  //  - Column: Column to be processed
		  // - LowValueColumn: column with minimum value
		  // - HighValueColumn: column with maximum value
		  //  
		  //  Returns:
		  //  - number of cells updated
		  //
		  
		  
		  if column = nil then return 0
		  if LowValueColumn = nil then return 0
		  if HighValueColumn = nil then return 0
		  
		  var last_index as integer = column.RowCount
		  var count_changes as integer = 0
		  
		  
		  self.AddMetadata("transformation", "Apply range clipping using " + LowValueColumn.name + " and " + HighValueColumn.name)
		  
		  for index as integer = 0 to last_index
		    var tmp as variant = column.GetElement(index)
		    var low_value as Variant = LowValueColumn.GetElement(index)
		    var high_value as Variant = HighValueColumn.GetElement(index)
		    
		    
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
		Function ClipByRange(column_name as string, LowValueColumnName as string, HighValueColumnName as String) As integer
		  //
		  // Clip the values of the column to a given range:
		  // - If the value of the cell is below the minimum, it is set to the minimum
		  // - if the value of the cell is above the maximum, it is set to the maximum
		  //
		  //  
		  //  Parameters:
		  //  - Column_name: name of the column  to be processed
		  // - LowValueColumnName: name of the column with minimum value
		  // - HighValueColumnName: name of the column  with maximum value
		  //  
		  //  Returns:
		  //  - number of cells updated
		  //
		  
		  var column as clAbstractDataSerie = self.GetColumn(column_name)
		  var high_column as clAbstractDataSerie = self.GetColumn(HighValueColumnName)
		  var low_column as clAbstractDataSerie = self.GetColumn(LowValueColumnName)
		  
		  if column = nil then return 0
		  if high_column = nil then return 0
		  if low_column = nil then return 0
		  
		  return self.ClipByRange(column, low_column, high_column)
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ClipByRange(column_name as string, low_value as variant, high_value as variant) As integer
		  //
		  // Clip the values of the column to a given range:
		  // - If the value of the cell is below the minimum, it is set to the minimum
		  // - if the value of the cell is above the maximum, it is set to the maximum
		  //
		  //  
		  //  Parameters:
		  //  - Column_name: Name of the column to be processed
		  // - low_value: minimum value, applicable to all rows
		  // - high_value: maximum value, applicable to all rows
		  //  
		  //  Returns:
		  //  - number of cells updated
		  //
		  
		  var column as clAbstractDataSerie = self.GetColumn(column_name)
		  
		  if column = nil then return 0
		  
		  return column.ClipByRange(low_value, high_value)
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ClipHighValues(column as clAbstractDataSerie, HighValueColumn as clAbstractDataSerie) As integer
		  //
		  // Clip the values of the column to a given range:
		  // - if the value of the cell is above the maximum, it is set to the maximum
		  //
		  //  
		  //  Parameters:
		  //  - Column: Column to be processed
		  // - HighValueColumn: column with maximum value
		  //  
		  //  Returns:
		  //  - number of cells updated
		  //
		  if column = nil then return 0
		  if HighValueColumn = nil then return 0
		  
		  var last_index as integer = column.RowCount
		  var count_changes as integer = 0
		  
		  for index as integer = 0 to last_index
		    var tmp as variant = column.GetElement(index)
		    var high_value as Variant = HighValueColumn.GetElement(index)
		    
		    if  tmp > high_value then
		      column.SetElement(index, high_value)
		      count_changes = count_changes + 1
		      
		    end if
		    
		  next
		  
		  self.AddMetadata("transformation", "Clip high values using " + HighValueColumn.name)
		  
		  
		  
		  Return count_changes
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ClipHighValues(column_name as string, HighValueColumnName as String) As integer
		  //
		  // Clip the values of the column to a given range:
		  // - if the value of the cell is above the maximum, it is set to the maximum
		  //
		  //  
		  //  Parameters:
		  //  - Column_name: name of the column  to be processed
		  // - HighValueColumnName: name of the column  with maximum value
		  //  
		  //  Returns:
		  //  - number of cells updated
		  //
		  var column as clAbstractDataSerie = self.GetColumn(column_name)
		  var high_column as clAbstractDataSerie = self.GetColumn(HighValueColumnName)
		  
		  if column = nil then return 0
		  if high_column = nil then return 0
		  
		  return self.ClipHighValues(column, high_column)
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ClipHighValues(column_name as string, high_value as variant) As integer
		  //
		  // Clip the values of the column to a given range:
		  // - if the value of the cell is above the maximum, it is set to the maximum
		  //
		  //  
		  //  Parameters:
		  //  - Column_name: Name of the column to be processed
		  // - high_value: maximum value, applicable to all rows
		  //  
		  //  Returns:
		  //  - number of cells updated
		  //
		  var column as clAbstractDataSerie = self.GetColumn(column_name)
		  
		  if column = nil then return 0
		  
		  return column.ClipHighValues(high_value)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ClipLowValues(column as clAbstractDataSerie, LowValueColumn as clAbstractDataSerie) As integer
		  //
		  // Clip the values of the column to a given range:
		  // - If the value of the cell is below the minimum, it is set to the minimum
		  //
		  //  
		  //  Parameters:
		  //  - Column: Column to be processed
		  // - LowValueColumn: column with minimum value
		  //  
		  //  Returns:
		  //  - number of cells updated
		  //
		  if column = nil then return 0
		  if LowValueColumn = nil then return 0
		  
		  var last_index as integer = column.RowCount
		  var count_changes as integer = 0
		  
		  for index as integer = 0 to last_index
		    var tmp as variant = column.GetElement(index)
		    var low_value as Variant = LowValueColumn.GetElement(index)
		    
		    if  tmp < low_value then
		      column.SetElement(index, low_value)
		      count_changes = count_changes + 1
		      
		    end if
		    
		  next
		  
		  self.AddMetadata("transformation", "Clip low values using " + LowValueColumn.name)
		  
		  Return count_changes
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ClipLowValues(column_name as string, LowValueColumnName as String) As integer
		  //
		  // Clip the values of the column to a given range:
		  // - If the value of the cell is below the minimum, it is set to the minimum
		  //
		  //  
		  //  Parameters:
		  //  - Column_name: name of the column  to be processed
		  // - LowValueColumnName: name of the column with minimum value
		  //  
		  //  Returns:
		  //  - number of cells updated
		  //
		  var column as clAbstractDataSerie = self.GetColumn(column_name)
		  var low_column as clAbstractDataSerie = self.GetColumn(LowValueColumnName)
		  
		  if column = nil then return 0
		  if low_column = nil then return 0
		  
		  return self.ClipLowValues(column, low_column)
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ClipLowValues(column_name as string, low_value as Variant) As integer
		  //
		  // Clip the values of the column to a given range:
		  // - If the value of the cell is below the minimum, it is set to the minimum
		  //
		  //  
		  //  Parameters:
		  //  - Column_name: Name of the column to be processed
		  // - low_value: minimum value, applicable to all rows
		  //  
		  //  Returns:
		  //  - number of cells updated
		  //
		  var column as clAbstractDataSerie = self.GetColumn(column_name)
		  
		  if column = nil then return 0
		  
		  return column.ClipLowValues(low_value)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Clone(NewName as string = "") As clDataTable
		  //
		  //  Duplicates the table and all its columns
		  //  
		  //  Parameters:
		  //  - NewName (optional): name of the new table, default to name of current table followed by '...copy'
		  //  
		  //  Returns:
		  //  - New table 
		  //  
		  var output_table as clDataTable = new clDataTable(StringWithDefault(NewName, self.Name+" copy"))
		  
		  
		  output_table. AddSourceToMetadata( self.name)
		  
		  for each col as clAbstractDataSerie in self.columns
		    var new_col as clAbstractDataSerie = col.Clone()
		    
		    call output_table.AddColumn(new_col)
		    
		  next
		  
		  Return output_table
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function CloneStructure(NewName as string = "") As clDataTable
		  //
		  //  Duplicate the table and all its columns, without data
		  //  
		  //  Parameters:
		  //  - NewName (optional): name of the new table, default to name of current table followed by '...copy'
		  //  
		  //  Returns:
		  //  - New table
		  //  
		  
		  var output_table as clDataTable =  new clDataTable(StringWithDefault(NewName, self.Name+" copy"))
		  
		  output_table. AddSourceToMetadata( self.name)
		  
		  for each col as clAbstractDataSerie in self.columns
		    var new_col as clAbstractDataSerie = col.CloneStructure()
		    
		    call output_table.AddColumn(new_col)
		    
		  next
		  
		  Return output_table
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Column(pColumnName as string) As clAbstractDataSerie
		  return self.GetColumn(pColumnName, false)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Column(pColumnName as string, assigns SourceColumn as clAbstractDataSerie)
		  
		  call self.SetColumnValues(pColumnName, SourceColumn, True)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Column(pColumnName as string, assigns SourceValue as double)
		  
		  call self.SetColumnValues(pColumnName, SourceValue, False)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Column(pColumnName as string, assigns SourceValue as integer)
		  
		  
		  call self.SetColumnValues(pColumnName, SourceValue, False)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Column(pColumnName as string, assigns SourceValue as string)
		  
		  call self.SetColumnValues(pColumnName, SourceValue, False)
		  
		End Sub
	#tag EndMethod

	#tag DelegateDeclaration, Flags = &h0
		Delegate Function ColumnAllocator(column_name as String, column_type_info as string) As clAbstractDataSerie
	#tag EndDelegateDeclaration

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
		  //  - Index: the index of the column
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

	#tag Method, Flags = &h0
		Sub ColumnValues(pColumnName as string, assigns pSourceValue as Variant)
		  //
		  // Update the values in a given column
		  // - If the source value is an array, each element are used, extra elements are ignored and missing elements are replaced by the 
		  //.   default value for the specified columns
		  //
		  //  
		  //  Parameters:
		  //  - pColumnName: name of the column  to be processed
		  // - pSourceValue: source used for update
		  //  
		  //  Returns:
		  //  (nothing)
		  //
		  
		  var temp_column as clAbstractDataSerie = self.GetColumn(pColumnName)
		  
		  if temp_column = nil then
		    Raise New clDataException("Cannot find  column " + pColumnName)
		    return 
		    
		  elseif pSourceValue.Type = Variant.TypeObject then
		    
		    var temp_obj as Object = pSourceValue.ObjectValue
		    
		    if temp_obj isa clAbstractDataSerie then
		      temp_column.SetElements(clAbstractDataSerie(temp_obj))
		      return
		    end if
		    
		    Raise New clDataException("Assigned item is an object, when updating " + pColumnName)
		    
		  elseif pSourceValue.IsArray then
		    Raise New clDataException("Assigned item is an array, when updating " + pColumnName)
		    
		  else
		    
		    for i as integer = 0 to temp_column.RowCount
		      temp_column.SetElement(i, pSourceValue)
		      
		    next
		    return
		    
		  end if
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(NewTableName as string)
		  //
		  //  Creates a datatable
		  //  
		  //  Parameters:
		  //  - the name of the data table
		  //
		  //  Returns:
		  //  - 
		  //
		  self.Metadata = new clMetadata
		  
		  var tmp_table_name As String
		  
		  tmp_table_name = NewTableName
		  
		  internal_NewTable(tmp_table_name)
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(NewTableName as string, ColumnsSource() as clabstractDataSerie, AutoCloneColumns as boolean = false)
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
		  
		  self.Metadata = new clMetadata
		  
		  var tmp_columns() As clAbstractDataSerie = ColumnsSource
		  
		  if ColumnsSource = nil then return
		  
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
		  
		  internal_NewTable(NewTableName)
		  
		  For Each c As clAbstractDataSerie In tmp_columns
		    //  add column takes care of adjusting the length
		    call Self.AddColumn(c)
		    
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(NewTableName as string, ColumnsSource as Dictionary, allocator as ColumnAllocator = nil)
		  //
		  // Creates a new data table from a set of columns. Columns are passed as a dictionary with column name as key and an array of values as value
		  //  
		  //  Parameters:
		  //  - the name of the data table
		  // - the columns as a dictionary (column name as key, column values as an array of variant
		  // - an option to clone a data serie (column) if it is already used in another table
		  //
		  //  Returns:
		  //  -  
		  //
		  
		  self.Metadata = new clMetadata
		  
		  if ColumnsSource = nil then return
		  
		  var tmp_columns() as clAbstractDataSerie
		  
		  for each tmp_column_name as string in ColumnsSource.Keys
		    var v() as variant = ExtractVariantArray(ColumnsSource.value(tmp_column_name))
		    
		    if allocator = nil then
		      tmp_columns.Add(new clDataSerie(tmp_column_name, v))
		      
		    else
		      var tmp_column as clAbstractDataSerie = allocator.Invoke(tmp_column_name,"")
		      
		      if tmp_column = nil then tmp_column = new clDataSerie(tmp_column_name)
		      
		      tmp_column.AddElements(v)
		      
		      tmp_columns.Add(tmp_column)
		      
		    end if
		  next
		  
		  internal_NewTable(NewTableName)
		  
		  For Each c As clAbstractDataSerie In tmp_columns
		    //  add column takes care of adjusting the length
		    call Self.AddColumn(c)
		    
		  Next
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(NewTableName as string, ColumnNames() as string)
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
		  self.Metadata = new clMetadata
		  
		  var tmp_table_name As String
		  
		  tmp_table_name = NewTableName
		  
		  internal_NewTable(tmp_table_name)
		  
		  
		  For Each name As string In ColumnNames
		    var temp_name as string = name.Trim
		    call Self.AddColumn(temp_name)
		    
		  Next
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(NewTableName as string, NewTableSource as TableRowReaderInterface, allocator as ColumnAllocator = nil)
		  //
		  //  Creates a datatable from a table row reader
		  //  
		  //  Parameters:
		  //  - the table reader
		  //
		  //  Returns:
		  //  - 
		  //
		  
		  self.Metadata = new clMetadata
		  
		  self.allow_local_columns = False
		  
		  var tmp_table_name As String = StringWithDefault(NewTableName.Trim, DefaultTableName)
		  
		  AddSourceToMetadata(tmp_table_name)
		  
		  internal_NewTable(tmp_table_name)
		  
		  var tmp_column_names() as string = NewTableSource.GetColumnNames
		  var tmp_column_types as Dictionary = NewTableSource.GetColumnTypes
		  
		  var tmp_columns() as clAbstractDataSerie = internal_CreateColumnsWithAllocator (tmp_column_names, tmp_column_types, allocator)
		  
		  call internal_AddRows(NewTableSource, tmp_columns, "")
		  
		  self.AdjustLength()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(NewTableSource as TableColumnReaderInterface, materialize as boolean = False)
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
		  
		  self.Metadata = new clMetadata 
		  
		  self.allow_local_columns = False
		  
		  var tmp_table_name As String = StringWithDefault(NewTableSource.Name.Trim, DefaultTableName)
		  
		  AddSourceToMetadata(tmp_table_name)
		  
		  internal_NewTable("from " + tmp_table_name)
		  
		  if NewTableSource.IsPersistant and not materialize then
		    // 
		    // we create a virtual table
		    //
		    self.link_to_source = NewTableSource
		    
		    For Each column_name As String In NewTableSource.GetColumnNames
		      var tmp_column As clAbstractDataSerie = NewTableSource.GetColumn(column_name)
		      
		      If tmp_column <> Nil Then
		        call self.AddColumn(tmp_column)
		        
		      else
		        AddErrorMessage(CurrentMethodName, ErrMsgCannotFIndColumn, self.Name, name)
		        
		      End If
		      
		    next
		  else
		    
		    For Each column_name As String In NewTableSource.GetColumnNames
		      var tmp_column As clAbstractDataSerie = NewTableSource.GetColumn(column_name)
		      
		      If tmp_column <> Nil Then
		        call self.AddColumn(tmp_column.clone)
		        
		      else
		        AddErrorMessage(CurrentMethodName, ErrMsgCannotFIndColumn, self.Name, name)
		        
		      End If
		      
		    next
		    
		    
		  end if
		  
		  self.AdjustLength()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(NewTableSource as TableRowReaderInterface, allocator as ColumnAllocator = nil)
		  //
		  //  Creates a datatable from a table row reader. Note that the source must be able to provide a list of field names before scanning starts.
		  //  
		  //  Parameters:
		  //  - the table reader
		  //
		  //  Returns:
		  //  - 
		  //
		  
		  self.Metadata = new clMetadata
		  
		  self.allow_local_columns = False
		  
		  var tmp_table_name As String = StringWithDefault(NewTableSource.Name.Trim, DefaultTableName)
		  
		  AddSourceToMetadata(tmp_table_name)
		  
		  internal_NewTable("from " + tmp_table_name) 
		  
		  var tmp_column_names() as string = NewTableSource.GetColumnNames
		  var tmp_column_types as Dictionary = NewTableSource.GetColumnTypes
		  
		  var tmp_columns() as clAbstractDataSerie = internal_CreateColumnsWithAllocator (tmp_column_names, tmp_column_types, allocator)
		  
		  call self.internal_AddRows(NewTableSource, tmp_columns, "")
		  
		  self.AdjustLength()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function CreateTableFromStructure(new_table_name as String) As clDataTable
		  //
		  // Create a new table assuming the current table contains a structure description
		  // 
		  // Paramters
		  // - new_table_name: name of the new table
		  //
		  // Returns
		  // - the new table
		  //
		  
		  var tbl as new clDataTable(new_table_name)
		  
		  for each row as clDataRow in self
		    var col_name as string = row.GetCell(StructureNameColumn)
		    var col_type as string = row.GetCell(StructureTypeColumn)
		    var col_title as string  = row.GetCell(StructureTitleColumn)
		    
		    var column as clAbstractDataSerie = tbl.AddColumn(clDataType.CreateDataSerieFromType(col_name, col_type))
		    
		    if col_title.Length > 0 then
		      column.DisplayTitle = col_title
		      
		    end if
		    
		  next
		  
		  return tbl
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub debug_dump()
		  
		  var tmp_item() As String
		  
		  System.DebugLog("----START " + Self.Name+" --------")
		  
		  System.DebugLog("#rows : " + str(self.RowCount))
		  System.DebugLog("#columns : " + str(self.columns.LastIndex+1))
		  
		  tmp_item.Add("index")
		  For Each tmp_column As clAbstractDataSerie In columns
		    tmp_item.Add(tmp_column.name)
		    
		  Next
		  
		  System.DebugLog(Join(tmp_item, ";"))
		  
		  For row As Integer = 0 To RowCount-1
		    tmp_item.RemoveAll
		    
		    tmp_item.Add(Self.RowIndexColumn.GetElement(row))
		    
		    For Each tmp_column As clAbstractDataSerie In columns
		      tmp_item.Add(tmp_column.GetElement(row))
		      
		    Next
		    System.DebugLog(Join(tmp_item, ";"))
		    
		  Next
		  
		  System.DebugLog("----END " + Self.Name+" --------")
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function DoubleDataRows() As clDataTableDoubleRows
		  //
		  // Returns a clDataTableDoubleRows, allowing to iterate a table getting clDoubleDataRow
		  // A clDoubleDataRow is eExpected to be faster to use for numerical processing
		  //
		  
		  var tmp() as clDoubleDataRowFieldInfo
		  
		  for each c as clAbstractDataSerie in self.columns
		    tmp.Add(new clDoubleDataRowFieldInfo(c.name, clDoubleDataRow.IsUsed(c)))
		    
		  next
		  
		  return new clDataTableDoubleRows(self, tmp)
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ExtractColumns(ColumnNames() as string) As clDataTable
		  //
		  // Create a new table with cloned columns from source table
		  // Use SelectColumns() method to create a logical table
		  //
		  // Paramters:
		  // - ColumnNames() : name of columns to duplicate in new table
		  //
		  // Returns
		  // - New table
		  //
		  
		  var res As New clDataTable("extract " + Self.Name)
		  
		  res. AddSourceToMetadata( self.Name)
		  res.RowIndexColumn = Self.RowIndexColumn.Clone
		  
		  res.link_to_parent = nil
		  
		  For Each column_name As String In ColumnNames
		    var tmp_column As clAbstractDataSerie = Self.GetColumn(column_name)
		    
		    If tmp_column <> Nil Then
		      call res.AddColumn(tmp_column.Clone())
		      
		    else
		      AddErrorMessage(CurrentMethodName, ErrMsgCannotFIndColumn, self.Name, name)
		      
		    End If
		    
		  Next
		  
		  Return res
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ExtractColumns(paramarray ColumnNames as string) As clDataTable
		  //
		  // Create a new table with cloned columns from source table
		  // Use SelectColumns() method to create a logical table
		  //
		  // Paramters:
		  // - ColumnNames() : name of columns to duplicate in new table
		  //
		  // Returns
		  // - New table
		  //
		  
		  Return ExtractColumns(ColumnNames)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function FilteredOn(pBooleanSerie as clBooleanDataSerie) As clDataTableFilter
		  //  
		  //  Creates a data table filter (iterable) using a column as a mask,  the column (data serie)  is passed as parameter. 
		  //  The data serie does not need to belong to any data table
		  //  
		  //  Parameters:
		  //  - pBooleanSerie: a boolean data serie used as mask
		  //  
		  //  Returns:
		  //  - a data table filter
		  //  
		  var retval as new clDataTableFilter(self, pBooleanSerie)
		  
		  return retval
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function FilteredOn(BooleanFieldName as string) As clDataTableFilter
		  //  
		  //  Creates a data table filter (iterable) using a column as a mask, the name fof the column is passed as parameter. The column must be defined
		  //  in the table
		  //  
		  //  Parameters:
		  //  - the name of the column used to select rows
		  //  
		  //  Returns:
		  //  - a data table filter
		  //  
		  var retval as new clDataTableFilter(self, BooleanFieldName)
		  
		  return retval
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function FindAllMatchingRowIndexes(pColumnNames() as string, the_column_values() as string, limit as integer = -1) As integer()
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
		  
		  for each name as string in pColumnNames
		    var tmp_column as clAbstractDataSerie = GetColumn(name)
		    
		    If tmp_column = Nil Then
		      Return nil
		      
		    End If
		    
		    tmp_columns.Add(tmp_column)
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
		Function FindAllMatchingRowIndexes(pColumnName as string, the_column_value as string, limit as integer = -1) As integer()
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
		  
		  tmp_column = GetColumn(pColumnName)
		  
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
		Function FindFirstMatchingRow(pColumnNames() as string, the_column_values() as string, include_index as Boolean) As clDataRow
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
		  var tmp_row_index as integer = self.FindFirstMatchingRowIndex(pColumnNames, the_column_values)
		  
		  if tmp_row_index <0 then
		    return nil
		    
		  end if
		  
		  return self.GetRowAt(tmp_row_index, include_index)
		  
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function FindFirstMatchingRow(pColumnName as string, the_column_value as string, include_index as Boolean) As clDataRow
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
		  var tmp_row_index as integer = self.FindFirstMatchingRowIndex(pColumnName, the_column_value)
		  
		  if tmp_row_index <0 then
		    return nil
		    
		  end if
		  
		  return self.GetRowAt(tmp_row_index, include_index)
		  
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function FindFirstMatchingRowIndex(pColumnNames() as string, the_column_values() as string) As integer
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
		  
		  for each name as string in pColumnNames
		    var tmp_column as clAbstractDataSerie = GetColumn(name)
		    
		    If tmp_column = Nil Then
		      Return -2
		      
		    End If
		    
		    tmp_columns.Add(tmp_column)
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
		Function FindFirstMatchingRowIndex(pColumnName as string, the_column_value as string) As integer
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
		  
		  tmp_column = GetColumn(pColumnName)
		  
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
		Function FullJoin(TableToJoin as clDataTable, mode as JoinMode, KeyFields() as string, JoinSuccessField as string = "") As clDataTable
		  //
		  // Executes a full join between the current table and the 'TableToJoin'
		  // Either an inner join or an outer join
		  // Use Lookpu() function for a left join
		  // All fields are included from both side, key fields are not replicateed
		  //
		  // Paramters
		  // TableToJoin  (clDataTable): table used as lookup source
		  // Mode: indicates inner join or outer join
		  // KeyFields: list of fields used as join keys, field names must match
		  //
		  //
		  // Returns
		  // Datatable with joined results
		  //
		  
		  // const JoinSuccessBoth = "Both"
		  // const JoinSuccessMainOnly = "Main"
		  // const JoinSuccessJoinedOnly= "Joined"
		  
		  
		  var mastertable as clDataTable = self
		  var joinedtable as clDataTable = TableToJoin
		  var OutputTable as   clDataTable
		  
		  
		  var trsf as new clJoinTransformer(mastertable, joinedtable, mode, KeyFields, JoinSuccessField)
		  
		  trsf.SetJoinStatusLeft( JoinSuccessMainOnly)
		  trsf.SetJoinStatusRight(JoinSuccessJoinedOnly)
		  trsf.SetJoinStatusBoth(JoinSuccessBoth)
		  
		  if trsf.Transform() then
		    var connection as clTransformerConnector = trsf.GetOutputConnector(trsf.cOutputConnectorJoined)
		    
		    OutputTable = connection.GetTable()
		    //OutputTable =  trsf.GetOutputTable(trsf.cOutputConnectorJoined)
		    
		    return OutputTable
		    
		  else
		    return nil
		    
		  end if
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetAllColumns() As clAbstractDataSerie()
		  return columns
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetBooleanColumn(pColumnName as string, IncludeAlias as boolean = False) As clBooleanDataSerie
		  //
		  // Returns the selected column as an boolean data serie
		  //
		  //  Parameters:
		  //  - pColumnName: the name of the column
		  //  - IncludeAlias (optional) search the column aliases
		  // 
		  //  
		  //  Returns:
		  //  - the column matching the name or nil
		  //  
		  
		  return clBooleanDataSerie(self.GetColumn(pColumnName, IncludeAlias))
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetColumn(pColumnName as String, IncludeAlias as boolean = False) As clAbstractDataSerie
		  //  
		  //  returns a column
		  //  
		  //  Parameters:
		  //  - pColumnName: the name of the column
		  //  - IncludeAlias (optional) search the column aliases
		  // 
		  //  
		  //  Returns:
		  //  - the column matching the name or nil
		  //  
		  
		  For Each column As clAbstractDataSerie In Self.columns
		    If column.name = pColumnName Then
		      Return column
		      
		    End If
		    
		  Next
		  
		  if not IncludeAlias then return nil
		  
		  For Each column As clAbstractDataSerie In Self.columns
		    if column.HasAlias(pColumnName) then
		      return column
		      
		    end if
		    
		  Next
		  
		  Return Nil
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetColumnAt(pColumnIndex as integer) As clAbstractDataSerie
		  //  
		  //  returns a column
		  //  
		  //  Parameters:
		  //  - pColumnIndex: the index of the column
		  //  
		  //  Returns:
		  //  - the column at specified index
		  //  
		  
		  try
		    return self.columns(pColumnIndex)
		    
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
		    ret_str.Add(column.name)
		    
		  Next
		  
		  Return ret_str
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetColumns(ColumnNames() as string, IncludeNilValue as boolean) As clAbstractDataSerie()
		  //  
		  //  returns selected columns
		  //  
		  //  Parameters:
		  //  - ColumnNames: the name of the columns as an array of string
		  //  - Flag to include a nil value for unknow columns in the results
		  //
		  //  Returns:
		  //  - the columns matching the name or nil, as an array
		  //  
		  
		  
		  var ret() As clAbstractDataSerie
		  
		  for each name as string in ColumnNames
		    if name.trim.Length > 0 then
		      var c as clAbstractDataSerie = self.GetColumn(name)
		      
		      if c <> nil then
		        ret.add(c)
		        
		      elseif IncludeNilValue then 
		        ret.add(c)
		        
		      else
		        AddErrorMessage(CurrentMethodName,ErrMsgCannotFIndColumn, self.name, Name)
		        
		        
		      end if
		    end if
		  next
		  
		  return ret
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetColumns(paramarray ColumnNames as string) As clAbstractDataSerie()
		  
		  //  returns selected columns
		  //  
		  //  Parameters:
		  //  - ColumnNames: the name of the columns as string parameters
		  //  
		  //  Returns:
		  //  - the columns matching the name or nil, as an array
		  //  
		  
		  Return GetColumns(ColumnNames, True)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetColumnTypes() As string()
		  //  
		  //  Return the type of all columns
		  //  
		  //  Parameters:
		  //  - none
		  //  
		  //  Returns:
		  //  - a string array with the type of the columns
		  //  
		  var ret_str() As String
		  
		  For Each column As clAbstractDataSerie In columns
		    ret_str.Add(column.GetType)
		    
		  Next
		  
		  Return ret_str
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetDateColumn(pColumnName as string, IncludeAlias as boolean = False) As clDateDataSerie
		  //
		  // Returns the selected column as an date data serie
		  //
		  //  Parameters:
		  //  - pColumnName: the name of the column
		  //  - IncludeAlias (optional) search the column aliases
		  // 
		  //  
		  //  Returns:
		  //  - the column matching the name or nil
		  //  
		  
		  return clDateDataSerie(self.GetColumn(pColumnName, IncludeAlias))
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetDateTimeColumn(pColumnName as string, IncludeAlias as boolean = False) As clDateTimeDataSerie
		  //
		  // Returns the selected column as an date-time  data serie
		  //
		  //  Parameters:
		  //  - pColumnName: the name of the column
		  //  - IncludeAlias (optional) search the column aliases
		  // 
		  //  
		  //  Returns:
		  //  - the column matching the name or nil
		  //  
		  
		  return clDateTimeDataSerie(self.GetColumn(pColumnName, IncludeAlias))
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetDoubleRowAt(pRowIndex as integer) As clDoubleDataRow
		  //  
		  //  returns a specific data row
		  //  
		  //  Parameters:
		  //  - the  index of the data row
		  //  
		  //  Returns:
		  //  - a data row with the value of the cell in each column at the specified index, only number, integer and currency columns are populated
		  //  
		  
		  var fieldInfo() as clDoubleDataRowFieldInfo
		  
		  var tmp_row as new clDoubleDataRow(pRowIndex, "", self.ColumnCount, fieldInfo)
		  
		  for i as integer = 0 to self.columns.LastIndex
		    
		    var column as clAbstractDataSerie = self.Columns(i)
		    var columnInfo as new clDoubleDataRowFieldInfo(column.name, clDoubleDataRow.IsUsed(column))
		    
		    fieldInfo.Add(columnInfo)
		    
		    if columnInfo.Supported then
		      tmp_row.SetCell(i, column.GetElementAsNumber(pRowIndex))
		      
		    end if
		    
		  next
		  
		  // tmp_row.columnsInfo = fieldInfo
		  
		  tmp_row.SetTableLink(self)
		  
		  return tmp_row
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetDoubleRowAt(pRowIndex as integer, fieldInfo() as clDoubleDataRowFieldInfo) As clDoubleDataRow
		  //  
		  //  returns a specific data row, the number of fields in the table must be consistent with the number of fields in the FieldInfo() array
		  //  
		  //  Parameters:
		  //  - the  index of the data row
		  //  - field information as an array of clDoubleDataRowFieldInfo
		  //  
		  //  Returns:
		  //  - a data row with the value of the cell in each column at the specified index, only number, integer and currency columns are populated
		  //  
		  
		  if fieldInfo.Count <> self.Columns.Count then
		    raise new clDataException("Inconsistent column count in " + CurrentMethodName)
		    
		  end if
		  
		  var tmp_row as new clDoubleDataRow(pRowIndex, "", fieldInfo)
		  
		  for i as integer = 0 to self.columns.LastIndex
		    var column as clAbstractDataSerie = self.Columns(i)
		    
		    if clDoubleDataRow.IsUsed(column) then
		      tmp_row.SetCell(i, column.GetElementAsNumber(pRowIndex))
		      
		    end if
		    
		  next
		  
		  tmp_row.SetTableLink(self)
		  
		  return tmp_row
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetElement(ColumnIndex as integer, ElementIndex as integer) As variant
		  //  
		  //  returns a specific cell based on column name and row number
		  //  
		  //  Parameters:
		  //  - ColumnIndex: the index of the column 
		  //  - ElementIndex: the row index
		  //  
		  //  Returns:
		  //  - the value of the matching cell or nil
		  //  
		  var tmp_col as clAbstractDataSerie = self.GetColumnAt(ColumnIndex)
		  
		  if tmp_col = nil then return nil
		  
		  return tmp_col.GetElement(ElementIndex)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetElement(pColumnName as String, ElementIndex as integer) As variant
		  //  
		  //  returns a specific cell based on column name and row number
		  //  
		  //  Parameters:
		  //  - pColumnName: the name of the columns 
		  //  - ElementIndex: the row index
		  //  
		  //  Returns:
		  //  - the value of the matching cell or nil
		  //  
		  var tmp_col as clAbstractDataSerie = self.GetColumn(pColumnName)
		  
		  if tmp_col = nil then return nil
		  
		  return tmp_col.GetElement(ElementIndex)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetIntegerColumn(pColumnName as string, IncludeAlias as boolean = False) As clIntegerDataSerie
		  //
		  // Returns the selected column as an integer data serie
		  //
		  //  Parameters:
		  //  - pColumnName: the name of the column
		  //  - IncludeAlias (optional) search the column aliases
		  // 
		  //  
		  //  Returns:
		  //  - the column matching the name or nil
		  //  
		  
		  return clIntegerDataSerie(self.GetColumn(pColumnName, IncludeAlias))
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function getLogManager() As clLogManager
		  
		  if self.localLogger = nil then
		    return clLogManager.GetDefaultLogingSupport
		    
		  else
		    return self.localLogger
		    
		  end if
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetMetadata() As clMetaData
		  Return self.Metadata
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetNumberColumn(pColumnName as string, IncludeAlias as boolean = False) As clNumberDataSerie
		  //
		  // Returns the selected column as an number data serie
		  //
		  //  Parameters:
		  //  - pColumnName: the name of the column
		  //  - IncludeAlias (optional) search the column aliases
		  // 
		  //  
		  //  Returns:
		  //  - the column matching the name or nil
		  //  
		  
		  return clNumberDataSerie(self.GetColumn(pColumnName, IncludeAlias))
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetPropertiesAsTable(NewTableName as string = "") As clDataTable
		  //
		  // Get properties of each columns as a data table
		  //
		  // Parameters:
		  // - NewTableName: name of the new table
		  //
		  // Returns
		  // - new datatable
		  //
		  
		  var DataRows() as clDataRow
		  
		  for i as integer = 0 to columns.LastIndex
		    var p as clDataSerieProperties = columns(i).GetProperties
		    var r as new clDataRow(p)
		    
		    r.SetCell("name", columns(i).name)
		    
		    DataRows.Add(r)
		    
		  next
		  
		  
		  var NewTable as new clDataTable(StringWithDefault(NewTableName, self.PropertyTableNamePrefix.trim + " " + self.name))
		  
		  call NewTable.AddRows(DataRows)
		  
		  return NewTable
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetRowAt(pRowIndex as integer, include_index as Boolean) As clDataRow
		  //  
		  //  returns a specific data row
		  //  
		  //  Parameters:
		  //  - the  index of the data row
		  //  
		  //  Returns:
		  //  - a data row with the value of the cell in each column at the specified index
		  //  
		  var tmp_row as new clDataRow(pRowIndex)
		  
		  if not include_index then
		    
		  elseif RowIndexColumn = nil then
		    tmp_row.SetCell(DefaultRowIndexColumnName,  pRowIndex)
		    
		  else
		    tmp_row.SetCell(DefaultRowIndexColumnName,  RowIndexColumn.GetElement(pRowIndex))
		    
		  end if
		  
		  for each column as clAbstractDataSerie in self.columns
		    var col_name as string = column.name
		    var col_val as Auto = column.GetElement(pRowIndex)
		    tmp_row.SetCell(col_name, col_val)
		    
		  next
		  
		  tmp_row.SetTableLink(self)
		  return tmp_row
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetRowReader() As clDataTableRowReader
		  return new clDataTableRowReader(self)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetSelectedRowsAsTable(SelectedRowIndex() as integer, NameOfNewTable as string = "") As clDataTable
		  //
		  // Create a new table containing the rows of the current of which index is in the array passed as parameter
		  //
		  // Parameters:
		  // - SelectedRowIndex(): list of row index to include in generated table
		  //
		  // Returns:
		  // - new table with copy of the selected rows
		  //
		  
		  
		  var return_table as new clDataTable(StringWithDefault(NameOfNewTable, "Extract from "+ self.Name))
		  
		  return_table.Metadata.AddSource("Extract from " + self.name)
		  
		  for each index as integer in SelectedRowIndex
		    
		    return_table.AddRow(self.GetRowAt(index, false))
		    
		  next
		  
		  return return_table
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetStatisticsAsTable(NewTableName as string = "") As clDataTable
		  
		  //
		  //
		  
		  var tbl_name() as string
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
		    tbl_name.add(self.name)
		    col_name.Add(columns(i).name)
		    
		    col_ubound.Add(columns(i).LastIndex)
		    
		    // returns of non null items
		    col_count.Add(columns(i).CountDefined)
		    col_count_nz.Add(columns(i).CountNonZero)
		    
		    col_sum.add(columns(i).sum)
		    col_average.Add(columns(i).average)
		    col_average_nz.Add(columns(i).AverageNonZero)
		    
		    col_stdev.Add(columns(i).StandardDeviation)
		    col_stdev_nz.Add(columns(i).StandardDeviationNonZero)
		    
		  next
		  
		  var series() as clAbstractDataSerie
		  
		  series.Add(new clStringDataSerie(StatisticsTableNameColumn, tbl_name))
		  series.Add(new clStringDataSerie(StatisticsSerieNameColumn, col_name))
		  series.add(new clIntegerDataSerie(StatisticsUboundColumn, col_ubound))
		  series.Add(new clIntegerDataSerie(StatisticsCountColumn, col_count))
		  series.Add(new clIntegerDataSerie(StatisticsCountNZColumn, col_count_nz))
		  
		  series.Add(new clNumberDataSerie(StatisticsSumColumn, col_sum))
		  series.Add(new clNumberDataSerie(StatisticsAverageColumn, col_average))
		  series.Add(new clNumberDataSerie(StatisticsAverageNZColumn, col_average_nz))
		  
		  series.Add(new clNumberDataSerie(StatisticsStdDevColumn, col_stdev))
		  series.Add(new clNumberDataSerie(StatisticsStdDevNZColumn, col_stdev_nz))
		  
		  var temp as string = NewTableName.trim
		  
		  if temp.Length < 1 then temp = self.StatisticsTableNamePrefix.trim + " " + self.name
		  
		  return new clDataTable(temp, series)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetStringColumn(pColumnName as string, IncludeAlias as boolean = False) As clStringDataSerie
		  //
		  // Returns the selected column as an string data serie
		  //
		  //  Parameters:
		  //  - pColumnName: the name of the column
		  //  - IncludeAlias (optional) search the column aliases
		  // 
		  //  
		  //  Returns:
		  //  - the column matching the name or nil
		  //  
		  
		  var tmp as clAbstractDataSerie = self.GetColumn(pColumnName, IncludeAlias)
		  if tmp = nil then return nil
		  
		  if tmp isa clStringDataSerie then
		    return clStringDataSerie(tmp)
		    
		  elseif tmp isa clNumberDataSerie then 
		    return clNumberDataSerie(tmp).ToString
		    
		  elseif tmp isa clIntegerDataSerie then
		    return clIntegerDataSerie(tmp).ToString
		    
		  else
		    Return new clStringDataSerie(tmp.name, tmp.GetElements)
		    
		  end if
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetStructureAsTable(NewTableName as string = "") As clDataTable
		  
		  var col_name() as string
		  var col_type() as string
		  var col_title() as String
		  
		  for i as integer = 0 to columns.LastIndex
		    col_name.Add(columns(i).name)
		    col_type.add(columns(i).GetType)
		    col_title.add(columns(i).DisplayTitle)
		    
		  next
		  
		  var dct as new Dictionary
		  dct.Value(StructureNameColumn) = col_name
		  dct.Value(StructureTypeColumn) = col_type
		  dct.Value(StructureTitleColumn) = col_title
		  
		  var temp as string = NewTableName.trim
		  
		  if temp.Length < 1 then temp = self.StructureTableNamePrefix.trim + " " + self.name
		  
		  return new clDataTable(temp, dct)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetUniqueColumnName(BaseColumnName as string) As string
		  
		  //  
		  //  returns a unique column name by adding a suffix. The suffix is an integer, starting at zero
		  //  If the baseColumnName is "Something"   and the table already contains a column named "Something", this
		  //  method returns "Something 0"
		  //  
		  //  Parameters:
		  //  - the name of a future column, which may duplicate the name of an existing column
		  //  
		  //  Returns:
		  //  - the name of the column made unique by appending a number
		  //  
		  
		  return GetUniqueColumnName(BaseColumnName, " ", "") 
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetUniqueColumnName(BaseColumnName as string, prefix as string, suffix as string, counterStart as integer = 0) As string
		  
		  //  
		  //  returns a unique column name by adding a suffix. The suffix is an integer, starting at zero
		  //
		  //  If the baseColumnName is "Something" , the prefix is '-', the suffix is an empty string  and the table already contains a column named "Something", this
		  //  method returns "Something-0"
		  //
		  //  If the baseColumnName is "Something" , the prefix is '[', the suffix is ']' and the table already contains a column named "Something", this
		  //  method returns "Something[0]"
		  //
		  //  Parameters:
		  //  - the name of a future column, which may duplicate the name of an existing column
		  //  - the string inserted before the integer
		  //  - the string inserted after the integer
		  //  - the start value of the counter used to create unique column name
		  //  
		  //  Returns:
		  //  - the name of the column made unique by appending a number
		  //  
		  
		  const limitForNumberOfTests = 1000  
		  
		  var tmp() as string = self.GetColumnNames
		  var tmppfx as string = prefix
		  var tmpsfx as string = suffix
		  
		  if tmp.IndexOf(BaseColumnName) < 0 then return BaseColumnName
		  
		  for i as integer = counterStart to counterStart + limitForNumberOfTests
		    var tmp_name as string = BaseColumnName + tmppfx + str(i) + tmpsfx
		    if tmp.IndexOf(tmp_name)  < 0 then return tmp_name
		    
		  next
		  
		  return "?"
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Groupby(grouping_dimensions() as string) As clDataTable
		  //
		  // Group records per distinct values in the grouping_dimensions
		  // This is typically used to get a list of distinct combinations
		  //
		  // Parameters:
		  // - Input table
		  // - grouping_dimenions() list of columns to be used as grouping dimensions
		  //
		  
		  var gTransform as new clGroupByTransformer(self, grouping_dimensions, "")
		  
		  if gTransform.Transform() then
		    return gTransform.GetOutputTable
		    
		  else
		    return nil
		    
		  end if
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GroupBy(grouping_dimensions() as string, measures() as pair) As clDataTable
		  //
		  // Group records per distinct values in the grouping_dimensions
		  // Aggregate the number fields as defined the each pair, columnname:agg mode
		  //
		  // Parameters:
		  // - grouping_dimenions() list of columns to be used as grouping dimensions
		  // - measures() pair of columnname : agg mode
		  //
		  
		  
		  
		  var gTransform as new clGroupByTransformer(self, grouping_dimensions, Measures, "")
		  
		  if gTransform.Transform() then
		    return gTransform.GetOutputTable
		    
		  else
		    return nil
		    
		  end if 
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GroupBy(grouping_dimensions() as string, measures() as String) As clDataTable
		  //
		  // Group records per distinct values in the grouping_dimensions
		  // Aggregate the number fields as defined in the second array, aggregation mode is sum
		  //
		  // Parameters:
		  // - grouping_dimenions() list of columns to be used as grouping dimensions
		  // - measures() list of columns to sum: agg mode
		  //
		  
		  var gTransform as new clGroupByTransformer(self, grouping_dimensions, Measures, "")
		  
		  if gTransform.Transform() then
		    return gTransform.GetOutputTable
		    
		  else
		    return nil
		    
		  end if 
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Groupby(grouping_dimensions() as string, rowCountColumnName as string) As clDataTable
		  //
		  // Group records per distinct values in the grouping_dimensions
		  // This is typically used to get a list of distinct combinations
		  //
		  // Parameters:
		  // - Input table
		  // - grouping_dimenions() list of columns to be used as grouping dimensions
		  //
		  
		  var gTransform as new clGroupByTransformer(self, grouping_dimensions, rowCountColumnName)
		  
		  if gTransform.Transform() then
		    return gTransform.GetOutputTable
		    
		  else
		    return nil
		    
		  end if
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GroupBy(grouping_dimensions() as string, rowCountColumnName as string, measures() as pair) As clDataTable
		  //
		  // Group records per distinct values in the grouping_dimensions
		  // Aggregate the number fields as defined the each pair, columnname:agg mode
		  //
		  // Parameters:
		  // - grouping_dimenions() list of columns to be used as grouping dimensions
		  // - measures() pair of columnname : agg mode
		  //
		  
		  
		  
		  var gTransform as new clGroupByTransformer(self, grouping_dimensions, Measures, rowCountColumnName)
		  
		  if gTransform.Transform() then
		    return gTransform.GetOutputTable
		    
		  else
		    return nil
		    
		  end if 
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GroupBy(grouping_dimensions() as string, rowCountColumnName as string, measures() as String) As clDataTable
		  //
		  // Group records per distinct values in the grouping_dimensions
		  // Aggregate the number fields as defined in the second array, aggregation mode is sum
		  //
		  // Parameters:
		  // - grouping_dimenions() list of columns to be used as grouping dimensions
		  // - measures() list of columns to sum: agg mode
		  //
		  
		  var gTransform as new clGroupByTransformer(self, grouping_dimensions, Measures, rowCountColumnName)
		  
		  if gTransform.Transform() then
		    return gTransform.GetOutputTable
		    
		  else
		    return nil
		    
		  end if 
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub IncludeRowNameAsColumn(status as Boolean)
		  
		  self.row_name_as_column = status
		End Sub
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
		  //   (nothing)
		  //  
		  
		  var max_RowCount as integer
		  
		  if self.RowCount > the_length then
		    max_RowCount = self.RowCount
		    
		  else
		    max_RowCount = the_length
		    
		  end if
		  
		  RowIndexColumn.SetLength(max_RowCount)
		  
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

	#tag Method, Flags = &h0
		Function InnerJoin(TableToJoin as clDataTable, KeyFields() as string) As clDataTable
		  //
		  // Executes a inner join between the current table and the 'TableToJoin'
		  // Use Lookpu() function for a left join
		  // Use $$ to get a list of unmatched records $$$
		  // All fields are included from both side, key fields are not replicateed
		  //
		  // Paramters
		  // TableToJoin  (clDataTable): table used as lookup source
		  // KeyFields: list of fields used as join keys, field names must match
		  //
		  //
		  // Returns
		  // Datatable with joined results
		  //
		  
		  // const JoinSuccessBoth = "Both"
		  // const JoinSuccessMainOnly = "Main"
		  // const JoinSuccessJoinedOnly= "Joined"
		  
		  
		  var mastertable as clDataTable = self
		  var joinedtable as clDataTable = TableToJoin
		  var OutputTable as clDataTable
		  
		  var trsf as new clJoinTransformer(mastertable, joinedtable, joinmode.InnerJoin, KeyFields, "")
		  
		  trsf.SetJoinStatusLeft(JoinSuccessMainOnly)
		  trsf.SetJoinStatusRight(JoinSuccessJoinedOnly)
		  trsf.SetJoinStatusBoth(JoinSuccessBoth)
		  
		  if trsf.Transform() then
		    var connection as clTransformerConnector = trsf.GetOutputConnector(trsf.cOutputConnectorJoined)
		    
		    OutputTable = connection.GetTable
		    
		    return OutputTable
		    
		  else
		    Return nil
		    
		  end if
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub IntegerColumnValues(pColumnName as string, assigns pSourceValue as Variant)
		  
		  var temp_column as clAbstractDataSerie = self.GetColumn(pColumnName)
		  
		  if temp_column = nil then
		    Raise New clDataException("Cannot find  column " + pColumnName)
		    return 
		    
		  elseif pSourceValue.Type = Variant.TypeObject then
		    
		    var temp_obj as Object = pSourceValue.ObjectValue
		    
		    if temp_obj isa clNumberDataSerie or temp_obj isa clIntegerDataSerie then
		      temp_column.SetElements(clAbstractDataSerie(temp_obj))
		      return
		    end if
		    
		    Raise New clDataException("Assigned item is an object, when updating " + pColumnName)
		    
		  elseif pSourceValue.IsArray then
		    Raise New clDataException("Assigned item is an array, when updating " + pColumnName)
		    
		  else
		    
		    for i as integer = 0 to temp_column.RowCount
		      temp_column.SetElement(i, pSourceValue)
		      
		    next
		    return
		    
		  end if
		  
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
		Private Function internal_AddRows(RowSource as TableRowReaderInterface, TargetColumns() as clAbstractDataSerie, SourceName as string) As integer
		  //
		  //  Add rows from the received source
		  //  
		  //  Parameters:
		  //  - RowSource: source of data rows
		  //  - TargetColumns: list of colums to be populated, by position
		  //  - SourceName: used to populate a 'data source name' column, name of the column is in the 'LoadedDataSourceColumn' constant
		  //
		  //  Returns:
		  //  - 
		  //
		  var added_rows as integer
		  
		  var source_name_col as clAbstractDataSerie
		  
		  if SourceName.Length > 0 then
		    source_name_col = self.GetColumn(LoadedDataSourceColumn)
		    
		  end if
		  
		  var numericColumns() as Boolean
		  
		  for each c as clAbstractDataSerie in TargetColumns
		    numericColumns.Add(c isa clNumberDataSerie)
		    
		  next
		  
		  while not RowSource.EndOfTable
		    var tmp_row() as variant
		    added_rows = added_rows + 1
		    
		    tmp_row  = RowSource.NextRowAsVariant
		    
		    if tmp_row <> nil then 
		      
		      for i as integer=0 to TargetColumns.LastIndex
		        if TargetColumns(i) <> nil then
		          if i <= tmp_row.LastIndex then
		            
		            TargetColumns(i).AddElement(tmp_row(i))
		            
		          else
		            TargetColumns(i).AddElement(TargetColumns(i).GetDefaultValue)
		            
		          end if
		        end if
		      next
		      
		      if source_name_col <> nil then source_name_col.AddElement(SourceName)
		      
		    end if
		    
		  wend
		  
		  // make sure all columns have the same length
		  self.AdjustLength
		  
		  return added_rows
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function internal_CreateColumnsWithAllocator(ColumnNames() as string, ColumnTypes as Dictionary, allocator as ColumnAllocator = nil) As clAbstractDataSerie()
		  
		  
		  var tmp_column_names() as string = ColumnNames
		  var tmp_column_types as Dictionary = ColumnTypes
		  var tmp_columns() as clAbstractDataSerie  
		  
		  if tmp_column_types = nil then tmp_column_types = new Dictionary
		  
		  for each tmp_column_name as string in tmp_column_names
		    var c as  clAbstractDataSerie
		    var t as string = tmp_column_types.Lookup(tmp_column_name, clDataType.VariantValue)
		    
		    if allocator = nil then
		      c = clDataType.CreateDataSerieFromType(tmp_column_name, t)
		      if c <> nil then  
		        c.SetLinkToTable(Self)
		        columns.Add(c)
		      end if
		      
		    else
		      c = allocator.Invoke(tmp_column_name, t)
		      if c <> nil then 
		        c.SetLinkToTable(Self)
		        columns.Add(c)
		      end if
		      
		    end if
		    
		    // internal_addrows can handle nil values, to indicate columns in source to ignore
		    
		    tmp_columns.add(c)
		    
		  next
		  
		  return tmp_columns
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function internal_HandleNewColumn(ColumnName as string, ColumnType as string, v as variant, Mode as AddRowMode) As clAbstractDataSerie
		  
		  var tmp_column as clAbstractDataSerie
		  
		  select case Mode
		  case AddRowMode.CreateNewColumn 
		    if ColumnType = "" then
		      tmp_column = clDataType.CreateDataSerieFromVariantType(ColumnName, v)
		      
		    else
		      tmp_column = clDataType.CreateDataSerieFromType(ColumnName, ColumnType)
		      
		    end if
		    
		  case  AddRowMode.CreateNewColumnAsVariant  
		    tmp_column =new clDataSerie(ColumnName)
		    
		  case AddRowMode.IgnoreNewColumn
		    
		  case AddRowMode.WarningOnNewColumn
		    self.AddWarningMessage(CurrentMethodName, ErrMsgIgnoringColumn, ColumnName)
		    
		  case AddRowMode.ErrorOnNewColumn
		    self.AddErrorMessage(CurrentMethodName, ErrMsgIgnoringColumn, ColumnName)
		    
		  case AddRowMode.ExceptionOnNewColumn
		    Raise New clDataException("Adding row with unexpected column " + ColumnName)
		    
		  case else
		    Raise New clDataException("Unexpected value for AddRowMode " + str(mode))
		    
		    
		  end select
		  
		  return tmp_column
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub internal_NewTable(NewTableName as string)
		  
		  Self.TableName = StringWithDefault(NewTableName.Trim, "Unnamed")
		  
		  RowIndexColumn = New clDataSerieRowID(DefaultRowIDColumnName)
		  
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
		Function LastIndex() As integer
		  If Self.RowIndexColumn = Nil Then
		    Return -1
		    
		  Else
		    Return Self.RowIndexColumn.LastIndex
		    
		  End If
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function LeftJoin(TableToJoin as clDataTable, KeyFields() as string, JoinSuccessField as string = "") As clDataTable
		  //
		  // Executes a outer join between the current table and the 'TableToJoin'
		  // Use Lookpu() function for a left join
		  // All fields are included from both side, key fields are not replicateed
		  //
		  // Paramters
		  // TableToJoin  (clDataTable): table used as lookup source
		  // KeyFields: list of fields used as join keys, field names must match
		  //
		  //
		  // Returns
		  // Datatable with joined results
		  //
		  
		  // const JoinSuccessBoth = "Both"
		  // const JoinSuccessMainOnly = "Main"
		  // const JoinSuccessJoinedOnly= "Joined"
		  
		  
		  var mastertable as clDataTable = self
		  var joinedtable as clDataTable = TableToJoin
		  var OutputTable as   clDataTable
		  
		  var trsf as new clJoinTransformer(mastertable, joinedtable, JoinMode.LeftJoin , KeyFields, JoinSuccessField)
		  
		  trsf.SetJoinStatusLeft(JoinSuccessMainOnly)
		  trsf.SetJoinStatusRight(JoinSuccessJoinedOnly)
		  trsf.SetJoinStatusBoth(JoinSuccessBoth)
		  
		  if trsf.Transform() then
		    var connection as clTransformerConnector = trsf.GetOutputConnector(trsf.cOutputConnectorJoined)
		    
		    OutputTable =  connection.GetTable
		    
		    return OutputTable
		    
		  else
		    return nil
		    
		  end if
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Lookup(LookupSourceTable As clDataTable, KeyFieldMapping() As pair, LookupFieldMapping() As pair, JoinSuccessField As string = "") As Boolean
		  //
		  // Lookup data
		  // Similar to left join or an Excel Vlookup()
		  //
		  // Paramters
		  // LookupSourceTable  (clDataTable): table used as lookup source
		  // KeyFieldapping: list of fields used as lookup keys as an array of pair. For each pair, left value is expected in the current table and  right value  is expected in the joined table
		  // LookUpFieldMaping: Field to 'bring back' from the lookup table as an array of pair. For each pair, left value is expected in the current table and right value is expected in the joined table
		  // JoinSuccessField: Field to store a flag indicating the success of the lookup
		  //
		  
		  var trsf as new clLookupTransformer(self, LookupSourceTable, KeyFieldMapping, LookupFieldMapping, JoinSuccessField)
		  
		  return trsf.Transform()
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Lookup(LookupSourceTable as clDataTable, KeyFields() as string, LookupFields() as string, JoinSuccessField as string = "") As Boolean
		  //
		  // Lookup data
		  // Similar to left join or an Excel Vlookup()
		  //
		  // Paramters
		  // LookupSourceTable  (clDataTable): table used as lookup source
		  // KeyFields: list of fields used as lookup keys, field names must match
		  // LookUpFields: Field to 'bring back' from the lookup table
		  // JoinSuccessField: Field to store a flag indicating the success of the lookup
		  //
		  
		  var pKey() as pair
		  var pData() as pair
		  
		  for each key as string in KeyFields
		    pKey.Add(new pair(key,key))
		    
		  next
		  
		  for each dataField  as string in  LookupFields
		    pData.Add(new pair(dataField, dataField))
		    
		  next
		  
		  var trsf as new clLookupTransformer(self, LookupSourceTable, pKey, pData, JoinSuccessField)
		  
		  return trsf.Transform()
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Name() As string
		  Return self.TableName
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub NumberColumnValues(pColumnName as string, assigns pSourceValue as Variant)
		  
		  var temp_column as clAbstractDataSerie = self.GetColumn(pColumnName)
		  
		  if temp_column = nil then
		    Raise New clDataException("Cannot find  column " + pColumnName)
		    return 
		    
		  elseif pSourceValue.Type = Variant.TypeObject then
		    
		    var temp_obj as Object = pSourceValue.ObjectValue
		    
		    if temp_obj isa clNumberDataSerie or temp_obj isa clIntegerDataSerie then
		      temp_column.SetElements(clAbstractDataSerie(temp_obj))
		      return
		    end if
		    
		    Raise New clDataException("Assigned item is an object, when updating " + pColumnName)
		    
		  elseif pSourceValue.IsArray then
		    Raise New clDataException("Assigned item is an array, when updating " + pColumnName)
		    
		  else
		    
		    for i as integer = 0 to temp_column.RowCount
		      temp_column.SetElement(i, pSourceValue)
		      
		    next
		    return
		    
		  end if
		  
		End Sub
	#tag EndMethod

	#tag DelegateDeclaration, Flags = &h0
		Delegate Function ObjectAllocator(name as string) As object
	#tag EndDelegateDeclaration

	#tag Method, Flags = &h0
		Function OuterJoin(TableToJoin as clDataTable, KeyFields() as string, JoinSuccessField as string = "") As clDataTable
		  //
		  // Executes a outer join between the current table and the 'TableToJoin'
		  // Use Lookpu() function for a left join
		  // All fields are included from both side, key fields are not replicateed
		  //
		  // Paramters
		  // TableToJoin  (clDataTable): table used as lookup source
		  // KeyFields: list of fields used as join keys, field names must match
		  //
		  //
		  // Returns
		  // Datatable with joined results
		  //
		  
		  // const JoinSuccessBoth = "Both"
		  // const JoinSuccessMainOnly = "Main"
		  // const JoinSuccessJoinedOnly= "Joined"
		  
		  
		  var mastertable as clDataTable = self
		  var joinedtable as clDataTable = TableToJoin
		  var OutputTable as   clDataTable
		  
		  var trsf as new clJoinTransformer(mastertable, joinedtable, JoinMode.OuterJoin, KeyFields, JoinSuccessField)
		  
		  trsf.SetJoinStatusLeft(JoinSuccessMainOnly)
		  trsf.SetJoinStatusRight(JoinSuccessJoinedOnly)
		  trsf.SetJoinStatusBoth(JoinSuccessBoth)
		  
		  if trsf.Transform() then
		    var connection as clTransformerConnector = trsf.GetOutputConnector(trsf.cOutputConnectorJoined)
		    
		    OutputTable = connection.GetTable
		    
		    return OutputTable
		    
		  else
		    return nil
		    
		  end if
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Rename(the_new_name as string)
		  
		  If the_new_name.Trim.Len = 0 Then
		    Self.TableName = DefaultTableName
		    
		  Else
		    Self.TableName = the_new_name.Trim
		    
		  End If
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Rename(the_new_name as string) As clDataTable
		  
		  If the_new_name.Trim.Len = 0 Then
		    Self.TableName = DefaultTableName
		    
		  Else
		    Self.TableName = the_new_name.Trim
		    
		  End If
		  
		  return self
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RenameColumn(OldColumnName as string, NewColumnName as string)
		  
		  var col as clAbstractDataSerie = self.GetColumn(OldColumnName)
		  
		  if col = nil then return
		  
		  if self.GetColumn(NewColumnName) <> nil then return
		  
		  col.Rename(NewColumnName)
		  
		  Return
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
		Function ReplacePlaceHolders(BaseString as string, values() as string) As string
		  var ret as string = BaseString
		  
		  for i as integer = 0 to values.LastIndex
		    ret = ret.replaceall("%"+str(i), values(i))
		    
		  next
		  
		  return ret
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ReplacePlaceHolders(BaseString as string, paramarray values as string) As string
		  var ret as string = BaseString
		  
		  for i as integer = 0 to values.LastIndex
		    ret = ret.replaceall("%"+str(i), values(i))
		    
		  next
		  
		  return ret
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function RowCount() As integer
		  If Self.RowIndexColumn = Nil Then
		    Return -1
		    
		  Else
		    Return Self.RowIndexColumn.RowCount
		    
		  End If
		  
		End Function
	#tag EndMethod

	#tag DelegateDeclaration, Flags = &h0
		Delegate Function RowFilter(pRowIndex as integer, pRowCount as integer, pColumnNames() as string, pCellValues() as variant, pFunctionParameters() as variant) As Boolean
	#tag EndDelegateDeclaration

	#tag Method, Flags = &h0
		Sub Save(write_to as TableRowWriterInterface, IncludeRowIndex as boolean = false)
		  
		  var ColumnNames() as string = self.GetColumnNames
		  var ColumnTypes() as string = self.GetColumnTypes
		  
		  
		  if IncludeRowIndex Then
		    ColumnNames.AddAt(0, self.RowIndexColumn.name)
		    ColumnTypes.AddAt(0, clDataType.IntegerValue)
		    
		  end if
		  
		  write_to.DefineColumns(name, ColumnNames, ColumnTypes)
		  
		  var columnValues() as variant
		  
		  for RowIndex as integer = 0 to self.RowCount-1
		    columnValues.RemoveAll
		    
		    for ColumnIndex as integer = 0 to self.columns.LastIndex
		      columnValues.Add(self.columns(ColumnIndex).GetElement(RowIndex))
		      
		    next
		    
		    if IncludeRowIndex Then columnValues.AddAt(0, self.RowIndexColumn.GetElement(RowIndex))
		    
		    
		    Write_to.AddRow(columnValues)
		    
		  next
		  
		  
		  write_to.DoneWithTable
		  
		  return
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SaveWithIndex(write_to as TableRowWriterInterface)
		  
		  self.save(write_to, true)
		  
		  return 
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SelectAllColumns(AllowLocalColumns as Boolean = False) As clDataTable
		  //
		  // Create a new logical table (view) with  all columns from source table
		  // Use the Clone() method to create a new table with cloned columns
		  //
		  //
		  // Returns
		  // - New table
		  //
		  
		  
		  var res As New clDataTable("select all " + Self.Name)
		  
		  res. AddSourceToMetadata( self.Name)
		  res.RowIndexColumn = Self.RowIndexColumn
		  //  
		  //  link to parent must be called BEFORE adding logical columns
		  //  
		  res.link_to_parent = Self
		  
		  for each column As clAbstractDataSerie in self.columns
		    call res.AddColumn(column)
		    
		  next
		  
		  res.allow_local_columns = AllowLocalColumns
		  
		  Return res
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SelectColumns(ColumnNames() as string) As clDataTable
		  //
		  // Create a new logical table (view) with  columns from source table
		  // Use ExtractColumns() method to create a new table with cloned columns
		  //
		  // Paramters:
		  // - ColumnNames() : name of columns to show in new table
		  //
		  // Returns
		  // - New table
		  //
		  
		  
		  var res As New clDataTable("select " + Self.Name)
		  
		  res. AddSourceToMetadata( self.Name)
		  res.RowIndexColumn = Self.RowIndexColumn
		  //  
		  //  link to parent must be called BEFORE adding logical columns
		  //  
		  res.link_to_parent = Self
		  
		  For Each column_name As String In ColumnNames
		    var tmp_column As clAbstractDataSerie = Self.GetColumn(column_name)
		    
		    If tmp_column <> Nil Then
		      call res.AddColumn(tmp_column)
		      
		    else
		      AddErrorMessage(CurrentMethodName, ErrMsgCannotFIndColumn, self.Name, name)
		      
		    End If
		    
		  Next
		  
		  Return res
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SelectColumns(paramarray ColumnNames as string) As clDataTable
		  //
		  // Create a new logical table (view) with  columns from source table
		  // Use ExtractColumns() method to create a new table with cloned columns
		  //
		  // Paramters:
		  // - ColumnNames() as paramarray : name of columns to show in new table
		  //
		  // Returns
		  // - New table
		  //
		  
		  Return SelectColumns(ColumnNames)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SelectRowsFilteredOn(pBooleanSerie as clBooleanDataSerie) As clDataTable
		  //
		  // Create a new table with selected rows, using flags from clBooleanDataSerie
		  //
		  
		  
		  var res as clDataTable = self.CloneStructure("Filtered " + self.Name)
		  
		  for each row as clDataRow in self.FilteredOn(pBooleanSerie)
		    res.AddRow(row)
		    
		  next
		  
		  return res
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SelectRowsFilteredOn(pBooleanColumnName as string) As clDataTable
		  //
		  // Create a new table with selected rows, using existing boolean column
		  //
		  
		  var tmp as  clBooleanDataSerie = self.GetBooleanColumn(pBooleanColumnName)
		  
		  Return self.SelectRowsFilteredOn(tmp)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SelectRowsFilteredOn(pBooleanArray() as Variant) As clDataTable
		  //
		  // Create a new table with selected rows, using flags from Passed array
		  //
		  
		  var tmp as new clBooleanDataSerie("temp", pBooleanArray)
		  
		  tmp.SetLength(self.LastIndex, false)
		  
		  Return self.SelectRowsFilteredOn(tmp)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SetColumnValues(pColumnName as string, source_column as clAbstractDataSerie, can_create as boolean = False) As clAbstractDataSerie
		  
		  var temp_column as clAbstractDataSerie = self.GetColumn(pColumnName)
		  
		  if temp_column = nil then
		    
		    if can_create then
		      temp_column = source_column.clone()
		      temp_column.rename(pColumnName)
		      
		      call self.AddColumn(temp_column)
		      
		      return temp_column
		      
		    else
		      return nil
		      
		    end if
		    
		  else
		    temp_column.SetElements(source_column)
		    return temp_column
		    
		  end if
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SetColumnValues(pColumnName as string, the_values as double, can_create as boolean = False) As clAbstractDataSerie
		  
		  var temp_column as clAbstractDataSerie = self.GetColumn(pColumnName)
		  
		  if temp_column = nil then
		    
		    if can_create then
		      temp_column = new clDataSerie(pColumnName, the_values)
		      call self.AddColumn(temp_column)
		      
		      return temp_column
		      
		    else
		      return nil
		      
		    end if
		    
		  else
		    temp_column.SetElements(the_values)
		    Return temp_column
		    
		  end if
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SetColumnValues(pColumnName as string, the_values as string, can_create as boolean = False) As clAbstractDataSerie
		  
		  var temp_column as clAbstractDataSerie = self.GetColumn(pColumnName)
		  
		  if temp_column = nil then
		    
		    if can_create then
		      temp_column = new clDataSerie(pColumnName, the_values)
		      call self.AddColumn(temp_column)
		      
		      return temp_column
		      
		    else
		      return nil
		      
		    end if
		    
		  else
		    temp_column.SetElements(the_values)
		    Return temp_column
		    
		  end if
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SetColumnValues(pColumnName as string, the_values() as variant, can_create as boolean = False) As clAbstractDataSerie
		  
		  var temp_column as clAbstractDataSerie = self.GetColumn(pColumnName)
		  
		  if temp_column = nil then
		    
		    if can_create then
		      temp_column = new clDataSerie(pColumnName, the_values)
		      call self.AddColumn(temp_column)
		      
		      return temp_column
		      
		    else
		      return nil
		      
		    end if
		    
		  else
		    temp_column.SetElements(the_values)
		    Return temp_column
		    
		  end if
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SetLogger(newLogger as clLogManager)
		  
		  self.localLogger = newLogger
		  
		  return
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Sort(ColumnNames() as string, order as SortOrder = SortOrder.ascending) As clDataTable
		  //
		  // Produces a new table with content of current table sorted on the value of the columns 
		  //
		  // Parameters:
		  // - ColumnNames (array of string)  : name of columns used as sort key
		  // - order: Sort order (ascending or descending), the order apply on the combined keys
		  //
		  // Returns:
		  //  sorted table
		  //
		  
		  var sortTransformer as new clSortTransformer(self, ColumnNames,  order)
		  
		  if sortTransformer.Transform() then
		    return sortTransformer.GetOutputTable()
		    
		  else
		    return nil
		    
		  end if
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function StringColumn(pColumnName as string) As clStringDataSerie
		  return clStringDataSerie(self.GetColumn(pColumnName, false))
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub StringColumn(pColumnName as string, assigns pSourceValue as Variant)
		  
		  var temp_column as clAbstractDataSerie = self.GetColumn(pColumnName)
		  
		  if temp_column = nil then
		    Raise New clDataException("Cannot find  column " + pColumnName)
		    return 
		    
		  elseif pSourceValue.Type = Variant.TypeObject then
		    
		    var temp_obj as Object = pSourceValue.ObjectValue
		    
		    if temp_obj isa clAbstractDataSerie then
		      temp_column.SetElements(clAbstractDataSerie(temp_obj))
		      return
		    end if
		    
		    Raise New clDataException("Assigned item is an object, when updating " + pColumnName)
		    
		  elseif pSourceValue.IsArray then
		    Raise New clDataException("Assigned item is an array, when updating " + pColumnName)
		    
		  else
		    
		    for i as integer = 0 to temp_column.RowCount
		      temp_column.SetElement(i, pSourceValue)
		      
		    next
		    return
		    
		  end if
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function StringWithDefault(value as string, defaultValue as string) As string
		  if value.Trim.Length = 0 then
		    Return defaultValue.trim
		    
		  else
		    return value.Trim
		    
		  end if
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub UpdateRowAt(RowIndex as integer, NewRow as clDataRow)
		  
		  var d as Dictionary = NewRow.GetCells
		  
		  self.UpdateRowAt(RowIndex, d)
		  
		  return
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub UpdateRowAt(RowIndex as integer, NewRow as Dictionary)
		  
		  var d as Dictionary = NewRow
		  
		  for each name as string in d.Keys
		    var temp as clAbstractDataSerie = self.GetColumn(name)
		    
		    if temp = nil then
		      self.AddErrorMessage(CurrentMethodName, ErrMsgCannotFIndColumn, self.Name, name)
		      
		    else
		      temp.SetElement(RowIndex, d.value(name))
		      
		    end if
		    
		  next
		  
		  return
		  
		End Sub
	#tag EndMethod


	#tag Note, Name = Description
		Defines a data table
		
		A dataTable is a collection of dataSeries.
		
		Only one dataTable can 'own'  a dataSerie, but the series can be shared by multiple tables.
		
		Available on: https://github.com/slo1958/sl-xj-lib-data.git
		
	#tag EndNote

	#tag Note, Name = License
		MIT License
		
		sl-xj-lib-data Data Handling Library
		Copyright (c) 2021-2025 Serge Louvet
		
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
		Protected LastErrorMessage As String
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected LastWarningMessage As String
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected link_to_parent As clDataTable
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected link_to_source As TableColumnReaderInterface
	#tag EndProperty

	#tag Property, Flags = &h21
		Private localLogger As clLogManager
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected Metadata As clMetadata
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected RowIndexColumn As clDataSerieRowID
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected row_name_as_column As Boolean
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected TableName As String
	#tag EndProperty


	#tag Constant, Name = DefaultColumnNamePattern, Type = String, Dynamic = False, Default = \"Untitled %0", Scope = Public
	#tag EndConstant

	#tag Constant, Name = DefaultRowIDColumnName, Type = String, Dynamic = False, Default = \"row_id", Scope = Public
	#tag EndConstant

	#tag Constant, Name = DefaultRowIndexColumnName, Type = String, Dynamic = False, Default = \"row_index", Scope = Public
	#tag EndConstant

	#tag Constant, Name = DefaultTableName, Type = String, Dynamic = False, Default = \"Noname", Scope = Public
	#tag EndConstant

	#tag Constant, Name = ErrMsgCannotFIndColumn, Type = String, Dynamic = False, Default = \"Cannot find column [%1] in table [%0]", Scope = Public
	#tag EndConstant

	#tag Constant, Name = ErrMsgColumnAlreadyDefined, Type = String, Dynamic = False, Default = \"Column [%1] already defined in table [%0]", Scope = Public
	#tag EndConstant

	#tag Constant, Name = ErrMsgColumnNotLinked, Type = String, Dynamic = False, Default = \"Column [%1] in table [%0] is not linked", Scope = Public
	#tag EndConstant

	#tag Constant, Name = ErrMsgColumnNotLinkedInMixedView, Type = String, Dynamic = False, Default = \"Column [%1] in mixed view [%0] is not linked", Scope = Public
	#tag EndConstant

	#tag Constant, Name = ErrMsgColumnNotLinkedInView, Type = String, Dynamic = False, Default = \"Column [%1] in view [%0] is not linked", Scope = Public
	#tag EndConstant

	#tag Constant, Name = ErrMsgColumnWrongLink, Type = String, Dynamic = False, Default = \"Column [%1] in table [%0] linked to [%2]", Scope = Public
	#tag EndConstant

	#tag Constant, Name = ErrMsgColumnWrongLinkView, Type = String, Dynamic = False, Default = \"Column [%1] in view [%0] linked to [%2]", Scope = Public
	#tag EndConstant

	#tag Constant, Name = ErrMsgIgnoringColumn, Type = String, Dynamic = False, Default = \"Ignoring column %0", Scope = Public
	#tag EndConstant

	#tag Constant, Name = ErrMsgInvalidAggregation, Type = String, Dynamic = False, Default = \"Invalid aggregation mode %0", Scope = Public
	#tag EndConstant

	#tag Constant, Name = ErrMsgInvalidColumnLength, Type = String, Dynamic = False, Default = \"Invalid column length in table [%0]\x2C column [%1]\x2C expected %2\x2C observed  %3", Scope = Public
	#tag EndConstant

	#tag Constant, Name = ErrMsgMissingMeasureColumnName, Type = String, Dynamic = False, Default = \"Missing measure column name", Scope = Public
	#tag EndConstant

	#tag Constant, Name = JoinSuccessBoth, Type = String, Dynamic = False, Default = \" Both", Scope = Public
	#tag EndConstant

	#tag Constant, Name = JoinSuccessJoinedOnly, Type = String, Dynamic = False, Default = \" Joined", Scope = Public
	#tag EndConstant

	#tag Constant, Name = JoinSuccessMainOnly, Type = String, Dynamic = False, Default = \" Main", Scope = Public
	#tag EndConstant

	#tag Constant, Name = LoadedDataSourceColumn, Type = String, Dynamic = False, Default = \"loaded_from", Scope = Public
	#tag EndConstant

	#tag Constant, Name = PropertyTableNamePrefix, Type = String, Dynamic = False, Default = \"Properties of ", Scope = Public
	#tag EndConstant

	#tag Constant, Name = RowNameColumn, Type = String, Dynamic = False, Default = \"row_type", Scope = Public
	#tag EndConstant

	#tag Constant, Name = StatisticsAverageColumn, Type = String, Dynamic = False, Default = \"average", Scope = Public
	#tag EndConstant

	#tag Constant, Name = StatisticsAverageNZColumn, Type = String, Dynamic = False, Default = \"average_nz", Scope = Public
	#tag EndConstant

	#tag Constant, Name = StatisticsCountColumn, Type = String, Dynamic = False, Default = \"count", Scope = Public
	#tag EndConstant

	#tag Constant, Name = StatisticsCountNZColumn, Type = String, Dynamic = False, Default = \"count_nz", Scope = Public
	#tag EndConstant

	#tag Constant, Name = StatisticsSerieNameColumn, Type = String, Dynamic = False, Default = \"name", Scope = Public
	#tag EndConstant

	#tag Constant, Name = StatisticsStdDevColumn, Type = String, Dynamic = False, Default = \"std_dev", Scope = Public
	#tag EndConstant

	#tag Constant, Name = StatisticsStdDevNZColumn, Type = String, Dynamic = False, Default = \"std_dev_nz", Scope = Public
	#tag EndConstant

	#tag Constant, Name = StatisticsSumColumn, Type = String, Dynamic = False, Default = \"sum", Scope = Public
	#tag EndConstant

	#tag Constant, Name = StatisticsTableNameColumn, Type = String, Dynamic = False, Default = \"table", Scope = Public
	#tag EndConstant

	#tag Constant, Name = StatisticsTableNamePrefix, Type = String, Dynamic = False, Default = \"statistics of", Scope = Public
	#tag EndConstant

	#tag Constant, Name = StatisticsUboundColumn, Type = String, Dynamic = False, Default = \"ubound", Scope = Public
	#tag EndConstant

	#tag Constant, Name = StructureNameColumn, Type = String, Dynamic = False, Default = \"name", Scope = Public
	#tag EndConstant

	#tag Constant, Name = StructureTableNamePrefix, Type = String, Dynamic = False, Default = \"structure of ", Scope = Public
	#tag EndConstant

	#tag Constant, Name = StructureTitleColumn, Type = String, Dynamic = False, Default = \"title", Scope = Public
	#tag EndConstant

	#tag Constant, Name = StructureTypeColumn, Type = String, Dynamic = False, Default = \"type", Scope = Public
	#tag EndConstant


	#tag Enum, Name = AddRowMode, Flags = &h0
		IgnoreNewColumn
		  ErrorOnNewColumn
		  ExceptionOnNewColumn
		  CreateNewColumn
		  CreateNewColumnAsVariant
		WarningOnNewColumn
	#tag EndEnum


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
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
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
