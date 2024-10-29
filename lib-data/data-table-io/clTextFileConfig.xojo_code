#tag Class
Class clTextFileConfig
	#tag Method, Flags = &h0
		Sub Constructor()
		  Self.field_separator = chr(9)
		  
		  self.enc = Encodings.UTF8
		  
		  self.quote_char = """"
		  
		  self.DefaultNumberFormat = "-##########0.0##########"
		  
		  self.file_extension = ".csv"
		  
		  self.UseLocalFormatting = False
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(sep as string)
		  Self.field_separator = sep
		  
		  self.enc = Encodings.UTF8
		  
		  self.quote_char = """"
		  
		  self.DefaultNumberFormat = "-##########0.0##########"
		  
		  self.file_extension = ".csv"
		  
		  self.UseLocalFormatting = False
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(sep as string, encoding as TextEncoding, quote_char as string = "")
		  Self.field_separator = sep
		  
		  self.enc = encoding
		  
		  if quote_char.Length>0 then
		    self.quote_char = quote_char.Left(1)
		    
		  else
		    self.quote_char = """"
		    
		  end if
		  
		  self.DefaultNumberFormat = "-##########0.0##########"
		  
		  self.file_extension = ".csv"
		  
		  self.UseLocalFormatting = False
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub EnableLocalFormatting()
		  UseLocalFormatting = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub UpdateNumberFormat(new_format as string)
		  DefaultNumberFormat = new_format
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		DefaultNumberFormat As string
	#tag EndProperty

	#tag Property, Flags = &h0
		enc As TextEncoding
	#tag EndProperty

	#tag Property, Flags = &h0
		field_separator As String
	#tag EndProperty

	#tag Property, Flags = &h0
		file_extension As String
	#tag EndProperty

	#tag Property, Flags = &h0
		quote_char As String
	#tag EndProperty

	#tag Property, Flags = &h0
		UseLocalFormatting As Boolean
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
			Name="field_separator"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="quote_char"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="DefaultNumberFormat"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="string"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="file_extension"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="UseLocalFormatting"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
