#tag Class
Protected Class clDataPool
Implements Iterable
	#tag Method, Flags = &h0
		Sub AddErrorMessage(source as string, ErrorMessageTemplate as string, paramarray item as variant)
		  //  
		  //  Add an error message
		  //  
		  //  Parameters
		  //  - source: name of method generating the message
		  //  - error message with placeholders
		  // - list of values for placeholders
		  //  
		  //  Returns:
		  //  
		  
		  self.getLogManager.WriteError(Source, ErrorMessageTemplate, item)
		  
		  self.LastErrorMessage = self.getLogManager.GetProcessedMessage(ErrorMessageTemplate, item)
		  
		  return 
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function CheckIntegrity() As Boolean
		  
		  var Results as boolean = True
		  
		  for each key as string in ItemDictionary.keys
		    var table as clDataTable = clDataTable(self.ItemDictionary.value(key))
		    
		    if not table.CheckIntegrity then results = False
		    
		  next
		  
		  
		  return Results
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  self.ItemDictionary = new Dictionary
		  
		  self.FullNamePrefix = ""
		  
		  self.FullNameSuffix = ""
		  
		  self.verbose = False
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function getLogManager() As clLogManager
		  
		  if self.localLogger = nil then
		    return clLogManager.GetDefaultLogingSupport
		    
		  else
		    return self.localLogger
		    
		  end if
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetTable(table_label as string) As clDataTable
		  
		  return internalGetTable(table_label)
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetTableNames() As string()
		  var tmp() as string
		  
		  for each k as String in ItemDictionary.Keys
		    tmp.Add(k)
		    
		  next
		  
		  return tmp
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function internalGetTable(table_label as string) As clDataTable
		  
		  var c as clDataPoolItem = self.ItemDictionary.Lookup(table_label, nil)
		  
		  if c = nil then return nil
		  
		  return c.table
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub internalSetTable(table as clDataTable, table_label as string, table_source as Datapoolsource)
		  
		  var c as new clDataPoolItem()
		  
		  if table_label.length() > 0 then
		    c.entry_label = table_label
		    
		  else
		    c.entry_label = table.name
		    
		  end if
		  
		  c.source = table_source
		  c.table = table
		  
		  self.ItemDictionary.value(c.entry_label) =  c
		  WriteLog("Saving datatable %0 as %1", table.name, c.entry_label)
		  
		  return
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Iterator() As Iterator
		  // Part of the Iterable interface.
		  
		  return new clDataPoolIterator(self)
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub LoadEachTable(ReadFrom as TableRowReaderInterface, allocator as clDataTable.ColumnAllocator = nil)
		  
		  var tmp() as string = ReadFrom.GetListOfExternalElements
		  
		  for each table as string in tmp
		    //NewTableSource.se
		    ReadFrom.UpdateExternalName(table)
		    
		    var tmp_table as new clDataTable(ReadFrom, allocator)
		    
		    self.internalSetTable(tmp_table, "", DatapoolSource.Loaded)
		    
		  next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub LoadOneTable(ReadFrom as TableRowReaderInterface, allocator as clDataTable.ColumnAllocator = nil)
		  var tmp_table as new clDataTable(ReadFrom, allocator)
		  
		  self.internalSetTable(tmp_table, "", DatapoolSource.Loaded)
		  
		  Return
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SaveEachTable(WriteTo as TableRowWriterInterface, flag_empty_table as boolean = false)
		  
		  
		  
		  for each table_name as String in ItemDictionary.Keys
		    call self.SaveOneTable(table_name, WriteTo, flag_empty_table)
		    
		  next
		  
		  WriteTo.AllDone
		  
		  return
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SaveOneTable(name as string, WriteTo as TableRowWriterInterface, flag_empty_table as boolean = false) As Boolean
		  
		  var table as clDataTable = self.GetTable(name)
		  
		  if table = Nil then
		    WriteLog("Cannot find table %0 in pool keys", name)
		    return False
		    
		  end if
		  
		  if flag_empty_table and table.RowCount < 1 then
		    WriteLog("Table %0 is empty", name)
		    
		  end if
		  
		  var fullname as string = name
		  
		  if self.FullNamePrefix.Length > 0 then
		    fullname = self.FullNamePrefix + fullname
		    
		  end if
		  
		  if self.FullNameSuffix.Length > 0 then
		    fullname = fullname + self.FullNameSuffix
		    
		  end if
		  
		  WriteTo.UpdateExternalName(fullname)
		  
		  table.save(WriteTo)
		  
		  return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SetFullnamePrefix(prefix as string)
		  self.FullNamePrefix = prefix
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SetFullnamePrefixToTimeStamp()
		  
		  self.FullNamePrefix = DateTime.Now.SQLDateTime.replaceall(":","").ReplaceAll("-","").ReplaceAll(" ","_") + "_"
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SetFullnameSuffix(suffix as string)
		  self.FullNameSuffix = suffix
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SetFullnameSuffixToTimeStamp()
		  
		  self.FullNameSuffix = "_" +  DateTime.Now.SQLDateTime.replaceall(":","").ReplaceAll("-","").ReplaceAll(" ","_")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SetLogger(newLogger as clLogManager)
		  
		  self.localLogger = newLogger
		  
		  return
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SetTable(table as clDataTable, table_key as string = "")
		  
		  self.internalSetTable(table, table_key, DatapoolSource.Set)
		  
		  return
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SetTables(table() as clDataTable)
		  for each tbl as clDataTable in table
		    self.SetTable(tbl)
		    
		  next
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SetTables(table_key() as string, table() as clDataTable)
		  for i as integer = 0 to table_key.LastIndex
		    var tbl as clDataTable
		    
		    try
		      tbl = table(i)
		      
		      self.SetTable(tbl, table_key(i))
		      
		    Catch
		      WriteLog("No matching datatable for %0", table_key(i))
		      
		    end try
		    
		  next
		  
		  return
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Table(assigns tbl as clDataTable)
		  self.SetTable(tbl)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Table(table_name as string) As clDataTable
		  return self.GetTable(table_name)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Table(table_name as string, assigns tbl as clDataTable)
		  self.SetTable(tbl, table_name)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function TableCount() As integer
		  return ItemDictionary.KeyCount
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub WriteLog(message as string, paramarray txt as string)
		  if self.verbose then
		    var tmp as string = message
		    
		    for i as integer = 0 to txt.LastIndex
		      tmp = tmp.ReplaceAll("%"+str(i), txt(i))
		    next
		    
		    System.DebugLog(message)
		    
		  end if
		End Sub
	#tag EndMethod


	#tag Note, Name = Description
		A datapool is a collection of datatables.
		
		A method is provided to save all tables in a datapool in a single call.
		This method can also be used to track the evolution of the content of tables by calling SetFullnameSuffixToTimeStamp() to use a common timestamp as sufix or SetFullnamePrefixToTimeStamp() to use a common timestamp as prefix.
		
		Available on: https://github.com/slo1958/sl-xj-lib-data.git
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


	#tag Property, Flags = &h1
		Protected FullNamePrefix As String
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected FullNameSuffix As String
	#tag EndProperty

	#tag Property, Flags = &h0
		ItemDictionary As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private LastErrorMessage As string
	#tag EndProperty

	#tag Property, Flags = &h21
		Private localLogger As clLogManager
	#tag EndProperty

	#tag Property, Flags = &h0
		verbose As Boolean
	#tag EndProperty


	#tag Enum, Name = DatapoolSource, Flags = &h0
		None
		  Loaded
		  Set
		TransformerOutput
	#tag EndEnum


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
