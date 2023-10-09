#tag Module
Protected Module helper_functions
	#tag Method, Flags = &h0
		Function serie_array(paramarray series as clAbstractDataSerie) As clAbstractDataSerie()
		  Dim tmp() As clAbstractDataSerie
		  
		  For Each c As clAbstractDataSerie In series
		    tmp.Append(c)
		    
		  Next
		  
		  Return tmp
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function string_array(paramarray  items as string) As string()
		  Dim ret() As String
		  
		  For Each item As String In items
		    ret.append(item)  
		    
		  Next
		  
		  Return ret
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function variant_array(paramarray  items as variant) As variant()
		  Dim ret() As variant
		  
		  For Each item As variant In items
		    ret.append(item)
		    
		  Next
		  
		  Return ret
		  
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
End Module
#tag EndModule
