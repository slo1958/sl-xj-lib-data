#tag Module
Protected Module clDataTable_tests_helper
	#tag Method, Flags = &h0
		Function alloc_obj_for_test_calc_026(name as string) As object
		  select case name
		  case "test_class_01"
		    return new test_class_01
		    
		  case "test_class_02"
		    return new test_class_02
		    
		  case "test_class_03"
		    return new test_class_03
		    
		  case else
		    return nil
		    
		  end select
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function alloc_series_for_test_calc_020(column_name as string, column_type_info as string) As clAbstractDataSerie
		  if column_name = "Sales" then
		    Return new clNumberDataSerie(column_name)
		    
		  else
		    return nil
		  end if
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function alloc_series_for_test_io_001(column_name as string, column_type_info as string) As clAbstractDataSerie
		  if column_name = "Alpha" then
		    Return new clCompressedDataSerie(column_name)
		    
		  else
		    return new clDataSerie(column_name)
		    
		  end if
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function filter_for_test_calc_008(pRowIndex as integer, pRowCount as integer, pColumnNames() as string, pCellValues() as variant, paramarray pFunctionParameters as variant) As Boolean
		  var idx as integer = pColumnNames.IndexOf("cc2")
		  
		  return pCellValues(idx) = pFunctionParameters(0)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Rowsorter_table_for_test_io_06(Sourceline as string, phase as clTextReader.RowSorterPhase) As clTextReader.TextLineType
		  select case phase 
		  case clTextReader.RowSorterPhase.Opening 
		    rowsorter_table_io_06_flag = 0
		    return clTextReader.TextLineType.Ignore
		    
		  case clTextReader.RowSorterPhase.Running
		    
		    if rowsorter_table_io_06_flag = 2 then
		      return clTextReader.TextLineType.Data
		      
		    elseif Sourceline.Trim = "=" then // this is the end of the file header, next row is column headers
		      rowsorter_table_io_06_flag = 2
		      return clTextReader.TextLineType.Ignore
		      
		    else
		      return clTextReader.TextLineType.Metadata
		      
		    end if
		    
		  case else
		    return clTextReader.TextLineType.Ignore
		    
		  end Select
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function TrsfFctApplyFixedRate_for_test_calc_052(t as clDataTable, columns() as string, params() as variant) As boolean
		  
		  var rate as Double = params(0)
		  
		  var srcColumnName as string = columns(1)
		  var dstColumnName as string = columns(0)
		  
		  var srcColumn as clNumberDataSerie = clNumberDataSerie(t.GetColumn(srcColumnName))
		  
		  if srcColumn = nil then Return false
		  
		  var resColumn as clNumberDataSerie = srcColumn * rate
		  call t.SetColumnValues(dstColumnName, resColumn, true)
		  
		  return true
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function TrsfFctApplyFixedRate_for_test_calc_053(t as clDataTable, columns() as string, params() as variant) As boolean
		  
		  var rate as Double = params(0)
		  
		  
		  var ColumnName as string = columns(0)
		  
		  var SrcColumn as clNumberDataSerie = clNumberDataSerie(t.GetColumn(ColumnName))
		  
		  if SrcColumn = nil then Return false
		  
		  var resColumn as clNumberDataSerie = SrcColumn * rate
		  
		  call t.SetColumnValues(ColumnName, resColumn, true)
		  
		  return true
		  
		  
		End Function
	#tag EndMethod


	#tag Property, Flags = &h1
		Protected rowsorter_table_io_06_flag As Integer
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
End Module
#tag EndModule
