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
		Sub DefineMetadata(name as string, columns() as string)
		  // Part of the TableRowWriterInterface interface.
		  var temp() as string
		  
		  self.DefineMetadata(name, columns, temp)
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub DefineMetadata(DatasetName as string, columns() as string, column_type() as string)
		  // Part of the TableRowWriterInterface interface.
		  
		  var d() as Dictionary
		  
		  for i as integer = 0 to columns.LastIndex
		    var ColumnName as String = columns(i)
		    
		    var ColumnType as string = clDataType.VariantValue
		    
		    if column_type.LastIndex < i then
		      ColumnType = column_type(i)
		    end if
		    
		    d.Add(new Dictionary(self.Configuration.KeyforFieldName: ColumnName, self.Configuration.KeyforFieldType:ColumnType))
		  next
		  
		  Header.value(self.Configuration.KeyForDatasetName)  = DatasetName
		  Header.value(self.Configuration.KeyForListOfColumns) = d
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub done()
		  // Part of the TableRowWriterInterface interface.
		  
		  
		  var output_json as new JSONItem
		  
		  output_json.Value(Configuration.KeyForHeader) = Header
		  output_json.value(Configuration.KeyForData) = rows
		  
		  output_json.Compact = False
		   
		  if self.destination = nil then return 
		  
		  var txt as TextOutputStream = TextOutputStream.Create(self.destination) 
		  txt.Write(output_json.ToString)
		  
		  txt.close
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ExpectsDictionary() As Boolean
		  return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub UpdateExternalName(new_name as string)
		  // Part of the TableRowWriterInterface interface.
		  
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		Configuration As clJSONFileConfig
	#tag EndProperty

	#tag Property, Flags = &h0
		Destination As FolderItem
	#tag EndProperty

	#tag Property, Flags = &h0
		Header As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h0
		Rows() As Dictionary
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
			Name="Header"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
