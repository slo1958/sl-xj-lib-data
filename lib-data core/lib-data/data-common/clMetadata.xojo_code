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
		Sub Add(MetadataCategory as string, MetadataType as string, Message as string)
		  //
		  // Add an entry to the metadata
		  //
		  // Parameters:
		  // - MetadataCategory (string): category of metadata
		  // - MetadataType (string) : type of information added
		  // - message (string) : details
		  //
		  // Return
		  // (none)
		  //
		  
		  DataList.Add(new clMetadataEntry(MetadataCategory, MetadataType, Message))
		  
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
		Sub AppendFrom(source as clMetadata)
		  
		  for i as integer = 0 to source.LastIndex
		    self.Add(MetadataAt(i).Clone)
		    
		  next
		  
		  Return
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Clear()
		  //
		  // Cleanup all metadata
		  //
		  
		  self.DataList.RemoveAll
		  
		  return
		  
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
		Function CountFiltered(filterOnCategory as string, filterOnType as string) As integer
		  //
		  // Count the number of occurence of the passed datacategory and datatype exists in the metadata
		  //
		  // Parameters:
		  // - filterOnCategory (string): optional filter on metadata category, empty string means no filter
		  // - filterOnType (string): option filter on metadata type, empty string means no filter
		  //
		  // Returns
		  // number of entries matching the filter
		  //
		  
		  var cnt as integer = 0
		  for each m as clMetadataEntry in self.DataList
		    if  (filterOnCategory.trim.Length = 0 or filterOnCategory.trim = m.CategoryValue) _
		    and (filterOnType.trim.Length = 0 or filterOnType.trim = m.TypeValue) then cnt = cnt + 1
		    
		  next
		  
		  return cnt
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ExtractFiltered(filterOnCategory as string, filterOnType as string) As clMetadataEntry()
		  //
		  // Return all metadata entries matching the filters
		  //
		  // Parameters:
		  // - filterOnCategory (string): optional filter on metadata category, empty string means no filter
		  // - filterOnType (string): option filter on metadata type, empty string means no filter
		  //
		  // Returns
		  // list of selected metadata entries
		  //
		  
		  var filteredList() as clMetadataEntry
		  
		  
		  for each m as clMetadataEntry in self.DataList
		    if  (filterOnCategory.trim.Length = 0 or filterOnCategory.trim = m.CategoryValue) _
		    and (filterOnType.trim.Length = 0 or filterOnType.trim = m.TypeValue) then filteredList.Add(m)
		    
		  next
		  
		  return filteredList
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function HasData(filterOnCategory as string, filterOnType as string) As boolean
		  //
		  // Check if the passed datatype exists in the metadata
		  //
		  // Parameters:
		  // - filterOnCategory (string): optional filter on metadata category, empty string means no filter
		  // - filterOnType (string): option filter on metadata type, empty string means no filter
		  //
		  // Returns
		  // boolean
		  //
		  
		  
		  for each m as clMetadataEntry in self.DataList
		    if  (filterOnCategory.trim.Length = 0 or filterOnCategory.trim = m.CategoryValue) _
		    and (filterOnType.trim.Length = 0 or filterOnType.trim = m.TypeValue) then return true
		    
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

	#tag Method, Flags = &h0
		Sub RemoveEntries(CategoryToRemove as string, TypeToRemove as string)
		  //
		  // Remove all metadata entries matching the filters
		  //
		  // Parameters:
		  // - CategoryToRemove (string): optional filter on metadata category, empty string means no filter
		  // - TypeToRemove (string): option filter on metadata type, empty string means no filter
		  //
		  // Returns
		  // list of selected metadata entries
		  //
		  
		  var filteredList() as clMetadataEntry
		  
		  for each m as clMetadataEntry in self.DataList
		    if  CategoryToRemove.trim <> m.CategoryValue  and CategoryToRemove.trim.Length > 0 then
		      filteredList.add(m)
		      
		    elseif TypeToRemove.trim <> m.TypeValue and TypeToRemove.trim.Length > 0 then
		      filteredList.add(m)
		      
		    else
		      
		    end if
		    
		    
		  next
		  
		  self.DataList = filteredList
		  
		  return
		  
		  
		End Sub
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
