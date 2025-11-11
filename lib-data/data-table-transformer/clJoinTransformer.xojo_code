#tag Class
Protected Class clJoinTransformer
Inherits clAbstractTransformer
	#tag Method, Flags = &h0
		Sub Constructor(LeftTable as clDataTable, RightTable as clDataTable, mode as JoinMode, KeyFields() as string, JoinStatusField as string = "")
		  // Calling the overridden superclass constructor.
		  Super.Constructor
		  
		  
		  self.AddInput(new clTransformerConnector(cInputConnectorLeft, LeftTable))
		  self.AddInput(new clTransformerConnector(cInputConnectorRight, RightTable))
		  
		  
		  select case mode
		    
		  case JoinMode.OuterJoin 
		    self.AddOutput(new clTransformerConnector(cOutputConnectorJoined, cDefaultMainOutputTableName))
		    
		    self.JoinStatusBoth = "JOIN"
		    
		  case JoinMode.LeftJoin
		    self.AddOutput(new clTransformerConnector(cOutputConnectorJoined, cDefaultMainOutputTableName))
		    
		    self.JoinStatusBoth = "JOIN"
		    self.JoinStatusLeftOnly = "LEFT"
		    
		  case JoinMode.InnerJoin
		    self.AddOutput(new clTransformerConnector(cOutputConnectorJoined, cDefaultMainOutputTableName)) // $$ "JoinedResults"))
		    
		    // by default, we only generated the main output (joined results)
		    
		    self.JoinStatusBoth = "JOIN"
		    self.JoinStatusLeftOnly = "LEFT"
		    self.JoinStatusRightOnly = "RIGHT"
		    
		  case else
		    
		    
		  end Select
		  
		  self.mode = mode
		  self.joinKeyFields = KeyFields
		  self.JoinStatusFieldName = JoinStatusField
		  
		  return
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub FullJoin(MasterTable as clDataTable, SecondaryTable as clDataTable, JoinStatusMasterOnly as string, JoinStatusSecondaryOnly as string, MasterOnlyOutputConnectorName as string, SecondaryOnlyOutputConnectorName as String)
		  //
		  // Executes a full join between the Master table and the secondary table
		  //
		  
		  var connector as clTransformerConnector
		  var OutputTable as clDataTable 
		  var masterOnlyOutputTable as clDataTable = nil
		  var secondaryOnlyOutputTable as clDataTable = nil
		  
		  connector = self.GetOutputConnector(cOutputConnectorJoined)
		  
		  OutputTable = new clDataTable(connector.GetTableName(False))
		  
		  if MasterOnlyOutputConnectorName.trim <> "" then
		    connector = self.GetOutputConnector(MasterOnlyOutputConnectorName)
		    if connector <> nil then masterOnlyOutputTable = new clDataTable(connector.GetTableName(False))
		    
		  end if
		  
		  if SecondaryOnlyOutputConnectorName.trim <> "" then
		    connector = self.GetOutputConnector(SecondaryOnlyOutputConnectorName)
		    if connector <> nil then secondaryOnlyOutputTable = new clDataTable(connector.GetTableName(False))
		    
		  end if
		  
		  
		  var rowmap() as Boolean
		  var JoinKeyColumns() as clAbstractDataSerie = SecondaryTable.GetColumns(joinKeyFields, True)
		  
		  // Build list of record id in secondary table for each combination of key values
		  var grp as new clSeriesGroupBy(JoinKeyColumns)
		  
		  // build boolean map of records in secondary table, used later to add unused record when doing an outer join
		  if mode = JoinMode.OuterJoin then
		    rowmap.RemoveAll
		    
		    for i as integer = 0 to SecondaryTable.LastIndex
		      rowmap.Add(False)
		      
		    next 
		    
		  end if
		  
		  var JoinKeyColumnValues() as Variant
		  var FoundRowsInJoinedTable as Boolean = false
		  
		  for each row as clDataRow in mastertable
		    JoinKeyColumnValues.RemoveAll
		    
		    for each col as clAbstractDataSerie  in JoinKeyColumns
		      JoinKeyColumnValues.add(row.GetCell(col.name)) // to improve
		      
		      // here lookup in group by results
		      var rowToMerge() as integer = grp.GetRowIndexes(JoinKeyColumnValues)
		      
		      if rowToMerge.Count > 0 then
		        for each index  as integer in rowToMerge
		          var row_main as clDataRow = row.Clone
		          
		          var row_join as clDataRow = SecondaryTable.GetRowAt(index, False)
		          
		          if JoinStatusFieldName.Length>0 then row_main.SetCell(JoinStatusFieldName, JoinStatusBoth)
		          
		          row_main.AppendCellsFrom(row_join)
		          
		          OutputTable.AddRow(row_main, clDataTable.AddRowMode.CreateNewColumn)
		          
		          if mode = JoinMode.OuterJoin then rowmap(index) = True
		          FoundRowsInJoinedTable = True
		          
		        next
		        
		      end if
		      
		      if rowToMerge.Count = 0 and (mode = JoinMode.OuterJoin or mode = JoinMode.LeftJoin) then
		        var row_main as clDataRow = row.Clone()
		        
		        if JoinStatusFieldName.Length>0 then row_main.SetCell(JoinStatusFieldName, JoinStatusMasterOnly)
		        
		        OutputTable.AddRow(row_main, clDataTable.AddRowMode.CreateNewColumn)
		        
		      end if
		      
		      if rowToMerge.Count = 0 and mode = JoinMode.InnerJoin and masterOnlyOutputTable <> nil then
		        masterOnlyOutputTable.AddRow(row, clDataTable.AddRowMode.CreateNewColumn)
		        
		      end if
		      
		      
		    next
		    
		  next
		  
		  // Add empty columns from master table and joined table if output is empty
		  if OutputTable.RowCount = 0 then 
		    for each col as clAbstractDataSerie in mastertable.GetAllColumns
		      call OutputTable.AddColumn(col.CloneStructure)
		      
		    next
		    
		    if  JoinStatusFieldName.Length > 0  then call OutputTable.AddColumn(new clDataSerie(JoinStatusFieldName))
		    
		    for each col as clAbstractDataSerie in SecondaryTable.GetAllColumns
		      call OutputTable.AddColumn(col.CloneStructure)
		      
		    next
		    
		  end if
		  
		  
		  
		  select case mode
		  case JoinMode.InnerJoin
		    
		    
		  case JoinMode.OuterJoin
		    
		    // For outer join, add missing rows from joined table
		    
		    for index as integer = 0 to rowmap.LastIndex
		      if not rowmap(index) then 
		        var row_join as clDataRow = SecondaryTable.GetRowAt(index, False)
		        
		        if JoinStatusFieldName.Length>0 then row_join.SetCell(JoinStatusFieldName, JoinStatusSecondaryOnly)
		        
		        OutputTable.AddRow(row_join, clDataTable.AddRowMode.CreateNewColumn)
		        
		      end if
		      
		    next
		    
		    if JoinStatusFieldName.Length>0 then
		      var ds As clAbstractDataSerie = OutputTable.GetColumn(JoinStatusFieldName)
		      ds.AddMetadata("Source", "Generated by JoinTransformer")
		      
		    end if
		    
		    
		  case JoinMode.LeftJoin
		    if JoinStatusFieldName.Length>0 then
		      var ds As clAbstractDataSerie = OutputTable.GetColumn(JoinStatusFieldName)
		      ds.AddMetadata("Source", "Generated by JoinTransformer")
		      
		    end if
		    
		    
		  case else
		    
		  end select
		  
		  self.SetOutputTable(cOutputConnectorJoined, OutputTable)
		  
		  return
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub GenerateNonMatchingDatasets(GenerateNonMatchingLeft as Boolean, GenerateNonMatchingRight as Boolean)
		  
		  if mode = JoinMode.OuterJoin then return
		  
		  
		  If GenerateNonMatchingLeft then 
		    self.AddOutput(new clTransformerConnector(cOutputConnectorLeft, "LeftResults"))
		    
		  elseif self.OutputConnectors.HasKey(cOutputConnectorLeft) then 
		    self.OutputConnectors.Remove(cOutputConnectorLeft)
		    
		  end if
		  
		  
		  
		  If GenerateNonMatchingRight then 
		    self.AddOutput(new clTransformerConnector(cOutputConnectorRight, "RightResults"))
		    
		  elseif self.OutputConnectors.HasKey(cOutputConnectorRight) then 
		    self.OutputConnectors.Remove(cOutputConnectorRight)
		    
		  end if
		  
		  return
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SetJoinStatusBoth(label as string)
		  
		  self.JoinStatusBoth = label
		  
		  return
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SetJoinStatusLeft(label as string)
		  
		  self.JoinStatusLeftOnly = label
		  
		  return
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SetJoinStatusRight(label as string)
		  
		  self.JoinStatusRightOnly = label
		  
		  return
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Transform() As Boolean
		  
		  var tblleft as clDataTable = self.GetInputTable(cInputConnectorLeft)
		  var tblright as clDataTable = self.GetInputTable(cInputConnectorRight)
		  
		  if tblleft = nil or tblright = nil then
		    return false
		    
		  end if
		  
		  var cntleft as integer = tblleft.RowCount
		  var cntright as integer = tblright.RowCount
		  
		  var connector as clTransformerConnector
		  
		  var outputLeftConnection as string = ""
		  var outputRightConnection as string = ""
		  
		  connector = self.GetOutputConnector(cOutputConnectorLeft)
		  if connector <>nil and  connector.GetTableName(false).trim.Length > 0 then outputLeftConnection = cOutputConnectorLeft
		  
		  connector = self.GetOutputConnector(cOutputConnectorRight)
		  if connector <>nil and connector.GetTableName(false).trim.Length > 0 then outputRightConnection = cOutputConnectorRight
		   
		  
		  if cntleft > cntright or self.mode = JoinMode.LeftJoin then
		    FullJoin(tblleft, tblright, self.JoinStatusLeftOnly, self.JoinStatusRightOnly, outputLeftConnection, cOutputConnectorRight)
		    
		  else
		    FullJoin(tblright, tblleft, self.JoinStatusRightOnly, self.JoinStatusLeftOnly, cOutputConnectorRight, outputLeftConnection)
		    
		    
		  end if
		  
		  
		  // Update metadata
		  
		  var OutputJoin as clDataTable =  self.GetOutputTable(cOutputConnectorJoined)
		  var outputLeft as clDataTable = Self.GetOutputTable(cOutputConnectorLeft)
		  var outputRight as clDataTable = Self.GetOutputTable(cOutputConnectorRight) 
		  
		  select case mode
		    
		  case JoinMode.InnerJoin
		    OutputJoin.AddMetaData("Transformation", "Inner join between " + tblleft.name + " and " + tblright.name+"." )
		    
		    if outputLeft <> nil then outputLeft.AddMetaData("Transformation", "Non matching records from "+ tblleft.name  + " when joining with " + tblright.name+"." )
		    
		    if outputRight <> nil then outputRight.AddMetaData("Transformation", "Non matching records from "+ tblright.name  + " when joining with " + tblleft.name+"." )
		    
		  case JoinMode.OuterJoin
		    OutputJoin.AddMetaData("Transformation", "Outer join between " + tblleft.name + " and " + tblright.name+"." )
		    
		  case JoinMode.LeftJoin
		    OutputJoin.AddMetaData("Transformation", "Left join between " + tblleft.name + " and " + tblright.name+"." )
		    
		  case else
		    OutputJoin.AddMetaData("Transformation", "Join between " + tblleft.name + " and " + tblright.name+"." )
		    
		  end select
		  
		  return true
		  
		End Function
	#tag EndMethod


	#tag Note, Name = TODO
		Add support for only left and only right output
		
		
	#tag EndNote


	#tag Property, Flags = &h0
		joinKeyFields() As String
	#tag EndProperty

	#tag Property, Flags = &h0
		JoinStatusBoth As string
	#tag EndProperty

	#tag Property, Flags = &h0
		JoinStatusFieldName As String
	#tag EndProperty

	#tag Property, Flags = &h0
		JoinStatusLeftOnly As string
	#tag EndProperty

	#tag Property, Flags = &h0
		JoinStatusRightOnly As string
	#tag EndProperty

	#tag Property, Flags = &h0
		mode As JoinMode
	#tag EndProperty


	#tag Constant, Name = cInputConnectorLeft, Type = String, Dynamic = False, Default = \"LeftInput", Scope = Public
	#tag EndConstant

	#tag Constant, Name = cInputConnectorRight, Type = String, Dynamic = False, Default = \"RightInput", Scope = Public
	#tag EndConstant

	#tag Constant, Name = cOutputConnectorJoined, Type = String, Dynamic = False, Default = \"JoinedOutput", Scope = Public
	#tag EndConstant

	#tag Constant, Name = cOutputConnectorLeft, Type = String, Dynamic = False, Default = \"LeftOutput", Scope = Public
	#tag EndConstant

	#tag Constant, Name = cOutputConnectorRight, Type = String, Dynamic = False, Default = \"RightOutput", Scope = Public
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
			Name="mode"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="JoinMode"
			EditorType="Enum"
			#tag EnumValues
				"0 - OuterJoin"
				"1 - InnerJoin"
				"2 - LeftJoin"
			#tag EndEnumValues
		#tag EndViewProperty
		#tag ViewProperty
			Name="JoinStatusBoth"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="string"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="JoinStatusLeftOnly"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="string"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="JoinStatusRightOnly"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="string"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="JoinStatusFieldName"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
