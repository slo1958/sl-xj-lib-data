#tag Class
Protected Class clGenericLogWriter
Implements itfLogWriter
	#tag Method, Flags = &h1
		Protected Function AcceptSeverity(MessageSeverity as string) As Boolean
		  // 
		  // Returns the status of the severity filter
		  //
		  // Parameters:
		  // - severity
		  //
		  // Returns:
		  //  Status of the severity filter
		  //
		  
		  return self.AcceptedSeverity.Value(MessageSeverity)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AddLogEntry(MessageSeverity as string, MessageTime as string, MessageSource as string, MessageText as string)
		  // Part of the itfLogingWriter interface.
		  
		  // Should be implemented in child classes
		  
		  
		  #Pragma unused MessageSeverity
		  #Pragma unused MessageTime
		  #Pragma unused MessageSource
		  #Pragma unused MessageText
		  
		  Raise New RuntimeException("Unimplemented method " + CurrentMethodName)
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  
		  self.AcceptedSeverity = new Dictionary
		  
		  Self.AcceptedSeverity.Value(cstSeverityFatalError) = true
		  Self.AcceptedSeverity.Value(cstSeverityError) = true
		  Self.AcceptedSeverity.Value(cstSeverityWarning) = true 
		  self.AcceptedSeverity.Value(cstSeverityMessage) = true
		  self.AcceptedSeverity.Value(cstSeverityInformation) = true
		  self.AcceptedSeverity.Value(cstSeverityStatistics) = True
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub UpdateSeverityFilter(SeverityLevel as string, AllowOutput as Boolean)
		  
		  
		  self.AcceptedSeverity.Value(SeverityLevel) = AllowOutput
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private AcceptedSeverity As Dictionary
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
