#tag Class
Class clTextWriter
Implements itf_table_row_writer
	#tag Method, Flags = &h0
		Sub add_row(row_data() as variant)
		  // Part of the itf_table_row_writer interface.
		  const kDoubleQuote = """"
		  
		  if textstream = nil then return
		  
		  dim tmpStr() as string
		  
		  for each row_field as variant in row_data
		    dim field as string
		    
		    if row_field.type = 4 or row_field.type=5 then
		      field = str(row_field,self.number_format)
		    else 
		      field = row_field
		    end if
		    
		    dim reqQuotes as Boolean = False
		    
		    reqQuotes = reqQuotes or (field.IndexOf(field_separator)>0)
		    
		    reqQuotes = reqQuotes or ( field.IndexOf(chr(13))>0) 
		    
		    if field.IndexOf(kDoubleQuote)>0 then
		      field = field.ReplaceAll(kDoubleQuote, kDoubleQuote+kDoubleQuote)
		      reqQuotes = True
		      
		    end if
		    
		    if reqQuotes then
		      tmpStr.Add kDoubleQuote + field + kDoubleQuote
		      
		    else
		      tmpStr.Add field
		    end if
		    
		  next
		  
		  textstream.WriteLine(join(tmpStr, field_separator))
		  
		  line_count = line_count + 1
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(the_destination_file as FolderItem, has_header as Boolean)
		  self.DestinationFile = the_destination_file
		  
		  
		  if not self.DestinationFile.IsFolder and self.DestinationFile.IsWriteable then
		    self.TextStream = TextOutputStream.Create(self.DestinationFile)
		    
		  else
		    self.TextStream =  nil
		    
		  end if 
		  
		  self.internal_init_config(nil) 
		  
		  self.header_written = not has_header
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(the_destination_file as FolderItem, has_header as Boolean, config as clTextFileConfig)
		  self.DestinationFile = the_destination_file
		  
		  
		  if not self.DestinationFile.IsFolder and self.DestinationFile.IsWriteable then
		    self.TextStream = TextOutputStream.Create(self.DestinationFile)
		    
		  else
		    self.TextStream =  nil
		    
		  end if 
		  
		  self.internal_init_config(config)
		  
		  
		  self.header_written = not has_header
		  
		  
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
		Private Sub internal_init_config(config as clTextFileConfig)
		  
		  dim tmp_config as clTextFileConfig = config
		  
		  if tmp_config = nil then tmp_config = new clTextFileConfig
		  
		  self.field_separator = tmp_config.field_separator
		  self.encoding = tmp_config.enc
		  self.quote_char = tmp_config.quote_char
		  self.number_format = tmp_config.NumberFormat
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub write_column_headers(headers() as string)
		  dim tmp() as variant
		  
		  for each s as string in headers
		    tmp.add(s)
		    
		  next
		  
		  self.add_row(tmp)
		  
		  header_written = True
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h1
		Protected DestinationFile As folderitem
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected encoding As TextEncoding
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected field_separator As String
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected header_written As Boolean
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected line_count As Integer
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected number_format As string
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected quote_char As string
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected TextStream As TextOutputStream
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
