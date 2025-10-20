#tag Class
Protected Class clAbstractTransformer
	#tag Method, Flags = &h1
		Protected Sub AddInput(ConnectionName as string, table as clDataTable)
		  
		  self.InputConnections.add(ConnectionName)
		  
		  if self.TableDict.HasKey(ConnectionName) then
		    Raise New clDataException("Input connection already linked to a table:" + ConnectionName)
		    
		  else
		    
		    self.TableDict.Value(ConnectionName) = table
		    
		  end if
		  
		  return
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub AddOutput(ConnectionName as string, table as clDataTable)
		  
		  self.OutputConnections.add(ConnectionName)
		  
		  if self.TableDict.HasKey(ConnectionName) then
		    Raise New clDataException("Output connection already linked to a table:" + ConnectionName)
		    
		  else
		    self.TableDict.Value(ConnectionName) = table
		    
		  end if
		  
		  return 
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  
		  self.TableDict = new Dictionary
		  
		  self.TableNameDict = new Dictionary
		  
		  
		End Sub
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
		  
		  for each ConnectionName as string in self.InputConnections
		    r.Add(self.TableDict.value(ConnectionName))
		    
		  next
		  
		  return r
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetName(ConnectionName as string) As String
		  
		  if TableDict.HasKey(ConnectionName) then
		    return  clDataTable(self.TableDict.Value(ConnectionName)).Name
		    
		  else
		    return self.TableNameDict.Lookup(ConnectionName, "NoName")
		    
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
		  
		  
		  Return self.TableDict.Lookup(self.OutputConnections(0), nil)
		  
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
		  
		  for each ConnectionName as string in self.OutputConnections
		    r.Add(self.TableDict.value(ConnectionName))
		    
		  next
		  
		  return r
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetTable(ConnectionName as string) As clDataTable
		  
		  return self.TableDict.Lookup(ConnectionName, nil)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Reset()
		  //
		  // Prepare the transformer for another run with the same configuration
		  //
		  // Remove all output tables
		  // Clean output connections
		  //
		  
		  for each name as string in OutputConnections
		    TableDict.Remove(name)
		    
		  next
		  
		  OutputConnections.RemoveAll
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SetOutputName(ConnectionName as string, OutputName as string)
		  //
		  // Overwrite a default output name
		  // Default output names are expected to be defined by the transformer constructor
		  //
		  //
		  // Parameters
		  // - name of the connection
		  // - new name
		  //
		  
		  self.TableNameDict.value(ConnectionName) = OutputName
		  
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
		Protected InputConnections() As string
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected OutputConnections() As string
	#tag EndProperty

	#tag Property, Flags = &h21
		Private TableDict As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private TableNameDict As Dictionary
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
