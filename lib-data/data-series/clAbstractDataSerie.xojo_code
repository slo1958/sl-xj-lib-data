#tag Class
Protected Class clAbstractDataSerie
Implements Xojo.Core.Iterable,itf_json_able
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
		    self.AddErrorMessage("Alias " + alias + " already used as name.")
		    return 
		    
		  end if
		  
		  
		  if aliases.IndexOf(alias) < 0 then
		    aliases.Add(alias)
		    Return
		  end if
		  
		  self.AddErrorMessage("Alias " + alias + " already defined.")
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AddElement(the_item as Variant)
		  //  
		  //  Add an element to the data serie
		  //  Implemented in type specific subclass
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
		  //  
		  
		  for each item as variant in the_items
		    self.AddElement(item)
		    
		  next
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AddErrorMessage(msg as string)
		  //  
		  //  Add an error message
		  //  
		  //  Parameters
		  //  - error message (string) 
		  //  
		  //  Returns:
		  //  
		  
		  
		  self.last_error_message = msg
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
		  
		  meta_dict.AddMetadata(type, message)
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
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Average() As double
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
		Function Clone() As clAbstractDataSerie
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
		  target.display_title = self.display_title
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
		Sub Constructor(the_label as string, the_values() as variant)
		  
		  self.Reset
		  
		  serie_name = the_label
		  physical_table_link = Nil
		  
		  For i As Integer = 0 To the_values.LastIndex
		    self.AddElement(the_values(i))
		    
		  Next
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(the_label as string, paramarray the_values() as variant)
		  
		  self.Reset
		  
		  serie_name = the_label
		  physical_table_link = Nil
		  
		  if the_values.LastIndex < 0 then return
		  
		  if the_values(0).IsArray and the_values.LastIndex = 0 then
		    var tmp() as variant = MakeVariantArray(the_values(0))
		    
		    For i As Integer = 0 To tmp.LastIndex
		      self.AddElement(tmp(i))
		      
		    Next
		    
		    return
		    
		  end if
		  
		  
		  For i As Integer = 0 To the_values.LastIndex
		    self.AddElement(the_values(i))
		    
		  Next
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub CopyTo(target_data_serie as clAbstractDataSerie)
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
		  target_data_serie.AddMetadata("source", self.name)
		  
		  for index as Integer = 0 to self.LastIndex
		    target_data_serie.AddElement(self.GetElement(index))
		    
		  next
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Count() As double
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
		Function CountNonZero() As double
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
		Sub debug_dump()
		  
		  var tmp_item() As String
		  
		  System.DebugLog("----START SERIE " + Self.serie_name+" --------")
		  
		  
		  System.DebugLog(Join(tmp_item, ";"))
		  
		  For row As Integer = 0 To RowCount-1
		    var element As variant = GetElement(row)
		    var ok_convert As Boolean
		    redim tmp_item(-1)
		    
		    tmp_item.Append(Str(row))
		    
		    ok_convert = False
		    
		    If element IsA clDataSerie Then
		      tmp_item.Append(itf_json_able(element).ToJSON.ToString)
		      ok_convert = True
		      
		    Else
		      Try
		        tmp_item.Append(element.StringValue)
		        ok_convert = True
		        
		      Catch TypeMismatchException
		        
		        
		      End Try
		    End If
		    
		    If Not ok_convert Then
		      If element IsA itf_json_able Then
		        tmp_item.Append(itf_json_able(element).ToJSON.ToString)
		        ok_convert = True
		      End If
		      
		    End If
		    
		    If Not ok_convert Then
		      tmp_item.Append("")
		      
		    End If
		    
		    System.DebugLog(Join(tmp_item, ";"))
		    
		  Next
		  
		  System.DebugLog("----END " + Self.serie_name+" --------")
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ElementIsDefined(the_element_index As integer) As Boolean
		  return self.GetElement(the_element_index) <> nil
		  
		End Function
	#tag EndMethod

	#tag DelegateDeclaration, Flags = &h0
		Delegate Function FilterColumnByRows(the_row_index as integer, the_RowCount as integer, the_column_name as string, the_cell_value as variant, paramarray function_param as variant) As Boolean
	#tag EndDelegateDeclaration

	#tag Method, Flags = &h0
		Function FilterWithFunction(the_filter_function as FilterColumnByRows, paramarray function_param as variant) As variant()
		  var return_boolean() As Variant
		  
		  Return return_boolean
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function FindRowIndexForValue(the_find_value as Variant) As integer()
		  //
		  // returns row index of rows matching the value
		  //
		  var ret() As Integer
		  
		  For i As Integer = 0 To self.LastIndex
		    if self.GetElement(i) = the_find_value Then
		      ret.Append(i)
		      
		    End If
		    
		  Next
		  
		  Return ret
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function FullName(add_brackets as boolean = False) As string
		  if self.physical_table_link = nil then
		    return self.name
		    
		  elseif add_brackets then
		    return "[" + self.physical_table_link.name + "]" + "." + "[" + self.name + "]"  
		    
		  else
		    return self.physical_table_link.name + "." + self.name
		    
		  end if
		  
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
		Function GetElement(the_element_index as integer) As Variant
		  //  
		  //  Returns the element at index (only implemented in type specific subclasses)
		  //
		  //  Parameters
		  //  - the_element_index (integer) index of the element to be returned
		  //  
		  //  Returns:
		  //  - the selected element (variant)
		  //
		  
		  
		  Raise New clDataException("Unimplemented method " + CurrentMethodName)
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetElementAsDataSerie(the_element_index as integer) As clDataSerie
		  
		  var tmp_v As clDataSerie
		  
		  Try 
		    tmp_v = GetElement(the_element_index)
		    
		  Catch TypeMismatchException
		    tmp_v = Nil
		    self.AddErrorMessage("Cannot convert element "+Str(the_element_index) + " to string.")
		    
		  End Try
		  
		  Return tmp_v
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetElementAsInteger(the_element_index as integer) As integer
		  //  
		  //  Returns the element at index as a double
		  //
		  //  Parameters
		  //  - the_element_index (integer) index of the element to be returned
		  //  
		  //  Returns:
		  //  - the selected element (integer)
		  //
		  
		  // Note: this generic method is overloaded when the serie is natively using integer
		  
		  var tmp_d As integer
		  var tmp_v As variant
		  
		  tmp_v = GetElement(the_element_index)
		  
		  Try 
		    tmp_d = tmp_v.IntegerValue
		    
		  Catch TypeMismatchException
		    tmp_d = 0
		    self.AddErrorMessage( "Cannot convert element "+Str(the_element_index) + " to integer.")
		    
		  End Try
		  
		  Return tmp_d
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetElementAsNumber(the_element_index as integer) As double
		  //  
		  //  Returns the element at index as a double
		  //
		  //  Parameters
		  //  - the_element_index (integer) index of the element to be returned
		  //  
		  //  Returns:
		  //  - the selected element (double)
		  //
		  
		  // Note: this generic method is overloaded when the serie is natively using double
		  
		  
		  var tmp_d As Double
		  var tmp_v As variant
		  
		  tmp_v = GetElement(the_element_index)
		  
		  Try 
		    // some test cases will cause an exception here, this is expected
		    tmp_d = tmp_v.DoubleValue
		    
		  Catch TypeMismatchException
		    tmp_d = 0
		    self.AddErrorMessage( "Cannot convert element "+Str(the_element_index) + " to number.")
		    
		  End Try
		  
		  Return tmp_d
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetElementAsString(the_element_index as integer) As string
		  //  
		  //  Returns the element at index as a string
		  //
		  //  Parameters
		  //  - the_element_index (integer) index of the element to be returned
		  //  
		  //  Returns:
		  //  - the selected element (string)
		  //
		  
		  // Note: this generic method is overloaded when the serie is natively using string
		  
		  var tmp_s As String
		  var tmp_v As variant
		  
		  tmp_v = GetElement(the_element_index)
		  
		  Try 
		    tmp_s = tmp_v.StringValue
		    
		  Catch TypeMismatchException
		    tmp_s = ""
		    self.AddErrorMessage( "Cannot convert element "+Str(the_element_index) + " to string.")
		    
		  End Try
		  
		  Return tmp_s
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetIterator() As Xojo.Core.Iterator
		  // Part of the Xojo.Core.Iterable interface.
		  
		  var tmp_serie_iterator As New clDataSerieIterator(self)
		  
		  Return tmp_serie_iterator 
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetLastErrorMessage() As string
		  return self.last_error_message
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
		  
		  Return self.meta_dict
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetType() As string
		  
		  return  clDataType.TranslateFromSerie(self)
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
		Function IsLinkedToTable() As Boolean
		  //  
		  //  Checks if the current data serie is linked to a table
		  //
		  //  Parameters
		  //  
		  //  Returns:
		  //  - True if the current data serie is linked to a table
		  //
		  
		  Return physical_table_link <> Nil
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function LastIndex() As integer
		  Raise New clDataException("Unimplemented method " + CurrentMethodName)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Rename(the_new_name as string)
		  //  
		  //  use setter of computed property
		  //  
		  Self.name = the_new_name
		  
		  
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Rename(the_new_name as string) As clAbstractDataSerie
		  //  
		  //  use setter of computed property
		  //  
		  Self.name = the_new_name
		  
		  return self
		  
		  
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
		  //  - the_element_index (integer) index of the element to be returned
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
		  
		  self.meta_dict = new clMetadata
		  
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
		  
		  Return count_changes
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function RowCount() As integer
		  return self.LastIndex+1
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SetDefaultValue(v as Variant)
		  Raise New clDataException("Unimplemented method " + CurrentMethodName)
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SetElement(the_element_index as integer, the_item as Variant)
		  Raise New clDataException("Unimplemented method " + CurrentMethodName)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SetElements(the_values() as variant)
		  for i as integer = 0 to the_values.LastIndex
		    self.SetElement(i, the_values(i))
		    
		  next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SetLength(the_length as integer)
		  var v as variant = self.GetDefaultValue
		  
		  self.SetLength(the_length, v)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SetLength(the_length as integer, default_value as variant)
		  Raise New clDataException("Unimplemented method " + CurrentMethodName)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SetLinkToTable(the_table as clDataTable)
		  
		  If physical_table_link = Nil Then
		    physical_table_link = the_table
		    
		  Else
		    Raise New clDataException("Cannot redefine link to table for a serie")
		    
		  End If
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function StandardDeviation(is_population as boolean = False) As double
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

	#tag Method, Flags = &h0
		Function Sum() As double
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
		    
		    If element IsA itf_json_able Then
		      js_list.append(itf_json_able(element).ToJSON)
		      
		    Else
		      Try
		        js_list.Append(element.StringValue)
		        
		      Catch TypeMismatchExceptionvar  
		        js_list.Append("Cannot convert")
		        
		      End Try
		      
		    End If
		    
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
		
		
	#tag EndNote

	#tag Note, Name = License
		MIT License
		
		sl-xj-lib-data Data Handling Library
		Copyright (c) 2021-2023 slo1958
		
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
		
		FilterWithFunction
		
		get_element
		
		remove_all_elements
		
		SetElement
		
		SetLength
		
		LastIndex
	#tag EndNote


	#tag Property, Flags = &h0
		aliases() As String
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  if self.serie_title.len() = 0 then
			    Return serie_name
			    
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
		display_title As string
	#tag EndComputedProperty

	#tag Property, Flags = &h1
		Protected last_error_message As String
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected meta_dict As clMetadata
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return serie_name
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If value.Trim.Len = 0 Then
			    Self.serie_name = "noname"
			    
			  Else
			    Self.serie_name = value.Trim
			    
			  End If
			  
			End Set
		#tag EndSetter
		name As string
	#tag EndComputedProperty

	#tag Property, Flags = &h1
		Protected physical_table_link As clDataTable
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected serie_name As string
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected serie_title As string
	#tag EndProperty


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
			Name="display_title"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="string"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
