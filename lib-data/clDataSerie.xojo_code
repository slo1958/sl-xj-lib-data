#tag Class
Protected Class clDataSerie
Implements  clDataSupport.itf_json_able
	#tag Method, Flags = &h0
		Sub append_element(the_item as Variant)
		  items.Append(the_item)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function apply_filter(the_filter_function as filter_column, paramarray function_param as variant) As variant()
		  Dim return_boolean() As Variant
		  
		  For i As Integer=0 To items.Ubound
		    return_boolean.Append(the_filter_function.Invoke(i,  items.Ubound, name, items(i), function_param))
		    
		  Next
		  
		  Return return_boolean
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function clone() As clDataSerie
		  Dim tmp As New clDataSerie(Self.name)
		  
		  For Each v As variant In Self.items
		    tmp.append_element(v)
		    
		  Next
		  
		  Return tmp
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(the_source_file as FolderItem)
		  Dim tmp_serie_name As String
		  
		  tmp_serie_name = load_from_text(the_source_file, True)
		  
		  If tmp_serie_name.Len>0 Then
		    serie_name = tmp_serie_name
		    
		  End If
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(the_label as string)
		  serie_name = the_label
		  physical_table_link = Nil
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(the_label as string, the_values() as variant)
		  serie_name = the_label
		  physical_table_link = Nil
		  
		  For i As Integer = 0 To the_values.Ubound
		    items.Append(the_values(i))
		    
		  Next
		  
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
		    
		    Try
		      tmp_item.Append(element.StringValue)
		      ok_convert = True
		      
		    Catch TypeMismatchException
		      
		      
		    End Try
		    
		    If Not ok_convert Then
		      If element IsA clDataSupport.itf_json_able Then
		        tmp_item.Append(clDataSupport.itf_json_able(element).to_json.ToString)
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

	#tag DelegateDeclaration, Flags = &h0
		Delegate Function filter_column(the_row_index as integer, the_row_count as integer, the_column_name as string, the_cell_value as variant, paramarray function_param as variant) As Boolean
	#tag EndDelegateDeclaration

	#tag Method, Flags = &h0
		Function find_row_index_for_value(the_find_value as Variant) As integer()
		  //
		  // returns row index of rows matching the value
		  //
		  Dim ret() As Integer
		  
		  For i As Integer = 0 To items.Ubound
		    If items(i) = the_find_value Then
		      ret.Append(i)
		      
		    End If
		    
		  Next
		  
		  Return ret
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function get_element(the_element_index as integer) As Variant
		  If items.Ubound >= the_element_index Then
		    Return items(the_element_index)
		    
		  Else
		    Return ""
		    
		  End If
		  
		  
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
		Function is_linked_to_table() As Boolean
		  Return physical_table_link <> Nil
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub link_to_table(the_table as clDataTable)
		  
		  If physical_table_link = Nil Then
		    physical_table_link = the_table
		    
		  Else
		    Raise New clDataException("Cannot redefine link to table for a serie")
		    
		  End If
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function load_from_text(the_source as FolderItem, has_header  as Boolean) As String
		  //
		  // Load the serie from a text file, each line is loaded into one element, without further processing
		  // The method returns the header if the 'has_header' flag is set to true, otherwise it returns an empty string
		  //
		  
		  Dim got_header As Boolean
		  Dim text_file  As TextInputStream
		  Dim return_header As String
		  
		  If the_source = Nil Then
		    Return "noname"
		    
		  End If
		  
		  text_file = TextInputStream.Open(the_source)
		  
		  got_header = Not has_header
		  
		  While Not text_file.EOF
		    Dim tmp_source_line As String = text_file.ReadLine
		    
		    If got_header Then
		      append_element(tmp_source_line)
		      
		    Else
		      return_header = tmp_source_line
		      got_header = True
		      
		    End If
		    
		  Wend
		  
		  text_file.close
		  
		  Return return_header
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function name() As String
		  Return serie_name
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub rename(the_new_name as string)
		  If the_new_name.Len = 0 Then
		    Self.serie_name = "noname"
		    
		  Else
		    Self.serie_name = the_new_name
		    
		  End If
		  
		  If Self.physical_table_link <> Nil Then
		    Self.physical_table_link.synch_columns
		    
		  End If
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function row_count() As integer
		  Return items.Ubound+1
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub save_as_text(the_destination as FolderItem, name_as_header as Boolean)
		  //
		  // Load the serie from a text file, each line is loaded into one element, without further processing
		  // The method returns the header if the 'has_header' flag is set to true, otherwise it returns an empty string
		  //
		  
		  Dim got_header As Boolean
		  Dim text_file  As TextOutputStream
		  Dim return_header As String
		  
		  If the_destination = Nil Then
		    Return
		    
		  End If
		  
		  text_file = TextOutputStream.Create(the_destination)
		  
		  If name_as_header Then
		    text_file.WriteLine Self.name
		    
		  End If
		  
		  For i As Integer = 0 To items.Ubound
		    text_file.WriteLine items(i)
		    
		  Next
		  
		  text_file.close
		  
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub set_element(the_element_index as integer, the_item as Variant)
		  If items.Ubound <= the_element_index Then
		    items(the_element_index) = the_item
		    
		  End If
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub set_length(the_length as integer)
		  While items.Ubound < the_length-1
		    items.Append("")
		    
		  Wend
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function sum_group_by(the_groups as integer) As double
		  Dim limit As Integer = row_count
		  Dim i As Integer
		  
		  Dim s As Double
		  For i = 0 To limit-1
		    s = s + get_element_as_number(i)
		    
		  Next
		  
		  return s
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function to_json() As JSONItem
		  // Part of the clDataSupport.itf_json_able interface.
		  
		  // Part of the clDataSupport.itf_string_able interface.
		  
		  Dim js_list As New JSONItem
		  Dim js_return As New JSONItem
		  
		  For row As Integer = 0 To row_count-1
		    Dim element As variant = get_element(row)
		    
		    If element IsA clDataSupport.itf_json_able Then
		      js_list.append(clDataSupport.itf_json_able(element).to_json)
		      
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


	#tag Property, Flags = &h1
		Protected items() As Variant
	#tag EndProperty

	#tag Property, Flags = &h0
		last_error_message As String
	#tag EndProperty

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
