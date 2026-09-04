#tag Module
Protected Module support_tests
	#tag Method, Flags = &h0
		Function check_serie(log as clLogManager, label as string, expected as clAbstractDataSerie, calculated as clAbstractDataSerie, accepted_error_on_double as double = 0.00001) As Boolean
		  
		  if not  check_value(log,label + " name", expected.name, calculated.name) then
		    return False
		    
		  end if
		  
		  if not check_value(log, label + " row count", expected.RowCount, calculated.RowCount) then
		    Return False
		    
		  end if
		  
		  
		  var cell_ok as Boolean = True
		  
		  for row as integer = 0 to expected.RowCount-1
		    cell_ok = cell_ok and check_value(log,  label + " row " + str(row), expected.GetElement(row), calculated.GetElement(row), accepted_error_on_double)
		    
		  next
		  
		  return cell_ok
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function check_table(log as clLogManager, label as string, expected as clDataTable, calculated as clDataTable, accepted_error_on_double as double = 0.00001) As Boolean
		  var cnt1 as integer  
		  var cnt2 as integer  
		  
		  if calculated = nil then
		    if log <> nil then log.WriteTestCheckError(CurrentMethodName,": (%0) Missing or unknow calculated table.", label)
		    return false
		    
		  end if
		  
		  var calcTableName as string = calculated.Name
		  
		  if calculated.CheckIntegrity() then
		    if expected = nil then return True
		    
		  else
		    if log <> nil then log.WriteTestCheckError(CurrentMethodName,": (%0) Integrity error calculated table [%1]", label, calcTableName)
		    if expected = nil then return False
		    
		  end if
		  
		  if expected = nil then
		    if log <> nil then log.WriteTestCheckError(CurrentMethodName,": (%0) Missing or unknow expected table.", label)
		    return False
		    
		  end if
		  
		  var expectName as string = expected.Name
		  
		  
		  if expected.CheckIntegrity() then
		  else
		    if log <> nil then log.WriteTestCheckError(CurrentMethodName,": (%0) Integrity error expected table [%1]", label, expectName)
		    
		  end if
		  
		  
		  
		  cnt1 = expected.ColumnCount
		  cnt2 = calculated.ColumnCount
		  
		  if not check_value(log,"("+label+") column count in tables [" + calcTableName+"] vs ["+expectName+"]", cnt1, cnt2) then return False
		  
		  var col_ok as boolean = True
		  for col as integer = 0 to expected.ColumnCount-1
		    
		    col_ok = col_ok and check_serie(log, label + " ("+label+") field [" + expected.ColumnNameAt(col)+"]", expected.GetColumnAt(col), calculated.GetColumnAt(col), accepted_error_on_double)
		    
		  next
		  
		  Return col_ok
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function check_value(log as clLogManager, label as string, expected as variant, calculated as variant, accepted_error_on_double as double = 0.00001) As boolean
		  if (expected.Type = variant.TypeDouble or expected.Type = Variant.TypeSingle) then //and (calculated.Type = variant.TypeDouble or calculated.Type = variant.TypeSingle) then
		    
		    var calculated_float as double = calculated.DoubleValue
		    
		    if abs(expected - calculated_float) < accepted_error_on_double then return true
		    log.WriteTestCheckError(CurrentMethodName,"Invalid numeric value for %0, expecting %1  got %2,  dif. %3 " , label, str(expected), str(calculated)  , str(abs(expected - calculated_float) ))
		    
		    return false
		  end if
		  
		  
		  if expected = calculated then return  True
		  
		  var fmt_expected as string
		  var fmt_calculated as string
		  
		  if expected.Type = Variant.TypeDouble or expected.type = variant.TypeSingle then
		    fmt_expected = str(expected,  "-#####.#####")
		    
		  else
		    fmt_expected = str(expected)
		    
		  end if
		  
		  if calculated.Type = Variant.TypeDouble or calculated.type = variant.TypeSingle then
		    fmt_calculated = str(calculated, "-#####.#####")
		    
		  else
		    fmt_calculated = str(calculated)
		    
		  end if
		  
		  
		  log.WriteTestCheckError(CurrentMethodName,"Invalid value for %0, expecting <%1> got <%2>" , label , fmt_expected , fmt_calculated)
		  
		  
		  return False
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetTestInputBaseFolder() As FolderItem
		  var fld_folder As New FolderItem
		  return  fld_folder.Child("test-data").child("input")
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetTestMethods(c as object, mask as string) As Dictionary
		  
		  Var t As Introspection.TypeInfo
		  
		  
		  var d as new Dictionary
		  t = Introspection.GetType(c)
		  
		  for each met as Introspection.MethodInfo in t.GetMethods
		    if met.name.left(mask.Length) = mask then
		      d.value(met.name) = met
		      
		    end if
		    
		  next
		  
		  return d
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetTestOutputFolder(childname as string) As FolderItem
		  var fld_folder As New FolderItem
		  
		  fld_folder =  fld_folder.Child("test-data")
		  
		  fld_folder = fld_folder.child("output")
		  
		  if not fld_folder.Exists then
		    fld_folder.CreateFolder
		    
		  end if
		  
		  fld_folder = fld_folder.Child(childname)
		  
		  // child folder does not exist => create and exit
		  
		  if not fld_folder.Exists then 
		    fld_folder.CreateFolder
		    Return fld_folder
		    
		  end if
		  
		  if not fld_folder.IsFolder then return nil
		  
		  // clean up
		  
		  fld_folder.RemoveFolderAndContents
		  
		  fld_folder.CreateFolder
		  
		  Return fld_folder
		  
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub MetaDataToLog(log as clLogManager, metadata as clMetadata)
		  
		  for i as integer = 0 to metadata.LastIndex
		    var m as clMetadataEntry = metadata.MetadataAt(i)
		    
		    log.WriteInfo(CurrentMethodName, "%0: Category %1 ,  %2 = %3",i, m.CategoryValue, m.TypeValue, m.DataValue)
		    
		  next
		  
		  Return
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RunTests(c as object, mask as string, logwriter as clLogManager)
		  
		  
		  Var t As Introspection.TypeInfo
		  
		  //
		  // Extract all methods of which name is matching the mask
		  // With mask set to "test_calc_", it returns all methods of which name starts with "test_calc_"
		  // The dictionary contains the name of the method as key and the pointer to the method as value
		  //
		  var MethodInfoDict as   Dictionary = GetTestMethods(c, mask)
		  
		  
		  var s() as string
		  
		  for each k as string in MethodInfoDict.keys
		    s.Add(k)
		    
		  next
		  
		  s.Sort
		  
		  t = Introspection.GetType(c)
		  
		  for each k as string in s
		    var met as Introspection.MethodInfo  = Introspection.MethodInfo (MethodInfoDict.value(k))
		    var v() as Variant
		    v.Add(logwriter)
		    met.Invoke(c, v)
		    
		  next
		End Sub
	#tag EndMethod


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
