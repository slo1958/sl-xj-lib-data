#tag Module
Protected Module Module1
	#tag Method, Flags = &h0
		Function TestStorePipeline() As clDataTable
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
		  
		  var pipeline1 as new clDataStorePipeline
		  
		  var s3 as clAbstractTransformer = pipeline1.AddStep("Select columns", _
		  new clColumnSelectorTransformer(array("Country":"Country","Sum of Quantity":"Quantity", "Sum of Sales":"Sales", "NbrRows":"NbrRows"), true) _
		  )
		  
		  var s2 as clAbstractTransformer = pipeline1.AddStep( "Add country", _
		  new clJoinTransformer(JoinMode.LeftJoin, array("City"),"") _
		  )
		  
		  var s1 as clAbstractTransformer = pipeline1.AddStep( "Group by city", _
		  new clGroupByTransformer(new clGroupByParameters(array("City"), array("Quantity","Sales"), "NbrRows")) _
		  )
		  
		  
		  // Define steps input and output
		  
		  pipeline1.SetStepInput(s1,  clGroupByTransformer.cInputConnectorName, salestable)
		  
		  var output1 as clTransformerConnector = s1.GetOutputConnector()
		  
		  
		  pipeline1.SetStepInput(s3, clColumnSelectorTransformer.cInputConnectorName, s2.GetOutputConnector)
		  
		  pipeline1.SetStepInput(s2, clJoinTransformer.cInputConnectorLeft, output1)
		  pipeline1.SetStepInput(s2, clJoinTransformer.cInputConnectorRight, countrytable)
		  
		  
		  var output2 as clTransformerConnector = s3.GetOutputConnector()
		  
		  pipeline1.SetOutput("", output2)
		  
		  pipeline1.run()
		  
		  var t1 as clDataTable = output2.GetTable
		  
		  return t1
		  
		  
		  
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
