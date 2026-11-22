#tag Class
Protected Class clSeriesGrouperElement
	#tag Method, Flags = &h0
		Sub AddMeasureValue(Index as integer, value as double)
		  
		  self.intMeasures(Index).AddElement(value)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AddRowIndex(RowIndex as integer)
		  
		  self.RowIndexes.Add(RowIndex)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetRowIndexCount() As integer
		  return self.RowIndexes.Count
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetRowIndexes() As integer()
		  
		  return self.RowIndexes
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function HasKey(Key as string) As Boolean
		  
		  if Node = nil then return False
		  
		  return Node.HasKey(key)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Keys() As Variant()
		  
		  if node = nil then
		    var tmp() as variant
		    return tmp
		    
		  else
		    return node.keys
		    
		  end if
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MeasureCount() As integer
		  Return intMeasures.count 
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub MeasureCount(assigns n as integer)
		  
		  if intMeasures.count > 0 then return
		  
		  for i as integer = 0 to n-1
		    self.intMeasures.Add(new clNumberDataSerie(str(i)))
		    
		  next
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MeasureValues(index as integer) As clNumberDataSerie
		  return self.intMeasures(index)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Value(key as string) As variant
		  
		  if Node = nil then return ""
		  
		  return Node.Value(key)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Value(Key as string, assigns v as variant)
		  
		  if node = nil then node = new Dictionary
		  node.Value(key) = v
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private intMeasures() As clNumberDataSerie
	#tag EndProperty

	#tag Property, Flags = &h21
		Private Node As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private RowIndexes() As Integer
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
