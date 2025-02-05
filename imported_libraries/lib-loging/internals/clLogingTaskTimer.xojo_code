#tag Class
Protected Class clLogingTaskTimer
	#tag Method, Flags = &h0
		Sub Constructor(pTaskId as string)
		  identifier = pTaskId
		  start_time = DateTime.now
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Done()
		  end_time = DateTime.now
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetExecutionTime() As double
		  
		  
		  var interval as integer
		  
		  interval = end_time.Nanosecond - start_time.Nanosecond
		  
		  Return interval / 100000000
		  
		  
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0
		end_time As DateTime
	#tag EndProperty

	#tag Property, Flags = &h0
		identifier As String
	#tag EndProperty

	#tag Property, Flags = &h0
		start_time As DateTime
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
	#tag EndViewBehavior
End Class
#tag EndClass
