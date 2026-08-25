#tag Class
Protected Class clDataStorePipeline
	#tag Method, Flags = &h0
		Function AddStep(aStepLabel as string, aStep as clAbstractTransformer) As clAbstractTransformer
		  //
		  // Add a transformation step to the pipeline.
		  // The order of insertion is not the order of execution
		  // Execution order is decided later, based on the availability of the data in the input connectors
		  //
		  // Parameters
		  // - aStepLabel: label for the transformation step, must be unique
		  // - aStep: transformation step
		  //
		  // Returns
		  // - transformation step if insertion is successful, nil otherwise
		  //
		  
		  
		  var tmpLabel as string = aStepLabel.Trim
		  
		  if tmpLabel.Length = 0 then
		    WriteLog("Missing step label for %0", Introspection.GetType(aStep).Name)
		    return nil
		    
		  end if
		  
		  for each s as clAbstractTransformer in self.Steps
		    if s.StepLabel = tmpLabel then
		      WriteLog("Step label %1 already in use for %2 when adding %0", Introspection.GetType(aStep).Name, tmpLabel, Introspection.GetType(s).Name)
		      Return nil
		      
		    end if
		    
		  next
		  
		  self.Steps.Add(aStep)
		  aStep.StepLabel = tmpLabel
		  
		  
		  Return aStep
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetOutput(ConnectorLabel as string) As clDataTable
		  
		  return self.OutputConnector(0).GetTable
		  
		   
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Run()
		  
		  var traceExecution as Boolean = True
		  
		  var executionQueue() as clAbstractTransformer
		  
		  var bDone as Boolean = false
		  
		  var maxRun as integer = Steps.Count * 2
		  
		  while not (bDone or maxRun < 1)
		    bDone = True
		    maxRun = maxRun - 1
		    
		    for each execstep as clAbstractTransformer in steps
		      if execstep.OutputAreReady then
		        
		      elseif execstep.InputAreReady  then
		        
		        WriteLog("Executing step [%0] labeled [%1].", Introspection.GetType(execstep).Name, execstep.StepLabel)
		        
		        var res as boolean = execstep.Execute
		        
		        if not res then WriteLog("Execution failed.")
		        
		        bDone = False
		        
		      end if
		      
		    next
		  wend
		  
		  Return
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SetOutput(ConnectorLabel as string, aConnector as clTransformerConnector)
		  
		  self.OutputConnector.Add(aConnector)
		  
		  Return
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SetStepInput(aStep as clAbstractTransformer, inputName as string, inputTable as clDataTable)
		  
		  aStep.SetInput(inputName, inputTable)
		  
		  self.InternalConnectors.Add(aStep.GetInputConnector(inputName))
		  
		  Return
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SetStepInput(aStep as clAbstractTransformer, inputName as string, connector as clTransformerConnector)
		  
		  aStep.SetInput(inputName, connector)
		  
		  self.InternalConnectors.Add(connector)
		  
		  Return
		End Sub
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


	#tag Property, Flags = &h0
		InternalConnectors() As clTransformerConnector
	#tag EndProperty

	#tag Property, Flags = &h0
		#tag Note
			//
			// List of connectors producing the output dataset from the pipeline
			//
		#tag EndNote
		OutputConnector() As clTransformerConnector
	#tag EndProperty

	#tag Property, Flags = &h0
		Steps() As clAbstractTransformer
	#tag EndProperty


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
