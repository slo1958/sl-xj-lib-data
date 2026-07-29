#tag Class
Protected Class clShadowTableRowReader
Inherits clAbstractShadowTable
Implements TableRowReaderInterface
	#tag Method, Flags = &h0
		Function ColumnCount() As integer
		  // Part of the TableRowReaderInterface interface.
		  
		  return FieldNameCache.Count
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ColumnInfoAvailable() As boolean
		  return FieldNameCache.Count >= 1
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(source_table as clAbstractShadowTable)
		  
		  source = source_table
		  current_row = 0
		  FieldNameCache.RemoveAll
		  workbuffer = nil
		  EndOfSource = False
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function CurrentRowIndex() As integer
		  // Part of the TableRowReaderInterface interface.
		  return current_row
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function EndOfTable() As boolean
		  // Part of the TableRowReaderInterface interface.
		  
		  if workbuffer <> nil then
		    return (workbuffer.EndOfBuffer and workbuffer.IsLastBuffer)
		    
		  end if
		  
		  return EndOfSource 
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetColumnNames() As string()
		  // Part of the TableRowReaderInterface interface.
		  return self.FieldNameCache
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetColumnTypes() As dictionary
		   
		  return nil
		  
		  // return source.GetColumnTypes
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetListOfExternalElements() As string()
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetMetadata() As Dictionary
		  return nil
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Name() As string
		  // Part of the TableRowReaderInterface interface.
		  return Source.Name
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function NextRow() As clDataRow
		  // Part of the TableRowReaderInterface interface.
		  
		  if source  = nil then return nil
		  
		  if workbuffer = nil or workbuffer.EndOfBuffer then
		    workbuffer = source.GetNextRowBuffer(5)
		    
		  end if
		  
		  
		  if workbuffer = nil or workbuffer.EndOfBuffer then
		    EndOfSource = True
		    return nil
		    
		  end if
		  
		  if FieldNameCache.Count < 1 then
		    FieldNameCache = workbuffer.GetColumnNames
		    
		  end if
		  
		  
		  current_row = current_row + 1
		  
		  return workbuffer.GetNextRow
		  
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function NextRowAsString() As string()
		  // Part of the TableRowReaderInterface interface.
		  var row_value() as string
		  
		  var temp as clDataRow = NextRow
		  
		  if temp = nil then return row_value
		  
		  for each name as string in self.FieldNameCache
		    row_value.Add(temp.GetCell(name).StringValue)
		    
		  next
		  
		  return row_value
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function NextRowAsVariant() As variant()
		  // Part of the TableRowReaderInterface interface.
		  var row_value() as variant
		  
		  var temp as clDataRow = NextRow
		  
		  if temp = nil then return row_value
		  
		  for each name as string in self.FieldNameCache
		    row_value.Add(temp.GetCell(name))
		    
		  next
		  
		  return row_value
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function NextRowAvailable() As boolean
		  return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub UpdateExternalName(new_name as string)
		  
		  return
		  
		End Sub
	#tag EndMethod


	#tag Note, Name = Description
		Implements the row reader interface using a table as source.
		It could be used to read rows from a table to feed another table.
	#tag EndNote


	#tag Property, Flags = &h21
		Private current_row As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		EndOfSource As Boolean
	#tag EndProperty

	#tag Property, Flags = &h0
		FieldNameCache() As string
	#tag EndProperty

	#tag Property, Flags = &h21
		Private source As clAbstractShadowTable
	#tag EndProperty

	#tag Property, Flags = &h0
		workbuffer As clDataRowBuffer
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
		#tag ViewProperty
			Name="EndOfSource"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
