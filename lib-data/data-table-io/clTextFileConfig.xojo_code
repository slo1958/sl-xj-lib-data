#tag Class
Class clTextFileConfig
	#tag Method, Flags = &h0
		Sub Constructor()
		  Self.FieldSeparator = chr(9)
		  
		  self.enc = Encodings.UTF8
		  
		  self.QuoteCharacter = """"
		  
		  self.DefaultNumberFormat = "-##########0.0##########"
		  
		  self.file_extension = ".csv"
		  
		  self.UseLocalFormatting = False
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(sep as string)
		  Self.FieldSeparator = sep
		  
		  self.enc = Encodings.UTF8
		  
		  self.QuoteCharacter = """"
		  
		  self.DefaultNumberFormat = "-##########0.0##########"
		  
		  self.file_extension = ".csv"
		  
		  self.UseLocalFormatting = False
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(sep as string, encoding as TextEncoding, quote_char as string = "")
		  Self.FieldSeparator = sep
		  
		  self.enc = encoding
		  
		  if QuoteCharacter.Length>0 then
		    self.QuoteCharacter = QuoteCharacter.Left(1)
		    
		  else
		    self.QuoteCharacter = """"
		    
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
		Sub UpdateNumberFormat(NewFormat as string)
		  DefaultNumberFormat = NewFormat
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		DefaultNumberFormat As string
	#tag EndProperty

	#tag Property, Flags = &h0
		enc As TextEncoding
	#tag EndProperty

	#tag Property, Flags = &h0
		FieldSeparator As String
	#tag EndProperty

	#tag Property, Flags = &h0
		file_extension As String
	#tag EndProperty

	#tag Property, Flags = &h0
		QuoteCharacter As String
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
			Name="FieldSeparator"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="QuoteCharacter"
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
