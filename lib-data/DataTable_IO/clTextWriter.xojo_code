#tag Class
Class clTextWriter
Implements itf_table_row_writer
	#tag Method, Flags = &h0
		Sub add_row(row_data() as variant)
		  // Part of the itf_table_row_writer interface.
		  dim tmp as string = RowParser.serialize_line(row_data)
		  
		  if TextStream = nil then return
		  
		  TextStream.WriteLine(tmp)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(the_destination_file as FolderItem, the_line_parser as itf_row_parser, has_header as Boolean)
		  self.DestinationFile = the_destination_file
		  self.RowParser = the_line_parser
		  
		  
		  if not self.DestinationFile.IsFolder and self.DestinationFile.IsWriteable then
		    TextStream = TextOutputStream.Create(self.DestinationFile)
		    self.header_written = not has_header
		    
		  else
		    TextStream = nil
		    
		  end if
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub define_meta_data(name as string, columns() as string)
		  // Part of the itf_table_row_writer interface.
		  
		  if header_written then return
		  
		  write_column_headers(columns)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub define_meta_data(name as string, columns() as string, column_type() as string)
		  // Part of the itf_table_row_writer interface.
		  
		  
		  if header_written then return
		  
		  write_column_headers(columns)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub done()
		  // Part of the itf_table_row_writer interface.
		  
		  TextStream.close
		  TextStream = nil
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub write_column_headers(headers() as string)
		  dim tmp() as variant
		  
		  for each s as string in headers
		    tmp.add(s)
		    
		  next
		  
		  dim tmp_line as string = RowParser.serialize_line(tmp)
		  
		  if TextStream = nil then return
		  
		  TextStream.WriteLine(tmp_line)
		  
		  header_written = True
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		DestinationFile As folderitem
	#tag EndProperty

	#tag Property, Flags = &h0
		header_written As Boolean
	#tag EndProperty

	#tag Property, Flags = &h0
		RowParser As itf_row_parser
	#tag EndProperty

	#tag Property, Flags = &h0
		TextStream As TextOutputStream
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
	#tag EndViewBehavior
End Class
#tag EndClass