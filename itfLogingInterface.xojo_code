#tag Interface
Protected Interface itfLogingInterface
	#tag Method, Flags = &h0
		Sub WriteError(MessageSource as string, MessageText as string, ParamArray the_parameters as variant)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub WriteFatalError(MessageSource as string, MessageText as string, ParamArray the_parameters as variant)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub WriteInfo(MessageSource as string, MessageText as string, ParamArray the_parameters as Variant)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub WriteStatistics(MessageText as string, ParamArray the_parameters as Variant)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub WriteSummary()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub WriteWarning(MessageSource as string, MessageText as string, ParamArray the_parameters as variant)
		  
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
End Interface
#tag EndInterface
