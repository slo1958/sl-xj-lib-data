#tag Class
Class clDBReader
Implements TableRowReaderInterface
	#tag Method, Flags = &h0
		Function ColumnCount() As integer
		  // Part of the TableRowReaderInterface interface.
		  
		  if rs = nil then return -1
		  
		  return rs.ColumnCount
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(dbAccess as clAbstractDatabaseAccess, RecordSource as string)
		  self.dbAccess = dbAccess
		  if dbAccess <> nil then self.db = dbAccess.GetDatabase
		  
		  var ret() as string = GetSourceInfo(RecordSource)
		  
		  if ret(1).length > 0 then
		    self.source_name = ret(0)
		    self.source_sql = ret(1)
		    
		    if self.db <> nil then self.rs = self.db.SelectSQL(self.source_sql)
		    
		  elseif self.db <> nil then
		    var rs as RowSet = self.db.Tables
		    for each row As DatabaseRow  in rs
		      Tables.add(row.ColumnAt(0).StringValue)
		    next
		    
		    rs.Close
		    
		  end if
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(rs as RowSet)
		  self.rs = rs
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function CurrentRowIndex() As integer
		  // Part of the TableRowReaderInterface interface.
		  
		  if rs = nil then return -1
		  
		  return LineCount
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function EndOfTable() As boolean
		  // Part of the TableRowReaderInterface interface.
		  
		  if rs = nil then return True
		  
		  return rs.AfterLastRow
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetColumnNames() As string()
		  // Part of the TableRowReaderInterface interface.
		  
		  var tmp() as string
		  
		  if rs = nil then return tmp
		  
		  for i as integer = 0 to rs.LastColumnIndex
		    tmp.add(rs.ColumnAt(i).Name)
		    
		  next
		  
		  return tmp
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetColumnTypes() As dictionary
		  
		  var tmp as new Dictionary
		  
		  if rs = nil then return nil
		  
		  for i as integer = 0 to rs.LastColumnIndex
		    var tmp_name as string = rs.ColumnAt(i).name
		    
		    tmp.value(tmp_name) = clAbstractDatabaseAccess.ConvertXojoDBTypesToCommonTypes(rs.ColumnAt(i).Type)
		    
		  next
		  
		  return tmp
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetDBColumnTypes() As dictionary
		  
		  var tmp as new Dictionary
		  
		  if rs = nil then return nil
		  
		  for i as integer = 0 to rs.LastColumnIndex
		    var tmp_name as string = rs.ColumnAt(i).name
		    
		    tmp.value(tmp_name) = clAbstractDatabaseAccess.ConvertXojoDBTypesToDBTypes(rs.ColumnAt(i).Type)
		    
		  next
		  
		  return tmp
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetListOfExternalElements() As string()
		  var ret() as string
		  
		  for each s as string in Tables
		    ret.Add(s)
		    
		  next
		  
		  return ret
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetSourceInfo(RecordSource as string) As string()
		  
		  var select_index as integer = RecordSource.IndexOf("select ") 
		  var tempSourceSQL as string
		  var tempName as string
		  
		  if RecordSource.trim.Length = 0 then return array ("","")
		  
		  
		  if select_index < 0 then 
		    tempName = RecordSource
		    tempSourceSQL = "select * from " + RecordSource
		    
		  else
		    tempSourceSQL = RecordSource
		    var from_index as integer = RecordSource.IndexOf(" from")
		    tempName = RecordSource.Middle(from_index+6,RecordSource.Length).trim().NthField(" ",1).trim()
		    
		    if tempName.Length = 0 then tempName = RecordSource.left(20)
		    
		  end if
		  
		  return array(tempName, tempSourceSQL)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Name() As string
		  // Part of the TableRowReaderInterface interface.
		  
		  return self.source_name
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function NextRow() As clDataRow
		  // Part of the TableRowReaderInterface interface.
		  
		  Raise New clDataException("Unimplemented method " + CurrentMethodName)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function NextRowAsVariant() As variant()
		  // Part of the TableRowReaderInterface interface.
		  
		  var tmp() as variant
		  
		  if rs = nil then return tmp
		  
		  for i as integer = 0 to  rs.LastColumnIndex
		    tmp.add(rs.ColumnAt(i).value)
		    
		  next
		  
		  rs.MoveToNextRow
		  
		  return tmp
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub UpdateExternalName(new_name as string)
		  
		  var ret() as string = GetSourceInfo(new_name)
		  
		  self.source_name = ret(0)
		  self.source_sql = ret(1)
		  
		  if self.db <> nil then self.rs = self.db.SelectSQL(self.source_sql)
		  
		  return
		End Sub
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
		Protected LineCount As Integer
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

	#tag Property, Flags = &h1
		Protected Tables() As String
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
