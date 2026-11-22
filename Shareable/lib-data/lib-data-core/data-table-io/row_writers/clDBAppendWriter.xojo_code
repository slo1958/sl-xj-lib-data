#tag Class
Class clDBAppendWriter
Inherits clDBWriter
	#tag CompatibilityFlags = ( TargetConsole and ( Target32Bit or Target64Bit ) ) or ( TargetWeb and ( Target32Bit or Target64Bit ) ) or ( TargetDesktop and ( Target32Bit or Target64Bit ) ) or ( TargetIOS and ( Target64Bit ) ) or ( TargetAndroid and ( Target64Bit ) )
	#tag Method, Flags = &h0
		Sub DefineColumns(name as string, columns() as string, column_type() as string)
		  // Part of the TableRowWriterInterface interface.
		  
		  self.table_name = name
		  
		  self.columns.RemoveAll
		  
		  var table_found as Boolean
		  
		  var tmp_missing_columns() as string
		  var tmp_missing_types() as String
		  
		  for index as integer = 0 to columns.LastIndex
		    
		    tmp_missing_columns.Add(columns(index))
		    self.columns.Add columns(index)
		    
		    tmp_missing_types.add column_type(index)
		    
		  next
		  
		  table_found = False
		  
		  var rs as RowSet 
		  
		  rs = db.Tables()
		  while not ( rs.AfterLastRow or table_found)
		    table_found = rs.Column("TableName").StringValue = self.table_name
		    
		    rs.MoveToNextRow
		  wend
		  
		  
		  
		  try
		    rs = db.TableColumns(name)
		    
		    while not rs.AfterLastRow
		      var tmp_field as string = rs.Column("ColumnName").StringValue
		      var idx as integer = tmp_missing_columns.IndexOf(tmp_field)
		      
		      if idx >= 0 then 
		        tmp_missing_columns.RemoveAt(idx)
		        tmp_missing_types.RemoveAt(idx)
		        
		      end if
		      
		      rs.MoveToNextRow
		    wend 
		    
		  Catch DatabaseException
		    table_found = False
		    
		  end try
		  
		  
		  if table_found then
		    
		    if tmp_missing_columns.Count > 0 then 
		      self.dbAccess.AppendFields(self.table_name, tmp_missing_columns, tmp_missing_types)
		      
		    end if
		    
		    return
		    
		  else
		    self.dbAccess.CreateTable(self.table_name, self.columns, column_type)
		    
		  end if
		  
		  
		  
		  
		  
		  
		  
		  
		End Sub
	#tag EndMethod


	#tag Note, Name = Description
		
		Used to download data from a clDataTable to a database table, the data in the target table is retained before transfering the rows.
		
		Add missing columns to the target table.
		
		Uses an instance of a  database access component.
		
		The database access component is responsible for preparing sql statement using the appropriate sql dialect.
		
		
		
	#tag EndNote


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
