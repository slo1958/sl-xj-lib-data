#tag Class
Class clTextReader
Implements TableRowReaderInterface
	#tag Method, Flags = &h0
		Sub Close()
		  if self.textstream = nil then 
		    Return
		    
		  end if
		  
		  self.textstream.Close
		  
		  self.textstream = nil
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ColumnCount() As integer
		  // Part of the TableRowReaderInterface interface.
		  return mheader.Count
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(fld as FolderItem, has_header as Boolean, config as clTextFileConfig)
		  
		  var TempConfig as clTextFileConfig = config
		  
		  if TempConfig = nil then TempConfig = new clTextFileConfig
		  
		  self.mDataFile = fld
		  
		  if not fld.Exists or fld.IsFolder then
		    self.textstream = nil
		    Return
		    
		  end if
		  
		  self.textstream  = TextInputStream.Open(self.mDataFile)
		  self.textstream.Encoding = TempConfig.enc
		  self.set_separator(TempConfig.FieldSeparator)
		  self.set_encoding(TempConfig.enc)
		  
		  if has_header then
		    var tmp() as variant = self.NextRow
		    self.mheader.RemoveAll
		    
		    for each v as variant in tmp
		      self.mheader.add(v)
		      
		    next
		    
		  end if
		  
		  self.LineCount = 0
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function CurrentRowIndex() As integer
		  // Part of the TableRowReaderInterface interface.
		  
		  Return LineCount
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Datafile() As FolderItem
		  return self.mDataFile
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function EndOfFile() As Boolean
		  if textstream = nil then
		    return True
		    
		  end if
		  
		  if  textstream.EndOfFile  then
		    textstream.close
		    textstream = nil
		    return True
		    
		  else
		    return false
		    
		  end if
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function EndOfTable() As boolean
		  // Part of the TableRowReaderInterface interface.
		  return EndOfFile
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetColumnName(field_index as integer) As String
		  if field_index > mheader.LastIndex then
		    return ""
		    
		  else
		    return mheader(field_index)
		    
		  end if
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetColumnNames() As string()
		  // Part of the TableRowReaderInterface interface.
		  
		  var tmp() as string
		  for each s as string in mheader
		    tmp.add(s)
		    
		  next
		  
		  return tmp
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetColumnTypes() As dictionary
		  return nil
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetListOfExternalElements() As string()
		  var ret() as string
		  
		  var tmp_fd as FolderItem
		  
		  if mDataFile = nil then
		    return ret
		    
		  end if
		  
		  if mDataFile.IsFolder then
		    tmp_fd = mDataFile
		    
		  else 
		    tmp_fd = mDataFile.Parent
		    
		  end if
		  
		  if not tmp_fd.Exists then
		    return ret
		    
		  end if
		  
		  For Each file As FolderItem In tmp_fd.Children
		    if not file.IsFolder then
		      ret.Add(file.Name)
		      
		    end if
		    
		  next
		  
		  return ret
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Name() As string
		  // Part of the TableRowReaderInterface interface
		  
		  if self.mDataFile = nil then return ""
		  
		  return self.mDataFile.Name
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function NextRow() As variant()
		  // Part of the TableRowReaderInterface interface.
		  
		  const kDoubleQuote = """"
		  
		  var cellArray() as variant
		  
		  var lineBuffer as string
		  var charBuffer as string
		  
		  if textstream = nil then
		    return cellArray
		    
		  end if
		  
		  if  textstream.EndOfFile then
		    return cellArray
		    
		  end if
		  
		  
		  lineBuffer = textstream.ReadLine()
		  
		  // since a single CR in a quoted string is handled as a line break by TextInputStream, we may have to read more
		  // lines from the file
		  
		  var cellBuffer as string
		  var bDone as Boolean = False
		  var gotQuote as Boolean = False
		  
		  while not bDone
		    
		    var lenBuffer as integer = lineBuffer.Length 
		    
		    for index as integer = 1 to lenBuffer
		      
		      charBuffer = lineBuffer.mid(index, 1)
		      
		      if gotQuote then
		        
		        if charBuffer = kDoubleQuote then 
		          
		          if index < lenBuffer and lineBuffer.mid(index+1,1) = kDoubleQuote then
		            cellBuffer = cellBuffer+ kDoubleQuote
		            index = index +1
		            
		          else
		            gotquote = False
		            // will be pushed either by FieldSeparator or end of line
		            
		          end if
		        else
		          cellBuffer = cellBuffer + charBuffer
		          
		        end if
		      else
		        if charBuffer = kDoubleQuote then
		          gotQuote = True
		          
		        elseif charBuffer = FieldSeparator Then
		          cellArray.add(cellBuffer)
		          cellBuffer = ""
		          
		        else
		          cellBuffer = cellBuffer + charBuffer
		          
		        end if
		      end if
		      
		    next
		    
		    
		    if gotQuote and not textstream.EndOfFile then
		      lineBuffer = textstream.ReadLine(Encodings.UTF8)
		      
		    else
		      cellArray.add(cellBuffer)
		      bdone = true
		      
		    end if
		    
		  wend 
		  
		  self.LineCount = self.LineCount +1
		  
		  return cellArray
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub set_encoding(enc as TextEncoding)
		  encoding = enc
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub set_separator(prm_sep as string)
		  FieldSeparator = prm_sep
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h1
		Protected encoding As TextEncoding
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected FieldSeparator As String
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected LineCount As Integer
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mDataFile As FolderItem
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mheader() As string
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected QuoteCharacter As string
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected textstream As TextInputStream
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
