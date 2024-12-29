#tag Class
Protected Class clJSONReader
Implements TableRowReaderInterface
	#tag Method, Flags = &h0
		Function ColumnCount() As integer
		  // Part of the TableRowReaderInterface interface.
		  
		  return self.columnsName.Count
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(fld as FolderItem, config as clJSONFileConfig)
		  
		  var TempConfig as clJSONFileConfig = config
		  
		  if TempConfig = nil then TempConfig = new clJSONFileConfig
		  
		  self.mDataFile = fld
		  
		  if not fld.Exists or fld.IsFolder then
		    Return
		    
		  end if
		  
		  var tmp_stream as TextInputStream =  TextInputStream.Open(self.mDataFile)
		  
		  self.JSONSource = tmp_stream.ReadAll
		  
		  tmp_stream.close
		  
		  var tmp_master as new JSONItem(self.JSONSource)
		  
		  
		  if not tmp_master.HasKey(config.KeyForHeader) then
		    raise new clDataException("Missing metadata in JSON file, looking for ["+config.KeyForHeader + "]")
		    return
		    
		  end if
		  
		  if not tmp_master.HasKey(config.KeyForData) then
		    raise new clDataException("Missing data in JSON file, looking for ["+config.KeyForData + "]")
		    return
		    
		  end if
		  
		  try
		    
		    var JSONForHeader as JSONItem = tmp_master.Value(config.KeyForHeader)
		    
		    var tempa as Dictionary = ParseJSON(JSONForHeader.ToString)
		    
		    Self.MetaData = tempa
		    
		  catch
		    raise new clDataException("Cannot process the JSON header")
		    
		  end try
		  
		  try
		    var JSONForData as JSONItem = tmp_master.value(config.KeyForData)
		    
		    var tempb() as variant = ParseJSON(JSONForData.ToString)
		    
		    for each d as variant in tempb
		      if d isa Dictionary then
		        
		        self.SourceData.Add(d)
		      end if
		    next
		    
		  catch
		    raise new clDataException("Cannot process the JSON data")
		    
		  end try
		  
		  // Extract columns info
		  
		  var tmp_col() as variant = self.MetaData.value(config.KeyForListOfColumns)
		  self.columnsType = new Dictionary
		  self.columnsName.RemoveAll
		  
		  for each d as variant in tmp_col
		    if d isa Dictionary then
		      var fieldname as string = Dictionary(d).value(config.KeyforFieldName)
		      self.columnsName.Add(fieldname)
		      
		      self.columnsType.value(fieldname) = Dictionary(d).Value(config.KeyForFieldType)
		    end if
		    
		  next
		  
		  self.TempRowIndex = 0
		  
		  return
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function CurrentRowIndex() As integer
		  // Part of the TableRowReaderInterface interface.
		  Return self.TempRowIndex
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Datafile() As FolderItem
		  return self.mDataFile
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function EndOfTable() As boolean
		  // Part of the TableRowReaderInterface interface.
		  
		  return self.TempRowIndex > self.SourceData.LastIndex
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetColumnNames() As string()
		  // Part of the TableRowReaderInterface interface.
		  return self.columnsName
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetColumnTypes() As dictionary
		  // Part of the TableRowReaderInterface interface.
		  
		  return self.columnsType
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetListOfExternalElements() As string()
		  // Part of the TableRowReaderInterface interface.
		  var tmp() as string
		  
		  return tmp
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Name() As string
		  // Part of the TableRowReaderInterface interface.
		  
		  if self.mDataFile = nil then return ""
		  
		  return self.mDataFile.Name
		  
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function NextRow() As variant()
		  // Part of the TableRowReaderInterface interface.
		  
		  
		  var cellArray() as variant
		  
		  var sourceDict as Dictionary = self.SourceData(self.TempRowIndex)
		  
		  for each s as string in self.columnsName
		    cellArray.Add(SourceDict.value(s))
		    
		  next
		  
		  self.TempRowIndex = self.TempRowIndex +1
		  
		  return cellArray
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private columnsName() As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private columnsType As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h0
		JSONSource As string
	#tag EndProperty

	#tag Property, Flags = &h0
		mDataFile As FolderItem
	#tag EndProperty

	#tag Property, Flags = &h0
		MetaData As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h0
		SourceData() As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private TempRowIndex As Integer
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
			Name="JSONSource"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="string"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
