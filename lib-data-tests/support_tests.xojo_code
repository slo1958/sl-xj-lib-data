#tag Module
Protected Module support_tests
	#tag Method, Flags = &h0
		Sub check_value(label as string, expected as variant, calculated as variant)
		  dim tmp as Boolean =  check_value(label, expected, calculated)
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function check_value(label as string, expected as variant, calculated as variant) As boolean
		  if (expected.Type = variant.TypeDouble or expected.Type = Variant.TypeSingle) and (calculated.Type = variant.TypeDouble or calculated.Type = variant.TypeSingle) then
		    if abs(expected - calculated) < 0.00001 then return true
		    system.DebugLog("Invalid value for " + label + ", expecting " + str(expected) + " got " + str(calculated) + " dif. " + str(abs(expected - calculated) ))
		    return false
		  end if
		  
		  
		  if expected = calculated then return  True
		  
		  system.DebugLog("Invalid value for " + label + ", expecting " + str(expected) + " got " + str(calculated))
		  return False
		  
		  
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
