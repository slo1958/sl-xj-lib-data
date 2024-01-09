#tag Class
Class clDBReader
Implements TableRowReaderInterface
	#tag Method, Flags = &h0
		Function column_count() As integer
		  // Part of the TableRowReaderInterface interface.
		  
		  if rs = nil then return -1
		  
		  return rs.ColumnCount
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(dbAccess as clAbstractDatabaseAccess, record_source as string)
		  self.dbAccess = dbAccess
		  if dbAccess <> nil then self.db = dbAccess.GetDatabase
		  
		  dim select_index as integer = record_source.IndexOf("select ") 
		  if select_index < 0 then 
		    self.source_name = record_source
		    self.source_sql = "select * from " + record_source
		    
		  else
		    self.source_sql = record_source
		    dim from_index as integer = record_source.IndexOf(" from")
		    self.source_name = record_source.Middle(from_index+6,record_source.Length).trim().NthField(" ",1).trim()
		    
		    if self.source_name.Length = 0 then self.source_name = record_source.left(20)
		    
		  end if
		  
		  if self.db <> nil then self.rs = self.db.SelectSQL(self.source_sql)
		  
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(rs as RowSet)
		  self.rs = rs
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function current_row_number() As integer
		  // Part of the TableRowReaderInterface interface.
		  
		  if rs = nil then return -1
		  
		  return line_count
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function end_of_table() As boolean
		  // Part of the TableRowReaderInterface interface.
		  
		  if rs = nil then return True
		  
		  return rs.AfterLastRow
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetColumnNames() As string()
		  // Part of the TableRowReaderInterface interface.
		  
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
		Function GetListOfExternalElements() As string()
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function name() As string
		  // Part of the TableRowReaderInterface interface.
		  
		  return self.source_name
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function next_row() As variant()
		  // Part of the TableRowReaderInterface interface.
		  
		  dim tmp() as variant
		  
		  if rs = nil then return tmp
		  
		  for i as integer = 0 to  rs.LastColumnIndex
		    tmp.add(rs.ColumnAt(i).value)
		    
		  next
		  
		  rs.MoveToNextRow
		  
		  return tmp
		  
		End Function
	#tag EndMethod


	#tag Note, Name = Description
		Used to load data in a clDataTable from a database table or query
		
		Can be used with an existing recordset or by providing an instance of a  database access component.
		
		The database access component is responsible for preparing sql statement using the appropriate sql dialect.
		
		
		
		
		
	#tag EndNote


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
		Protected source_name As string
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
