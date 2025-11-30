#tag Class
Protected Class clLibDataCommon
	#tag Method, Flags = &h0
		Shared Function logger() As clLoging
		  
		  return localLogger
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function ReplacePlaceHolders(BaseString as string, values() as string) As string
		  var ret as string = BaseString
		  
		  for i as integer = 0 to values.LastIndex
		    ret = ret.replaceall("%"+str(i), values(i))
		    
		  next
		  
		  return ret
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Sub SetLogger(newLogger as clLoging)
		  
		  localLogger = newLogger
		  
		  return
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private Shared localLogger As clLoging
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
