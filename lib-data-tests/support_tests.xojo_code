#tag Module
Protected Module support_tests
	#tag Method, Flags = &h0
		Sub check_value(label as string, expected as variant, calculated as variant)
		  dim tmp as Boolean =  check_value(label, expected, calculated)
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function check_value(label as string, expected as variant, calculated as variant) As boolean
		  if expected = calculated then
		    return True
		    
		  else
		    system.DebugLog("Invalid value for " + label + ", expecting " + str(expected) + " got " + str(calculated))
		    return False
		    
		  end if
		  
		End Function
	#tag EndMethod


End Module
#tag EndModule
