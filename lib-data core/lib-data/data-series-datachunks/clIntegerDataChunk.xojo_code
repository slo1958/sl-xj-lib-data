#tag Class
Protected Class clIntegerDataChunk
Inherits clAbstractDataChunk
	#tag Method, Flags = &h0
		Function AddElement(value as integer) As Boolean
		  if self.canGrow() then
		    self.values.Add(value)
		    return true
		    
		  elseif self.hasSpace() then
		    self.mLastUsedIndex = self.mLastUsedIndex + 1
		    self.values(self.mLastUsedIndex) = value
		    return true
		    
		  else
		    Return false
		    
		  end if 
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function AllocatedSize() As integer
		  //  
		  //  Returns the allocated size
		  //
		  //  Parameters
		  //  (none)
		  //  
		  //  Returns:
		  //  - the allocated size
		  //
		  
		  return values.Count
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function Allocator(policy as clDataChunkManagerPolicy) As clAbstractDataChunk
		  return new clIntegerDataChunk(policy)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(policy as clDataChunkManagerPolicy)
		  // Calling the overridden superclass constructor.
		  Super.Constructor(policy)
		  
		  if policy.isDynamic() then
		    self.Values.RemoveAll
		    
		  else
		    // ResizeTo expects the last index, not the count
		    self.values.ResizeTo(policy.FixedSize-1)
		    
		  end if
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getIntegerValue(index as Integer) As integer
		  
		  if (0 <= index and index <= values.LastIndex) then 
		    return self.values(index)
		    
		  else
		    return 0
		    
		  end if
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub internalGrow(requestedNewSize as integer)
		  
		  self.values.ResizeTo(requestedNewSize)
		  
		  Return
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setIntegerValue(index as Integer, value as Integer)
		  
		  if (0 <= index) and (index <= values.LastIndex) then 
		     self.values(index) = value
		    
		  else
		    
		  end if
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		values() As Integer
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
			Name="values()"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
