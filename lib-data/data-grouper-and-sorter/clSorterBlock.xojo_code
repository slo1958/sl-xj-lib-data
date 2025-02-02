#tag Class
Protected Class clSorterBlock
	#tag Method, Flags = &h0
		Sub Add(sortkey() as variant, recordIndex as integer)
		  
		  SortData.Add(sortkey:recordIndex)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function PairCompareForSort(value1 as Pair, value2 as Pair) As integer
		  
		  var v1() as variant = value1.left
		  var v2() as variant = value2.left
		  
		  for i as integer = 0 to v1.LastIndex
		    if v1(i) > v2(i) then return 1
		    if v1(i) < v2(i) then return -1
		    
		  next
		  
		  If value1.Right.IntegerValue > value2.Right.IntegerValue Then Return 1
		  If value1.Right.IntegerValue < value2.Right.IntegerValue Then Return -1
		  
		  Return 0
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Sort(order as SortOrder)
		  
		  SortData.sort(AddressOf PairCompareForSort)
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		SortData() As pair
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
