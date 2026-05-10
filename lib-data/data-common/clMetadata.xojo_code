#tag Class
Protected Class clMetadata
	#tag Method, Flags = &h0
		Sub Add(item as clMetadataEntry)
		  
		  self.DataList.Add(item)
		  
		  return
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Add(MetadataType as string, Message as string)
		  //
		  // Add an entry to the metadata
		  //
		  // Parameters:
		  // - MetadataType (string) : type of information added
		  // - message (string) : details
		  //
		  // Return
		  // (none)
		  //
		  
		  DataList.Add(new clMetadataEntry(MetadataType, Message))
		  
		  return
		  
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AddSource(DataSource as string)
		  //
		  // Add an entry to the metadata, with key indicating source
		  //
		  // Parameters:
		  // - Datasource (string) : source of the data
		  //
		  
		  
		  self.Add(self.KeyForSource, DataSource.trim)
		  
		  return
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function AllFormattedData(Sep as String, filterOn as string = "") As string()
		  //
		  // Returns all metadata as an array of string
		  // 
		  // Parameters:
		  // - sep (string) : separator to use between datatype and message
		  // - filter on (string): optional filter on datatype
		  //
		  // Returns
		  // Array of string, one entry per enty in list of metadata, datatype and message separated by ":"
		  //
		  
		  var ret() as string
		  
		  for each m as clMetadataEntry in self.DataList
		    if filterOn.trim.Length = 0 or filterOn.trim = m.TypeValue then ret.Add(m.TypeValue + sep + m.DataValue)
		    
		  next
		  
		  return ret
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AppendFrom(source as clMetadata)
		  
		  for i as integer = 0 to source.LastIndex
		    self.Add(MetadataAt(i).Clone)
		    
		  next
		  
		  Return
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Clear(DataType as string = "")
		  //
		  // Cleanup all metadata
		  //
		  
		  if DataType.trim.Length = 0 then
		    DataList.RemoveAll
		    
		    return 
		    
		  end if
		  
		  var new_list() as clMetadataEntry
		  
		  
		  for each m as clMetadataEntry in self.DataList
		    if m.TypeValue<> DataType.trim then new_list.Add(m)
		    
		  next
		  
		  self.DataList = new_list
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Clone() As clMetadata
		  //
		  // Clone all metadata
		  //
		  
		  var ret as new clMetadata
		  
		  for each m as clMetadataEntry in self.DataList
		    ret.add(m.Clone)
		    
		  next
		  
		  return ret
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Count() As integer
		  //
		  // Returns number of items in the list of metadata
		  //
		  
		  return DataList.Count
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function CountDataType(MetadataType as string) As integer
		  //
		  // Count the number of occurence of the passed datatype exists in the metadata
		  //
		  // Parameters:
		  // - Metadata type (string) : type of information searched
		  //
		  
		  var ret as integer
		  for each m as clMetadataEntry in self.DataList
		    
		    if m.TypeValue = MetadataType then ret = ret + 1
		    
		  next
		  
		  return ret
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function HasDataType(MetadataType as string) As boolean
		  //
		  // Check if the passed datatype exists in the metadata
		  //
		  // Parameters:
		  // - Metadata type (string) : type of information searched
		  //
		  
		  for each m as clMetadataEntry in self.DataList
		    if m.TypeValue = MetadataType then return true
		    
		  next
		  
		  return false
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function LastIndex() As integer
		  
		  //
		  // Returns Lastindex of the list of metadata
		  //
		  
		  return DataList.LastIndex
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MetadataAt(rowindex as Integer) As clMetadataEntry
		  //
		  // Returns the metadata entry at rowindex
		  //
		  // Parameters:
		  //  - rowindex (integer) index of the entry to be returned
		  // 
		  // Returns
		  //  - clMetadataEntry
		  //
		  
		  var m as clMetadataEntry 
		  
		  
		  try
		    m = self.DataList(rowindex).Clone
		    
		  catch 
		    m = nil
		    
		  end Try
		  
		  return m 
		  
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private DataList() As clMetadataEntry
	#tag EndProperty


	#tag Constant, Name = KeyForSource, Type = String, Dynamic = False, Default = \"source", Scope = Public
	#tag EndConstant


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
