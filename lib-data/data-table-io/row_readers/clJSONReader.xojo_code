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
		Sub Constructor(SourceFile as FolderItem, config as clJSONFileConfig)
		  
		  if config = nil then 
		    self.Configuration = new clJSONFileConfig
		    
		  else
		    self.Configuration = config
		    
		  end if
		  
		  self.mDataFile = SourceFile
		  self.CurrentName = SourceFile.Name
		  
		  if not SourceFile.Exists or SourceFile.IsFolder then
		    Return
		    
		  end if
		  
		  var tmp_stream as TextInputStream =  TextInputStream.Open(self.mDataFile)
		  
		  self.JSONSource = tmp_stream.ReadAll
		  
		  tmp_stream.close
		  
		  var tmp_master as new JSONItem(self.JSONSource)
		  
		  if tmp_master.HasKey(self.Configuration.keyForManifest)  then
		    self.TableDictionary = new Dictionary
		    self.ProcessMultipleJSONTable(tmp_master, self.Configuration)
		    self.CurrentName = ""
		    
		  else
		    self.TableDictionary = nil
		    self.ProcessSingleJSONTable(tmp_master, self.Configuration)
		    
		  end if
		  
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

	#tag Method, Flags = &h21
		Private Sub DetectConsolidatedFIle(input as JSONItem, config as clJSONFileConfig)
		  
		End Sub
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
		  
		  for each s as string in self.TableDictionary.keys
		    if self.TableDictionary.Value(s) <> nil then
		      tmp.Add(s)
		      
		    end if
		    
		  next
		  
		  return tmp
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Name() As string
		  // Part of the TableRowReaderInterface interface.
		  
		  return self.CurrentName
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function NextRow() As clDataRow
		  // Part of the TableRowReaderInterface interface.
		  
		  Raise New clDataException("Unimplemented method " + CurrentMethodName)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function NextRowAsVariant() As variant()
		  // Part of the TableRowReaderInterface interface.
		  
		  var emptyVariant as Variant
		  
		  var cellArray() as variant
		  
		  var sourceDict as Dictionary = self.SourceData(self.TempRowIndex)
		  
		  for each s as string in self.columnsName
		    cellArray.Add(SourceDict.lookup(s, emptyVariant))
		    
		  next
		  
		  self.TempRowIndex = self.TempRowIndex +1
		  
		  return cellArray
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ProcessMultipleJSONTable(input as JSONItem, config as clJSONFileConfig)
		  var temp_master as JSONItem = input
		  
		  if not temp_master.HasKey(config.KeyForManifest) then
		    raise new clDataException("Missing manifest in JSON file, looking for ["+config.KeyForManifest + "]")
		    return
		    
		  end if
		  
		  if not temp_master.HasKey(config.KeyForTables) then
		    raise new clDataException("Missing table array in JSON file, looking for ["+config.KeyForTables + "]")
		    return
		    
		  end if
		  
		  var temp_manifest as JSONItem = temp_master.Value(config.KeyForManifest)
		  
		  for i as integer = 0 to temp_manifest.LastRowIndex
		    self.TableDictionary.value(temp_manifest.ValueAt(i)) = nil
		    
		  next
		  
		  var temp_tables as JSONItem = temp_master.Value(config.KeyForTables)
		  
		  for i as integer = 0 to temp_tables.LastRowIndex
		    var temp_table as JSONItem = temp_tables.ValueAt(i)
		    var temp_name as string = ""
		    
		    if temp_table.HasKey(config.KeyForHeader) then
		      var temp_header as JSONItem = temp_table.Value(config.KeyForHeader)
		      
		      if temp_header.HasKey(config.KeyForDatasetName) then
		        temp_name  = str(temp_header.value(config.KeyForDatasetName))
		        
		      end if
		      
		    end if
		    
		    if self.TableDictionary.HasKey(temp_name) then
		      self.TableDictionary.value(temp_name) = temp_table
		      
		    else
		      Raise new clDataException("Inconsistent data structure, found data for " + temp_name+" not defined in manifest")
		      Return
		      
		    end if
		  next
		  
		  return
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ProcessSingleJSONTable(input as JSONItem, config as clJSONFileConfig)
		  
		  var tmp_master as JSONItem = input
		  
		  self.SourceData.RemoveAll
		  self.MetaData = new Dictionary
		  self.columnsType = new Dictionary
		  self.columnsName.RemoveAll
		  
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
		Sub UpdateExternalName(new_name as string)
		  if self.TableDictionary.HasKey(new_name) then
		    
		    self.CurrentName = new_name
		    
		    self.ProcessSingleJSONTable(self.TableDictionary.value(new_name), self.Configuration)
		    
		    
		  else
		    raise new clDataException("Cannot find requested table " + new_name)
		    
		    
		  end if
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private columnsName() As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private columnsType As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private Configuration As clJSONFileConfig
	#tag EndProperty

	#tag Property, Flags = &h21
		Private CurrentName As string
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
		Private TableDictionary As Dictionary
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
			EditorType="MultiLineEditor"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
