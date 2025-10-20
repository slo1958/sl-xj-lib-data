#tag Class
Protected Class clAbstractTransformer
	#tag Method, Flags = &h1
		Protected Sub AddInput(connection as clTransformerConnection)
		  
		  self.InputConnections.Value(connection.GetName) = connection
		  
		  return
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub AddOutput(connection as clTransformerConnection)
		  
		  self.OutputConnections.value(connection.GetName) = connection
		  
		  if self.firstOutputConnection = nil then self.firstOutputConnection = connection
		  
		  return 
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  
		  self.InputConnections = new Dictionary
		  self.OutputConnections = new Dictionary
		  
		  self.firstOutputConnection = nil
		  
		  return
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetInputTable(ConnectionName as string) As clDataTable
		  
		  
		  var c as clTransformerConnection
		  
		  c = self.inputConnections.Lookup(connectionName, nil)
		  
		  if c = nil then return nil
		  
		  return c.GetTable
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetInputTables() As clDataTable()
		  //
		  // Returns an array with the input tables
		  //
		  // Parameters:
		  // (nothing)
		  //
		  // Returns:
		  // Array of input tables
		  //
		  var r() as clDataTable
		  
		  for each Connection as clTransformerConnection in self.InputConnections
		    r.add(connection.GetTable)
		    
		  next
		  
		  return r
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
		   
		  if self.firstOutputConnection = nil then
		    return nil
		    
		  else
		    return self.firstOutputConnection.GetTable
		    
		  end if
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetOutputTable(connectionName as string) As clDataTable
		  //
		  // Returns the output table related to the connection
		  //
		  // Parameters:
		  // - connection name
		  //
		  // Returns:
		  // selected output table
		  //
		  
		  var c as clTransformerConnection
		  
		  c = self.OutputConnections.Lookup(connectionName, nil)
		  
		  if c = nil then return nil
		  
		  return c.GetTable
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetOutputTableName(ConnectionName as string, AllowDefault as Boolean = False) As String
		  //
		  // Returns the name of output table related to the connection
		  //
		  // Parameters:
		  // - connection name
		  // - allow default value (if the connection exists but it is not linked to a table, and no table name have been defined)
		  //
		  // Returns:
		  // - selected output table name
		  //
		  
		  
		  var c as clTransformerConnection
		  
		  c = self.OutputConnections.Lookup(connectionName, nil)
		  
		  if c = nil then return ""
		  
		  return c.GetTableName(AllowDefault)
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetOutputTables() As clDataTable()
		  //
		  // Returns an array with the output tables
		  //
		  // Parameters:
		  // (nothing)
		  //
		  // Returns:
		  // Array of output tables
		  //
		  
		  var r() as clDataTable
		  
		  for each Connection as clTransformerConnection in self.OutputConnections
		    r.Add(Connection.GetTable)
		    
		  next
		  
		  return r
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
		  
		  var c as clTransformerConnection
		  
		  c = self.OutputConnections.Lookup(connectionName, nil)
		  
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
		  
		  var c as clTransformerConnection
		  
		  c = self.OutputConnections.Lookup(connectionName, nil)
		  
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


	#tag Note, Name = Description
		
		A  transformer is an object that takes a set of tables as input and produces a set of tables.
		
		Specific variants:
		
		- linear transformer: one input and one output, for example sorting, grouping, ...
		
		
	#tag EndNote


	#tag Property, Flags = &h1
		Protected firstOutputConnection As clTransformerConnection
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected InputConnections As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected OutputConnections As Dictionary
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
