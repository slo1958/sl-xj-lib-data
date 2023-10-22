#tag Class
Protected Class clAbstractDataSerie
Implements Xojo.Core.Iterable,itf_json_able
	#tag Method, Flags = &h0
		Sub add_meta_data(type as string, message as string)
		  
		  meta_dict.add_meta_data(type, message)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub append_element(the_item as Variant)
		  Raise New clDataException("Unimplemented method " + CurrentMethodName)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub append_serie(the_serie as clAbstractDataSerie)
		  dim tmp_source as clAbstractDataSerie = the_serie
		  
		  For row_num As Integer = 0 To tmp_source.row_count-1
		    self.append_element(tmp_source.get_element(row_num))
		    
		  Next
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub append_to(target_data_serie as clAbstractDataSerie)
		  for index as Integer = 0 to self.upper_bound
		    target_data_serie.append_element(self.get_element(index))
		    
		  next
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function clipped_by_range(low_value as variant, high_value as variant) As clAbstractDataSerie
		  
		  dim new_col as clAbstractDataSerie = self.clone()
		  
		  new_col.rename("clip " + self.name)
		  
		  call new_col.clip_range(low_value, high_value)
		  
		  return new_col
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function clip_high(high_value as variant) As integer
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
		  Raise New clDataException("Unimplemented method " + CurrentMethodName)
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function get_element(the_element_index as integer) As Variant
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
		    last_error_message = "Cannot convert element "+Str(the_element_index) + " to string."
		    
		  End Try
		  
		  Return tmp_v
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function get_element_as_number(the_element_index as integer) As double
		  Dim tmp_d As Double
		  Dim tmp_v As variant
		  
		  tmp_v = get_element(the_element_index)
		  
		  Try 
		    tmp_d = tmp_v.DoubleValue
		    
		  Catch TypeMismatchException
		    tmp_d = 0
		    last_error_message = "Cannot convert element "+Str(the_element_index) + " to number."
		    
		  End Try
		  
		  Return tmp_d
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function get_element_as_string(the_element_index as integer) As string
		  Dim tmp_s As String
		  Dim tmp_v As variant
		  
		  tmp_v = get_element(the_element_index)
		  
		  Try 
		    tmp_s = tmp_v.StringValue
		    
		  Catch TypeMismatchException
		    tmp_s = ""
		    last_error_message = "Cannot convert element "+Str(the_element_index) + " to string."
		    
		  End Try
		  
		  Return tmp_s
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function get_meta_data() As clMetaData
		  Return self.meta_dict
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function is_linked_to_table() As Boolean
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
		last_error_message As String
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
			Name="last_error_message"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
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
