#tag Class
Class clTextWriter
Implements TableRowWriterInterface
	#tag Method, Flags = &h0
		Sub AddRow(row_data() as variant)
		  // Part of the TableRowWriterInterface interface.
		  
		  if TextFile = nil then return
		  
		  var tmpStr() as string
		  
		  for each row_field as variant in row_data
		    var field as string
		    
		    if row_field.type = variant.TypeSingle or row_field.type= Variant.TypeDouble then
		      
		      if self.UseLocaleForNumbers then
		        field = format(row_field,self.DefaultNumberFormat)
		        
		      else
		        field = str(row_field,self.DefaultNumberFormat)
		        
		      end if
		    else 
		      field = row_field
		    end if
		    
		    field = QuoteValue(field, FieldSeparator)
		    
		    tmpStr.Add field
		    
		  next
		  
		  TextFile.WriteLine(join(tmpStr, FieldSeparator))
		  
		  LineCount = LineCount + 1
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AllDone()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(DestinationFileOrFolder as FolderItem, has_header as Boolean, config as clTextFileConfig = nil)
		  
		  self.DestinationPath = DestinationFileOrFolder
		  self.FileHasHeader = has_header
		  
		  open_text_Stream(self.DestinationPath)
		  
		  self.InternalInitConfiguration(config)
		  
		  
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub DefineColumns(name as string, columns() as string, column_type() as string)
		  // Part of the TableRowWriterInterface interface.
		  
		  ColumnNames.RemoveAll
		  
		  var k as integer= 0
		  
		  for each column as string in columns
		    ColumnNames.add (column)
		    
		  next
		  
		  if HeaderWritten then return
		  
		  write_column_headers(columns)
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub DoneWithTable()
		  // Part of the TableRowWriterInterface interface.
		  
		  if TextFile = nil then return
		  
		  TextFile.close
		  TextFile = nil
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub InternalInitConfiguration(config as clTextFileConfig)
		  
		  var TempConfig as clTextFileConfig = config
		  
		  if TempConfig = nil then TempConfig = new clTextFileConfig
		  
		  self.FieldSeparator = TempConfig.FieldSeparator
		  self.encoding = TempConfig.enc
		  self.QuoteCharacter = TempConfig.QuoteCharacter
		  self.DefaultNumberFormat = TempConfig.DefaultNumberFormat
		  self.DefaultFileExtension = TempConfig.file_extension
		  self.UseLocaleForNumbers = TempConfig.UseLocalFormatting
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub open_text_Stream(DestinationFileOrFolder as FolderItem)
		  
		  self.LineCount = 0
		  
		  self.CurrentFIle = DestinationFileOrFolder
		  
		  if not self.CurrentFIle.IsFolder and self.CurrentFIle.IsWriteable then
		    self.TextFile = TextOutputStream.Create(self.CurrentFIle)
		    
		  else
		    self.TextFile =  nil
		    
		  end if 
		  
		  self.HeaderWritten = not self.FileHasHeader
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function QuoteValue(value as String, FieldSeparator as string) As string
		  const kDoubleQuote = """"
		  
		  var field as string = value
		  
		  var reqQuotes as Boolean = False
		  
		  reqQuotes = reqQuotes or (field.IndexOf(FieldSeparator)>0)
		  
		  reqQuotes = reqQuotes or ( field.IndexOf(chr(13))>0) 
		  
		  if field.IndexOf(kDoubleQuote)>0 then
		    field = field.ReplaceAll(kDoubleQuote, kDoubleQuote+kDoubleQuote)
		    reqQuotes = True
		    
		  end if
		  
		  if reqQuotes then
		    return kDoubleQuote + field + kDoubleQuote
		    
		  else
		    return  field
		    
		  end if
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub UpdateExternalName(new_name as string)
		  
		  var tmp_fld as new FolderItem  
		  
		  if self.DestinationPath = nil then
		    self.TextFile = nil
		    return
		    
		  elseif self.DestinationPath.IsFolder then
		    tmp_fld = self.DestinationPath.Child(new_name + self.DefaultFileExtension)
		    open_text_Stream(tmp_fld)
		    
		  else
		    tmp_fld = self.DestinationPath.Parent.Child(new_name + self.DefaultFileExtension)
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
		  
		  HeaderWritten = True
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h1
		Protected ColumnNames() As string
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected CurrentFIle As FolderItem
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected DefaultFileExtension As string
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected DefaultNumberFormat As string
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected DestinationPath As folderitem
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected encoding As TextEncoding
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected FieldSeparator As String
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected FileHasHeader As Boolean
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected HeaderWritten As Boolean
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected LineCount As Integer
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected QuoteCharacter As string
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected TextFile As TextOutputStream
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected UseLocaleForNumbers As Boolean
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
