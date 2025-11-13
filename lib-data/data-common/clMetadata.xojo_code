#tag Class
Protected Class clMetadata
	#tag Method, Flags = &h0
		Sub Add(MetadataType as string, Message as string)
		  //
		  // Add an entry to the metadata
		  //
		  // Parameters:
		  // - Metadata type (string) : type of information added
		  // - message (string) : details
		  //
		  
		  var dtp as string = MetadataType.ReplaceAll(":","-")
		  var msg as string = Message.Trim
		  
		  var p as pair = (dtp:msg)
		  
		  DataList.Add(p)
		  
		  
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
		  
		  for each p as pair in self.DataList
		    if filterOn.trim.Length = 0 or filterOn.trim = p.left then ret.Add(p.left + sep + p.right)
		    
		  next
		  
		  return ret
		  
		End Function
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
		  
		  var new_list() as pair
		  
		  for each p as pair in self.DataList
		    if p.Left <> DataType.trim then new_list.Add(p)
		    
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
		  
		  for each p as pair in self.DataList
		    ret.Add(p.left, p.Right)
		    
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
		  for each p as pair in self.DataList
		    
		    if p.left = MetadataType then ret = ret + 1
		    
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
		  
		  for each p as pair in self.DataList
		    
		    if p.left = MetadataType then return true
		    
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
		Function MetadataAt(rowindex as Integer) As string()
		  //
		  // Returns the metadata entry at rowindex
		  //
		  // Parameters:
		  //  - rowindex (integer) index of the entry to be returned
		  // 
		  // Returns
		  //  - string array with two elements (Datatype and message)
		  //
		  
		  var ret() as string
		  ret.Add("")
		  ret.Add("")
		  
		  try
		    var p as pair = DataList(rowindex)
		    ret(0) = p.Left
		    ret(1) = p.Right
		    
		    
		  catch 
		    
		  end Try
		  
		  return ret 
		  
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private DataList() As pair
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
