#tag Class
Protected Class clDataChunkManagerPolicy
	#tag Method, Flags = &h0
		Function Clone() As clDataChunkManagerPolicy
		  var temp as new clDataChunkManagerPolicy(0, mode.lateUpdate)
		  
		  temp.fixedChunkSize = self.fixedChunkSize
		  temp.maximumChunkSize = self.maximumChunkSize
		  temp.mDynamic = self.mDynamic
		  
		  return temp
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(value as integer, handlingMode as mode)
		  
		  select case handlingMode 
		    
		  case mode.StaticAllocation
		    self.maximumChunkSize = -1
		    self.fixedChunkSize = value
		    self.mDynamic = false
		    
		  case mode.DynamicAllocation
		    self.maximumChunkSize = value
		    self.fixedChunkSize = -1
		    self.mDynamic = true
		    
		  case mode.unlimitedDynamic
		    self.maximumChunkSize = -1
		    self.fixedChunkSize = -1
		    self.mDynamic = true
		    
		  case mode.lateUpdate
		    self.maximumChunkSize = -1
		    self.fixedChunkSize = -1
		    self.mDynamic = false
		    
		  case else
		    self.maximumChunkSize = -1
		    self.fixedChunkSize = -1
		    self.mDynamic = false
		    
		  end select
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function FixedSize() As integer
		  return fixedChunkSize
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function getDefaultPolicy() As clDataChunkManagerPolicy
		  
		  return new clDataChunkManagerPolicy(-1, mode.unlimitedDynamic)
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function isDynamic() As Boolean
		  Return self.mDynamic
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function isUnlimited() As Boolean
		  
		  return self.isDynamic and maximumChunkSize < 0
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MaximumSize() As integer
		  return maximumChunkSize
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub policyToLog(log as clLogManager)
		  
		  if log = nil then Return
		  
		  log.WriteInfo(CurrentMethodName, "Fixed Chunk Size:%0", self.fixedChunkSize.ToString)
		  log.WriteInfo(CurrentMethodName, "Maximum Chunk Size:%0", self.maximumChunkSize.ToString)
		  log.WriteInfo(CurrentMethodName, "Dynamic mode :%0", self.mDynamic.ToString)
		  
		  Return
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h1
		Protected fixedChunkSize As Integer
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected maximumChunkSize As Integer
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mDynamic As Boolean
	#tag EndProperty


	#tag Enum, Name = mode, Type = Integer, Flags = &h0
		StaticAllocation
		  DynamicAllocation
		  unlimitedDynamic
		lateUpdate
	#tag EndEnum


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
			Name="mDynamic"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
