#tag Class
Protected Class clLookupTransformer
Inherits clAbstractTransformer
	#tag Method, Flags = &h0
		Sub Constructor(MainTable as clDataTable, LookupTable as clDataTable, KeyFieldMapping() as Pair, LookupFieldMapping() as pair, JoinStatusField as string = "")
		  // Calling the overridden superclass constructor.
		  Super.Constructor
		  
		  self.AddInput(new clTransformerConnector(cInputConnectorMain, MainTable))
		  self.AddInput(new clTransformerConnector(cInputConnectorLookUp, LookupTable))
		  
		  self.JoinStatusFieldName = JoinStatusField
		  
		  
		  self.LookupKeyFields.RemoveAll
		  self.MainKeyFields.RemoveAll
		  
		  for each p as pair in KeyFieldMapping
		    self.MainKeyFields.Add(p.Left)
		    self.LookupKeyFields.Add(p.Right)
		    
		  next
		  
		  
		  self.MainTargetDataFields.RemoveAll
		  self.LookupSourceDataFields.RemoveAll
		  
		  for each p as pair in LookupFieldMapping
		    self.MainTargetDataFields.add(p.left)
		    self.LookupSourceDataFields.Add(p.right)
		    
		  next
		  
		  return
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(MainTable as clDataTable, LookupTable as clDataTable, KeyFields() as string, LookupFields() as string, JoinStatusField as string = "")
		  // Calling the overridden superclass constructor.
		  Super.Constructor
		  
		  self.AddInput(new clTransformerConnector(cInputConnectorMain, MainTable))
		  self.AddInput(new clTransformerConnector(cInputConnectorLookUp, LookupTable))
		  
		  self.JoinStatusFieldName = JoinStatusField
		  
		  
		  self.LookupKeyFields.RemoveAll
		  self.MainKeyFields.RemoveAll
		  
		  for each v as String in KeyFields
		    self.MainKeyFields.Add(v)
		    self.LookupKeyFields.Add(v)
		    
		  next
		  
		  
		  self.MainTargetDataFields.RemoveAll
		  self.LookupSourceDataFields.RemoveAll
		  
		  for each v as String in LookupFields
		    self.MainTargetDataFields.add(v)
		    self.LookupSourceDataFields.Add(v)
		    
		  next
		  
		  return
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function RunLookup() As boolean
		  const cstSuccessMark = "$$$M$$$"
		  
		  var tblleft as clDataTable = self.GetInputTable(cInputConnectorMain) 
		  var tblright as clDataTable = self.GetInputTable(cInputConnectorLookup)
		  
		  
		  var buffer as new Dictionary
		  
		  var keyColumns() as clAbstractDataSerie
		  var dataColumns() as clAbstractDataSerie
		  
		  var sourceColumns() as clAbstractDataSerie
		  
		  var JoinSuccessColumn as clAbstractDataSerie = nil
		  
		  if MainKeyFields.LastIndex <> LookupKeyFields.LastIndex then return false
		  if MainTargetDataFields.LastIndex <> LookupSourceDataFields.LastIndex then return false
		  
		  for each field as string in MainKeyFields
		    keyColumns.Add(tblleft.GetColumn(field, False))
		    
		  next
		  
		  if JoinStatusFieldName.Length > 0 then JoinSuccessColumn = tblleft.GetColumn(JoinStatusFieldName, False)
		  
		  // collect impacted data columns in the main table
		  for i as integer = 0 to MainTargetDataFields.LastIndex
		    
		    var c as clAbstractDataSerie = tblleft.GetColumn(MainTargetDataFields(i), false)
		    
		    
		    if c = nil then
		      // If the column does not exist in the main table ..
		      // Locate the mapped column in lookup table
		      var d as clAbstractDataSerie = tblright.GetColumn(LookupSourceDataFields(i), false)
		      
		      if d = nil then
		        // .... add the column to the main table, using default type
		        c = tblleft.AddColumn(new clDataSerie(MainTargetDataFields(i)))
		        
		      else
		        // ... add the column to the main table, matching the type of the column in the lookup table
		        c = tblleft.AddColumn(clDataType.CreateDataSerieFromType(MainTargetDataFields(i), d.GetType))
		        
		      end if
		      
		    end if
		    
		    dataColumns.add (c)
		    
		  next
		  
		  
		  for each field as string in LookupSourceDataFields
		    sourceColumns.Add(tblright.GetColumn(field, false))
		    
		  next
		  
		  // Scan main table
		  for i as integer = 0 to tblleft.RowCount
		    var lookupKeyParts() as string 
		    var lookupkey as string
		    var row as clDataRow
		    
		    
		    for each c as clAbstractDataSerie in keyColumns
		      lookupKeyParts.Add(c.GetElementAsString(i))
		      
		    next
		    
		    lookupkey = string.FromArray(Lookupkeyparts,chr(8))
		    
		    if buffer.HasKey(lookupkey) then
		      row = clDataRow(buffer.Value(lookupkey))
		      
		    else
		      
		      row = tblright.FindFirstMatchingRow(LookupKeyFields, lookupKeyParts, false)
		      
		      if row = nil then
		        row = new clDataRow()
		        
		        for each col as clAbstractDataSerie in sourceColumns
		          if col <> nil then
		            row.SetCell(col.name, col.GetDefaultValue)
		            
		          end if
		          
		        next
		        
		        
		        row.SetCell(cstSuccessMark, False)
		        
		      else
		        row.SetCell(cstSuccessMark, True)
		        
		      end if
		      
		      buffer.Value(lookupkey) = row
		      
		    end if
		    
		    
		    // Update the data columns in the main table
		    
		    for col_index as integer = 0 to dataColumns.LastIndex
		      var col  as clAbstractDataSerie = dataColumns(col_index)
		      var sourcename as string = LookupSourceDataFields(col_index)
		      
		      
		      if col <> nil then
		        col.SetElement(i, row.GetCell(sourcename))
		        
		      end if
		      
		      
		    next
		    
		    if JoinSuccessColumn <> nil then JoinSuccessColumn.SetElement(i, row.GetCell(cstSuccessMark))
		    
		  next
		  
		  
		  return True
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Transform() As Boolean
		  
		  return RunLookup()
		  
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0
		JoinStatusFieldName As String
	#tag EndProperty

	#tag Property, Flags = &h0
		LookupKeyFields() As string
	#tag EndProperty

	#tag Property, Flags = &h0
		LookupSourceDataFields() As string
	#tag EndProperty

	#tag Property, Flags = &h0
		MainKeyFields() As string
	#tag EndProperty

	#tag Property, Flags = &h0
		MainTargetDataFields() As string
	#tag EndProperty


	#tag Constant, Name = cInputConnectorLookUp, Type = String, Dynamic = False, Default = \"LookupInput", Scope = Public
	#tag EndConstant

	#tag Constant, Name = cInputConnectorMain, Type = String, Dynamic = False, Default = \"MainInput", Scope = Public
	#tag EndConstant

	#tag Constant, Name = cOutputConnectorName, Type = String, Dynamic = False, Default = \"Output", Scope = Public
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
