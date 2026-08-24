#tag Module
Protected Module Module1
	#tag Method, Flags = &h0
		Sub TestStorePipeline()
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
		  
		  var pipeline1 as clDataStorePipeline
		  
		  var s1 as clAbstractTransformer = pipeline1.AddStep( _
		  new clGroupByTransformer(new clGroupByParameters(array("City"), array("Quantity","Sales"), "NbrRows")) _
		  )
		  
		  s1.SetInput(clGroupByTransformer.cInputConnectorName, salestable)
		  
		  var output1 as clTransformerConnector = s1.GetOutputConnector()
		  
		  
		  var s2 as clAbstractTransformer = pipeline1.AddStep( _
		  new clJoinTransformer(JoinMode.LeftJoin, array("City"),"") _
		  )
		  
		  s2.SetInput(clJoinTransformer.cInputConnectorLeft, output1)
		  s2.SetInput(clJoinTransformer.cInputConnectorRight, countrytable)
		  
		  
		  
		End Sub
	#tag EndMethod


End Module
#tag EndModule
