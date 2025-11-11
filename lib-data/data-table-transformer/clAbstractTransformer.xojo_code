#tag Class
Protected Class clAbstractTransformer
	#tag Method, Flags = &h1
		Protected Sub AddInput(connector as clTransformerConnector)
		  
		  self.InputConnectors.Value(connector.GetName) = connector
		  
		  return
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub AddOutput(connector as clTransformerConnector)
		  
		  self.OutputConnectors.value(connector.GetName) = connector
		  
		  if self.firstOutputConnector = nil then self.firstOutputConnector = connector
		  
		  return 
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  
		  self.InputConnectors = new Dictionary
		  self.OutputConnectors = new Dictionary
		  
		  self.firstOutputConnector = nil
		  
		  return
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetInputConnector(InputConnectorName as string) As clTransformerConnector
		  //
		  // Returns the input connector matching passed name
		  //
		  // Parameters:
		  // - input connector name
		  //
		  // Returns:
		  // selected input connector
		  //
		  
		  var c as clTransformerConnector
		  
		  c = self.InputConnectors.Lookup(InputConnectorName, nil)
		  
		  return c
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetOutputConnector(OutputConnectorName as string = "") As clTransformerConnector
		  //
		  // Returns the output connector matching passed name or the first output connector if name is empty
		  //
		  // Parameters:
		  // - output connector name
		  //
		  // Returns:
		  // selected output connector
		  //
		  
		  
		  if OutputConnectorName.Length > 0 then
		    return self.OutputConnectors.Lookup(OutputConnectorName, nil)
		    
		  else
		     return self.firstOutputConnector  
		    
		  end if
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetOutputTable() As clDataTable
		  //
		  // Returns the output table related to the first output connection
		  //
		  // Parameters:
		  // (nothing)
		  //
		  // Returns:
		  // selected output table
		  //
		  
		  if self.firstOutputConnector = nil then
		    return nil
		    
		  else
		    return self.firstOutputConnector.GetTable
		    
		  end if
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SetOutputName(ConnectionName as string, OutputName as string)
		  //
		  // Overwrite a default output name
		  // Default output names are expected to be defined by the transformer constructor
		  // Must be called before the output table is created
		  //
		  //
		  // Parameters
		  // - name of the connection
		  // - new name
		  //
		  
		  var c as clTransformerConnector
		  
		  c = self.OutputConnectors.Lookup(connectionName, nil)
		  
		  if c = nil then return
		  
		  c.SetTableName(outputName)
		  
		  return
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SetOutputTable(connectionName as string, table as clDataTable)
		  //
		  // Set the output table related to the connection
		  //
		  // Parameters:
		  // - conenction name
		  // - table to associate with the connection
		  //
		  // Returns:
		  // selected output table
		  //
		  
		  var c as clTransformerConnector
		  
		  c = self.OutputConnectors.Lookup(connectionName, nil)
		  
		  if c = nil then return
		  
		  c.SetTable(table)
		  
		  return
		  
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Transform() As Boolean
		  return False
		  
		End Function
	#tag EndMethod

	#tag DelegateDeclaration, Flags = &h0
		Delegate Function TransformerFunction(table as clDatatable, columns() as string, parameters() as variant) As Boolean
	#tag EndDelegateDeclaration

	#tag Method, Flags = &h0
		Sub WriteLog(message as string, paramarray txt as string)
		  //if self.verbose then
		  var tmp as string = message
		  
		  for i as integer = 0 to txt.LastIndex
		    tmp = tmp.ReplaceAll("%"+str(i), txt(i))
		  next
		  
		  System.DebugLog(message)
		  
		  //end if
		End Sub
	#tag EndMethod


	#tag Note, Name = Description
		
		A  transformer is an object that takes a set of tables as input and produces a set of tables.
		
		Specific variants:
		
		- linear transformer: one input and one output, for example sorting, grouping, ...
		
		
	#tag EndNote


	#tag Property, Flags = &h1
		Protected firstOutputConnector As clTransformerConnector
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected InputConnectors As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected OutputConnectors As Dictionary
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
