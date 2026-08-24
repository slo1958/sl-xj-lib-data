#tag Class
Protected Class clDataStorePipeline
	#tag Method, Flags = &h0
		Function AddStep(aStep as clAbstractTransformer) As clAbstractTransformer
		  
		  
		  Return aStep
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Run()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SetOutput(ConnectorLabel as string, aConnector as clTransformerConnector)
		  
		End Sub
	#tag EndMethod


	#tag Note, Name = Description
		Pipeline working on tables, taking advantages of data transformers
		
		By default, data transformers create their input and output connectors.
		
		Interconnection
		
		Option 1: links set in source code
		Option 2: symbolic links set in source code, actual connections set up on start
		
	#tag EndNote

	#tag Note, Name = From Clipboard
		SetOutput
	#tag EndNote

	#tag Note, Name = Option 1
		
		
		Use define connection using clTransformerConnector and assign them from an output to an input:
		
		Example: join a table and a lookup table, then apply a filter:
		
		var s1 as clAbstractTransformer = pipeline1.AddStep(new join-transformer-step(...))
		s1.setInput(main-input-name, sourcetable)
		s1.setInput(lookup-input-name, lookUptable)
		
		var output1 as clTransformerConnector = s1.GetOutputConnector(outputname)
		var resultlog1 as clTransformerConnector = s1.GetOutputConnector(logname)
		
		var s2 as clAbstractTransformer = pipeline1.AddStep(new  filter-transformer-step(..))
		s2.setInput(input-name, output1)
		 
		pipeline1.SetOutput("Main", s2.GetOutputConnector(name))
		
		pipeline1.run()
		
		
		
	#tag EndNote


End Class
#tag EndClass
