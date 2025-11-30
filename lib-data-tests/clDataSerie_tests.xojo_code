#tag Module
Protected Module clDataSerie_tests
	#tag Method, Flags = &h0
		Function check_serie(log as support_tests.LogMessageInterface, label as string, expected as clAbstractDataSerie, calculated as clAbstractDataSerie, accepted_error_on_double as double = 0.00001) As Boolean
		  
		  if not  check_value(log,label + " name", expected.name, calculated.name) then
		    return False
		    
		  end if
		  
		  if not check_value(log, label + " row count", expected.RowCount, calculated.RowCount) then
		    Return False
		    
		  end if
		  
		  
		  var cell_ok as Boolean = True
		  
		  for row as integer = 0 to expected.RowCount-1
		    cell_ok = cell_ok and check_value(log,  label + " row " + str(row), expected.GetElement(row), calculated.GetElement(row), accepted_error_on_double)
		    
		  next
		  
		  return cell_ok
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function filter01(the_row as integer, pRowCount as integer, the_column as string, the_value as variant, paramarray pFunctionParameters as variant) As Boolean
		  Return True
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function filter_value_is_not_aaa(the_row as integer, pRowCount as integer, the_column as string, the_value as variant, paramarray pFunctionParameters as variant) As Boolean
		  Return the_value <> "aaa"
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function filter_value_is_parameter(the_row as integer, pRowCount as integer, the_column as string, the_value as variant, paramarray pFunctionParameters as variant) As Boolean
		  try
		    Return the_value = pFunctionParameters(0)
		    
		  Catch
		    return False
		    
		  end Try
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub tests(log as LogMessageInterface)
		  
		  var logwriter as  LogMessageInterface = log 
		  
		  if log = nil then
		    logwriter = new clWriteToSystemLog
		  end if
		  
		  logwriter.StartTask(CurrentMethodName)
		  
		  RunTests(new clDataSerieTests, "test_ca", logwriter)
		  
		  logwriter.end_exec(CurrentMethodName)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub tests_io(log as LogMessageInterface)
		  
		  var logwriter as  LogMessageInterface = log 
		  
		  if log = nil then
		    logwriter = new clWriteToSystemLog
		  end if
		  
		  logwriter.StartTask(CurrentMethodName)
		  
		  RunTests(new clDataSerieTests, "test_io", logwriter)
		  
		  logwriter.end_exec(CurrentMethodName)
		End Sub
	#tag EndMethod


	#tag ViewBehavior
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
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
			Name="Name"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
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
