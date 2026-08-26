#tag Class
Protected Class clDataStorePipelineTests
Inherits clObjectTest
	#tag Method, Flags = &h0
		Function CreatePipeline_001() As clDataStorePipeline
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
		Sub DSPipeline_test_calc_001(log as clLogManager)
		  
		  log.StartTask(CurrentMethodName)
		  
		  //
		  // Initial test 
		  //
		  
		  var ms0 as clMemoryStats = GetMemoryStats()
		  
		  var pipeline1 as  clDataStorePipeline = CreatePipeline_001
		  
		  pipeline1.run()
		  
		  var t1 as clDataTable = pipeline1.GetOutput("")
		  
		  var ms1 as clMemoryStats = GetMemoryStats()
		  
		  pipeline1 = nil
		  
		  var ms2 as clMemoryStats = GetMemoryStats()
		  
		  
		  log.WriteInfo(CurrentMethodName,"Tables in memory was:  %0,  dataseries in memory was: %1, transformers %2" , str(ms0.NumberOfTables), str(ms0.NumberOfDataSeries), str(ms0.NumberOfTransformers))
		  log.WriteInfo(CurrentMethodName,"Tables in memory is:  %0, dataseries in memory is: %1, transformers %2" , str(ms1.NumberOfTables), str(ms1.NumberOfDataSeries), str(ms1.NumberOfTransformers))
		  log.WriteInfo(CurrentMethodName,"Tables in memory after destroy  is:  %0, dataseries in memory is: %1, transformers %2" , str(ms2.NumberOfTables), str(ms2.NumberOfDataSeries), str(ms2.NumberOfTransformers))
		  
		  
		  var expected_table As New clDataTable("Expected", SerieArray( _
		  New clDataSerie("Country",  "FR","FR","BE","IT") _
		  ,New clNumberDataSerie("Quantity",105.0,52.0,108.0,56.0) _
		  , New clNumberDataSerie("Sales",500.0, 200.0, 800.0, 600.0) _
		  ,new clIntegerDataSerie("NbrRows", 2,1, 2, 1) _
		  ))
		  
		  call check_table(log, "T1", expected_table, t1)
		  
		  log.EndTask(CurrentMethodName)
		  
		  return
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetTestPrefix() As string
		  return "DSPipeline_"
		  
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
