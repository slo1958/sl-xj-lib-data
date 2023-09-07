#tag Class
Protected Class clDataTableFilter
Implements Iterable
	#tag Method, Flags = &h0
		Sub Constructor(the_table as clDataTable, the_serie_name as string)
		  self.tmp_table = the_table
		  self.tmp_serie_name = the_serie_name
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Iterator() As Iterator
		  // Part of the Iterable interface.
		  
		  dim tmp_serie as clBooleanDataSerie = clBooleanDataSerie(self.tmp_table.get_column(self.tmp_serie_name))
		  return new clDataTableFilterIterator(self.tmp_table, tmp_serie)
		  
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0
		tmp_serie_name As String
	#tag EndProperty

	#tag Property, Flags = &h0
		tmp_table As clDataTable
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
			Name="tmp_serie_name"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
