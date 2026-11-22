#tag Class
Protected Class clLogingTaskTimer
	#tag Method, Flags = &h0
		Function Completed() As Boolean
		  return end_time > 0
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(pTaskId as string)
		  identifier = pTaskId
		  start_time = System.Microseconds
		  end_time = -1
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Done()
		  end_time = System.Microseconds
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetExecutionTime() As double
		  if end_time > 0 then
		    return (end_time - start_time) / 1000000
		    
		  else
		    return 0
		    
		  end if
		  
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0
		end_time As Double
	#tag EndProperty

	#tag Property, Flags = &h0
		identifier As String
	#tag EndProperty

	#tag Property, Flags = &h0
		start_time As Double
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="identifier"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
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
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
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
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="end_time"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Double"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="start_time"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Double"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
