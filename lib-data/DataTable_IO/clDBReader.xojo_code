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
		Sub Constructor(rs as RowSet)
		  self.rs = rs
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function conv_db_type(db_type as integer) As String
		  
		  select  case db_type
		  case 0
		    return "NULL"
		    
		  case 1
		    return "BYTE"
		    
		  case 2
		    return "SMALLINT"
		    
		  case 3
		    return "INT"
		    
		  case 4
		    return  "FIXCHAR"
		    
		  case 5 
		    return "VARCHAR"
		    
		  case 6
		    return "FLOAT"
		    
		  case 7
		    return "DOUBLE"
		    
		  case 8
		    return "SQLDATE"
		    
		  case 9
		    return "SQLTIME"
		    
		  case 10
		    return "TIMESTAMP"
		    
		  case 11
		    return "CURRENCY"
		    
		  case 12
		    return "BOOLEAN"
		    
		  case 13
		    return  "DECIMAL"
		    
		  case 14
		    return "BINARY"
		    
		  case 15
		    return "BLOP"
		    
		  case 16
		    return "OBJECT"
		    
		  case 17
		    return "MACPICT"
		    
		  case 18
		    return "STRING"
		    
		  case 19
		    return "INT64"
		    
		  case else
		    return "UNKNOWN"
		    
		  end Select
		  
		  
		End Function
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
		    
		    tmp.value(tmp_name) = conv_db_type(rs.ColumnAt(i).Type)
		    
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
		Protected line_count As Integer
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected rs As rowset
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
