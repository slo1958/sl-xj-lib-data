#tag Class
Protected Class clTransposeTransformer
Inherits clLinearTransformer
	#tag Method, Flags = &h21
		Private Sub addColumnFromRow(index as integer, row as clDatarow, outputTable as clDataTable)
		  
		  var newColumnName as string
		  
		  select case FieldNameSource.Count
		    
		  case  0 
		    newColumnName = "Column " + str(index+1)
		    
		  case 1
		    newColumnName = row.GetCell(FieldNameSource(0))
		    
		  case else
		    var tmp() as string
		    for each colname as string in self.FieldNameSource
		      tmp.Add(row.GetCell(colname))
		      
		    next
		    
		    newColumnName = string.FromArray(tmp," ")
		    
		  end select
		  
		  newColumnName = newColumnName.Trim
		  
		  newColumnName = outputTable.GetUniqueColumnName(newColumnName.trim)
		  
		  var items() as Variant
		  
		  For Each column_name As String In row
		    var item As variant = Row.GetCell(column_name)
		    if FieldNameSource.IndexOf(column_name) < 0 then items.Add(item)
		    
		  next
		  
		  call outputTable.AddColumn(new clDataSerie(newColumnName, items))
		  
		  Return
		  
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ConfigureTranspose(columnsForFieldName() as string)
		  
		  if columnsForFieldName.Count = 0 then
		    self.useFirstColumn = True // this will be use when we get access to the source table, at the begining of the transformation
		    
		  else
		    self.useFirstColumn = False
		    
		    
		    for each s as string in columnsForFieldName
		      if FieldNameSource.IndexOf(s) < 0 then FieldNameSource.Add(s)
		      
		    next
		    
		  end if
		  
		  Return
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  // Calling the overridden superclass constructor.
		  Super.Constructor
		  
		  var dummy() as string
		  self.configureTranspose(dummy)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(MainTable as clDataTable)
		  // Calling the overridden superclass constructor.
		  Super.Constructor(MainTable)
		  
		  var dummy() as string
		  self.configureTranspose(dummy)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(MainTable as clDataTable, columnsForFieldName() as string)
		  // Calling the overridden superclass constructor.
		  // Note that this may need modifications if there are multiple constructor choices.
		  // Possible constructor calls:
		  // Constructor() -- From clLinearTransformer
		  // Constructor() -- From clAbstractTransformer
		  
		  Super.Constructor(MainTable)
		  
		  self.configureTranspose(columnsForFieldName)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(columnsForFieldName() as string)
		  // Calling the overridden superclass constructor.
		  // Note that this may need modifications if there are multiple constructor choices.
		  // Possible constructor calls:
		  // Constructor() -- From clLinearTransformer
		  // Constructor() -- From clAbstractTransformer
		  
		  Super.Constructor
		  
		  self.configureTranspose(columnsForFieldName)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub prepareTranspose(source as clDataTable)
		  
		  if self.useFirstColumn then
		    var tmp as string
		    tmp = source.GetColumnNameAt(0)
		    
		    if tmp.Length > 0 then  FieldNameSource.add(tmp)
		    
		  else
		    
		  end if
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function Transform() As Boolean
		  
		  
		  var source as clDataTable = self.SourceTable
		  
		  var results as new clDataTable("Transposed " + source.Name)
		  results.AddSourceToMetadata(source.Name)
		  results.AddMetaData(clMetadata.KeyForTransformation,"Transpose")
		  
		  self.prepareTranspose(source)
		  
		  var rowIndex as integer = 0
		  
		  for each r as clDataRow in source
		    rowIndex = rowIndex + 1
		    self.addColumnFromRow(rowIndex, r, results)
		    
		  next
		  
		  Self.SetOutputTable(cOutputConnectorName, results)
		  
		  return results <> nil
		  
		  
		  
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private FieldNameSource() As string
	#tag EndProperty

	#tag Property, Flags = &h21
		Private useFirstColumn As Boolean
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
	#tag EndViewBehavior
End Class
#tag EndClass
