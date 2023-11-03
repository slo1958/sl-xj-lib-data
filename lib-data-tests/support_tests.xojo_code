#tag Module
Protected Module support_tests
	#tag Method, Flags = &h0
		Function check_value(log as support_tests.itf_logmessage_writer, label as string, expected as variant, calculated as variant) As boolean
		  if (expected.Type = variant.TypeDouble or expected.Type = Variant.TypeSingle) and (calculated.Type = variant.TypeDouble or calculated.Type = variant.TypeSingle) then
		    if abs(expected - calculated) < 0.00001 then return true
		    log.write_message("Invalid value for " + label + ", expecting " + str(expected) + " got " + str(calculated) + " dif. " + str(abs(expected - calculated) ))
		    return false
		  end if
		  
		  
		  if expected = calculated then return  True
		  
		  log.write_message("Invalid value for " + label + ", expecting " + str(expected) + " got " + str(calculated))
		  return False
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub write_message(msg as string)
		  system.DebugLog(msg)
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
End Module
#tag EndModule
