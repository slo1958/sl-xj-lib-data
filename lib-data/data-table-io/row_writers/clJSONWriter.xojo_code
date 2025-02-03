#tag Class
Protected Class clJSONWriter
Implements TableRowWriterInterface
	#tag Method, Flags = &h0
		Sub AddRow(row_data() as variant)
		  // Part of the TableRowWriterInterface interface.
		  
		  // raise new clDataException("Unexpected call to addrow from array.")
		  
		  var d as new Dictionary
		  
		  for index as integer = 0 to self.ColumnNames.LastIndex
		    d.value(self.ColumnNames(index)) = row_data(index)
		    
		  next
		  
		  self.Rows.Add(d)
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AllDone()
		  
		  if self.Filelist.Count = 0 then return 
		  
		  var tempList as new JSONItem
		  for each filename as string in self.Filelist
		    tempList.add(filename)
		    
		  next
		  
		  OutputJSON = new JSONItem
		  
		  OutputJSON.Value(Configuration.KeyForManifest) = tempList
		  OutputJSON.Value(Configuration.KeyForTables) = FormattedData
		  
		  OutputJSON.Compact = False
		  
		  if self.destination = nil then return 
		  
		  var TextFile as TextOutputStream = TextOutputStream.Create(self.destination) 
		  TextFile.Write(OutputJSON.ToString)
		  
		  TextFile.close
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(DestinationFileOrFolder as FolderItem, config as clJSONFileConfig)
		  
		  self.header =new Dictionary
		  
		  self.Destination = DestinationFileOrFolder
		  
		  self.InternalInitConfiguration(config)
		  
		  self.FormattedData = new JSONItem
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub DefineColumns(DatasetName as string, ColumnName() as string)
		  // Part of the TableRowWriterInterface interface.
		  var temp() as string
		  
		  self.DefineColumns(DatasetName, ColumnName, temp)
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub DefineColumns(pDatasetName as string, pColumnName() as string, pColumnType() as string)
		  // Part of the TableRowWriterInterface interface.
		  
		  var d() as Dictionary
		  
		  self.ColumnNames.RemoveAll
		  
		  for i as integer = 0 to pColumnName.LastIndex
		    var TempColumnName as String = pColumnName(i).Trim
		    self.ColumnNames.add(pColumnName(i).trim)
		    
		    var TempColumnType as string = clDataType.VariantValue
		    
		    if pColumnType.LastIndex < i then
		      TempColumnType = pColumnType(i)
		    end if
		    
		    d.Add(new Dictionary(self.Configuration.KeyforFieldName: TempColumnName, self.Configuration.KeyforFieldType:TempColumnType))
		  next
		  
		  Header.value(self.Configuration.KeyForDatasetName)  = pDatasetName
		  Header.value(self.Configuration.KeyForListOfColumns) = d
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub DoneWithTable()
		  // Part of the TableRowWriterInterface interface.
		  
		  
		  
		  if self.Filelist.Count = 0 then // single table
		    
		    OutputJSON = new JSONItem
		    
		    OutputJSON.Value(Configuration.KeyForHeader) = Header
		    OutputJSON.Value(Configuration.KeyForData)  = rows
		    
		    OutputJSON.Compact = False
		    
		    if self.destination = nil then return 
		    
		    var TextFile as TextOutputStream = TextOutputStream.Create(self.destination) 
		    TextFile.Write(OutputJSON.ToString)
		    
		    TextFile.close
		    
		    return 
		    
		  else
		    var tempJSON as  new JSONItem
		    var tempRows as new JSONItem
		    
		    // Need to copy the content of the array
		    for each d as Dictionary in rows
		      tempRows.add(d)
		      
		    next
		    
		    tempJSON.Value(Configuration.KeyForHeader) = Header
		    tempJSON.value(Configuration.KeyForData) = tempRows
		    
		    var checks as String = tempJSON.ToString
		    
		    
		    FormattedData.Add(tempJSON)
		    
		    self.Header = new Dictionary
		    self.rows.RemoveAll
		    
		    return 
		    
		  end if
		  
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetJSON() As JSONItem
		  return OutputJSON
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub InternalInitConfiguration(config as clJSONFileConfig)
		  
		  if config = nil then
		    self.Configuration = new clJSONFileConfig
		    
		  else
		    self.Configuration = config
		    
		  end if
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub UpdateExternalName(new_name as string)
		  // Part of the TableRowWriterInterface interface.
		  
		  Filelist.Add(new_name)
		  
		  self.Header = new Dictionary
		  self.rows.RemoveAll
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h1
		Protected ColumnNames() As string
	#tag EndProperty

	#tag Property, Flags = &h21
		Private Configuration As clJSONFileConfig
	#tag EndProperty

	#tag Property, Flags = &h21
		Private Destination As FolderItem
	#tag EndProperty

	#tag Property, Flags = &h0
		Filelist() As String
	#tag EndProperty

	#tag Property, Flags = &h0
		FormattedData As JSONItem
	#tag EndProperty

	#tag Property, Flags = &h21
		Private Header As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private OutputJSON As JSONItem
	#tag EndProperty

	#tag Property, Flags = &h21
		Private Rows() As Dictionary
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
