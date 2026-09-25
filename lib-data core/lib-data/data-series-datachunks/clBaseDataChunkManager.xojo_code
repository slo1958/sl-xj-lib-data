#tag Class
Protected Class clBaseDataChunkManager
	#tag Method, Flags = &h1
		Protected Sub allocateNewChunk()
		  
		  var tmp as clAbstractDataChunk = self.mChunkAllocator.invoke(mChunkHandlingPolicy)
		  
		  dataChunks.Add(tmp)
		  
		  return
		  
		End Sub
	#tag EndMethod

	#tag DelegateDeclaration, Flags = &h0
		Delegate Function ChunkAllocator(policy as clDataChunkManagerPolicy) As clAbstractDataChunk
	#tag EndDelegateDeclaration

	#tag Method, Flags = &h0
		Sub Constructor(allocator as ChunkAllocator, policy as clDataChunkManagerPolicy)
		  
		  self.mChunkAllocator = allocator
		  
		  if policy = nil then 
		    self.mChunkHandlingPolicy = clDataChunkManagerPolicy.getDefaultPolicy()
		    
		  else
		    self.mChunkHandlingPolicy = policy.Clone
		    
		  end if
		  
		  self.allocateNewChunk
		  
		  Return
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getChunk(chunkIndex as integer) As clAbstractDataChunk
		  //
		  // get a data chunk
		  // 
		  // i
		  //
		  // Parameters
		  // - Index of dataChunk to be returned 
		  //
		  // Returns
		  // pointer to datachunk or nil
		  //
		  
		  
		  if (0 <= chunkIndex) and (chunkIndex <= self.dataChunks.LastIndex)   then 
		    return self.dataChunks(chunkIndex)
		    
		  else
		    return nil
		    
		  end if
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetChunkWithFreeSpace() As clAbstractDataChunk
		  //
		  // Returns the chunck which can be used to add a new element
		  //
		  // Parameters
		  // (none)
		  //
		  // Returns
		  // pointer to chunck with free space
		  //
		  
		  //
		  // Hypothesis: always adding to the last data chunck
		  //
		  var dataChunkIndex as integer = dataChunks.LastIndex
		  
		  if dataChunkIndex < 0 then return nil
		  
		  if self.dataChunks(dataChunkIndex).canAddElement then
		    
		  else
		    self.allocateNewChunk()
		    dataChunkIndex = dataChunks.LastIndex
		    
		  end if
		   
		  return dataChunks(dataChunkIndex)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetElementLocation(index as integer) As pair
		  //
		  // Returns the chunck number and the row number in the chunk as a pair
		  //
		  // Parameters
		  // - index of the element to retrieve
		  //
		  // Returns
		  // chunck number and row number as a pair
		  //
		  
		  var b as integer = 0
		  
		  for chkIndex as integer = 0 to self.dataChunks.LastIndex
		    
		    var  c as clAbstractDataChunk = self.dataChunks(chkIndex)
		    
		    if ( b <= index) and (index <= b+c.UsedSize) then
		      
		      return (chkIndex: index - b)
		    else
		      b = b + c.UsedSize
		      
		    end if
		    
		  next
		  
		  return (-1:-1)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function RowCount() As integer
		  //
		  // Get total row count
		  // Parameters
		  // (none)
		  //
		  // Returns
		  // total row count
		  //
		  
		  var total as integer
		  
		  for each c as clAbstractDataChunk in self.dataChunks
		    total = total + c.UsedSize
		    
		  next
		  
		  return total
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SummaryToLog(log as clLogManager, IncludePolicy as Boolean = true)
		  
		  if log = nil then Return
		  
		  log.WriteMessage(CurrentMethodName, "Number of chunks: %0", dataChunks.Count.ToString)
		  self.dataChunks(self.dataChunks.LastIndex).SummaryToLog(log)
		  if IncludePolicy then mChunkHandlingPolicy.policyToLog(log)
		  log.WriteMessage(CurrentMethodName, "----")
		  
		  Return
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h1
		Protected dataChunks() As clAbstractDataChunk
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mChunkAllocator As ChunkAllocator
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mChunkHandlingPolicy As clDataChunkManagerPolicy
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
