#tag Class
Protected Class clLogingMethodTimer
	#tag Method, Flags = &h0
		Sub Constructor(prmName as string)
		  
		  self.MethodName = prmName
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub EnterMethod()
		  
		  timers.Add(new clLogingTaskTimer(self.MethodName))
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ExitMethod()
		  
		  if timers.Count = 0 then return
		  
		  timers(timers.LastIndex).Done
		  
		  return
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MethodStats() As pair
		  
		  var count as integer
		  var totexecution as Double
		  
		  for each entry as clLogingTaskTimer in self.Timers
		    if entry.Completed then 
		      
		    else
		      count = count + 1
		      totexecution = totexecution + entry.GetExecutionTime
		    end if
		    
		  next
		  
		  return count:totexecution
		  
		  
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0
		MethodName As string
	#tag EndProperty

	#tag Property, Flags = &h0
		Timers() As clLogingTaskTimer
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
			Name="MethodName"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="string"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
