#tag Class
Protected Class clCurrencyLocalFormatting
Implements CurrencyFormatInterface
	#tag Method, Flags = &h0
		Sub Constructor(formatStr as string)
		  
		  self.FormatString = formatStr
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function FormatCurrency(the_value as Currency) As string
		  // Part of the CurrencyFormatInterface interface.
		  
		  return format(the_value, self.FormatString)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetInfo() As string
		  Return self.FormatString
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0
		FormatString As String
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
			Name="FormatString"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
