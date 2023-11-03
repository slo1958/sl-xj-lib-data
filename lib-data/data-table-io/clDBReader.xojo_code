#tag Class
Class clDBReader
Implements itf_table_row_reader
	#tag Method, Flags = &h0
		Function column_count() As integer
		  // Part of the itf_table_row_reader interface.
		  
		  if rs = nil then return -1
		  
		  return rs.ColumnCount
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(dbAccess as clAbstractDatabaseAccess, source_name as string)
		  self.dbAccess = dbAccess
		  self.db = dbAccess.get_db
		  
		  
		  if source_name.IndexOf("select of ") <= 0 then 
		    self.source_sql = "select * from " + source_name
		    
		  else
		    self.source_sql = source_name
		    
		  end if
		  
		  self.rs = db.SelectSQL(self.source_sql)
		  
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(rs as RowSet)
		  self.rs = rs
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function current_row_number() As integer
		  // Part of the itf_table_row_reader interface.
		  
		  if rs = nil then return -1
		  
		  return line_count
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function end_of_table() As boolean
		  // Part of the itf_table_row_reader interface.
		  
		  if rs = nil then return True
		  
		  return rs.AfterLastRow
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetColumnNames() As string()
		  // Part of the itf_table_row_reader interface.
		  
		  dim tmp() as string
		  
		  if rs = nil then return tmp
		  
		  for i as integer = 0 to rs.LastColumnIndex
		    tmp.add(rs.ColumnAt(i).Name)
		    
		  next
		  
		  return tmp
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetColumnTypes() As dictionary
		  
		  dim tmp as new Dictionary
		  
		  if rs = nil then return nil
		  
		  for i as integer = 0 to rs.LastColumnIndex
		    dim tmp_name as string = rs.ColumnAt(i).name
		    
		    tmp.value(tmp_name) = clAbstractDatabaseAccess.conv_db_type(rs.ColumnAt(i).Type)
		    
		  next
		  
		  return tmp
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function name() As string
		  // Part of the itf_table_row_reader interface.
		  
		  return ""
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function next_row() As variant()
		  // Part of the itf_table_row_reader interface.
		  
		  dim tmp() as variant
		  
		  if rs = nil then return tmp
		  
		  for i as integer = 0 to  rs.LastColumnIndex
		    tmp.add(rs.ColumnAt(i).value)
		    
		  next
		  
		  rs.MoveToNextRow
		  
		  return tmp
		  
		End Function
	#tag EndMethod


	#tag Property, Flags = &h1
		Protected db As Database
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected dbAccess As clAbstractDatabaseAccess
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected line_count As Integer
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected rs As rowset
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected source_sql As String
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