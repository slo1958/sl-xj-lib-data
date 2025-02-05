#tag Class
Protected Class clAbstractDatabaseAccess
	#tag Method, Flags = &h0
		Sub AppendFields(table_name as string, field_names() as string, field_types() as string)
		  //
		  // Add fields to a table
		  //
		  //  
		  //  Parameters:
		  //  - name of the target table
		  //  - list of fields
		  //. - type of each field
		  //  
		  //  Returns:
		  //   (nothing)
		  //  
		  
		  Raise New clDataException("Unimplemented method " + CurrentMethodName)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function ConvertCommonTypesToXojoDBTypes(CommonType as string) As integer
		  select case CommonType
		    
		  case clDataType.BooleanValue
		    return 12 // Boolean
		    
		  case clDataType.DateTimeValue
		    return 10 // Time stamp
		    
		  case clDataType.DateValue
		    return 8 // Date
		    
		  case clDataType.IntegerValue 
		    return 3 // Integer
		    
		  case clDataType.NumberValue
		    return 7 // Double
		    
		  case clDataType.StringValue
		    return 5 // Varchar
		    
		  case else
		    return 255 // Unrecognized
		    
		  end select
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function ConvertXojoDBTypesToCommonTypes(db_type as integer) As String
		  
		  select  case db_type
		  case 0
		    return clDataType.UndefinedType // DBType_Null
		    
		  case 1
		    return clDataType.IntegerValue // DBType_Byte
		    
		  case 2
		    return clDataType.IntegerValue // DBType_SmallInt
		    
		  case 3
		    return clDataType.IntegerValue // DBType_Integer
		    
		  case 4
		    return  clDataType.StringValue // DBType_FixChar
		    
		  case 5 
		    return clDataType.StringValue // DBType_VarChar
		    
		  case 6 
		    return clDataType.NumberValue // DBType_Float
		    
		  case 7
		    return clDataType.NumberValue // DBType_Double
		    
		  case 8
		    return clDataType.DateValue // DBType_SQLDate
		    
		  case 9
		    return  clDataType.DateTimeValue // DBType_SQLTime
		    
		  case 10
		    return clDataType.DateTimeValue // DBType_TimeStamp
		    
		  case 11
		    return clDataType.NumberValue // DBType_Currency
		    
		  case 12
		    return clDataType.BooleanValue // DBType_Boolean
		    
		  case 13
		    return  clDataType.NumberValue // DBType_Decimal
		    
		  case 14
		    return clDataType.BooleanValue // DBType_Binary
		    
		  case 15
		    return clDataType.UndefinedType  // "BLOP"
		    
		  case 16
		    return clDataType.UndefinedType // "OBJECT"
		    
		  case 17
		    return clDataType.UndefinedType // "MACPICT"
		    
		  case 18
		    return clDataType.StringValue // DBType_String
		    
		  case 19
		    return clDataType.IntegerValue // DBType_Int64
		    
		  case else
		    return DBType_Unknown
		    
		  end Select
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function ConvertXojoDBTypesToDBTypes(db_type as integer) As String
		  
		  select  case db_type
		  case 0
		    return DBType_Null
		    
		  case 1
		    return DBType_Byte
		    
		  case 2
		    return DBType_SmallInt
		    
		  case 3
		    return DBType_Integer
		    
		  case 4
		    return  DBType_FixChar
		    
		  case 5 
		    return DBType_VarChar
		    
		  case 6
		    return DBType_Float
		    
		  case 7
		    return DBType_Double
		    
		  case 8
		    return DBType_SQLDate
		    
		  case 9
		    return DBType_SQLTime
		    
		  case 10
		    return DBType_TimeStamp
		    
		  case 11
		    return DBType_Currency
		    
		  case 12
		    return DBType_Boolean
		    
		  case 13
		    return  DBType_Decimal
		    
		  case 14
		    return DBType_Binary
		    
		  case 15
		    return DBType_Unsupported // "BLOP"
		    
		  case 16
		    return DBType_Unsupported // "OBJECT"
		    
		  case 17
		    return DBType_Unsupported // "MACPICT"
		    
		  case 18
		    return DBType_String
		    
		  case 19
		    return DBType_Int64
		    
		  case else
		    return DBType_Unknown
		    
		  end Select
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub CreateTable(table_name as string, field_names() as string, field_types() as string)
		  //
		  // Creates a new table
		  //
		  //  
		  //  Parameters:
		  //  - name of the new table
		  //  - list of fields
		  //. - type of each field
		  //  
		  //  Returns:
		  //   (nothing)
		  //  
		  
		  Raise New clDataException("Unimplemented method " + CurrentMethodName)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub DropTable(table_name as string)
		  //
		  // Drop a table
		  //
		  //  
		  //  Parameters:
		  //  - name of the  table
		  //  
		  //  Returns:
		  //   (nothing)
		  //  
		  Raise New clDataException("Unimplemented method " + CurrentMethodName)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetDatabase() As Database
		  //
		  //  Get the db object
		  //
		  //  
		  //  Parameters:
		  //  - (none)
		  //  
		  //  Returns:
		  //   (nothing)
		  //  
		  
		  Raise New clDataException("Unimplemented method " + CurrentMethodName)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetSQLType(source_type as string) As String
		  //
		  // Convert a source type to SQL type of the current db engine
		  //
		  //  
		  //  Parameters:
		  //  - type to be mapped
		  //  
		  //  Returns:
		  //  - corresponding sql type
		  //  
		  
		  return source_type
		  
		  
		End Function
	#tag EndMethod


	#tag Note, Name = Description
		Defines an abstract database access class, provides common functions but it has no storage
		Used as base class for all database access classes
		
		The purpose of database access class is mainly to isolate the db readers and the db writers from db specific issues.
		For example, 
		
		The following child classes are defined:
		
		- clSqliteDBAccess: provides access to a sqlite db
		
		
		
		
	#tag EndNote

	#tag Note, Name = License
		MIT License
		
		sl-xj-lib-data Data Handling Library
		Copyright (c) 2021-2025 slo1958
		
		Permission is hereby granted, free of charge, to any person obtaining a copy
		of this software and associated documentation files (the "Software"), to deal
		in the Software without restriction, including without limitation the rights
		to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
		copies of the Software, and to permit persons to whom the Software is
		furnished to do so, subject to the following conditions:
		
		The above copyright notice and this permission notice shall be included in all
		copies or substantial portions of the Software.
		
		THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
		IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
		FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
		AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
		LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
		OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
		SOFTWARE.
		
		
	#tag EndNote


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


	#tag Constant, Name = DBType_Binary, Type = String, Dynamic = False, Default = \"BINARY", Scope = Public
	#tag EndConstant

	#tag Constant, Name = DBType_Boolean, Type = String, Dynamic = False, Default = \"BOOLEAN", Scope = Public
	#tag EndConstant

	#tag Constant, Name = DBType_Byte, Type = String, Dynamic = False, Default = \"BYTE", Scope = Public
	#tag EndConstant

	#tag Constant, Name = DBType_Currency, Type = String, Dynamic = False, Default = \"CURRENCY", Scope = Public
	#tag EndConstant

	#tag Constant, Name = DBType_Decimal, Type = String, Dynamic = False, Default = \"DECIMAL", Scope = Public
	#tag EndConstant

	#tag Constant, Name = DBType_Double, Type = String, Dynamic = False, Default = \"DOUBLE", Scope = Public
	#tag EndConstant

	#tag Constant, Name = DBType_FixChar, Type = String, Dynamic = False, Default = \" FIXCHAR", Scope = Public
	#tag EndConstant

	#tag Constant, Name = DBType_Float, Type = String, Dynamic = False, Default = \"FLOAT", Scope = Public
	#tag EndConstant

	#tag Constant, Name = DBType_Int64, Type = String, Dynamic = False, Default = \"INT64", Scope = Public
	#tag EndConstant

	#tag Constant, Name = DBType_Integer, Type = String, Dynamic = False, Default = \"INT", Scope = Public
	#tag EndConstant

	#tag Constant, Name = DBType_Null, Type = String, Dynamic = False, Default = \"NULL", Scope = Public
	#tag EndConstant

	#tag Constant, Name = DBType_SmallInt, Type = String, Dynamic = False, Default = \"SMALLINT", Scope = Public
	#tag EndConstant

	#tag Constant, Name = DBType_SQLDate, Type = String, Dynamic = False, Default = \"SQLDATE", Scope = Public
	#tag EndConstant

	#tag Constant, Name = DBType_SQLTime, Type = String, Dynamic = False, Default = \"SQLTIME", Scope = Public
	#tag EndConstant

	#tag Constant, Name = DBType_String, Type = String, Dynamic = False, Default = \"STRING", Scope = Public
	#tag EndConstant

	#tag Constant, Name = DBType_TimeStamp, Type = String, Dynamic = False, Default = \"TIMESTAMP", Scope = Public
	#tag EndConstant

	#tag Constant, Name = DBType_Unknown, Type = String, Dynamic = False, Default = \"UNKNOWN", Scope = Public
	#tag EndConstant

	#tag Constant, Name = DBType_Unsupported, Type = String, Dynamic = False, Default = \"UNSUPPORTED", Scope = Public
	#tag EndConstant

	#tag Constant, Name = DBType_VarChar, Type = String, Dynamic = False, Default = \"VARCHAR", Scope = Public
	#tag EndConstant


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
