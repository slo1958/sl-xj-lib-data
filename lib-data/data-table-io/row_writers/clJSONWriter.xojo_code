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
		  
		  raise new clDataException("Unexpected call to addrow from dictionary.")
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(the_destination_path as FolderItem, config as clJSONFileConfig)
		  self.Destination = the_destination_path
		  self.Configuration = config
		  
		  self.header =new Dictionary
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
		Sub done()
		  // Part of the TableRowWriterInterface interface.
		  
		  
		  OutputJSON =  new JSONItem
		  
		  OutputJSON.Value(Configuration.KeyForHeader) = Header
		  OutputJSON.value(Configuration.KeyForData) = rows
		  
		  OutputJSON.Compact = False
		  
		  if self.destination = nil then return 
		  
		  var txt as TextOutputStream = TextOutputStream.Create(self.destination) 
		  txt.Write(OutputJSON.ToString)
		  
		  txt.close
		  
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

	#tag Method, Flags = &h0
		Sub UpdateExternalName(new_name as string)
		  // Part of the TableRowWriterInterface interface.
		  
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private Configuration As clJSONFileConfig
	#tag EndProperty

	#tag Property, Flags = &h21
		Private Destination As FolderItem
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
