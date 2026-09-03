#tag Class
Protected Class clDataStorePipeline
	#tag Method, Flags = &h0
		Sub AddError()
		  
		  ErrorCounter = ErrorCounter + 1
		  
		  Return
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function AddStep(aStepLabel as string, aStep as clAbstractTransformer) As boolean
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
		  // - true if insertion is successful, false otherwise
		  //
		  
		  
		  var tmpLabel as string = aStepLabel.Trim
		  
		  if tmpLabel.Length = 0 then
		    getLogManager.WriteWarning(CurrentMethodName,"Missing step label for [%0]", Introspection.GetType(aStep).Name)
		    self.AddError
		    return  false
		    
		  end if
		  
		  if self.FindStep(tmpLabel) <> nil then
		    getLogManager.WriteWarning(CurrentMethodName,"Step label %1 already in use when adding [%0]", Introspection.GetType(aStep).Name, tmpLabel)
		    self.AddError
		    return  false
		    
		  end if
		  
		  aStep.SetLabel(tmpLabel)
		  
		  self.Steps.Add(aStep)
		  
		  Return  true
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ConnectSteps(ProviderSetpName as string, outputName as string, ConsumerStepName as string, inputName as string)
		  
		  var provider as clAbstractTransformer = self.FindStep(ProviderSetpName)
		  if provider = nil then
		    getLogManager.WriteWarning(CurrentMethodName,"Cannot find provider step [%0]", ProviderSetpName)
		    self.AddError
		    return  
		    
		  end if
		  
		  var providerOutput as clTransformerConnection = provider.GetOutputConnector(outputName)
		  if providerOutput = nil then
		    getLogManager.WriteWarning(CurrentMethodName,"Cannot find  output for provider [%0]", ConsumerStepName)
		    self.AddError
		    return  
		    
		  end if
		  
		  var consumer as clAbstractTransformer = self.FindStep(ConsumerStepName)
		  if consumer = nil then
		    getLogManager.WriteWarning(CurrentMethodName,"Cannot find consumer step [%0]", ConsumerStepName)
		    self.AddError
		    return  
		    
		  end if
		  
		  // aStep.GetInputConnector(inputName)) 
		  consumer.SetInput(inputName, providerOutput)
		  
		  return
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(myname as string)
		  
		  self.name = myname.trim
		  self.OutputConnectors = new Dictionary
		  
		  localLogger = nil
		  
		  TraceStepInput = true
		  TraceStepOutput = True
		  
		  TraceStepTiming = True
		  
		  TracePipelineOutput = true
		  TracePipelineTiming = True
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function FindStep(aStepLabel as string) As clAbstractTransformer
		  
		  var tmpLabel as string = aStepLabel.Trim
		  
		  for each s as clAbstractTransformer in self.Steps
		    if s.GetLabel = tmpLabel then
		      
		      Return s
		      
		    end if
		    
		  next
		  
		  return nil
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function getLogManager() As clLogManager
		  
		  if self.localLogger = nil then
		    return clLogManager.GetDefaultLogingSupport
		    
		  else
		    return self.localLogger
		    
		  end if
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetOutput(ConnectorLabel as string) As clDataTable
		  
		  var tmpConnectorLabel as string = ConnectorLabel.Trim
		  
		  if tmpConnectorLabel.Length = 0 then
		    tmpConnectorLabel = cDefaultOutput
		    
		  end if
		  
		  if self.OutputConnectors.HasKey(tmpConnectorLabel) then
		    return clTransformerConnection( self.OutputConnectors.Value(tmpConnectorLabel)).GetTable()
		    
		  else
		    getLogManager.WriteWarning(CurrentMethodName, "Cannot find output [%0] in pipeline", tmpConnectorLabel)
		    
		    return nil
		    
		  end if
		  
		  
		  
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ResetErrors()
		  
		  ErrorCounter = 0
		  
		  Return
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Run()
		  
		  
		  if self.ErrorCounter > 0 then
		    getLogManager.WriteWarning(CurrentMethodName, "Errors in pipeline [%0] prevent execution", Name)
		    return  
		    
		  end if
		  
		  if localLogger <> nil then
		    for each execstep as clAbstractTransformer in steps
		      execstep.SetLogger(localLogger)
		      
		    next
		    
		  end if
		   
		  
		  var traceExecution as Boolean = True
		  
		  var executionQueue() as clAbstractTransformer
		  
		  var bDone as Boolean = false
		  
		  var maxRun as integer = Steps.Count * 2
		  
		  if TracePipelineTiming Then getLogManager.StartTask("Pipeline " + self.name)
		  
		  while not (bDone or maxRun < 1)
		    bDone = True
		    maxRun = maxRun - 1
		    
		    var cntExec as integer = 0
		    var cntCannotExec as integer = 0
		    
		    for each execstep as clAbstractTransformer in steps
		      if execstep.OutputAreReady then
		        
		      elseif execstep.InputAreReady  then
		        
		        if TraceStepInput then execstep.TraceInputToLog(execstep.GetLabel())
		        
		        getLogManager.WriteInfo(CurrentMethodName,"Executing step [%0] labeled [%1].", Introspection.GetType(execstep).Name, execstep.GetLabel())
		        
		        if TraceStepTiming then getLogManager.StartTask(execstep.GetLabel())
		        
		        var res as boolean = execstep.Execute
		        
		        if TraceStepTiming then getLogManager.EndTask(execstep.GetLabel())
		        
		        if not res then getLogManager.WriteWarning(CurrentMethodName,"Execution failed.")
		        
		        if TraceStepOutput then  execstep.TraceOutputToLog(execstep.GetLabel())
		        
		        bDone = False
		        
		        cntExec = cntExec + 1
		        
		      else
		        cntCannotExec = cntCannotExec + 1
		        
		      end if
		      
		      
		      
		      if cntExec = 0 and cntCannotExec > 0 then
		        System.DebugLog("!!!!!!!!!!!!")
		        
		      end if
		      
		    next
		  wend
		  
		  if TracePipelineTiming Then  getLogManager.EndTask("Pipeline " + self.name)
		  
		  if TracePipelineOutput then  self.TraceOutputToLog()
		  
		  Return
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SetLogger(newLogger as clLogManager)
		  
		  self.localLogger = newLogger
		  
		  return
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SetOutput(ConnectorLabel as string, aConnector as clTransformerConnection)
		  
		  var tmpConnectorLabel as string = ConnectorLabel.Trim
		  
		  if tmpConnectorLabel.Length = 0 then
		    tmpConnectorLabel = cDefaultOutput
		    
		    
		  end if
		  
		  if self.OutputConnectors.HasKey(tmpConnectorLabel) then
		    getLogManager.WriteWarning(CurrentMethodName,"Pipeline output [%0] already defined", tmpConnectorLabel)
		    
		  else
		    self.OutputConnectors.Value(tmpConnectorLabel) = aConnector
		    
		  end if
		  
		  
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
		Sub SetStepInput(aStep as clAbstractTransformer, inputName as string, connector as clTransformerConnection)
		  
		  aStep.SetInput(inputName, connector)
		  
		  self.InternalConnectors.Add(connector)
		  
		  Return
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SetStepInput(StepName as string, inputName as string, inputTable as clDataTable)
		  
		  
		  var consumer as clAbstractTransformer = self.FindStep(StepName)
		  if consumer = nil then
		    getLogManager.WriteWarning(CurrentMethodName,"Cannot find  step [%0]", StepName)
		    AddError
		    return
		    
		  end if
		  
		  if consumer.ValidateInputConnector(InputName) then
		    consumer.SetInput(inputName, inputTable)
		    
		    self.InternalConnectors.Add(consumer.GetInputConnector(inputName))
		    
		  else
		    getLogManager.WriteWarning(CurrentMethodName, "Cannot find input [%0] in step [%1]",inputName, StepName)
		    AddError
		    
		  end if
		  
		  Return
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TraceOutputToLog()
		  for each c as clTransformerConnection in self.OutputConnectors.Values
		    
		    if c.GetTable = nil then
		      self.getLogManager.WriteInfo(CurrentMethodName _
		      , "Output connector [%0] of pipeline [%1] without table" _ 
		      ,  c.GetConnectorLabel _
		      , self.Name _
		      )
		      
		    else
		      self.getLogManager.WriteInfo(CurrentMethodName _
		      , "Output connector [%0] of pipeline [%3] has table [%1] %2 records." _
		      , c.GetConnectorLabel _
		      , c.GetTable.Name _
		      , c.GetTable.RowCount.ToString _
		      , self.Name _
		      )
		    end if
		  next
		  
		  return 
		End Sub
	#tag EndMethod


	#tag Note, Name = Description
		Pipelines work on tables
		A step is a data transformers
		The order of execution of the steps is decided at run time by the pipeline run() method
		
		
		Each data transformers create 
		- their input connectors
		- their output connectors
		- an empty connection to their OutputConnectors
		
		The connections are attached to the input connectors
		- A/ by obtaining a reference to the connection created for the relevant output of the provider 
		- B/ by describing the connection (provider step name, provider output name, consumer step name, consumer input)
		
		
		Example for A (full sourcr code in CreatePipeline_001)
		
		// Create each step, for example:
		var stepAddCountry as clAbstractTransformer =new clJoinTransformer(JoinMode.LeftJoin, array("City"),"") 
		var stepGroupByCity as clAbstractTransformer =new clGroupByTransformer(prm)
		
		// Add the steps to the pipeline (the order does not matter, it is not the order of execution):
		call pipeline1.AddStep("Select columns", stepFilterColumns)
		call pipeline1.AddStep( "Add country", stepAddCountry)
		call pipeline1.AddStep( "Group by city", stepGroupByCity)
		
		
		// Connect an input connector to a connection, for example:
		pipeline1.SetStepInput(stepFilterColumns, clColumnSelectorTransformer.cInputConnectorName, stepAddCountry.GetOutputConnector)
		
		
		
		Example for B (full sourcr code in CreatePipeline_002)
		
		// Create and add the steps to the pipeline:
		call pipeline1.AddStep("Select columns", new clColumnSelectorTransformer(array("Country":"Country","Sum of Quantity":"Quantity", "Sum of Sales":"Sales", "NbrRows":"NbrRows"), true))
		
		call pipeline1.AddStep( "Add country", new clJoinTransformer(JoinMode.LeftJoin, array("City"),"") )
		...
		call pipeline1.AddStep( "Group by city", new clGroupByTransformer(prm))
		
		
		// Establish the connections, for example:
		
		pipeline1.ConnectSteps("Group by city", clGroupByTransformer.cOutputConnectorName _
		                                       , "Add country", clJoinTransformer.cInputConnectorLeft)
		
		pipeline1.ConnectSteps("Add Country", clJoinTransformer.cOutputConnectorJoined _
		                                     , "Select columns", clColumnSelectorTransformer.cInputConnectorName)
		
		
	#tag EndNote


	#tag Property, Flags = &h21
		Private ErrorCounter As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private InternalConnectors() As clTransformerConnection
	#tag EndProperty

	#tag Property, Flags = &h0
		localLogger As clLogManager
	#tag EndProperty

	#tag Property, Flags = &h0
		Name As string
	#tag EndProperty

	#tag Property, Flags = &h0
		#tag Note
			//
			// List of connectors producing the output dataset from the pipeline
			//
		#tag EndNote
		OutputConnectors As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h0
		Steps() As clAbstractTransformer
	#tag EndProperty

	#tag Property, Flags = &h0
		TracePipelineOutput As Boolean
	#tag EndProperty

	#tag Property, Flags = &h0
		TracePipelineTiming As boolean
	#tag EndProperty

	#tag Property, Flags = &h0
		TraceStepInput As Boolean
	#tag EndProperty

	#tag Property, Flags = &h0
		TraceStepOutput As Boolean
	#tag EndProperty

	#tag Property, Flags = &h0
		TraceStepTiming As Boolean
	#tag EndProperty


	#tag Constant, Name = cDefaultOutput, Type = String, Dynamic = False, Default = \"PipelineOutput", Scope = Public
	#tag EndConstant


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
		#tag ViewProperty
			Name="TraceStepTiming"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="TraceStepInput"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="TraceStepOutput"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="TracePipelineOutput"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="TracePipelineTiming"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="boolean"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
