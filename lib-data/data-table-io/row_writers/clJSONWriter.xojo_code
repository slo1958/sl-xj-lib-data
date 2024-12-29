#tag Class
Protected Class clJSONWriter
Implements TableRowWriterInterface
	#tag Method, Flags = &h0
		Sub AddRow(row_data as Dictionary)
		  
		  self.Rows.Add(row_data)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AddRow(row_data() as variant)
		  // Part of the TableRowWriterInterface interface.
		  
		  raise new clDataException("Unexpected call to addrow from array.")
		  
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
		  
		  var txt as TextOutputStream = TextOutputStream.Create(self.destination) 
		  txt.Write(OutputJSON.ToString)
		  
		  txt.close
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(the_destination_path as FolderItem, config as clJSONFileConfig)
		  
		  self.header =new Dictionary
		  
		  self.Destination = the_destination_path
		  
		  self.InternalInitConfiguration(config)
		  
		  self.FormattedData = new JSONItem
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub DefineMetadata(DatasetName as string, ColumnName() as string)
		  // Part of the TableRowWriterInterface interface.
		  var temp() as string
		  
		  self.DefineMetadata(DatasetName, ColumnName, temp)
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub DefineMetadata(DatasetName as string, ColumnName() as string, ColumnType() as string)
		  // Part of the TableRowWriterInterface interface.
		  
		  var d() as Dictionary
		  
		  for i as integer = 0 to ColumnName.LastIndex
		    var TempColumnName as String = ColumnName(i).Trim
		    
		    var TempColumnType as string = clDataType.VariantValue
		    
		    if ColumnType.LastIndex < i then
		      TempColumnType = ColumnType(i)
		    end if
		    
		    d.Add(new Dictionary(self.Configuration.KeyforFieldName: TempColumnName, self.Configuration.KeyforFieldType:TempColumnType))
		  next
		  
		  Header.value(self.Configuration.KeyForDatasetName)  = DatasetName
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
		    
		    var txt as TextOutputStream = TextOutputStream.Create(self.destination) 
		    txt.Write(OutputJSON.ToString)
		    
		    txt.close
		    
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
		Function ExpectsDictionary() As Boolean
		  return True
		End Function
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
