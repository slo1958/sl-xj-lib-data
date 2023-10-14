#tag Class
Class clTextReader
Implements itf_table_row_reader
	#tag Method, Flags = &h0
		Function column_count() As integer
		  // Part of the itf_table_row_reader interface.
		  
		  if LoadedColumnNames.LastIndex <0 then
		    load_column_headers
		    
		  end if
		  
		  if LoadedColumnNames.LastIndex <0 then
		    return -1
		    
		  else
		    Return LoadedColumnNames.Count
		    
		  end if
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function column_names() As string()
		  // Part of the itf_table_row_reader interface.
		  
		  if LoadedColumnNames.LastIndex <0 then
		    load_column_headers
		    
		  end if
		  
		  if LoadedColumnNames.LastIndex <0 then
		    dim tmp() as string
		    return tmp 
		    
		  else
		    Return LoadedColumnNames
		    
		  end if
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(the_source_file as FolderItem, the_line_parser as itf_row_parser, has_header as Boolean)
		  SourceFile = the_source_file
		  RowParser = the_line_parser
		  
		  CurrentRow = -1
		  LoadedColumnNames.RemoveAll
		  
		  if SourceFile.Exists and not SourceFile.IsFolder then
		    TextStream = TextInputStream.Open(SourceFile)
		    
		  else
		    TextStream = nil
		    
		  end if
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function current_row_number() As integer
		  // Part of the itf_table_row_reader interface.
		  
		  Return CurrentRow
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function end_of_table() As boolean
		  // Part of the itf_table_row_reader interface.
		  
		  if TextStream = nil then
		    return True
		    
		  end if
		  
		  Return TextStream.EndOfFile
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub load_column_headers()
		  
		  if LoadedColumnNames.LastIndex >= 0 then
		    return
		    
		  end if
		  
		  
		  Dim tmp_source_line As String = TextStream.ReadLine
		  Dim tmp_items() As String
		  
		  if RowParser = nil then
		    tmp_items.Add(tmp_source_line.Trim)
		    
		  else
		    tmp_items = RowParser.parse_line(tmp_source_line)
		    
		  end if
		  
		  redim LoadedColumnNames(-1)
		  
		  for each tmp_item as variant in tmp_items
		    LoadedColumnNames.Add(tmp_item)
		    
		  next
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function name() As string
		  // Part of the itf_table_row_reader interface.
		  
		  if SourceFile = nil then
		    return ""
		  end if
		  
		  return SourceFile.Name
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function next_row() As variant()
		  return nil
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function next_row_as_string() As string()
		  // Part of the itf_table_row_reader interface.
		  
		  Dim tmp_items() As string
		  
		  if LoadedColumnNames.LastIndex <0 then
		    load_column_headers
		    
		  end if
		  
		  if LoadedColumnNames.LastIndex <0 then
		    return tmp_items
		    
		  end if
		  
		  if TextStream = nil then
		    return tmp_items
		    
		  end if
		  
		  if TextStream.EndOfFile then
		    Return tmp_items
		    
		  end if
		  
		  dim tmp_source_line as string = TextStream.ReadLine
		  
		  if RowParser = nil then
		    tmp_items.Add(tmp_source_line.Trim)
		    
		  else
		    tmp_items = RowParser.parse_line(tmp_source_line)
		    
		  end if
		  
		  return tmp_items
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0
		CurrentRow As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		LoadedColumnNames() As String
	#tag EndProperty

	#tag Property, Flags = &h0
		RowParser As itf_row_parser
	#tag EndProperty

	#tag Property, Flags = &h0
		SourceFile As folderitem
	#tag EndProperty

	#tag Property, Flags = &h0
		TextStream As TextInputStream
	#tag EndProperty


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
			Name="Super"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
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
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="CurrentRow"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
