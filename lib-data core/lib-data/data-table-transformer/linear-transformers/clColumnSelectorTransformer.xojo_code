#tag Class
Protected Class clColumnSelectorTransformer
Inherits clLinearTransformer
	#tag Method, Flags = &h21
		Private Sub ConfigureSelector(ColumnsToRetain() as pair, CreateMissingColumns as boolean)
		  
		  for each p as pair in ColumnsToRetain
		    self.OutputColumns.add(p)
		    
		  next
		  
		  self.CreateMissing = CreateMissingColumns
		  
		  Return
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ConfigureSelector(ColumnsToRetain() as string, CreateMissingColumns as boolean)
		  
		  for each s as string in ColumnsToRetain
		    self.OutputColumns.add(s:s)
		    
		  next
		  
		  self.CreateMissing = CreateMissingColumns
		  
		  Return
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(MainTable as clDataTable, ColumnsToRetain() as pair, CreateMissingColumns as boolean)
		  //
		  // Filter the rows of the source table
		  // 
		  // Parameters:
		  // - Input table
		  // - ColumnsToRetain: name of filter column
		  // - CreateMissingColumns: Add empty columns if it does not exists in input
		  //
		  
		  super.Constructor(MainTable)
		  
		  self.ConfigureSelector(ColumnsToRetain, CreateMissingColumns)
		  
		  Return
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(MainTable as clDataTable, ColumnsToRetain() as string, CreateMissingColumns as boolean)
		  //
		  // Filter the rows of the source table
		  // 
		  // Parameters:
		  // - Input table
		  // - ColumnsToRetain: name of filter column
		  // - CreateMissingColumns: Add empty columns if it does not exists in input
		  //
		  
		  super.Constructor(MainTable)
		  
		  self.ConfigureSelector(ColumnsToRetain, CreateMissingColumns)
		  
		  Return
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(ColumnsToRetain() as pair, CreateMissingColumns as boolean)
		  //
		  // Filter the rows of the source table
		  // The input connector should be setup using a distinct call
		  //
		  // Parameters:
		  // - ColumnsToRetain: name of filter column
		  // - CreateMissingColumns: Add empty columns if it does not exists in input
		  //
		  
		  super.Constructor()
		  
		  self.ConfigureSelector(ColumnsToRetain, CreateMissingColumns)
		  
		  // 
		  // for each p as pair in ColumnsToRetain
		  // self.OutputColumns.add(p)
		  // 
		  // next
		  // 
		  // self.CreateMissing = CreateMissingColumns
		  // 
		  // 
		  // 
		  
		  Return
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(ColumnsToRetain() as string, CreateMissingColumns as boolean)
		  //
		  // Filter the rows of the source table
		  // The input connector should be setup using a distinct call
		  //
		  // Parameters:
		  // - ColumnsToRetain: name of filter column
		  // - CreateMissingColumns: Add empty columns if it does not exists in input
		  //
		  
		  super.Constructor()
		  
		  self.ConfigureSelector(ColumnsToRetain, CreateMissingColumns)
		  
		  // for each s as string in ColumnsToRetain
		  // self.OutputColumns.add(s:s)
		  // 
		  // next
		  // 
		  // self.CreateMissing = CreateMissingColumns
		  // 
		  
		  
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function Transform() As Boolean
		  // Calling the overridden superclass method.
		  
		  var source as clDataTable = self.SourceTable
		  
		  if source = nil then return false
		  
		  var output as new clDataTable("FilteredResults")
		  
		  for each colpair as pair in self.OutputColumns 
		    var srccol as string = colpair.Left
		    var dstcol as string = colpair.Right
		    var tmpcol as clAbstractDataSerie = source.GetColumn(srccol)
		    var newcol as clAbstractDataSerie
		    
		    if tmpcol <> nil then
		      newcol = output.AddColumn(tmpcol.Clone(dstcol))
		      if newcol = nil then  getLogManager.WriteWarning(CurrentMethodName,"Cannot add column [%0] (renaming %2) to table [%1]", dstcol, output.Name, srccol)
		      
		    elseif self.CreateMissing then 
		      newcol =  output.AddColumn( new clDataSerie(dstcol))
		      if newcol = nil then getLogManager.WriteWarning(CurrentMethodName,"Cannot add column [%0] (renaming %2) to table [%1]", dstcol, output.Name, srccol)
		      
		    end if
		    
		  next
		  
		  Self.SetOutputTable(cOutputConnectorName, output)
		  
		  
		  return true
		  
		  
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0
		CreateMissing As Boolean
	#tag EndProperty

	#tag Property, Flags = &h0
		OutputColumns() As Pair
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="ExecutionCompletedFlag"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="StepLabel"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="EnableTraceMode"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
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
			Name="CreateMissing"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
