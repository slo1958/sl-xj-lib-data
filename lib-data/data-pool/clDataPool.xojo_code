#tag Class
Protected Class clDataPool
Implements Iterable
	#tag Method, Flags = &h0
		Sub Constructor()
		  self.datatable_dict = new Dictionary
		  
		  self.filename_prefix = ""
		  
		  self.filename_suffix = ""
		  
		  self.verbose = False
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function get_table(table_name as string) As clDataTable
		  return self.datatable_dict.Lookup(table_name, Nil)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Iterator() As Iterator
		  // Part of the Iterable interface.
		  
		  return new clDataPoolIterator(self)
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function load_datatable(name as string, file_path as string) As Boolean
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub save_all(folder_path as string)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function save_datatable(name as string, folder_path as string, flag_empty_datatable as boolean = false) As Boolean
		  
		  
		  dim table as clDataTable = self.get_table(name)
		  
		  if table = Nil then
		    writelog("Cannot find table %0", name)
		    return False
		    
		  end if
		  
		  if flag_empty_datatable and table.row_count < 1 then
		    writelog("Table %0 is empty", name)
		    
		  end if
		  
		  dim filename as string = name
		  
		  if self.filename_prefix.Length > 0 then
		    filename = self.filename_prefix + filename
		    
		  end if
		  
		  if self.filename_suffix.Length > 0 then
		    filename = filename + self.filename_suffix
		    
		  end if
		  
		  //  write datatable as text file
		  
		  writelog("Saving %0 as file %1 in folder %2", name, filename, folder_path)
		  
		  return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub set_filename_prefix(prefix as string)
		  self.filename_prefix = prefix
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub set_filename_suffix(suffix as string)
		  self.filename_suffix = suffix
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub set_multiple_tables(table() as clDataTable)
		  for each tbl as clDataTable in table
		    self.set_table(tbl)
		    
		  next
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub set_multiple_tables_with_key(table_key() as string, table() as clDataTable)
		  for i as integer = 0 to table_key.Ubound
		    dim tbl as clDataTable
		    
		    try
		      tbl = table(i)
		      
		      self.set_table(tbl, table_key(i))
		      
		    Catch
		      writelog("No matching datatable for %0", table_key(i))
		      
		    end try
		    
		  next
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub set_table(table as clDataTable, table_key as string = "")
		  
		  
		  if table_key.length() > 0 then
		    self.datatable_dict.value(table_key) =  table
		    writelog("Saving datatable %0 as %1", table.name, table_key)
		    
		  else
		    self.datatable_dict.value(table.name) =  table
		    writelog("Saving datatable %0 as %1", table.name, table.name)
		    
		  end if
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function tabke_names() As string()
		  dim tmp() as string
		  
		  for each k as String in datatable_dict.Keys
		    tmp.Append(k)
		    
		  next
		  
		  return tmp
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub table(assigns tbl as clDataTable)
		  self.set_table(tbl)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function table(table_name as string) As clDataTable
		  return self.get_table(table_name)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub table(table_name as string, assigns tbl as clDataTable)
		  self.set_table(tbl, table_name)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function table_count() As integer
		  return datatable_dict.KeyCount
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub writelog(message as string, paramarray txt as string)
		  if self.verbose then
		    dim tmp as string = message
		    
		    for i as integer = 0 to txt.ubound
		      tmp = tmp.ReplaceAll("%"+str(i), txt(i))
		    next
		    
		    System.DebugLog(message)
		    
		  end if
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		datatable_dict As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected filename_prefix As String
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected filename_suffix As String
	#tag EndProperty

	#tag Property, Flags = &h0
		verbose As Boolean
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
