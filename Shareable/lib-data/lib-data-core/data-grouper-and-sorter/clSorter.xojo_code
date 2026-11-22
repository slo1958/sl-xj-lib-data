#tag Class
Protected Class clSorter
	#tag Method, Flags = &h0
		Sub Constructor(SortColumns() as clAbstractDataSerie, order as SortOrder)
		  
		  var b as new clSorterBlock()
		  
		  if SortColumns.Count < 1 then Return
		  
		  
		  for rowindex as integer = 0 to SortColumns(0).LastIndex
		    var keys() as variant
		    
		    for each col as clAbstractDataSerie in SortColumns
		      if col <> nil then keys.Add(col.GetElement(rowindex))
		      
		    next
		    
		    b.add(keys, rowindex)
		    
		  next
		  
		  blocks.add(b)
		  
		  SortMergeBlocks(order)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetSortedListOfIndexes() As pair()
		  
		  return blocks(0).SortData
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub SortMergeBlocks(order as SortOrder)
		  //
		  // Sort each block, then do sorted merge
		  //
		  
		  // Initial implementation supports only one block
		  
		  blocks(0).Sort(order)
		  
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		blocks() As clSorterBlock
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
