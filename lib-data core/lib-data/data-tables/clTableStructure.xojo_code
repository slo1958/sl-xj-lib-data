#tag Class
Protected Class clTableStructure
	#tag Method, Flags = &h0
		Sub AddFieldInfo(v as clFieldInfoEntry)
		  
		  self.Fields.Add(v)
		  
		  Return
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(tablename as string)
		  
		  self.Name = tablename
		  
		  Return
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Convert() As clDataTable
		  //
		  // Create a structure table based on the list of fields
		  // Note: to create a table matching the described structure, use    new clDatatable(<clTableStructure object>)
		  //
		  // The table by the conversion has the following structure:
		  //
		  // - "name" : field name, defined as clDatatable.StructureNameColumn
		  // - "type" : field type, defined as clDatatable.StructureTypeColumn
		  // - 'title": field title, defined as clDatatable.StructureTitleColumn
		  // 
		  // The table is named. "structure of " defined as clDatatable.StructureTableNamePrefix, followed by the value stored in the name property
		  //
		  
		  
		  // TODO: implementation
		  
		  //  self.StructureTableNamePrefix.trim + " " + self.name
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Operator_Convert(source as clDataTable)
		  //
		  // Reset then populate the list of fields from the table passed as paramter
		  //
		  // The table is supposed to contain the following fields:
		  // - "name" : field name, defined as clDatatable.StructureNameColumn
		  // - "type" : field type, defined as clDatatable.StructureTypeColumn
		  // - 'title": field title, defined as clDatatable.StructureTitleColumn
		  //
		  // Such a table is produced, for example, by clDatatable.GetStructureAsTable()
		  //
		  
		  // TODO: implementation
		  
		  
		  
		  // 
		  // var col_name() as string
		  // var col_type() as string
		  // var col_title() as String
		  // 
		  // for i as integer = 0 to columns.LastIndex
		  // col_name.Add(columns(i).name)
		  // col_type.add(columns(i).GetType)
		  // col_title.add(columns(i).DisplayTitle)
		  // 
		  // next
		  // 
		  // var serie_name as new clStringDataSerie(StructureNameColumn, col_name)
		  // var serie_type as new clStringDataSerie(StructureTypeColumn, col_type)
		  // var serie_title as new clStringDataSerie(StructureTitleColumn, col_title)
		  // 
		  // 
		  // var temp as string = NewTableName.trim
		  // 
		  // if temp.Length < 1 then temp = self.StructureTableNamePrefix.trim + " " + self.name
		  // 
		  // return new clDataTable(temp, SerieArray(serie_name, serie_type, serie_title))
		  
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		Fields() As clFieldInfoEntry
	#tag EndProperty

	#tag Property, Flags = &h0
		Name As String
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
