#tag Class
Protected Class clAbstractDataSerie
Implements Xojo.Core.Iterable,itf_json_able
	#tag Method, Flags = &h0
		Sub Add_alias(alias as string)
		  //  
		  //  Add an alias to a column. Record an error if the alias is matching the name of the column or if the name is already defined.
		  //  
		  //  Parameters
		  //  - alias (string) the new alias
		  //  
		  //  Returns:
		  //  
		  
		  
		  if alias = name then
		    self.add_error_message("Alias " + alias + " already used as name.")
		    return 
		    
		  end if
		  
		  
		  if aliases.IndexOf(alias) < 0 then
		    aliases.Add(alias)
		    Return
		  end if
		  
		  self.add_error_message("Alias " + alias + " already defined.")
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub add_error_message(msg as string)
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
		Sub add_meta_data(type as string, message as string)
		  //  
		  //  Add meta data
		  //  
		  //  Parameters
		  // - type (string) the key for the meta data
		  //  - message (string) the associated message
		  //  
		  //  Returns:
		  //  
		  
		  meta_dict.add_meta_data(type, message)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub append_element(the_item as Variant)
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
		Sub append_serie(the_serie as clAbstractDataSerie)
		  //  
		  //  Add all elements of a data serie to the current data serie
		  //
		  //  Parameters
		  //  - the_serie (data serie) 
		  //  
		  //  Returns:
		  //  
		  
		  dim tmp_source as clAbstractDataSerie = the_serie
		  
		  For row_num As Integer = 0 To tmp_source.row_count-1
		    self.append_element(tmp_source.get_element(row_num))
		    
		  Next
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub append_to(target_data_serie as clAbstractDataSerie)
		  //  
		  //  Add all elements of the current data serie to  another data serie
		  //
		  //  Parameters
		  //  - target_data_serie (data serie) to which elements are added
		  //  
		  //  Returns:
		  //  
		  
		  
		  for index as Integer = 0 to self.upper_bound
		    target_data_serie.append_element(self.get_element(index))
		    
		  next
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub clear_aliases()
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
		Function clipped_by_range(low_value as variant, high_value as variant) As clAbstractDataSerie
		  //  
		  //  Create a new data_serie containing elements of the current data serie clipped to range
		  //
		  //  Parameters
		  //  - low_value (variant) lower bound
		  // - high_value (variant) upper bound
		  //  
		  //  Returns:
		  //  - the new data serie
		  
		  dim new_col as clAbstractDataSerie = self.clone()
		  
		  new_col.rename("clip " + self.name)
		  
		  call new_col.clip_range(low_value, high_value)
		  
		  return new_col
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function clip_high(high_value as variant) As integer
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
		  
		  
		  dim last_index as integer = self.row_count
		  dim count_changes as integer = 0
		  
		  for index as integer = 0 to last_index
		    dim tmp as variant = self.get_element(index)
		    
		    if  tmp > high_value then
		      self.set_element(index, high_value)
		      count_changes = count_changes + 1
		      
		    end if
		    
		  next
		  
		  Return count_changes
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function clip_low(low_value as Variant) As integer
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
		  
		  
		  dim last_index as integer = self.row_count
		  dim count_changes as integer = 0
		  
		  for index as integer = 0 to last_index
		    dim tmp as variant = self.get_element(index)
		    
		    if low_value > tmp then
		      self.set_element(index, low_value)
		      count_changes = count_changes + 1
		      
		    end if
		    
		  next
		  
		  Return count_changes
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function clip_range(low_value as variant, high_value as variant) As integer
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
		  
		  dim last_index as integer = self.row_count
		  dim count_changes as integer = 0
		  
		  for index as integer = 0 to last_index
		    dim tmp as variant = self.get_element(index)
		    
		    if low_value > tmp then
		      self.set_element(index, low_value)
		      count_changes = count_changes + 1
		      
		    elseif  tmp > high_value then
		      self.set_element(index, high_value)
		      count_changes = count_changes + 1
		      
		    end if
		    
		  next
		  
		  Return count_changes
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function clone() As clAbstractDataSerie
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

	#tag Method, Flags = &h0
		Sub Constructor(the_label as string, paramarray the_values() as variant)
		  
		  self.reset
		  
		  serie_name = the_label
		  physical_table_link = Nil
		  
		  For i As Integer = 0 To the_values.Ubound
		    self.append_element(the_values(i))
		    
		  Next
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(the_label as string, the_values() as variant)
		  
		  self.reset
		  
		  serie_name = the_label
		  physical_table_link = Nil
		  
		  For i As Integer = 0 To the_values.Ubound
		    self.append_element(the_values(i))
		    
		  Next
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub copy_to(target_data_serie as clAbstractDataSerie)
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
		  
		  
		  
		  target_data_serie.reset()
		  target_data_serie.add_meta_data("source", self.name)
		  
		  for index as Integer = 0 to self.upper_bound
		    target_data_serie.append_element(self.get_element(index))
		    
		  next
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub debug_dump()
		  
		  Dim tmp_item() As String
		  
		  System.DebugLog("----START SERIE " + Self.serie_name+" --------")
		  
		  
		  System.DebugLog(Join(tmp_item, ";"))
		  
		  For row As Integer = 0 To row_count-1
		    Dim element As variant = get_element(row)
		    Dim ok_convert As Boolean
		    Redim tmp_item(-1)
		    
		    tmp_item.Append(Str(row))
		    
		    ok_convert = False
		    
		    If element IsA clDataSerie Then
		      tmp_item.Append(itf_json_able(element).to_json.ToString)
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
		        tmp_item.Append(itf_json_able(element).to_json.ToString)
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
		Function filter_apply_function(the_filter_function as filter_column, paramarray function_param as variant) As variant()
		  Dim return_boolean() As Variant
		  
		  Return return_boolean
		  
		End Function
	#tag EndMethod

	#tag DelegateDeclaration, Flags = &h0
		Delegate Function filter_column(the_row_index as integer, the_row_count as integer, the_column_name as string, the_cell_value as variant, paramarray function_param as variant) As Boolean
	#tag EndDelegateDeclaration

	#tag Method, Flags = &h0
		Function find_row_index_for_value(the_find_value as Variant) As integer()
		  //
		  // returns row index of rows matching the value
		  //
		  Dim ret() As Integer
		  
		  For i As Integer = 0 To self.upper_bound
		    if self.get_element(i) = the_find_value Then
		      ret.Append(i)
		      
		    End If
		    
		  Next
		  
		  Return ret
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetIterator() As Xojo.Core.Iterator
		  // Part of the Xojo.Core.Iterable interface.
		  
		  Dim tmp_serie_iterator As New clDataSerieIterator(self)
		  
		  Return tmp_serie_iterator 
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function get_default_value() As variant
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
		Function get_element(the_element_index as integer) As Variant
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
		Function get_element_as_data_serie(the_element_index as integer) As clDataSerie
		  
		  Dim tmp_v As clDataSerie
		  
		  Try 
		    tmp_v = get_element(the_element_index)
		    
		  Catch TypeMismatchException
		    tmp_v = Nil
		    self.add_error_message("Cannot convert element "+Str(the_element_index) + " to string.")
		    
		  End Try
		  
		  Return tmp_v
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function get_element_as_integer(the_element_index as integer) As integer
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
		  
		  Dim tmp_d As integer
		  Dim tmp_v As variant
		  
		  tmp_v = get_element(the_element_index)
		  
		  Try 
		    tmp_d = tmp_v.IntegerValue
		    
		  Catch TypeMismatchException
		    tmp_d = 0
		    self.add_error_message( "Cannot convert element "+Str(the_element_index) + " to integer.")
		    
		  End Try
		  
		  Return tmp_d
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function get_element_as_number(the_element_index as integer) As double
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
		  
		  
		  Dim tmp_d As Double
		  Dim tmp_v As variant
		  
		  tmp_v = get_element(the_element_index)
		  
		  Try 
		    tmp_d = tmp_v.DoubleValue
		    
		  Catch TypeMismatchException
		    tmp_d = 0
		    self.add_error_message( "Cannot convert element "+Str(the_element_index) + " to number.")
		    
		  End Try
		  
		  Return tmp_d
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function get_element_as_string(the_element_index as integer) As string
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
		  
		  Dim tmp_s As String
		  Dim tmp_v As variant
		  
		  tmp_v = get_element(the_element_index)
		  
		  Try 
		    tmp_s = tmp_v.StringValue
		    
		  Catch TypeMismatchException
		    tmp_s = ""
		    self.add_error_message( "Cannot convert element "+Str(the_element_index) + " to string.")
		    
		  End Try
		  
		  Return tmp_s
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function get_last_error_message() As string
		  return self.last_error_message
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function get_meta_data() As clMetaData
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
		Function has_alias(alias as string) As Boolean
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
		Function is_linked_to_table() As Boolean
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
		Sub rename(the_new_name as string)
		  //  
		  //  use setter of computed property
		  //  
		  Self.name = the_new_name
		  
		  
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function rename(the_new_name as string) As clAbstractDataSerie
		  //  
		  //  use setter of computed property
		  //  
		  Self.name = the_new_name
		  
		  return self
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub reset()
		  //  
		  //  Reset the data serie. Type specific subclasses will clear all values.
		  //
		  //  Parameters
		  //  
		  //  Returns:
		  //
		  
		  self.reset_meta_data
		  self.reset_elements
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub reset_elements()
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
		Sub reset_meta_data()
		  //  
		  //  Resets the meta data
		  //
		  //  Parameters
		  //  
		  //  Returns:
		  //
		  
		  self.meta_dict = new clMetaData
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function row_count() As integer
		  return self.upper_bound+1
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub set_default_value(v as Variant)
		  Raise New clDataException("Unimplemented method " + CurrentMethodName)
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub set_element(the_element_index as integer, the_item as Variant)
		  Raise New clDataException("Unimplemented method " + CurrentMethodName)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub set_length(the_length as integer)
		  dim v as variant = self.get_default_value
		  
		  self.set_length(the_length, v)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub set_length(the_length as integer, default_value as variant)
		  Raise New clDataException("Unimplemented method " + CurrentMethodName)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub set_link_to_table(the_table as clDataTable)
		  
		  If physical_table_link = Nil Then
		    physical_table_link = the_table
		    
		  Else
		    Raise New clDataException("Cannot redefine link to table for a serie")
		    
		  End If
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub set_values(the_values() as variant)
		  for i as integer = 0 to the_values.Ubound
		    self.set_element(i, the_values(i))
		    
		  next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function sum() As double
		  Dim limit As Integer = row_count - 1
		  Dim i As Integer
		  
		  Dim s As Double
		  For i = 0 To limit
		    s = s + get_element_as_number(i)
		    
		  Next
		  
		  return s
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function to_json() As JSONItem
		  // Part of the itf_json_able interface.
		  
		  // Part of the itf_string_able interface.
		  
		  Dim js_list As New JSONItem
		  Dim js_return As New JSONItem
		  
		  For row As Integer = 0 To row_count-1
		    Dim element As variant = get_element(row)
		    
		    If element IsA itf_json_able Then
		      js_list.append(itf_json_able(element).to_json)
		      
		    Else
		      Try
		        js_list.Append(element.StringValue)
		        
		      Catch TypeMismatchExceptiondim  
		        js_list.Append("Cannot convert")
		        
		      End Try
		      
		    End If
		    
		  Next
		  
		  js_return.Value(name) = js_list
		  
		  Return js_return
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function unique() As variant()
		  dim dct as new Dictionary
		  dim results() as variant
		  
		  for row as integer = 0 to upper_bound
		    dim tmp as variant = self.get_element(row)
		    dim v as integer
		    
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

	#tag Method, Flags = &h0
		Function upper_bound() As integer
		  Raise New clDataException("Unimplemented method " + CurrentMethodName)
		  
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
		-clBooleanDataSerie: stores elements as Boolean
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

	#tag Note, Name = Methods to be defined in child class
		
		append_element
		
		clone 
		
		filter_apply_function
		
		get_element
		
		remove_all_elements
		
		set_element
		
		set_length
		
		upper_bound
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
		Protected meta_dict As clMetaData
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
