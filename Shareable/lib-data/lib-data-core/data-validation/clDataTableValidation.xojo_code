#tag Class
Protected Class clDataTableValidation
Implements TableColumnReaderInterface
	#tag Method, Flags = &h0
		Sub AddMessage(field_name as string, row_index as integer, message as string)
		  var r as new Dictionary
		  
		  r.value(field_name_output_column)=  field_name
		  r.value(row_index_output_column) =  row_index
		  r.Value(message_output_column) =  message
		  
		  if OutputTable <> nil then
		    self.OutputTable.AddRow(r)
		    
		  end if
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ColumnCount() As integer
		  // Part of the TableColumnReaderInterface interface.
		  
		  return 4
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ColumnNameAt(column_index as integer) As string
		  var tmp() as string = self.GetColumnNames()
		  
		  return tmp(column_index)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(validation_name as string, columns() as clDataSerieValidation, allow_extra_columns as boolean = False)
		  
		  ColumnsValidation.RemoveAll
		  
		  if validation_name.trim.len = 0 then
		    TableName = "Noname"
		    
		  else
		    TableName = validation_name.trim
		    
		  end if
		  
		  
		  for each column as clDataSerieValidation in columns
		    ColumnsValidation.Add(column)
		    
		  next
		  
		  self.opt_allow_extra_columns = allow_extra_columns
		  
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetAllColumns() As clAbstractDataSerie()
		  // Part of the TableColumnReaderInterface interface.
		  
		  var cols() as clAbstractDataSerie
		  
		  var col_name as new clDataSerie( field_name_input_column )
		  var col_input as new clDataSerie( field_nullable_input_column )
		  var col_mandatory as new clDataSerie(field_mandatory_input_column )
		  var col_type as new clDataSerie(field_type_input_column)
		  
		  
		  for each column as clDataSerieValidation in ColumnsValidation
		    col_name.AddElement(column.name)
		    col_input.AddElement(column.is_nullable)
		    col_mandatory.AddElement(column.is_required)
		    col_type.AddElement("generic")
		    
		  next
		  
		  Return cols
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetColumn(pColumnName as String, IncludeAlias as boolean = False) As clAbstractDataSerie
		  // Part of the TableColumnReaderInterface interface.
		  
		  var output as new clDataSerie(pColumnName)
		  
		  for each column as clDataSerieValidation in ColumnsValidation
		    
		    select case pColumnName
		    case  field_name_input_column 
		      output.AddElement(column.name)
		      
		    case field_nullable_input_column 
		      output.AddElement(column.is_nullable)
		      
		    case  field_mandatory_input_column 
		      output.AddElement(column.is_required)
		      
		    case field_type_input_column
		      output.AddElement("generic")
		      
		    case else
		      
		    end Select
		    
		  next
		  
		  return output
		  
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetColumnAt(column_index as integer) As clAbstractDataSerie
		  
		  var output as clDataSerie
		  
		  try
		    output = new clDataSerie(self.ColumnNameAt(column_index))
		    
		  catch
		    return nil
		    
		  end try
		  
		  
		  for each column as clDataSerieValidation in ColumnsValidation
		    
		    select case column_index
		    case  0 
		      output.AddElement(column.name)
		      
		    case 1 
		      output.AddElement(column.is_nullable)
		      
		    case  2 
		      output.AddElement(column.is_required)
		      
		    case 3
		      output.AddElement("generic")
		      
		    case else
		      
		    end Select
		    
		  next
		  
		  return output
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetColumnNames() As string()
		  // Part of the TableColumnReaderInterface interface
		  
		  var tmp() as string
		  
		  tmp.Add(field_name_input_column)
		  tmp.Add(field_type_input_column)
		  tmp.Add(field_nullable_input_column)
		  tmp.Add(field_mandatory_input_column)
		  
		  return tmp
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetResults() As clDataTable
		  Return OutputTable
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsPersistant() As boolean
		  // Part of the TableColumnReaderInterface interface.
		  
		  return False
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Name() As String
		  return TableName
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function RowCount() As integer
		  // Part of the TableColumnReaderInterface interface.
		  
		  return ColumnsValidation.LastIndex+1
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Validate(table as clDataTable)
		  
		  self.OutputTable = new clDataTable("error_report", array(field_name_output_column ,  row_index_output_column, message_output_column))
		  
		  var tmpColumnsToProcess() as string = table.GetColumnNames
		  
		  for each column as clDataSerieValidation in ColumnsValidation
		    
		    if  table.GetColumnNames.IndexOf(column.name) >= 0 then
		      var tmp() as clAbstractDataSerie = column.validate(table.GetColumn(column.name))
		      
		      tmp(0).rename(row_index_output_column)
		      tmp(1).rename(message_output_column )
		      
		      var tmp_table as new clDataTable("temp", tmp)
		      call tmp_table.AddColumn(field_name_output_column, column.name)
		      
		      self.OutputTable.AddColumnsData(tmp_table)
		      
		      tmpColumnsToProcess.RemoveAt(tmpColumnsToProcess.IndexOf(column.name))
		      
		    elseif column.is_required Then
		      AddMessage(column.name, -1, "missing mandatory column ")
		      
		    else
		      
		      
		    end if
		    
		    
		  next
		  
		  if not opt_allow_extra_columns and tmpColumnsToProcess.Count >0 then
		    for each column as string in tmpColumnsToProcess
		      AddMessage(column, -1, "unexpected extra column")
		      
		    next
		    
		  end if
		  
		  return 
		  
		  
		End Sub
	#tag EndMethod


	#tag Note, Name = Description
		Validates a data table
		
		Applies defined data serie validator, clDataSerieValidation or its child class, to each column.
		Link between columns in DataTable and columns in validation are made by column name.
		
		Columns defined in validation but not found in datatable generate an error if the column is marked as mandatory.
		
		Columns defined in the DataTable but not defined in the validation are reported as error unless the flag 'allow_extra_columns' is True
		
		Column order is not tested
		
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
		Protected ColumnsValidation() As clDataSerieValidation
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected opt_allow_extra_columns As Boolean = False
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected OutputTable As clDataTable
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected TableName As String
	#tag EndProperty


	#tag Constant, Name = field_mandatory_input_column, Type = String, Dynamic = False, Default = \"is_mandatory", Scope = Public
	#tag EndConstant

	#tag Constant, Name = field_name_input_column, Type = String, Dynamic = False, Default = \"field_name", Scope = Public
	#tag EndConstant

	#tag Constant, Name = field_name_output_column, Type = String, Dynamic = False, Default = \"field_name", Scope = Public
	#tag EndConstant

	#tag Constant, Name = field_nullable_input_column, Type = String, Dynamic = False, Default = \"is_nullable", Scope = Public
	#tag EndConstant

	#tag Constant, Name = field_type_input_column, Type = String, Dynamic = False, Default = \"field_type", Scope = Public
	#tag EndConstant

	#tag Constant, Name = message_output_column, Type = String, Dynamic = False, Default = \"error_message", Scope = Public
	#tag EndConstant

	#tag Constant, Name = row_index_output_column, Type = String, Dynamic = False, Default = \"row_index", Scope = Public
	#tag EndConstant


	#tag ViewBehavior
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
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
			Name="Name"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
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
