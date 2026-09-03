#tag Class
Protected Class clDataTableFilter
Implements Iterable
	#tag Method, Flags = &h0
		Sub Constructor(SourceTable as clDataTable, the_filter_serie as clBooleanDataSerie)
		  
		  self.tmp_table = SourceTable
		  self.tmp_serie = the_filter_serie
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(SourceTable as clDataTable, the_filter_serie_name as string)
		  
		  self.tmp_table = SourceTable
		  self.tmp_serie = clBooleanDataSerie(self.tmp_table.GetColumn(the_filter_Serie_Name))
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Iterator() As Iterator
		  // Part of the Iterable interface.
		  
		  return new clDataTableFilterIterator(self.tmp_table, self.tmp_serie)
		  
		End Function
	#tag EndMethod


	#tag Note, Name = Description
		Used together with clDataTableFilterIterator, allows to loop thru rows of a table, matching a condition stored as a boolean serie.
		The boolean serie can be either an independant boolean serie or a column in the table.
		
		
		
	#tag EndNote


	#tag Property, Flags = &h0
		tmp_serie As clBooleanDataSerie
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
	#tag EndViewBehavior
End Class
#tag EndClass
