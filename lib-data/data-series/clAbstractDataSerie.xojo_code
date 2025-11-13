#tag Class
Protected Class clAbstractDataSerie
Implements Iterable
	#tag Method, Flags = &h0
		Sub AddAlias(alias as string)
		  //  
		  //  Add an alias to a column. Record an error if the alias is matching the name of the column or if the name is already defined.
		  //  
		  //  Parameters
		  //  - alias (string) the new alias
		  //  
		  //  Returns:
		  //  
		  
		  
		  if alias = name then
		    self.AddErrorMessage(CurrentMethodName, ErrMsgAliasUsedAsName, alias)
		    return 
		    
		  end if
		  
		  
		  if Aliases.IndexOf(alias) < 0 then
		    Aliases.Add(alias)
		    Return
		  end if
		  
		  self.AddErrorMessage(CurrentMethodName, ErrMsgAliasAlreadyDefined, alias)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AddElement(the_item as Variant)
		  //  
		  //  Add an element to the data serie
		  //  Implemented in type specific subclass
		  //  Adding an element to a dataserie linked to a table will NOT automatically align the size of the other dataseries linked to that table.
		  //  Once elements have been added, call the method clDataTAble.AdjustLength() to make sure all dataseries have the same length.
		  //  An exception will occur while iterating a datatable with columns of different lengrhs. 
		  //  
		  //  Parameters
		  //  - the_item (variant) the value to add to the data serie
		  //  
		  //  Returns:
		  //  
		  
		  Raise New clDataException("Unimplemented method " + CurrentMethodName)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AddElements(the_items() as Variant)
		  //  
		  //  Add elements to the data serie
		  //  
		  //  Parameters
		  //  - the_items (array of variant) the values to add to the data serie
		  //  
		  //  Returns:
		  //  (nothing)
		  //
		  
		  for each item as variant in the_items
		    self.AddElement(item)
		    
		  next
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AddErrorMessage(source as string, ErrorMessage as string, paramarray item as string)
		  //  
		  //  Add an error message
		  //  
		  //  Parameters
		  //  - source: name of method generating the message
		  //  - error message with placeholders
		  // - list of values for placeholders
		  //  
		  //  Returns:
		  //  
		  
		  var msg as string = ReplacePlaceHolders(ErrorMessage, item)
		  
		  self.LastErrorMessage = "In " + source+": " + msg
		  
		  System.DebugLog(self.LastErrorMessage)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AddMetadata(type as string, message as string)
		  //  
		  //  Add meta data
		  //  
		  //  Parameters
		  // - type (string) the key for the meta data
		  //  - message (string) the associated message
		  //  
		  //  Returns:
		  //  
		  
		  self.Metadata.Add(type, message)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AddSerie(the_serie as clAbstractDataSerie)
		  //  
		  //  Add all elements of a data serie to the current data serie
		  //
		  //  Parameters
		  //  - the_serie (data serie) 
		  //  
		  //  Returns:
		  //  
		  
		  var tmp_source as clAbstractDataSerie = the_serie
		  
		  For row_num As Integer = 0 To tmp_source.RowCount-1
		    self.AddElement(tmp_source.GetElement(row_num))
		    
		  Next
		  
		  self.AddMetadata("transformation",  "add data from " + the_serie.name)
		  
		  
		End Sub
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
		Sub AddToTarget(target_data_serie as clAbstractDataSerie)
		  //  
		  //  Add all elements of the current data serie to  another data serie
		  //
		  //  Parameters
		  //  - target_data_serie (data serie) to which elements are added
		  //  
		  //  Returns:
		  //  
		  
		  
		  for index as Integer = 0 to self.LastIndex
		    target_data_serie.AddElement(self.GetElement(index))
		    
		  next
		  
		  target_data_serie.AddMetadata("transformation", "Add from " + self.name)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ApplyFilterFunction(pFilterFunction as FilterColumnByRows, paramarray pFunctionParameters as variant) As variant()
		  //
		  // Applies a filter function  for each row and returns the results as an array of variant
		  //
		  // Parameters:
		  // - pFIlterFunction: the address of the filter function
		  // - pFunctionParameters: parameters passed to the function
		  //
		  // Returns:
		  // - results as an array of variant
		  //
		  
		  var return_boolean() As Variant
		  
		  For row_index As Integer=0 To self.lastIndex // items.LastIndex
		    return_boolean.Add(pFilterFunction.Invoke(row_index,  self.LastIndex, name, GetElement(row_index), pFunctionParameters))
		    
		  Next
		  
		  Return return_boolean
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Average() As double
		  // 
		  // Calculate the average of the current column. Undefined values are ignored
		  // Note that if the underlying column is a number column or an integer colums, values are always defined but could be zero
		  //
		  //
		  // Parameters:
		  // (none)
		  //
		  //
		  // Returns:
		  // - avergae value
		  //
		  var limit As Integer = RowCount - 1
		  var i As Integer
		  
		  var s As Double
		  var n as integer
		  
		  For i = 0 To limit
		    if self.ElementIsDefined(i) then
		      var tmp as Double = GetElementAsNumber(i)
		      s = s + tmp
		      n = n + 1
		      
		    end if
		    
		  Next
		  
		  if n < 1 then return 0
		  
		  return s / n
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function AverageNonZero() As double
		  // 
		  // Calculate the average of the non zero values in the current column. Undefined values are ignored
		  // Note that if the underlying column is a number column or an integer colums, values are always defined but could be zero
		  //
		  //
		  // Parameters:
		  // (none)
		  //
		  //
		  // Returns:
		  // - avergae value
		  //
		  
		  var limit As Integer = RowCount - 1
		  var i As Integer
		  
		  var s As Double
		  var n as integer
		  
		  For i = 0 To limit
		    if self.ElementIsDefined(i) then
		      var tmp as Double = GetElementAsNumber(i)
		      
		      if tmp <> 0 then
		        s = s + tmp
		        n = n + 1
		      end if
		      
		    end if
		    
		  Next
		  
		  if n < 1 then return 0
		  
		  return s / n 
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ClearAliasses()
		  //  
		  //  Remove all aliases
		  //
		  //  Parameters
		  //  
		  //  
		  //  Returns:
		  //  
		  
		  self.aliases.RemoveAll
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ClipByRange(low_value as variant, high_value as variant) As integer
		  //  
		  //  Clip the values of the current data serie to a range: 
		  //.    if lower than low_value, element is replaced by low_value
		  //.    if higher than high_value, element is replaced by high_value
		  //
		  //  Parameters
		  //  - low_value (variant) lower bound
		  // - high_value (variant) upper bound
		  //  
		  //  Returns:
		  //  - the number of values changed
		  //
		  
		  var last_index as integer = self.RowCount
		  var count_changes as integer = 0
		  
		  for index as integer = 0 to last_index
		    var tmp as variant = self.GetElement(index)
		    
		    if low_value > tmp then
		      self.SetElement(index, low_value)
		      count_changes = count_changes + 1
		      
		    elseif  tmp > high_value then
		      self.SetElement(index, high_value)
		      count_changes = count_changes + 1
		      
		    end if
		    
		  next
		  
		  self.AddMetadata("transformation", "Apply range clipping")
		  
		  Return count_changes
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ClipHighValues(high_value as variant) As integer
		  //  
		  //  Clip the values of the current data serie against a high_value:
		  //.    if higher than high_value, element is replaced by high_value
		  //
		  //  Parameters
		  // - high_value (variant) upper bound
		  //  
		  //  Returns:
		  //  - the number of values changed
		  //
		  
		  
		  var last_index as integer = self.RowCount
		  var count_changes as integer = 0
		  
		  for index as integer = 0 to last_index
		    var tmp as variant = self.GetElement(index)
		    
		    if  tmp > high_value then
		      self.SetElement(index, high_value)
		      count_changes = count_changes + 1
		      
		    end if
		    
		  next
		  
		  self.AddMetadata("transformation", "Clip  values above " + str(high_value))
		  
		  Return count_changes
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ClipLowValues(low_value as Variant) As integer
		  //  
		  //  Clip the values of the current data serie against a low_value:
		  //.    if lower than low_value, element is replaced by low_value
		  //
		  //  Parameters
		  //  - low_value (variant) lower bound
		  //  
		  //  Returns:
		  //  - the number of values changed
		  //
		  
		  
		  var last_index as integer = self.RowCount
		  var count_changes as integer = 0
		  
		  for index as integer = 0 to last_index
		    var tmp as variant = self.GetElement(index)
		    
		    if low_value > tmp then
		      self.SetElement(index, low_value)
		      count_changes = count_changes + 1
		      
		    end if
		    
		  next
		  
		  self.AddMetadata("transformation", "Clip  values below " + str(low_value))
		  
		  Return count_changes
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ClippedByRange(low_value as variant, high_value as variant) As clAbstractDataSerie
		  //  
		  //  Create a new data_serie containing elements of the current data serie clipped to range
		  //
		  //  Parameters
		  //  - low_value (variant) lower bound
		  // - high_value (variant) upper bound
		  //  
		  //  Returns:
		  //  - the new data serie
		  
		  var new_col as clAbstractDataSerie = self.Clone()
		  
		  new_col.rename("clip " + self.name)
		  
		  call new_col.ClipByRange(low_value, high_value)
		  
		  return new_col
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Clone(NewName as string = "") As clAbstractDataSerie
		  //  
		  //  Clone the current data serie (only implemented at typed subclasses)
		  //
		  //
		  //  Parameters
		  //  - 
		  //  
		  //  Returns:
		  //  - the new data serie
		  //
		  
		  
		  Raise New clDataException("Unimplemented method " + CurrentMethodName)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub CloneInfo(target as clAbstractDataSerie)
		  
		  target.serie_title = self.serie_title
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function CloneStructure() As clAbstractDataSerie
		  //  
		  //  Clone the structure current data serie (only implemented at typed subclasses)
		  //
		  //
		  //  Parameters
		  //  - 
		  //  
		  //  Returns:
		  //  - the new data serie
		  //
		  
		  
		  Raise New clDataException("Unimplemented method " + CurrentMethodName)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(NewColumnName as string, the_values() as variant)
		  //
		  // Creates a new column
		  // 
		  // Parameters:
		  // - NewColumnName: name of the new column
		  // - the_values: Values to add to the column
		  //
		  
		  self.Reset
		  
		  SerieName = NewColumnName
		  physical_table_link = Nil
		  
		  self.AddElements(the_values)
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(NewColumnName as string, paramarray the_values() as variant)
		  
		  //
		  // Creates a new column
		  // 
		  // Parameters:
		  // - NewColumnName: name of the new column
		  // - the_values: Values to add to the column
		  //
		  
		  self.Reset
		  
		  SerieName = NewColumnName
		  physical_table_link = Nil
		  
		  if the_values.LastIndex < 0 then return
		  
		  // Accepts a data serie as first parameter
		  if the_values(0) isa clAbstractDataSerie and the_values.LastIndex = 0 then
		    self.AddElements(clAbstractDataSerie(the_values(0)).GetElements)
		    
		  elseif the_values(0).IsArray and the_values.LastIndex = 0 then
		    var tmp() as variant = ExtractVariantArray(the_values(0))
		    
		    self.AddElements(tmp)
		    
		  else
		    self.AddElements(the_values)
		    
		  end if
		  
		  Return
		  
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub CopyElementsTo(target_data_serie as clAbstractDataSerie)
		  //  
		  //  Copy the elements of the current data serie to another data serie, the other data serie is cleared before copy
		  //.    if lower than low_value, element is replaced by low_value
		  //
		  //
		  //  Parameters
		  //  - the_target_data_serie: destination
		  //  
		  //  Returns:
		  //  
		  //
		  
		  
		  
		  target_data_serie.Reset()
		  target_data_serie. AddSourceToMetadata( self.name)
		  
		  for index as Integer = 0 to self.LastIndex
		    target_data_serie.AddElement(self.GetElement(index))
		    
		  next
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function CountDefined() As integer
		  // 
		  // Calculate the number of definted elemnts in the current column. 
		  // Note that if the underlying column is a number column or an integer colums, values are always defined but could be zero
		  //
		  //
		  // Parameters:
		  // (none)
		  //
		  //
		  // Returns:
		  // - count
		  //
		  
		  var limit As Integer = RowCount - 1
		  var i As Integer
		  
		  var n as integer
		  
		  For i = 0 To limit
		    if self.ElementIsDefined(i) then
		      n = n + 1
		      
		    end if
		    
		  Next
		  
		  return n
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function CountNonZero() As integer
		  // 
		  // Calculate the number of definted non zero elemnts in the current column. 
		  // Note that if the underlying column is a number column or an integer colums, values are always defined but could be zero
		  //
		  //
		  // Parameters:
		  // (none)
		  //
		  //
		  // Returns:
		  // - count
		  //
		  
		  var limit As Integer = RowCount - 1
		  var i As Integer
		  
		  var n as integer
		  
		  For i = 0 To limit
		    if self.ElementIsDefined(i) and self.GetElementAsNumber(i) <> 0 then
		      n = n + 1
		      
		    end if
		    
		  Next
		  
		  return n
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub debug_dump2()
		  
		  var tmp_item() As String
		  
		  System.DebugLog("----START SERIE " + Self.SerieName+" --------")
		  
		  
		  System.DebugLog(Join(tmp_item, ";"))
		  
		  For row As Integer = 0 To RowCount-1
		    var element As variant = GetElement(row)
		    var ok_convert As Boolean
		    tmp_item.RemoveAll
		    
		    tmp_item.Add(Str(row))
		    
		    ok_convert = False
		    
		    If element IsA clDataSerie Then
		      tmp_item.Add("Data serie: " + clDataSerie(element).FullName(true))
		      ok_convert = True
		      
		    Else
		      Try
		        tmp_item.Add(element.StringValue)
		        ok_convert = True
		        
		      Catch TypeMismatchException
		        
		        
		      End Try
		    End If
		    
		    
		    
		    System.DebugLog(Join(tmp_item, ";"))
		    
		  Next
		  
		  System.DebugLog("----END " + Self.SerieName+" --------")
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ElementIsDefined(ElementIndex As integer) As Boolean
		  return self.GetElement(ElementIndex) <> nil
		  
		End Function
	#tag EndMethod

	#tag DelegateDeclaration, Flags = &h0
		Delegate Function FilterColumnByRows(pRowIndex as integer, pRowCount as integer, pColumnName as string, the_cell_value as variant, pFunctionParameters() as variant) As Boolean
	#tag EndDelegateDeclaration

	#tag Method, Flags = &h0
		Function FindRowIndexForValue(the_find_value as Variant) As integer()
		  //
		  // returns row index of rows matching the value
		  //
		  var ret() As Integer
		  
		  For i As Integer = 0 To self.LastIndex
		    if self.GetElement(i) = the_find_value Then
		      ret.Add(i)
		      
		    End If
		    
		  Next
		  
		  Return ret
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function FullName(add_brackets as boolean = False) As string
		  //
		  // build the full name of the column, that is:
		  // if the column is linked to a table:  table_name.column_name
		  // if the column is not linked to table:  column_name
		  // Add square brackets around each element
		  //
		  // Parameters:
		  // - add_brackets : surroung element names with bracket if true
		  //
		  // Returns:
		  // request name
		  //
		  
		  var ret() as string
		  
		  // Extract table name
		  if self.physical_table_link <> nil then
		    if self.physical_table_link.value <> nil then
		      ret.add( clDataTable(self.physical_table_link.value).name)
		      
		    end if
		    
		  end if
		  
		  // Add column name
		  ret.add (self.name)
		  
		  
		  if add_brackets then
		    for i as integer = 0 to ret.LastIndex
		      ret(i) = "[" + ret(i).trim + "]"
		      
		    next
		    
		  end if
		  
		  return string.FromArray(ret, ".")
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetDefaultValue() As variant
		  //  
		  //  Return the default value defined for the data serie (only implemented at type specific subclasses)
		  //
		  //
		  //  Parameters
		  //  
		  //  Returns:
		  //  - the defined default value (variant)
		  //
		  
		  
		  Raise New clDataException("Unimplemented method " + CurrentMethodName)
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetElement(ElementIndex as integer) As Variant
		  //  
		  //  Returns the element at index (only implemented in type specific subclasses)
		  //
		  //  Parameters
		  //  - ElementIndex (integer) index of the element to be returned
		  //  
		  //  Returns:
		  //  - the selected element (variant)
		  //
		  
		  
		  Raise New clDataException("Unimplemented method " + CurrentMethodName)
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetElementAsBoolean(ElementIndex as integer) As boolean
		  //  
		  //  Returns the element at index as a string
		  //
		  //  Parameters
		  //  - ElementIndex (integer) index of the element to be returned
		  //  
		  //  Returns:
		  //  - the selected element (boolean)
		  //
		  // Note: this generic method is overloaded when the serie is natively using boolean
		  
		  var tmp_b As boolean
		  var tmp_v As variant
		  
		  tmp_v = GetElement(ElementIndex)
		  
		  Try 
		    tmp_b = tmp_v.BooleanValue
		    
		  Catch TypeMismatchException
		    tmp_b = False
		    self.AddErrorMessage( CurrentMethodName, ErrMsgCannotConvertElement, Str(ElementIndex) , "boolean")
		    
		  End Try
		  
		  Return tmp_b
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetElementAsCurrency(ElementIndex as integer) As currency
		  //  
		  //  Returns the element at index as a Currency
		  //
		  //  Parameters
		  //  - ElementIndex (integer) index of the element to be returned
		  //  
		  //  Returns:
		  //  - the selected element (currency)
		  //
		  // Note: this generic method is overloaded when the serie is natively using double
		  
		  
		  var tmp_d As Currency
		  var tmp_v As variant
		  
		  tmp_v = GetElement(ElementIndex)
		  
		  #pragma BreakOnExceptions false
		  
		  Try 
		    // some test cases will cause an exception here, this is expected
		    tmp_d = tmp_v.CurrencyValue
		    
		  Catch TypeMismatchException
		    tmp_d = 0
		    self.AddErrorMessage( CurrentMethodName, ErrMsgCannotConvertElement, Str(ElementIndex) , "number")
		    
		  End Try
		  
		  #pragma BreakOnExceptions Default
		  
		  Return tmp_d
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetElementAsDataSerie(ElementIndex as integer) As clDataSerie
		  //  
		  //  Returns the element at index as a double
		  //
		  //  Parameters
		  //  - ElementIndex (integer) index of the element to be returned
		  //  
		  //  Returns:
		  //  - the selected element as a data serie
		  //
		  
		  var tmp_v As clDataSerie
		  
		  Try 
		    tmp_v = GetElement(ElementIndex)
		    
		  Catch TypeMismatchException
		    tmp_v = Nil
		    self.AddErrorMessage( CurrentMethodName, ErrMsgCannotConvertElement, Str(ElementIndex) , "clDataSerie()")
		    
		  End Try
		  
		  Return tmp_v
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetElementAsInteger(ElementIndex as integer) As integer
		  //  
		  //  Returns the element at index as a double
		  //
		  //  Parameters
		  //  - ElementIndex (integer) index of the element to be returned
		  //  
		  //  Returns:
		  //  - the selected element (integer)
		  //
		  // Note: this generic method is overloaded when the serie is natively using integer
		  //
		  
		  var tmp_d As integer
		  var tmp_v As variant
		  
		  tmp_v = GetElement(ElementIndex)
		  
		  Try 
		    tmp_d = tmp_v.IntegerValue
		    
		  Catch TypeMismatchException
		    tmp_d = 0
		    self.AddErrorMessage( CurrentMethodName, ErrMsgCannotConvertElement, Str(ElementIndex) , "integer")
		    
		  End Try
		  
		  Return tmp_d
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetElementAsNumber(ElementIndex as integer) As double
		  //  
		  //  Returns the element at index as a double
		  //
		  //  Parameters
		  //  - ElementIndex (integer) index of the element to be returned
		  //  
		  //  Returns:
		  //  - the selected element (double)
		  //
		  // Note: this generic method is overloaded when the serie is natively using double
		  
		  
		  var tmp_d As Double
		  var tmp_v As variant
		  
		  tmp_v = GetElement(ElementIndex)
		  
		  #pragma BreakOnExceptions false
		  
		  Try 
		    // some test cases will cause an exception here, this is expected
		    tmp_d = tmp_v.DoubleValue
		    
		  Catch TypeMismatchException
		    tmp_d = 0
		    self.AddErrorMessage( CurrentMethodName, ErrMsgCannotConvertElement, Str(ElementIndex) , "number")
		    
		  End Try
		  
		  #pragma BreakOnExceptions Default
		  
		  Return tmp_d
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetElementAsString(ElementIndex as integer) As string
		  //  
		  //  Returns the element at index as a string
		  //
		  //  Parameters
		  //  - ElementIndex (integer) index of the element to be returned
		  //  
		  //  Returns:
		  //  - the selected element (string)
		  //
		  // Note: this generic method is overloaded when the serie is natively using string
		  
		  var tmp_s As String
		  var tmp_v As variant
		  
		  tmp_v = GetElement(ElementIndex)
		  
		  Try 
		    tmp_s = tmp_v.StringValue
		    
		  Catch TypeMismatchException
		    tmp_s = ""
		    self.AddErrorMessage( CurrentMethodName, ErrMsgCannotConvertElement, Str(ElementIndex) , "string")
		    
		  End Try
		  
		  Return tmp_s
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetElements() As Variant()
		  //  
		  //  Returns all the elements of the data serie as variant
		  //
		  //  Parameters
		  //  - none
		  //  
		  //  Returns:
		  //  - an array of variant with all elements
		  //
		  
		  var v() as variant
		  for i as integer = 0 to self.LastIndex
		    v.Add(self.GetElement(i))
		    
		  next
		  
		  return v
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetLastErrorMessage() As string
		  return self.LastErrorMessage
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetLinkedTableName() As string
		  //
		  // Returns the name of table owning the column
		  //
		  // Parameters
		  // (none)
		  //
		  // Returns
		  // - name of the table (string)
		  //
		  
		  
		  if self.physical_table_link = nil then 
		    return ""
		    
		  elseif self.physical_table_link = nil then
		    return ""
		    
		  else
		    return clDataTable(self.physical_table_link.Value).Name
		    
		  end if
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetMetadata() As clMetaData
		  //  
		  //  Returns the meta data dictionary of the current data serie
		  //
		  //  Parameters
		  //  
		  //  Returns:
		  //  - the meta data dictionary  (dictionary)
		  //
		  
		  Return self.Metadata
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetProperties() As clDataSerieProperties
		  var p as new clDataSerieProperties
		  
		  p.SerieTitle = self.serie_title
		  p.DataType = self.GetType
		  
		  p.MetaData = self.Metadata.Clone
		  
		  p.Aliases.RemoveAll
		  for each s as string in self.Aliases
		    p.Aliases.Add(s)
		    
		  next
		  
		  return p
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetType() As string
		  
		  return  clDataType.ConvertSerieTypeToCommonType(self)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function HasAlias(alias as string) As Boolean
		  //  
		  //  Check if the current data serie has the specified the alias
		  //
		  //  Parameters
		  //  - alias (string) to be checked
		  //  
		  //  Returns:
		  //  - True if the current data serie has the alias passed as parameter
		  //
		  
		  
		  return aliases.IndexOf(alias) >= 0
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsLinkedToTable(ExpectedLink as clDataTable = nil) As Boolean
		  //  
		  //  Checks if the current data serie is linked to a table
		  //
		  //  Parameters
		  //  
		  //  Returns:
		  //  - True if the current data serie is linked to a table
		  //
		  
		  if physical_table_link <> nil then
		    if physical_table_link.value = nil then
		      physical_table_link = nil
		      
		    end if
		    
		  end if
		  
		  
		  if ExpectedLink = nil then
		    Return physical_table_link <> Nil
		    
		  elseif physical_table_link = nil then
		    return false
		    
		  else
		    return physical_table_link.value = ExpectedLink
		    
		  end if
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Iterator() As Iterator
		  // Part of the Iterable interface.
		  
		  return new clDataSerieIterator(self)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function LastIndex() As integer
		  
		  Raise New clDataException("Unimplemented method " + CurrentMethodName)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Rename(NewColumnName as string)
		  //  
		  //  use setter of computed property
		  //  
		  self.AddMetadata("transformation", "rename from " + self.name + " to " + NewColumnName)
		  
		  Self.name = NewColumnName
		  
		  
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Rename(NewColumnName as string) As clAbstractDataSerie
		  //  
		  //  use setter of computed property
		  //  
		  
		  self.AddMetadata("transformation", "rename from " + self.name + " to " + NewColumnName)
		  
		  Self.name = NewColumnName
		  
		  return self
		  
		  
		End Function
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
		Sub Reset()
		  //  
		  //  Reset the data serie. Type specific subclasses will clear all values.
		  //
		  //  Parameters
		  //  
		  //  Returns:
		  //
		  
		  self.ResetMetadata
		  self.ResetElements
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ResetElements()
		  //  
		  //  Clear the list of values (implemented at type specific subclasses)
		  //
		  //  Parameters
		  //  - ElementIndex (integer) index of the element to be returned
		  //  
		  //  Returns:
		  //  - the selected element (double)
		  //
		  
		  Raise New clDataException("Unimplemented method " + CurrentMethodName)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ResetMetadata()
		  //  
		  //  Resets the meta data
		  //
		  //  Parameters
		  //  
		  //  Returns:
		  //
		  
		  self.Metadata = new clMetadata
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function RoundValues(nb_decimal as integer = 0) As integer
		  //  
		  //  Round the values of the current data serie against a high_value:
		  //.    
		  //
		  //  Parameters
		  // - number of digits after decimal mark
		  //  
		  //  Returns:
		  //  - the number of values updated
		  //
		  
		  
		  var last_index as integer = self.RowCount
		  var count_changes as integer = 0
		  
		  var corr as double = 10 ^ max(nb_decimal,0)
		  
		  for index as integer = 0 to last_index
		    var current_value as variant = self.GetElement(index)
		    var new_value as double = round(current_value * corr) / corr
		    
		    if current_value <> new_value then
		      self.SetElement(index, new_value)
		      count_changes = count_changes + 1
		      
		    end if
		    
		  next
		  
		  self.AddMetadata("transformation", "round values to "+str(nb_decimal) + " digit(s).")
		  
		  Return count_changes
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function RowCount() As integer
		  
		  Raise New clDataException("Unimplemented method " + CurrentMethodName)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SetDefaultValue(v as Variant)
		  Raise New clDataException("Unimplemented method " + CurrentMethodName)
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SetElement(ElementIndex as integer, the_item as Variant)
		  
		  Raise New clDataException("Unimplemented method " + CurrentMethodName)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SetElements(the_values as clAbstractDataSerie)
		  
		  for i as integer = 0 to the_values.LastIndex
		    self.SetElement(i, the_values.GetElement(i))
		    
		  next
		  
		  self.AddMetadata("transformation", "Set all elements to values from data serie " + the_values.name)
		  
		  return
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SetElements(the_values() as variant)
		  
		  for i as integer = 0 to the_values.LastIndex
		    self.SetElement(i, the_values(i))
		    
		  next
		  
		  self.AddMetadata("transformation", "Set  elements to list of variants")
		  
		  return
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SetElements(the_value as variant)
		  
		  for i as integer = 0 to self.LastIndex
		    self.SetElement(i, the_value)
		    
		  next
		  
		  self.AddMetadata("transformation", "Set all elements to " +str(the_value))
		  
		  return
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SetLength(the_length as integer)
		  var v as variant = self.GetDefaultValue
		  
		  self.SetLength(the_length, v)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SetLength(the_length as integer, DefaultValue as variant)
		  Raise New clDataException("Unimplemented method " + CurrentMethodName)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SetLinkToTable(the_table as clDataTable)
		  
		  if the_table = nil then
		    physical_table_link = nil
		    
		  elseIf physical_table_link = Nil Then
		    physical_table_link = new Weakref(the_table)
		    
		  Else
		    Raise New clDataException("Cannot redefine link to table for a serie")
		    
		  End If
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SetProperties(properties as clDataSerieProperties)
		  
		  var p as  clDataSerieProperties = properties
		  
		  self.serie_title = p.SerieTitle
		  
		  self.Aliases.RemoveAll
		  for each s as string in p.Aliases
		    self.Aliases.Add(s)
		    
		  next
		  
		  self.Metadata = p.MetaData.Clone
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function StandardDeviation(is_population as boolean = False) As double
		  // 
		  // Calculate the standard deviation of the current column. Undefined values are ignored
		  // Note that if the underlying column is a number column or an integer colums, values are always defined but could be zero
		  //
		  //
		  // Parameters:
		  // (none)
		  //
		  //
		  // Returns:
		  // - value of standard deviation 
		  //
		  
		  var limit As Integer = RowCount - 1
		  var i As Integer
		  
		  var s1 As Double
		  var s2 as double
		  
		  var tmp as Double
		  
		  var n as integer
		  
		  For i = 0 To limit
		    if self.ElementIsDefined(i) then
		      tmp = GetElementAsNumber(i)
		      s1 = s1 + tmp
		      s2 = s2 + tmp * tmp
		      
		      n = n + 1
		      
		    end if
		    
		  Next
		  
		  if n < 2 then return 0
		  
		  var m as double = s1/n
		  
		  if is_population then
		    return Sqrt((n * m * m - 2 * m *s1 + s2)  / (n))
		    
		  else
		    return Sqrt((n * m * m - 2 * m *s1 + s2)  / (n-1))
		    
		  end if
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function StandardDeviationNonZero(is_population as boolean = False) As double
		  // 
		  // Calculate the standard deviation of the non zero values in the current column. Undefined values are ignored
		  // Note that if the underlying column is a number column or an integer colums, values are always defined but could be zero
		  //
		  //
		  // Parameters:
		  // (none)
		  //
		  //
		  // Returns:
		  // - value of standard deviation 
		  //
		  
		  var limit As Integer = RowCount - 1
		  var i As Integer
		  
		  var s1 As Double
		  var s2 as double
		  
		  var tmp as Double
		  
		  var n as integer
		  
		  For i = 0 To limit
		    if self.ElementIsDefined(i) then
		      tmp = GetElementAsNumber(i)
		      if tmp <> 0 then
		        s1 = s1 + tmp
		        s2 = s2 + tmp * tmp
		        
		        n = n + 1
		        
		      end if
		      
		    end if
		    
		  Next
		  
		  if n < 2 then return 0
		  
		  var m as double = s1/n
		  
		  if is_population then
		    return Sqrt((n * m * m - 2 * m *s1 + s2)  / (n))
		    
		  else
		    return Sqrt((n * m * m - 2 * m *s1 + s2)  / (n-1))
		    
		  end if
		  
		End Function
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
		Function Sum() As double
		  // 
		  // Calculate the sum of the elements in the current column. 
		  //
		  //
		  // Parameters:
		  // (none)
		  //
		  //
		  // Returns:
		  // - sum of elements
		  //
		  
		  
		  var limit As Integer = RowCount - 1
		  var i As Integer
		  
		  var s As Double
		  For i = 0 To limit
		    s = s + GetElementAsNumber(i)
		    
		  Next
		  
		  return s
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ToJSON() As JSONItem
		  // Part of the itf_json_able interface.
		  
		  var js_list As New JSONItem
		  var js_return As New JSONItem
		  
		  For row As Integer = 0 To RowCount-1
		    var element As variant = GetElement(row)
		    
		    Try
		      js_list.Add(element.StringValue)
		      
		    Catch TypeMismatchExceptionvar  
		      js_list.Add("Cannot convert")
		      
		    End Try
		    
		  Next
		  
		  js_return.Value(name) = js_list
		  
		  Return js_return
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Unique() As variant()
		  var dct as new Dictionary
		  var results() as variant
		  
		  for row as integer = 0 to LastIndex
		    var tmp as variant = self.GetElement(row)
		    
		    if dct.HasKey(tmp) then
		      dct.value(tmp)  = dct.Value(tmp) + 1
		      
		    else
		      dct.value(tmp) = 1
		      results.Add(tmp)
		      
		    end if
		    
		    
		  next
		  
		  return results
		  
		  
		  
		  
		End Function
	#tag EndMethod


	#tag Note, Name = Description
		Defines an abstract data serie, provides common functions but it has no storage
		Used as base class for all DataSerie
		
		The following child classes are defined:
		
		- clDataSerie: stores elements as variant
		- clCompressedDataSerie: stores elements as variant, but internally elements are stored as an integer, an index in a value dictionary.
		- clNumberDataSerie: stores elements as double
		- clIntegerDataSerie: stores elements as integer
		- clBooleanDataSerie: stores elements as Boolean
		- clDateDataSerie: stores elements as timestamp
		- clDataSerieRowID: used to assign a unique row id to each row, starting at 0. Used by clDataTable to handle the row index
		
		
		Only one dataTable can 'own'  a dataSerie, but the series can be shared by multiple tables.
		
		Available on: https://github.com/slo1958/sl-xj-lib-data.git
		
	#tag EndNote

	#tag Note, Name = License
		MIT License
		
		sl-xj-lib-data Data Handling Library
		Copyright (c) 2021-2025 slo1958
		
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

	#tag Note, Name = Methods to be defined in child classes
		METHODS TO BE DEFINED IN CHILD CLASSES
		
		append_element
		
		clone 
		
		ApplyFilterFunction
		
		get_element
		
		remove_all_elements
		
		SetElement
		
		SetLength
		
		LastIndex
	#tag EndNote


	#tag Property, Flags = &h21
		Private Aliases() As String
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  if self.serie_title.len() = 0 then
			    Return SerieName
			    
			  else
			    return serie_title
			    
			  end if
			  
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  Self.serie_title = value.Trim
			  
			  
			End Set
		#tag EndSetter
		DisplayTitle As string
	#tag EndComputedProperty

	#tag Property, Flags = &h1
		Protected LastErrorMessage As String
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected Metadata As clMetadata
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return SerieName
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If value.Trim.Len = 0 Then
			    Self.SerieName = "noname"
			    
			  Else
			    Self.SerieName = value.Trim
			    
			  End If
			  
			End Set
		#tag EndSetter
		name As string
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private physical_table_link As Weakref
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected SerieName As string
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected serie_title As string
	#tag EndProperty


	#tag Constant, Name = ErrMsgAliasAlreadyDefined, Type = String, Dynamic = False, Default = \"Alias %0 already defined ", Scope = Public
	#tag EndConstant

	#tag Constant, Name = ErrMsgAliasUsedAsName, Type = String, Dynamic = False, Default = \"Alias %0 already used as name", Scope = Public
	#tag EndConstant

	#tag Constant, Name = ErrMsgCannotConvert, Type = String, Dynamic = False, Default = \"Cannot convert %0 to %1", Scope = Public
	#tag EndConstant

	#tag Constant, Name = ErrMsgCannotConvertElement, Type = String, Dynamic = False, Default = \"Cannot convert element %0 to %1", Scope = Public
	#tag EndConstant

	#tag Constant, Name = ErrMsgIndexOutOfbounds, Type = String, Dynamic = False, Default = \"Element index %0 is out of range in column [%1]", Scope = Public
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
			Name="DisplayTitle"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="string"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
