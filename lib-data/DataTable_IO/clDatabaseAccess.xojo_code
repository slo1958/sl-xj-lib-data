#tag Class
Protected Class clDatabaseAccess
	#tag Method, Flags = &h0
		Sub AppendFields(table_name as string, field_names() as string, field_types() as string)
		  Raise New clDataException("Unimplemented method " + CurrentMethodName)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function convert_type(source_type as string) As String
		  return source_type
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function conv_db_type(db_type as integer) As String
		  
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
		Sub create_table(table_name as string, field_names() as string, field_types() as string)
		  Raise New clDataException("Unimplemented method " + CurrentMethodName)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub DropTable(table_name as string)
		  Raise New clDataException("Unimplemented method " + CurrentMethodName)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function get_db() As Database
		  
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mVerbose As Boolean
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return mVerbose
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  mVerbose = value
			End Set
		#tag EndSetter
		verbose As Boolean
	#tag EndComputedProperty


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
			Name="verbose"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
