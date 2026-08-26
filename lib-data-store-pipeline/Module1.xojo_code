#tag Module
Protected Module Module1
	#tag Method, Flags = &h0
		Function CreatePipeline() As clDataStorePipeline
		  //
		  // Initial test 
		  //
		  
		  var salestable As New clDataTable("sales", SerieArray( _
		  New clDataSerie("City",  "Paris","Lyon","Namur","Paris","Namur","Milan") _
		  , New clDataSerie("Year", 2000,2000,2000,2000,2000,2000) _
		  , New clNumberDataSerie("Sales", 100,200,300,400,500,600) _
		  , New clNumberDataSerie("Quantity", 51, 52,53,54, 55,56) _
		  ))
		  
		  
		  var countrytable As New clDataTable("countryref", SerieArray( _
		  New clDataSerie("City",  "Paris","Lyon","Namur", "Milan") _
		  , New clDataSerie("Country", "FR","FR","BE", "IT") _
		  ))
		  
		  
		  // Define pipeline
		  // The order in which steps are added does not define the execution order
		  // So, we can randomly add the steps
		  //
		  var pipeline1 as new clDataStorePipeline
		  
		  var sFilterColumns as clAbstractTransformer = pipeline1.AddStep("Select columns", _
		  new clColumnSelectorTransformer(array("Country":"Country","Sum of Quantity":"Quantity", "Sum of Sales":"Sales", "NbrRows":"NbrRows"), true) _
		  )
		  
		  var sAddCountry as clAbstractTransformer = pipeline1.AddStep( "Add country", _
		  new clJoinTransformer(JoinMode.LeftJoin, array("City"),"") _
		  )
		  
		  var sGroupByCity as clAbstractTransformer = pipeline1.AddStep( "Group by city", _
		  new clGroupByTransformer(new clGroupByParameters(array("City"), array("Quantity","Sales"), "NbrRows")) _
		  )
		  
		  // Define steps input and output
		  
		  pipeline1.SetStepInput(sGroupByCity,  clGroupByTransformer.cInputConnectorName, salestable)
		  
		  pipeline1.SetStepInput(sFilterColumns, clColumnSelectorTransformer.cInputConnectorName, sAddCountry.GetOutputConnector)
		  
		  pipeline1.SetStepInput(sAddCountry, clJoinTransformer.cInputConnectorLeft, sGroupByCity.GetOutputConnector())
		  pipeline1.SetStepInput(sAddCountry, clJoinTransformer.cInputConnectorRight, countrytable)
		  
		  
		  var output2 as clTransformerConnection = sFilterColumns.GetOutputConnector()
		  
		  pipeline1.SetOutput("", output2)
		  
		  Return pipeline1
		  
		  
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function TestStorePipeline() As clDataTable
		  //
		  // Initial test 
		  //
		  
		  var ms0 as clMemoryStats = GetMemoryStats()
		  
		  var pipeline1 as  clDataStorePipeline = CreatePipeline
		  
		  pipeline1.run()
		  
		  var t1 as clDataTable = pipeline1.GetOutput("")
		  
		  var ms1 as clMemoryStats = GetMemoryStats()
		  
		  pipeline1 = nil
		  
		  var ms2 as clMemoryStats = GetMemoryStats()
		  
		  WriteLog(CurrentMethodName+":Tables in memory was:  %0,  dataseries in memory was: %1, transformers %2" , str(ms0.NumberOfTables), str(ms0.NumberOfDataSeries), str(ms0.NumberOfTransformers))
		  Writelog(CurrentMethodName+":Tables in memory is:  %0, dataseries in memory is: %1, transformers %2" , str(ms1.NumberOfTables), str(ms1.NumberOfDataSeries), str(ms1.NumberOfTransformers))
		  Writelog(CurrentMethodName+":Tables in memory after destroy  is:  %0, dataseries in memory is: %1, transformers %2" , str(ms2.NumberOfTables), str(ms2.NumberOfDataSeries), str(ms2.NumberOfTransformers))
		  
		  
		  return t1
		  
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub WriteLog(message as string, paramarray txt as string)
		  
		  var tmp as string = message
		  
		  for i as integer = 0 to txt.LastIndex
		    tmp = tmp.ReplaceAll("%"+str(i), txt(i))
		  next
		  
		  System.DebugLog(tmp)
		  
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
