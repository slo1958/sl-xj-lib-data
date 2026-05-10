#tag Class
Class clTextReader
Implements TableRowReaderInterface
	#tag Method, Flags = &h0
		Sub Close()
		  //  
		  // Close the data source
		  //
		  //  Parameters
		  //  - 
		  //  
		  //  Returns:
		  //  (none)
		  //
		  if self.TextFile = nil then 
		    Return
		    
		  end if
		  
		  self.TextFile.Close
		  
		  self.TextFile = nil
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ColumnCount() As integer
		  //
		  // Part of the TableRowReaderInterface interface.
		  //  
		  // Return the number of columns in the source dataset
		  //
		  //  Parameters
		  //  - 
		  //  
		  //  Returns:
		  //  Number of columns in the data source
		  //
		  return mheader.Count
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(SourceFileOrFolder as FolderItem, SourceHasHeader as Boolean, config as clTextFileConfig, selectedRowSorter as RowSorter = nil)
		  //
		  //  
		  //  Parameters
		  // - SourceFileOrFolder: Folderitem pointing to a file or to a folder
		  // - SourceHasHeader: the first usable row in the file contains field names, used as names for the data series
		  // - Config: Configuration parameters for the reader (separator, encoding, ...) 
		  // - selectedRowSorter: method to sort  text line
		  //  
		  //  Returns:
		  //  (none)
		  //
		  var TempConfig as clTextFileConfig = config
		  
		  if TempConfig = nil then TempConfig = new clTextFileConfig
		  
		  self.SourcePath = SourceFileOrFolder
		  self.RequiresHeader = SourceHasHeader
		  
		  self.AccumulatedMetadata = nil
		  
		  self.dRowSorter = selectedRowSorter
		  
		  self.InternalInitConfig(TempConfig)
		  
		  if not SourceFileOrFolder.Exists or SourceFileOrFolder.IsFolder then
		    self.TextFile = nil
		    Return
		    
		  end if
		  
		  OpenTextStream(SourceFileOrFolder)
		  
		  return
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function CurrentRowIndex() As integer
		  //
		  // Part of the TableRowReaderInterface interface.
		  //
		  // Return the index of the current source line
		  //  
		  //  Parameters
		  // - 
		  //  
		  //  Returns:
		  //  Index of the current source line
		  //
		  Return LineCount
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Datafile() As FolderItem
		  //
		  // Return the path to the current file
		  //  
		  //  Parameters
		  // - 
		  //  
		  //  Returns:
		  //  Folderitem pointing to the current file
		  //
		  
		  return self.CurrentFIle
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Shared Function DefaultRowSorter(textLine as string) As TextLineType
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function EndOfTable() As boolean
		  //
		  // Part of the TableRowReaderInterface interface.
		  //
		  //  
		  //  Parameters
		  // - 
		  //  
		  //  Returns:
		  //  End of dataset has been reached
		  //
		  
		  if TextFile = nil then
		    return True
		    
		  end if
		  
		  if  TextFile.EndOfFile  then
		    TextFile.close
		    TextFile = nil
		    return True
		    
		  else
		    return false
		    
		  end if
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetColumnNames() As string()
		  //
		  // Part of the TableRowReaderInterface interface.
		  //
		  //  
		  //  Parameters
		  // - 
		  //  
		  //  Returns:
		  //  Return the name of the columns
		  //
		  
		  var tmp() as string
		  for each s as string in mheader
		    tmp.add(s)
		    
		  next
		  
		  return tmp
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetColumnTypes() As dictionary
		  // Part of the TableRowReaderInterface interface.
		  var tmp as new Dictionary
		  
		  for each s as string in mheader
		    tmp.value(s) = "string"
		    
		  next
		  
		  return tmp
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetListOfExternalElements() As string()
		  var ret() as string
		  
		  var tmp_fd as FolderItem
		  
		  if self.SourcePath = nil then
		    return ret
		    
		  end if
		  
		  if self.SourcePath.IsFolder then
		    tmp_fd = self.SourcePath
		    
		  else 
		    tmp_fd = self.SourcePath.Parent
		    
		  end if
		  
		  if not tmp_fd.Exists then
		    return ret
		    
		  end if
		  
		  For Each file As FolderItem In tmp_fd.Children
		    
		    if file.IsFolder then
		      
		    elseif file.name.Length <= self.DefaultFileExtension.Length then
		      ret.Add(file.name)
		      
		    elseif file.name.right(self.DefaultFileExtension.Length) = self.DefaultFileExtension then
		      ret.add(file.name.left(file.name.Length - self.DefaultFileExtension.Length))
		      
		    else
		      ret.Add(file.Name)
		      
		    end if
		    
		  next
		  
		  return ret
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetMetadata() As Dictionary
		  
		  
		  return self.AccumulatedMetadata
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function getNextTextLine() As string
		  
		  if self.dRowSorter = nil then
		    return TextFile.ReadLine(Encodings.UTF8)
		    
		  end if
		  
		  var tmp as string = TextFile.ReadLine(Encodings.UTF8)
		  
		  return tmp
		  
		  
		  
		  select case self.dRowSorter.Invoke(tmp)
		    
		  case TextLineType.Ignore
		    
		  case TextLineType.Data
		    Return tmp
		    
		  case TextLineType.Metadata
		    
		  case else
		    
		  end Select
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub InternalInitConfig(config as clTextFileConfig)
		  
		  self.DefaultFileExtension = config.file_extension
		  self.FieldSeparator = config.FieldSeparator
		  self.encoding = config.enc
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Name() As string
		  // Part of the TableRowReaderInterface interface
		  
		  if self.CurrentFIle = nil then return ""
		  
		  return self.CurrentFIle.Name
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function NextRow() As clDataRow
		  // Part of the TableRowReaderInterface interface.
		  //
		  // NextRow returns the row as a clDataRow if the source file has a header, otherwise an emtpy data row is returned
		  // Use NextRowAsVariant is the source file does not have a header
		  //
		  
		  var data() as variant = self.NextRowAsVariant
		  
		  var d as new Dictionary
		  
		  for index as integer = 0 to mheader.LastIndex
		    var v as variant
		    
		    if index <= data.LastIndex then
		      d.value(mheader(index)) = data(index)
		      
		    else
		      d.Value(mheader(index)) = v
		      
		    end if
		    
		  next
		  
		  return new clDataRow(d)
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function NextRowAsVariant() As variant()
		  // Part of the TableRowReaderInterface interface.
		  
		  const kDoubleQuote = """"
		  
		  var cellArray() as variant
		  
		  var lineBuffer as string
		  var charBuffer as string
		  
		  if TextFile = nil then
		    return cellArray
		    
		  end if
		  
		  if  TextFile.EndOfFile then
		    return cellArray
		    
		  end if
		  
		  //lineBuffer = TextFile.ReadLine()
		  
		  lineBuffer = getNextTextLine()
		  
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
		    
		    
		    if gotQuote and not TextFile.EndOfFile then
		      // lineBuffer = TextFile.ReadLine(Encodings.UTF8)
		      lineBuffer = getNextTextLine()
		      
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
		Private Sub OpenTextStream(SourceFile as FolderItem)
		  //
		  // Open the source file and load the column names, if the source file contains column headers
		  //
		  //  
		  //  Parameters
		  // - Source file
		  //  
		  //  Returns:
		  // (none)
		  //
		  self.CurrentFIle = SourceFile
		  
		  if not self.CurrentFIle.IsFolder and self.CurrentFIle.Exists then
		    self.TextFile  = TextInputStream.Open(SourceFile)
		    self.TextFile.Encoding = self.encoding
		    
		  else
		    System.DebugLog("Cannot open " + self.CurrentFIle.Name + " for reading.")
		    self.TextFile = nil
		    
		  end if
		  
		  if self.RequiresHeader then
		    var tmp() as variant = self.NextRowAsVariant
		    self.mheader.RemoveAll
		    
		    for each v as variant in tmp
		      self.mheader.add(v)
		      
		    next
		    
		  end if
		  
		  self.LineCount = 0
		  
		  Return
		End Sub
	#tag EndMethod

	#tag DelegateDeclaration, Flags = &h1
		Protected Delegate Function RowSorter(textLine as string) As TextLineType
	#tag EndDelegateDeclaration

	#tag Method, Flags = &h0
		Sub UpdateExternalName(new_name as string)
		  //
		  // This method is used when the path passed to the constructor is the path of a folder
		  // This method is then used to define the filename
		  //
		  //  
		  //  Parameters
		  //  - new_name: name of the file
		  //  
		  //  Returns:
		  //  (none)
		  //
		  var tmp_fld as new FolderItem  
		  
		  if self.SourcePath = nil then
		    self.TextFile = nil
		    return
		    
		  elseif self.SourcePath.IsFolder then
		    tmp_fld = self.SourcePath.Child(new_name + self.DefaultFileExtension)
		    OpenTextStream(tmp_fld)
		    
		  else
		    tmp_fld = self.SourcePath.Parent.Child(new_name + self.DefaultFileExtension)
		    OpenTextStream(tmp_fld)
		    
		  end if
		  
		  
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private AccumulatedMetadata As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected CurrentFIle As FolderItem
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected DefaultFileExtension As string
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected dRowSorter As RowSorter
	#tag EndProperty

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
		Protected mheader() As string
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected nextRow As clDataRow
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected QuoteCharacter As string
	#tag EndProperty

	#tag Property, Flags = &h21
		Private RequiresHeader As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private SourcePath As FolderItem
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected TextFile As TextInputStream
	#tag EndProperty


	#tag Enum, Name = TextLineType, Type = Integer, Flags = &h0
		Ignore
		  Metadata
		Data
	#tag EndEnum


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
