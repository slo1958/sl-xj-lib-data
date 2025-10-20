#tag Class
Protected Class clJoinTransformer
Inherits clAbstractTransformer
	#tag Method, Flags = &h0
		Sub Constructor(LeftTable as clDataTable, RightTable as clDataTable, mode as JoinMode, KeyFields() as string, JoinSuccessField as string = "")
		  // Calling the overridden superclass constructor.
		  Super.Constructor
		  
		  
		  self.AddInput(cInputConnectionLeft, LeftTable)
		  self.AddInput(cInputConnectionRight, RightTable)
		  
		  select case mode
		    
		  case  JoinMode.OuterJoin 
		    self.SetOutputName(cOutputConnectionJoined, "Results")
		    
		    self.JoinSuccessBoth = "JOIN"
		    
		  case JoinMode.InnerJoin
		    self.SetOutputName(cOutputConnectionJoined, "JoinedResults")
		    self.SetOutputName(cOutputConnectionLeft,"LeftResults")
		    self.SetOutputName(cOutputConnectionRight,"RightResults")
		    
		    self.JoinSuccessBoth = "JOIN"
		    self.JoinSuccessLeftOnly = "LEFT"
		    self.JoinSuccessRightOnly = "RIGHT"
		    
		  case else
		    
		    
		  end Select
		  
		  
		  self.mode = mode
		  self.joinKeyFields = KeyFields
		  self.JoinSuccessField = JoinSuccessField
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub FullJoin(MasterTable as clDataTable, SecondaryTable as clDataTable, JoinSuccessMasterOnly as string, JoinSuccessSecondaryOnly as string)
		  //
		  // Executes a full join between the Master table and the secondary table
		  //
		  
		  
		  //var leftOutputTable as clDataTable = self.GetTable(cOutputConnectionLeft)
		  var outputTable as clDataTable = new clDataTable(self.GetName(cOutputConnectionJoined))
		  
		  //var rightOutputTable as clDataTable = self.GetTable(cOutputConnectionRight)
		  
		  
		  var rowmap() as Boolean
		  var JoinKeyColumns() as clAbstractDataSerie = SecondaryTable.GetColumns(joinKeyFields, True)
		  var JoinKeyColumnValues() as Variant
		  
		  var grp as new clSeriesGroupBy(JoinKeyColumns)
		  
		  
		  if mode = JoinMode.OuterJoin then
		    rowmap.RemoveAll
		    
		    for i as integer = 0 to SecondaryTable.LastIndex
		      rowmap.Add(False)
		      
		    next 
		    
		  end if
		  
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
		          
		          if JoinSuccessField.Length>0 then row_main.SetCell(JoinSuccessField, JoinSuccessBoth)
		          
		          row_main.AppendCellsFrom(row_join)
		          
		          outputtable.AddRow(row_main, clDataTable.AddRowMode.CreateNewColumn)
		          
		          if mode = JoinMode.OuterJoin then rowmap(index) = True
		          FoundRowsInJoinedTable = True
		          
		        next
		        
		      end if
		      
		      if rowToMerge.Count = 0 and mode = JoinMode.OuterJoin then
		        var row_main as clDataRow = row.Clone()
		        
		        if JoinSuccessField.Length>0 then row_main.SetCell(JoinSuccessField, JoinSuccessMasterOnly)
		        
		        outputtable.AddRow(row_main, clDataTable.AddRowMode.CreateNewColumn)
		        
		      end if
		      
		    next
		    
		  next
		  
		  // Add empty columns from master table and joined table if output is empty
		  if outputtable.RowCount = 0 then 
		    for each col as clAbstractDataSerie in mastertable.GetAllColumns
		      call outputtable.AddColumn(col.CloneStructure)
		      
		    next
		    
		    if  JoinSuccessField.Length > 0  then call outputtable.AddColumn(new clDataSerie(JoinSuccessField))
		    
		    for each col as clAbstractDataSerie in SecondaryTable.GetAllColumns
		      call outputtable.AddColumn(col.CloneStructure)
		      
		    next
		    
		  end if
		  
		  
		  
		  select case mode
		  case JoinMode.InnerJoin
		    
		    
		  case JoinMode.OuterJoin
		    
		    // For outer join, add missing rows from joined table
		    
		    for index as integer = 0 to rowmap.LastIndex
		      if not rowmap(index) then 
		        var row_join as clDataRow = SecondaryTable.GetRowAt(index, False)
		        
		        if JoinSuccessField.Length>0 then row_join.SetCell(JoinSuccessField, JoinSuccessSecondaryOnly)
		        
		        outputtable.AddRow(row_join, clDataTable.AddRowMode.CreateNewColumn)
		        
		      end if
		      
		      
		    next
		    
		  case else
		    
		  end select
		  
		  self.AddOutput(cOutputConnectionJoined, outputTable)
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SetJoinSuccessBoth(label as string)
		  self.JoinSuccessBoth = label
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SetJoinSuccessLeft(label as string)
		  self.JoinSuccessLeftOnly = label
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SetJoinSuccessRight(label as string)
		  self.JoinSuccessRightOnly = label
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Transform() As Boolean
		  
		  var tblleft as clDataTable = self.GetTable(cInputConnectionLeft)
		  var tblright as clDataTable = self.GetTable(cInputConnectionRight)
		  
		  var cntleft as integer = tblleft.RowCount
		  var cntright as integer = tblright.RowCount
		  
		  
		  if cntleft < cntright then
		    
		    FullJoin(tblright, tblleft, self.JoinSuccessRightOnly, self.JoinSuccessLeftOnly)
		    
		  else
		    FullJoin(tblleft, tblright, self.JoinSuccessLeftOnly, self.JoinSuccessRightOnly)
		    
		  end if
		  
		  
		  return true
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub zCodeToRetainInTable()
		  
		  var joinModeStr as string
		  if mode = JoinMode.InnerJoin then 
		    joinModeStr = "Inner join"
		    
		  elseif mode = JoinMode.OuterJoin then
		    joinModeStr = "Outer join"
		    
		  else
		    joinModeStr = "Strange join"
		    
		  end if
		  
		  //var outputtable as new clDataTable(joinModeStr + " " + mastertable.Name + " and " + joinedtable.Name)
		End Sub
	#tag EndMethod


	#tag Note, Name = TODO
		Add support for only left and only right output
		
		
	#tag EndNote


	#tag Property, Flags = &h0
		joinKeyFields() As String
	#tag EndProperty

	#tag Property, Flags = &h0
		JoinSuccessBoth As string
	#tag EndProperty

	#tag Property, Flags = &h0
		JoinSuccessField As String
	#tag EndProperty

	#tag Property, Flags = &h0
		JoinSuccessLeftOnly As string
	#tag EndProperty

	#tag Property, Flags = &h0
		JoinSuccessRightOnly As string
	#tag EndProperty

	#tag Property, Flags = &h0
		mode As JoinMode
	#tag EndProperty


	#tag Constant, Name = cInputConnectionLeft, Type = String, Dynamic = False, Default = \"LeftInput", Scope = Public
	#tag EndConstant

	#tag Constant, Name = cInputConnectionRight, Type = String, Dynamic = False, Default = \"RightInput", Scope = Public
	#tag EndConstant

	#tag Constant, Name = cOutputConnectionJoined, Type = String, Dynamic = False, Default = \"JoinedOutput", Scope = Public
	#tag EndConstant

	#tag Constant, Name = cOutputConnectionLeft, Type = String, Dynamic = False, Default = \"LeftOutput", Scope = Public
	#tag EndConstant

	#tag Constant, Name = cOutputConnectionRight, Type = String, Dynamic = False, Default = \"RightOutput", Scope = Public
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
			#tag EndEnumValues
		#tag EndViewProperty
		#tag ViewProperty
			Name="JoinSuccessBoth"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="string"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="JoinSuccessLeftOnly"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="string"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="JoinSuccessRightOnly"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="string"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="JoinSuccessField"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
