#tag Class
Class clSqliteDBAccess
Inherits clAbstractDatabaseAccess
	#tag CompatibilityFlags = ( TargetConsole and ( Target32Bit or Target64Bit ) ) or ( TargetWeb and ( Target32Bit or Target64Bit ) ) or ( TargetDesktop and ( Target32Bit or Target64Bit ) ) or ( TargetIOS and ( Target64Bit ) ) or ( TargetAndroid and ( Target64Bit ) )
	#tag Method, Flags = &h0
		Sub AppendFields(table_name as string, field_names() as string, field_types() as string)
		  
		  var tmp_sql as string
		  
		  for i as integer = 0 to field_names.LastIndex
		    tmp_sql = "ALTER TABLE " + table_name + " add " + field_names(i) + " " + self.GetSQLType(field_types(i))
		    
		    self.ExecuteSQL(tmp_sql)
		    
		  next
		  
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(db as SQLiteDatabase)
		  self.db = db
		  self.verbose = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub CreateTable(table_name as string, field_names() as string, field_types() as string)
		  var tmp_fields() as string
		  var tmp_sql as string
		  
		  for i as integer = 0 to field_names.LastIndex
		    tmp_fields.Add field_names(i) + " " + self.GetSQLType(field_types(i))
		    
		  next
		  
		  tmp_sql = "CREATE TABLE " + table_name +"(" + String.FromArray(tmp_fields, ",") + ")"
		  
		  self.ExecuteSQL(tmp_sql)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub DropTable(table_name as string)
		  var tmp_sql as string
		  
		  tmp_sql =  "DROP TABLE IF EXISTS " + table_name 
		  
		  self.ExecuteSQL(tmp_sql)
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ExecuteSql(sql as string)
		  if verbose then System.DebugLog("SQL:" + sql)
		  
		  db.ExecuteSQL sql
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetDatabase() As Database
		  return db
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetSQLType(source_type as string) As String
		  
		  
		  select case source_type
		  case clDataType.BooleanValue
		    return "BOOLEAN"
		    
		  case clDataType.IntegerValue
		    return "INTEGER"
		    
		  case clDataType.NumberValue
		    return "DOUBLE"
		    
		  case clDataType.StringValue
		    return "TEXT"
		    
		  case else
		    return "TEXT"
		    
		  end Select
		  
		  
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0
		db As SQLiteDatabase
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="verbose"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
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
			Name="db"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="SQLiteDatabase"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
