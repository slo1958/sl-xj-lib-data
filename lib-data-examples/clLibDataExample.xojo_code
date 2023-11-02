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
		Shared Function get_all_examples() As clLibDataExample()
		  dim ex() as clLibDataExample
		  
		  ex.Add(new cllibdataexample_01)
		  ex.Add(new cllibdataexample_02)
		  ex.Add(new cllibdataexample_03)
		  ex.Add(new cllibdataexample_04)
		  ex.Add(new cllibdataexample_05)
		  ex.Add(new cllibdataexample_06)
		  ex.Add(new cllibdataexample_07)
		  ex.Add(new cllibdataexample_08)
		  ex.Add(new cllibdataexample_09)
		  ex.Add(new cllibdataexample_10)
		  ex.Add(new cllibdataexample_11)
		  ex.Add(new cllibdataexample_12)
		  ex.Add(new cllibdataexample_14)
		  ex.Add(new cllibdataexample_15)
		  ex.Add(new cllibdataexample_16)
		  ex.Add(new cllibdataexample_17)
		  ex.Add(new cllibdataexample_18)
		  ex.Add(new cllibdataexample_19)
		  
		  return ex
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function id() As integer
		  return -1
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function run() As itf_table_column_reader()
		  
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
