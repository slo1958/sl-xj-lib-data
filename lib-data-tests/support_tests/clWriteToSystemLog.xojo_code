#tag Class
Class clWriteToSystemLog
Implements support_tests.LogMessageInterface
	#tag Method, Flags = &h0
		Sub end_exec(method as string)
		  write_message("Done with " + method)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub start_exec(method as string)
		  write_message("Starting " + method)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub write_message(msg as string)
		  // Part of the support_tests.logmessage_writer interface.
		  System.DebugLog(msg)
		  
		  
		End Sub
	#tag EndMethod


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
