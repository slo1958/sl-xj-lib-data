#tag Class
Class clDBWriter
Implements itf_table_row_writer
	#tag Method, Flags = &h0
		Sub add_row(row_data() as variant)
		  // Part of the itf_table_row_writer interface.
		  
		  dim dbrow as new DatabaseRow
		  
		  for i as integer = 0 to self.columns.LastIndex
		    
		    dbrow.Column(self.columns(i)) = row_data(i)
		    
		  next
		  
		  db.AddRow(self.table_name , dbrow)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(db as Database)
		  self.table_created = False
		  self.db = db
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub define_meta_data(name as string, columns() as string)
		  // Part of the itf_table_row_writer interface.
		  
		  dim tmp_type() as string
		  
		  for i as integer = 0 to columns.LastIndex
		    tmp_type.add("Text")
		    
		  next
		  
		  define_meta_data(name, columns, tmp_type)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub define_meta_data(name as string, columns() as string, column_type() as string)
		  // Part of the itf_table_row_writer interface.
		  
		  self.table_name = name
		  
		  dim tmp_sql as string
		  
		  self.columns.RemoveAll
		  
		  tmp_sql =  "DROP TABLE IF EXISTS " + self.table_name 
		  
		  db.ExecuteSQL(tmp_sql)
		  
		  dim tmp_fields() as string
		  
		  for i as integer = 0 to columns.LastIndex
		    self.columns.Add columns(i)
		    tmp_fields.Add columns(i) + " " + column_type(i)
		    
		  next
		  
		  tmp_sql = "CREATE TABLE " + self.table_name +"(" + String.FromArray(tmp_fields, ",") + ")"
		  
		  db.ExecuteSQL(tmp_sql)
		  
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub done()
		  // Part of the itf_table_row_writer interface.
		  
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h1
		Protected columns() As String
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected db As Database
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
		#tag ViewProperty
			Name="table_created"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
