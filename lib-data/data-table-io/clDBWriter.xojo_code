#tag Class
Class clDBWriter
Implements TableRowWriterInterface
	#tag Method, Flags = &h0
		Sub add_row(row_data() as variant)
		  // Part of the TableRowWriterInterface interface.
		  
		  dim dbrow as new DatabaseRow
		  
		  for i as integer = 0 to self.columns.LastIndex
		    
		    dbrow.Column(self.columns(i)) = row_data(i)
		    
		  next
		  
		  db.AddRow(self.table_name , dbrow)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub alter_external_name(new_name as string)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(dbAccess as clAbstractDatabaseAccess)
		  self.table_created = False
		  self.dbAccess = dbAccess
		  self.db = dbAccess.GetDatabase
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub define_meta_data(name as string, columns() as string)
		  // Part of the TableRowWriterInterface interface.
		  
		  dim tmp_type() as string
		  
		  for i as integer = 0 to columns.LastIndex
		    tmp_type.add("string")
		    
		  next
		  
		  define_meta_data(name, columns, tmp_type)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub define_meta_data(name as string, columns() as string, column_type() as string)
		  // Part of the TableRowWriterInterface interface.
		  
		  self.table_name = name
		  
		  self.columns.RemoveAll
		  
		  self.dbAccess.DropTable(self.table_name)
		  
		  for i as integer = 0 to columns.LastIndex
		    self.columns.Add columns(i)
		    
		  next
		  
		  self.dbAccess.CreateTable(self.table_name, self.columns, column_type)
		  
		  
		  
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub done()
		  // Part of the TableRowWriterInterface interface.
		  
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h1
		Protected columns() As String
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected db As Database
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected dbAccess As clAbstractDatabaseAccess
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected table_created As Boolean
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected table_name As String
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
