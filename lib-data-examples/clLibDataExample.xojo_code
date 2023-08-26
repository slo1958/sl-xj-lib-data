#tag Class
Protected Class clLibDataExample
	#tag Method, Flags = &h0
		Function describe() As string()
		  dim tmp() as string
		  
		  tmp.append("Example _"  + format(self.id, "000"))
		  
		  return tmp
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function id() As integer
		  return -1
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function run() As itf_table_reader()
		  
		End Function
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
