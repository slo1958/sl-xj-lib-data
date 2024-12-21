#tag Class
Class clTextWriter
Implements TableRowWriterInterface
	#tag Method, Flags = &h0
		Sub AddRow(row_data as Dictionary)
		  raise new clDataException("Unexpected call to addrow from dictionary.")
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AddRow(row_data() as variant)
		  // Part of the TableRowWriterInterface interface.
		  const kDoubleQuote = """"
		  
		  if textstream = nil then return
		  
		  var tmpStr() as string
		  
		  for each row_field as variant in row_data
		    var field as string
		    
		    if row_field.type = variant.TypeSingle or row_field.type= Variant.TypeDouble then
		      
		      if self.Use_locale_for_numbers then
		        field = format(row_field,self.default_number_format)
		        
		      else
		        field = str(row_field,self.default_number_format)
		        
		      end if
		    else 
		      field = row_field
		    end if
		    
		    var reqQuotes as Boolean = False
		    
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
		Sub Constructor(the_destination_path as FolderItem, has_header as Boolean)
		  self.DestinationPath = the_destination_path
		  self.file_has_header = has_header
		  
		  open_text_Stream(self.DestinationPath)
		  
		  self.internal_init_config(nil) 
		  
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(the_destination_path as FolderItem, has_header as Boolean, config as clTextFileConfig)
		  self.DestinationPath = the_destination_path
		  self.file_has_header = has_header
		  
		  open_text_Stream(self.DestinationPath)
		  
		  self.internal_init_config(config)
		  
		  
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub DefineMetadata(name as string, columns() as string)
		  // Part of the TableRowWriterInterface interface.
		  
		  if header_written then return
		  
		  write_column_headers(columns)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub DefineMetadata(name as string, columns() as string, column_type() as string)
		  // Part of the TableRowWriterInterface interface.
		  
		  
		  if header_written then return
		  
		  write_column_headers(columns)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Done()
		  // Part of the TableRowWriterInterface interface.
		  
		  if textstream = nil then return
		  
		  TextStream.close
		  TextStream = nil
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ExpectsDictionary() As Boolean
		  return false
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub internal_init_config(config as clTextFileConfig)
		  
		  var tmp_config as clTextFileConfig = config
		  
		  if tmp_config = nil then tmp_config = new clTextFileConfig
		  
		  self.field_separator = tmp_config.field_separator
		  self.encoding = tmp_config.enc
		  self.quote_char = tmp_config.quote_char
		  self.default_number_format = tmp_config.DefaultNumberFormat
		  self.default_extension = tmp_config.file_extension
		  self.Use_locale_for_numbers = tmp_config.UseLocalFormatting
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub open_text_Stream(tmp_file as FolderItem)
		  
		  self.line_count = 0
		  
		  self.current_file = tmp_file
		  
		  if not self.current_file.IsFolder and self.current_file.IsWriteable then
		    self.TextStream = TextOutputStream.Create(self.current_file)
		    
		  else
		    self.TextStream =  nil
		    
		  end if 
		  
		  self.header_written = not self.file_has_header
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub UpdateExternalName(new_name as string)
		  
		  var tmp_fld as new FolderItem  
		  
		  if self.DestinationPath = nil then
		    self.TextStream = nil
		    return
		    
		  elseif self.DestinationPath.IsFolder then
		    tmp_fld = self.DestinationPath.Child(new_name + self.default_extension)
		    open_text_Stream(tmp_fld)
		    
		  else
		    tmp_fld = self.DestinationPath.Parent.Child(new_name + self.default_extension)
		    open_text_Stream(tmp_fld)
		    
		  end if
		  
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub write_column_headers(headers() as string)
		  var tmp() as variant
		  
		  for each s as string in headers
		    tmp.add(s)
		    
		  next
		  
		  self.AddRow(tmp)
		  
		  header_written = True
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h1
		Protected current_file As FolderItem
	#tag EndProperty

	#tag Property, Flags = &h0
		default_extension As string
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected default_number_format As string
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected DestinationPath As folderitem
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected encoding As TextEncoding
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected field_separator As String
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected file_has_header As Boolean
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected header_written As Boolean
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected line_count As Integer
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected quote_char As string
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected TextStream As TextOutputStream
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected Use_locale_for_numbers As Boolean
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
			Name="default_extension"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="string"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
