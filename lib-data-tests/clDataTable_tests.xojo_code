#tag Module
Protected Module clDataTable_tests
	#tag Method, Flags = &h0
		Sub tests(log as LogMessageInterface)
		  
		  var logwriter as  LogMessageInterface = log 
		  
		  if log = nil then
		    logwriter = new clWriteToSystemLog
		  end if
		  
		  logwriter.StartTask(CurrentMethodName)
		  
		  var ms0 as clMemoryStats = GetMemoryStats
		  
		  RunTests(new clDataTableTests, "test_ca", logwriter)
		  
		  var ms1 as clMemoryStats = GetMemoryStats
		  
		  logwriter.WriteMessage("Tables in memory was: " + str(ms0.NumberOfTables)+", dataseries in memory was: " + str(ms0.NumberOfDataSeries))
		  logwriter.WriteMessage("Tables in memory is: " + str(ms1.NumberOfTables)+", dataseries in memory is: " + str(ms1.NumberOfDataSeries))
		  
		  logwriter.end_exec(CurrentMethodName)
		  
		  return
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub tests_examples(log as LogMessageInterface)
		  
		  var logwriter as  LogMessageInterface = log 
		  
		  if log = nil then
		    logwriter = new clWriteToSystemLog
		  end if
		  
		  logwriter.StartTask(CurrentMethodName)
		  
		  var ms0 as clMemoryStats = GetMemoryStats
		  
		  var ex as Dictionary = clLibDataExample.GetAllExamples
		  
		  for each example as string in ex.keys
		    call clLibDataExample.RunExample(logwriter, ex.value(example))
		    
		  next
		  
		  var ms1 as clMemoryStats = GetMemoryStats
		  
		  logwriter.WriteMessage("Tables in memory was: " + str(ms0.NumberOfTables)+", dataseries in memory was: " + str(ms0.NumberOfDataSeries))
		  logwriter.WriteMessage("Tables in memory is: " + str(ms1.NumberOfTables)+", dataseries in memory is: " + str(ms1.NumberOfDataSeries))
		  
		  
		  logwriter.end_exec(CurrentMethodName)
		  
		  return
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub tests_io(log as LogMessageInterface)
		  
		  var logwriter as  LogMessageInterface = log 
		  
		  if log = nil then
		    logwriter = new clWriteToSystemLog
		  end if
		  
		  
		  logwriter.StartTask(CurrentMethodName)
		  
		  var ms0 as clMemoryStats = GetMemoryStats
		  
		  RunTests(new clDataTableTests, "test_io", logwriter)
		  
		  var ms1 as clMemoryStats = GetMemoryStats
		  
		  logwriter.WriteMessage("Tables in memory was: " + str(ms0.NumberOfTables)+", dataseries in memory was: " + str(ms0.NumberOfDataSeries))
		  logwriter.WriteMessage("Tables in memory is: " + str(ms1.NumberOfTables)+", dataseries in memory is: " + str(ms1.NumberOfDataSeries))
		  
		  
		  logwriter.end_exec(CurrentMethodName)
		  
		  return
		  
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
