#tag Class
Protected Class clListOfDictionariesReader
Implements TableRowReaderInterface
	#tag Method, Flags = &h0
		Function ColumnCount() As integer
		  // Part of the TableRowReaderInterface interface.
		  
		  return column_names.Count
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(source() as Dictionary, name as string, sampleSize as integer = 10)
		  //
		  // builds a row reader from a list of dictionaries, returned for instance from parsing a json file
		  //
		  // an instance of this call can then be used as input of the constructor of a data table
		  //
		  
		  self.source_dict = source
		  self.myname = name
		  self.SampleSize = sampleSize
		  
		  var lastIndex as integer = sampleSize
		  
		  if lastIndex > source.LastIndex then lastIndex = source.LastIndex
		  
		  column_names.RemoveAll  
		  
		  for index as integer = 0 to lastIndex
		    var d as Dictionary = source(index)
		    
		    for each key as string in d.Keys
		      if self.column_names.IndexOf(key.Trim) < 0 then
		        self.column_names.Add(key.trim)
		        
		      end if
		      
		    next
		    
		  next
		  
		  self.last_row_index = -1
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(source() as Dictionary, name as string, retainColumns() as string, sampleSize as integer = 10)
		  //
		  // builds a row reader from an array of dictionaries, returned for instance from parsing a json file
		  //
		  // an instance of this call can then be used as input of the constructor of a data table
		  //
		  
		  self.source_dict = source
		  self.myname = name
		  self.SampleSize = sampleSize
		  
		  var lastIndex as integer = sampleSize
		  
		  if lastIndex > source.LastIndex then lastIndex = source.LastIndex
		  
		  column_names.RemoveAll  
		  
		  for each column_name as string in retainColumns
		    if self.column_names.IndexOf(column_name.Trim) < 0 then self.column_names.Add(column_name.trim)
		    
		  next
		  
		  self.last_row_index = -1
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function CurrentRowIndex() As integer
		  // Part of the TableRowReaderInterface interface.
		  return self.last_row_index
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function EndOfTable() As boolean
		  // Part of the TableRowReaderInterface interface.
		  
		  return self.last_row_index >= self.source_dict.LastIndex
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetColumnNames() As string()
		  // Part of the TableRowReaderInterface interface.
		  
		  return self.column_names
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetColumnTypes() As dictionary
		  // Part of the TableRowReaderInterface interface.
		  
		  return nil
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetListOfExternalElements() As string()
		  // Part of the TableRowReaderInterface interface.
		  
		  return self.column_names
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Name() As string
		  // Part of the TableRowReaderInterface interface.
		  Return self.myname
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function NextRow() As clDataRow
		  // Part of the TableRowReaderInterface interface.
		  
		  Raise New clDataException("Unimplemented method " + CurrentMethodName)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function NextRowAsVariant() As variant()
		  // Part of the TableRowReaderInterface interface.
		  
		  var cellArray() as variant
		  
		  last_row_index = last_row_index + 1
		  
		  if self.last_row_index > self.source_dict.LastIndex then return cellArray
		  
		  var d as Dictionary  = source_dict(last_row_index)
		  
		  for each field as string in column_names
		    cellArray.Add(d.Lookup(field, ""))
		    
		  next
		  
		  return cellArray
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub UpdateExternalName(new_name as string)
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		column_names() As String
	#tag EndProperty

	#tag Property, Flags = &h0
		last_row_index As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		myname As String
	#tag EndProperty

	#tag Property, Flags = &h0
		SampleSize As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		source_dict() As Dictionary
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
			Name="last_row_index"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="myname"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="SampleSize"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
