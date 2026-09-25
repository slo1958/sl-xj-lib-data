#tag Class
Protected Class clAbstractDataChunk
	#tag Method, Flags = &h0
		Function AllocatedSize() As integer
		  //  
		  //  Returns the allocated size(only implemented in type specific subclasses)
		  //
		  //  Parameters
		  //  (none)
		  //  
		  //  Returns:
		  //  - the allocated size
		  //
		  
		  Raise New clDataException("Unimplemented method " + CurrentMethodName)
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function canAddElement() As Boolean
		  
		  return self.canGrow() or self.hasSpace()
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function canGrow() As Boolean
		  
		  return  self.mPolicy.isDynamic and ( self.AllocatedSize < self.mPolicy.MaximumSize or self.mpolicy.isUnlimited)
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(policy as clDataChunkManagerPolicy)
		  
		  self.mPolicy = policy
		  self.mLastUsedIndex = -1
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function hasSpace() As Boolean
		  
		  return (not self.mPolicy.isDynamic) and (self.UsedSize < self.AllocatedSize)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SummaryToLog(log as clLogManager)
		  if log = nil then return
		  
		  log.WriteMessage(CurrentMethodName, "Last used index: %0, used size %1", mLastUsedIndex.ToString, self.UsedSize.ToString)
		  log.WriteMessage(CurrentMethodName, "Allocated size: %0", AllocatedSize.ToString)
		  log.WriteMessage(CurrentMethodName, "canGrow %0, hasSpace %1", self.canGrow.ToString, self.hasSpace.ToString)
		  
		  return
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function UsedSize() As integer
		  
		  if mPolicy.isDynamic then
		    Return AllocatedSize
		    
		  else
		    return mLastUsedIndex+1
		    
		  end if
		  
		End Function
	#tag EndMethod


	#tag Note, Name = Hanlding data chunks
		
		The abstract data chunk does not store data. Type specific subclass will take care of that
		
		Two allocation options
		- static allocation: an array of fixed size is pre-allocated
		- dynamic allocation: an empty array is allocated and can grow up to maximum size
		
		Method canAddElement() indicates if a new element can be added to the existing chunk
		
		
		
		
	#tag EndNote


	#tag Property, Flags = &h1
		Protected mLastUsedIndex As Integer
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mPolicy As clDataChunkManagerPolicy
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
