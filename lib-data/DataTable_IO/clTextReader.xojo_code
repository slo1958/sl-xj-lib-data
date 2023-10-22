#tag Class
Class clTextReader
Implements itf_table_row_reader
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
		Function column_count() As integer
		  // Part of the itf_table_row_reader interface.
		  return mheader.Count
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(fld as FolderItem, has_header as Boolean, config as clTextFileConfig)
		  
		  dim tmp_config as clTextFileConfig = config
		  
		  if tmp_config = nil then tmp_config = new clTextFileConfig
		  
		  self.mDataFile = fld
		  
		  if not fld.Exists or fld.IsFolder then
		    self.textstream = nil
		    Return
		    
		  end if
		  
		  self.textstream  = TextInputStream.Open(self.mDataFile)
		  self.textstream.Encoding = tmp_config.enc
		  self.set_separator(tmp_config.field_separator)
		  self.set_encoding(tmp_config.enc)
		  
		  if has_header then
		    dim tmp() as variant = self.next_row
		    self.mheader.RemoveAll
		    
		    for each v as variant in tmp
		      self.mheader.add(v)
		      
		    next
		    
		  end if
		  
		  self.line_count = 0
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function current_row_number() As integer
		  // Part of the itf_table_row_reader interface.
		  
		  Return line_count
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
		Function end_of_table() As boolean
		  // Part of the itf_table_row_reader interface.
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
		  // Part of the itf_table_row_reader interface.
		  
		  dim tmp() as string
		  for each s as string in mheader
		    tmp.add(s)
		    
		  next
		  
		  return tmp
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function name() As string
		  // Part of the itf_table_row_reader interface
		  
		  if self.mDataFile = nil then return ""
		  
		  return self.mDataFile.Name
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function next_row() As variant()
		  // Part of the itf_table_row_reader interface.
		  
		  const kDoubleQuote = """"
		  
		  dim cellArray() as variant
		  
		  dim lineBuffer as string
		  dim charBuffer as string
		  
		  if textstream = nil then
		    return cellArray
		    
		  end if
		  
		  if  textstream.EndOfFile then
		    return cellArray
		    
		  end if
		  
		  
		  lineBuffer = textstream.ReadLine()
		  
		  // since a single CR in a quoted string is handled as a line break by TextInputStream, we may have to read more
		  // lines from the file
		  
		  dim cellBuffer as string
		  dim bDone as Boolean = False
		  dim gotQuote as Boolean = False
		  
		  while not bDone
		    
		    dim lenBuffer as integer = lineBuffer.Length 
		    
		    for index as integer = 1 to lenBuffer
		      
		      charBuffer = lineBuffer.mid(index, 1)
		      
		      if gotQuote then
		        
		        if charBuffer = kDoubleQuote then 
		          
		          if index < lenBuffer and lineBuffer.mid(index+1,1) = kDoubleQuote then
		            cellBuffer = cellBuffer+ kDoubleQuote
		            index = index +1
		            
		          else
		            gotquote = False
		            // will be pushed either by field_separator or end of line
		            
		          end if
		        else
		          cellBuffer = cellBuffer + charBuffer
		          
		        end if
		      else
		        if charBuffer = kDoubleQuote then
		          gotQuote = True
		          
		        elseif charBuffer = field_separator Then
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
		  
		  self.line_count = self.line_count +1
		  
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
		  field_separator = prm_sep
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h1
		Protected encoding As TextEncoding
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected field_separator As String
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected line_count As Integer
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mDataFile As FolderItem
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mheader() As string
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected quote_char As string
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
