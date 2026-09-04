#tag Class
Protected Class clTableStructure
	#tag Method, Flags = &h0
		Sub AddFieldInfo(v as clFieldInfoEntry)
		  
		  self.Fields.Add(v)
		  
		  Return
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(sourceTable as clDataTable, processing as Mode)
		  
		  
		  select case processing
		    
		  case mode.Copy
		    self.loadStructureFromTable(sourceTable)
		    
		  case mode.ExtractStructure
		    self.extractStructureFromTable(sourceTable)
		    
		  case else
		    
		    
		  end Select
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(tablename as string)
		  
		  self.Name = tablename
		  
		  Return
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function CreateTable(newTableName as String) As clDataTable
		  
		  var res as  new clDataTable(newTableName, self)
		  
		  res.AddSourceToMetadata(ReplacePlaceHolders("Created from [%0]" , self.name)) 
		  
		  Return res
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub extractStructureFromTable(structureSource as clDataTable)
		  //
		  // Reset then populate the list of fields from the structure of the table passed as paramter
		  //
		  // 
		  // Parameters
		  // - structureSource:  name of the table of which the structure should be extracted
		  //
		  // Returns
		  // (nothing)
		  //
		  
		  self.Name = structureSource.Name
		  
		  self.fields.RemoveAll
		  
		  for i as integer = 0 to structureSource.ColumnCount-1
		    var colref as clAbstractDataSerie = structureSource.GetColumnAt(i)
		    
		    var colinfo as new clFieldInfoEntry()
		    colinfo.Name = colref.name
		    colinfo.Type = colref.GetType()
		    colinfo.Title = colref.DisplayTitle
		    
		    self.AddFieldInfo(colinfo)
		    
		  next
		  
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub loadStructureFromTable(structureSource as clDataTable)
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
		  
		  self.Name = "unnamed"
		  
		  self.fields.RemoveAll
		  
		  for each row as clDataRow in structureSource
		    
		    var colinfo as new clFieldInfoEntry()
		    colinfo.Name = row.GetCell(StructureNameColumn)
		    colinfo.Type = row.GetCell(StructureTypeColumn)
		    colinfo.Title = row.GetCell( StructureTitleColumn)
		    
		    self.AddFieldInfo(colinfo)
		    
		  next
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Convert() As clDataTable
		  //
		  // Create a structure table based on the list of fields
		  // Note: to create a table matching the described structure, use    new clDatatable(<clTableStructure object>)
		  //
		  // The table produced by the conversion has the following structure:
		  //
		  // - "name" : field name, defined as clDatatable.StructureNameColumn
		  // - "type" : field type, defined as clDatatable.StructureTypeColumn
		  // - 'title": field title, defined as clDatatable.StructureTitleColumn
		  // 
		  // The table is named. "structure of " defined as clDatatable.StructureTableNamePrefix, followed by the value stored in the name property
		  //
		  
		  var col_name() as string
		  var col_type() as string
		  var col_title() as String
		  
		  for each field as clFieldInfoEntry in self.fields
		    col_name.Add(field.name)
		    col_type.add(field.Type)
		    col_title.add(Field.Title)
		    
		  next
		  
		  var serie_name as new clStringDataSerie(StructureNameColumn, col_name)
		  var serie_type as new clStringDataSerie(StructureTypeColumn, col_type)
		  var serie_title as new clStringDataSerie(StructureTitleColumn, col_title)
		  
		  var res as   new clDataTable(StructureTableNamePrefix + self.name, SerieArray(serie_name, serie_type, serie_title))
		  res.AddSourceToMetadata(ReplacePlaceHolders("Created from [%0]" , self.name)) 
		  
		  Return res
		  
		  
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
		  
		  self.loadStructureFromTable(source)
		  
		  Return
		  
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		Fields() As clFieldInfoEntry
	#tag EndProperty

	#tag Property, Flags = &h0
		Name As String
	#tag EndProperty


	#tag Constant, Name = StructureNameColumn, Type = String, Dynamic = False, Default = \"name", Scope = Public
	#tag EndConstant

	#tag Constant, Name = StructureTableNamePrefix, Type = String, Dynamic = False, Default = \"structure of ", Scope = Public
	#tag EndConstant

	#tag Constant, Name = StructureTitleColumn, Type = String, Dynamic = False, Default = \"title", Scope = Public
	#tag EndConstant

	#tag Constant, Name = StructureTypeColumn, Type = String, Dynamic = False, Default = \"type", Scope = Public
	#tag EndConstant


	#tag Enum, Name = Mode, Type = Integer, Flags = &h0
		ExtractStructure
		Copy
	#tag EndEnum


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
