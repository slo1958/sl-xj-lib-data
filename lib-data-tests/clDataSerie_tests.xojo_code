#tag Module
Protected Module clDataSerie_tests
	#tag Method, Flags = &h0
		Function check_serie(log as support_tests.itf_logmessage_writer, label as string, expected as clAbstractDataSerie, calculated as clAbstractDataSerie, accepted_error_on_double as double = 0.00001) As Boolean
		  
		  if not  check_value(log,label + " name", expected.name, calculated.name) then
		    return False
		    
		  end if
		  
		  if not check_value(log, label + " row count", expected.row_count, calculated.row_count) then
		    Return False
		    
		  end if
		  
		  
		  dim cell_ok as Boolean = True
		  
		  for row as integer = 0 to expected.row_count-1
		    cell_ok = cell_ok and check_value(log,  label + " row " + str(row), expected.get_element(row), calculated.get_element(row), accepted_error_on_double)
		    
		  next
		  
		  return cell_ok
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function filter01(the_row as integer, the_row_count as integer, the_column as string, the_value as variant, paramarray function_param as variant) As Boolean
		  Return True
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function filter_value_is_not_aaa(the_row as integer, the_row_count as integer, the_column as string, the_value as variant, paramarray function_param as variant) As Boolean
		  Return the_value <> "aaa"
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function filter_value_is_parameter(the_row as integer, the_row_count as integer, the_column as string, the_value as variant, paramarray function_param as variant) As Boolean
		  try
		    Return the_value = function_param(0)
		    
		  Catch
		    return False
		    
		  end Try
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub tests(log as itf_logmessage_writer)
		  
		  dim logwriter as  itf_logmessage_writer = log 
		  
		  if log = nil then
		    logwriter = new clWriteToSystemLog
		  end if
		  
		  logwriter.start_exec(CurrentMethodName)
		  
		  test_001(logwriter)
		  test_003(logwriter)
		  
		  
		  test_006(logwriter)
		  test_007(logwriter)
		  test_008(logwriter)
		  test_009(logwriter)
		  test_010(logwriter)
		  test_011(logwriter)
		  test_012(logwriter)
		  test_014(logwriter)
		  test_015(logwriter)
		  test_016(logwriter)
		  test_017(logwriter)
		  test_018(logwriter)
		  
		  logwriter.end_exec(CurrentMethodName)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub tests_io(log as itf_logmessage_writer)
		  
		  dim logwriter as  itf_logmessage_writer = log 
		  
		  if log = nil then
		    logwriter = new clWriteToSystemLog
		  end if
		  
		  
		  logwriter.start_exec(CurrentMethodName)
		  
		  test_io_001(logwriter)
		  test_io_005(logwriter)
		  
		  logwriter.end_exec(CurrentMethodName)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub test_001(log as itf_logmessage_writer)
		  
		  log.start_exec(CurrentMethodName)
		  
		  Dim test  As clDataSerie
		  
		  
		  test = New clDataSerie("test")
		  
		  test.append_element("hello")
		  test.append_element("world")
		  
		  call check_value(log,"row count", test.row_count, 2)
		  
		  
		  log.end_exec(CurrentMethodName)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub test_003(log as itf_logmessage_writer)
		  
		  log.start_exec(CurrentMethodName)
		  
		  Dim test  As clDataSerie
		  
		  test = New clDataSerie("test", variant_array("aaa",123,True))
		  
		  dim expected() as variant
		  expected.add("aaa")
		  expected.add(123)
		  expected.Add(True)
		  
		  if test.row_count <> 3 then
		    System.DebugLog("Invalid row count")
		    return
		    
		  end if
		  
		  for row as integer =0 to test.row_count-1
		    call check_value(log,"row " + str(row), expected(row), test.get_element(row))
		    
		  next
		  
		  
		  log.end_exec(CurrentMethodName)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub test_006(log as itf_logmessage_writer)
		  
		  
		  log.start_exec(CurrentMethodName)
		  
		  Dim src As New clDataSerie("premier") 
		  
		  src.append_element("aaa1")
		  src.append_element("bb1")
		  src.append_element("cccc1")
		  src.append_element("aaa2")
		  src.append_element("bb2")
		  src.append_element("cccc2")
		  src.append_element("aaa3")
		  src.append_element("bb3")
		  src.append_element("cccc3")
		  src.append_element("aaa4")
		  src.append_element("bb4")
		  src.append_element("cccc4")
		  
		  Dim f1() As variant
		  Dim f2() As variant
		  Dim f3() As Variant
		  
		  // all boolean arrays have the same size
		  //
		  
		  f1 = src.filter_apply_function(AddressOf filter01)
		  
		  f2 = src.filter_apply_function(AddressOf retain_serie_head, 7)
		  
		  f3 = src.filter_apply_function(AddressOf retain_serie_tail)
		  
		  Dim c1 As New clDataSerie("test001", f1)
		  Dim c2 As New clDataSerie("test002", f2)
		  dim c3 as New clDataSerie("test003", f3)
		  
		  
		  dim cnt1, cnt2, cnt3, cnt4, cnt5, cnt6 as Integer
		  
		  for i as integer =  0 to f1.LastIndex
		    if f1(i) then  cnt1 = cnt1 + 1
		    if f2(i) then cnt2 = cnt2 + 1 
		    if f3(i) then cnt3 = cnt3 + 1
		    
		    if c1.get_element(i) then cnt4 = cnt4 + 1
		    if c2.get_element(i) then cnt5 = cnt5 + 1
		    if c3.get_element(i) then cnt6 = cnt6 + 1
		    
		  next
		  
		  call check_value(log,"cnt1", 12, cnt1)
		  call check_value(log, "cnt2", 7, cnt2)
		  call check_value(log,"cnt3", 10, cnt3)
		  
		  call check_value(log,"cnt4", 12, cnt4)
		  call check_value(log, "cnt5", 7, cnt5)
		  call check_value(log, "cnt6", 10, cnt6)
		  
		  log.end_exec(CurrentMethodName)
		  
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub test_007(log as itf_logmessage_writer)
		  
		  log.start_exec(CurrentMethodName)
		  
		  Dim c1 As New clDataSerie("premier") 
		  Dim c2 As New clDataSerie("second") 
		  
		  c1.append_element("123.4")
		  c1.append_element(140.5)
		  
		  c2.append_element("123.4")
		  c2.append_element(140.5)
		  c2.append_element("yoyo")
		  
		  Dim d1 As Double
		  Dim d2 As Double
		  
		  d1 = c1.sum
		  d2 = c2.sum
		  
		  call check_value(log,"d1", 263.9, d1)
		  call check_value(log,"d2", 263.9, d2)
		  
		  log.end_exec(CurrentMethodName)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub test_008(log as itf_logmessage_writer)
		  
		  log.start_exec(CurrentMethodName)
		  
		  Dim c1 As New clDataSerie("premier") 
		  Dim c2 As New clDataSerie("second") 
		  Dim c3 As New clDataSerie("parent")
		  Dim c4 As New clDataSerie("grand-parent")
		  
		  c1.append_element("123.4")
		  c1.append_element(140.5)
		  
		  c2.append_element("123.4")
		  c2.append_element(140.5)
		  c2.append_element("yoyo")
		  
		  
		  c3.append_element(c1)
		  c3.append_element(c2)
		  
		  c4.append_element(c3)
		  
		  Dim d3 As Double = c3.sum
		  Dim d4 As Double = c4.sum
		  
		  call check_value(log,"upper bound for c3", 1, c3.upper_bound)
		  call check_value(log, "upper bound for c4", 0, c4.upper_bound)
		  
		  
		  log.end_exec(CurrentMethodName)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub test_009(log as itf_logmessage_writer)
		  
		  log.start_exec(CurrentMethodName)
		  
		  Dim c1 As New clDataSerieMultiValued(Array("aaaa","bbbb")) 
		  
		  call check_value(log,"name", "aaaa" + Chr(9) + "bbbb", c1.name)
		  
		  
		  
		  log.end_exec(CurrentMethodName)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub test_010(log as itf_logmessage_writer)
		  
		  log.start_exec(CurrentMethodName)
		  
		  Dim c1 As New clCompressedDataSerie("CompSerie") 
		  Dim c2 As New clDataSerie("BaseSerie") 
		  
		  c1.append_element("aaa")
		  c1.append_element("bb")
		  c1.append_element("cccc")
		  c1.append_element("aaa")
		  c1.append_element("bb")
		  c1.append_element("cccc")
		  c1.append_element("aaa")
		  c1.append_element("bb")
		  c1.append_element("cccc")
		  c1.append_element("aaa")
		  c1.append_element("bb")
		  c1.append_element("cccc")
		  c1.append_element("bb")
		  c1.append_element("cccc")
		  c1.append_element("cccc")
		  
		  c1.copy_to(c2)
		  
		  
		  Dim f1() As variant
		  Dim f2() As variant 
		  
		  f1 = c1.filter_apply_function(AddressOf filter_value_is_not_aaa)
		  
		  f2 = c2.filter_apply_function(AddressOf filter_value_is_not_aaa)
		  
		  Dim r1 As New clDataSerie("test001", f1)
		  Dim r2 As New clDataSerie("test002", f2)
		  
		  dim nbf1, nbf2, nbr1, nbr2 as integer
		  
		  for i as integer = 0 to f1.LastIndex
		    if f1(i) then nbf1 = nbf1 + 1
		    if f2(i) then nbf2 = nbf2 + 1
		    
		    if r1.get_element(i) then nbr1 = nbr1 + 1
		    if r2.get_element(i) then nbr2 = nbr2 + 1
		    
		  next
		  
		  call check_value(log,"nbf1", 11, nbf1)
		  call check_value(log, "nbf2", 11, nbf2)
		  call check_value(log,"nbr1", 11, nbr1)
		  call check_value(log, "nbr2", 11, nbr2) 
		  
		  
		  log.end_exec(CurrentMethodName)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub test_011(log as itf_logmessage_writer)
		  
		  log.start_exec(CurrentMethodName)
		  
		  Dim test  As clNumberDataSerie
		  
		  
		  test = New clNumberDataSerie("test")
		  
		  test.append_element(125)
		  test.append_element(142)
		  
		  call check_value(log,"row count", test.row_count, 2) 
		  
		  log.end_exec(CurrentMethodName)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub test_012(log as itf_logmessage_writer)
		  
		  log.start_exec(CurrentMethodName)
		  
		  Dim test  As clNumberDataSerie
		  
		  
		  test = New clNumberDataSerie("test")
		  
		  test.append_element("125")
		  test.append_element(142)
		  
		  call check_value(log,"row count", test.row_count, 2) 
		  
		  log.end_exec(CurrentMethodName)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub test_014(log as itf_logmessage_writer)
		  
		  log.start_exec(CurrentMethodName)
		  
		  Dim test  As clNumberDataSerie
		  
		  
		  test = New clNumberDataSerie("test")
		  
		  test.append_element("abc")
		  test.append_element(142)
		  
		  call check_value(log,"row count", test.row_count, 2)
		  
		  
		  log.end_exec(CurrentMethodName)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub test_015(log as itf_logmessage_writer)
		  
		  log.start_exec(CurrentMethodName)
		  
		  Dim test0, test1, test2, test3  As clNumberDataSerie
		  dim expected, delta as clNumberDataSerie
		  
		  test1 = New clNumberDataSerie("test1")
		  
		  test1.append_element(124)
		  test1.append_element(456)
		  
		  test2 = new clNumberDataSerie("test2")
		  test2.append_element(12)
		  test2.append_element(24)
		  test2.append_element(10)
		  
		  test3 = new clNumberDataSerie("test3")
		  test3.append_element(100)
		  test3.append_element(300)
		  test3.append_element(6)
		  
		  test0 = (test1 + test2 - test3 + 1000) * 0.5
		  
		  expected = new clNumberDataSerie("expected")
		  expected.append_element(518)
		  expected.append_element(590)
		  expected.append_element(502)
		  
		  delta = test0 - expected
		  
		  call check_value(log,"sum of diff", 0, delta.sum)
		  
		  log.end_exec(CurrentMethodName)
		  
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub test_016(log as itf_logmessage_writer)
		  
		  log.start_exec(CurrentMethodName)
		  
		  
		  Dim c1 As New clDataSerie("premier") 
		  Dim c2 As New clIntegerDataSerie("second") 
		  
		  dim c3 as new clCompressedDataSerie("troisieme")
		  
		  for i as integer = 0 to 10
		    c1.append_element("aaa")
		    c1.append_element("bb")
		    c1.append_element("cccc")
		    c1.append_element("ddddd")
		    c1.append_element("ee")
		    
		    c2.append_element(345)
		    c2.append_element(5678)
		    c2.append_element(12756)
		    c2.append_element(3345)
		    c2.append_element(564378)
		    
		    c3.append_element("aaa")
		    c3.append_element("bb")
		    c3.append_element("cccc")
		    c3.append_element("ddddd")
		    c3.append_element("ee")
		    
		  next
		  
		  dim uniq1() as variant = c1.unique
		  dim uniq2() as Variant = c2.unique
		  dim uniq3() as variant = c3.unique
		  
		  call check_value(log, "uniq1", 5, uniq1.Count)
		  call check_value(log, "uniq2", 5, uniq2.Count)
		  call check_value(log, "uniq3", 5, uniq3.Count)
		  
		  log.end_exec(CurrentMethodName)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub test_017(log as itf_logmessage_writer)
		  
		  log.start_exec(CurrentMethodName)
		  
		  Dim c1 As New clCompressedDataSerie("CompSerie") 
		  Dim c2 As New clDataSerie("BaseSerie") 
		  
		  c1.append_element("aaa")
		  c1.append_element("bb")
		  c1.append_element("cccc")
		  c1.append_element("aaa")
		  c1.append_element("bb")
		  c1.append_element("cccc")
		  c1.append_element("aaa")
		  c1.append_element("bb")
		  c1.append_element("cccc")
		  c1.append_element("aaa")
		  c1.append_element("bb")
		  c1.append_element("cccc")
		  c1.append_element("bb")
		  c1.append_element("cccc")
		  c1.append_element("cccc")
		  
		  c1.copy_to(c2)
		  
		  
		  Dim f1() As variant
		  Dim f2() As variant 
		  
		  f1 = c1.filter_apply_function(AddressOf filter_value_is_parameter,"aaa")
		  
		  f2 = c2.filter_apply_function(AddressOf filter_value_is_parameter,"aaa")
		  
		  
		  Dim r1 As New clDataSerie("test001", f1)
		  Dim r2 As New clDataSerie("test002", f2)
		  
		  dim nbf1, nbf2, nbr1, nbr2 as integer
		  
		  for i as integer = 0 to f1.LastIndex
		    if f1(i) then nbf1 = nbf1 + 1
		    if f2(i) then nbf2 = nbf2 + 1
		    
		    if r1.get_element(i) then nbr1 = nbr1 + 1
		    if r2.get_element(i) then nbr2 = nbr2 + 1
		    
		  next
		  
		  call check_value(log,"nbf1", 4, nbf1)
		  call check_value(log, "nbf2", 4, nbf2)
		  call check_value(log,"nbr1", 4, nbr1)
		  call check_value(log, "nbr2", 4, nbr2) 
		  
		  log.end_exec(CurrentMethodName)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub test_018(log as itf_logmessage_writer)
		  
		  log.start_exec(CurrentMethodName)
		  
		  Dim c1 As New clDateDataSerie("premier") 
		  Dim c2 As New clDateDataSerie("second") 
		  
		  c1.append_element("2023-06-01")
		  c1.append_element("2022-08-12")
		  
		  c2.append_element("2021-06-01")
		  c2.append_element("2020-08-01")
		  
		  dim c3 as clIntegerDataSerie = c1 - c2
		  
		  dim c4 as clIntegerDataSerie = c1 - DateTime.FromString("2020-01-01")
		  
		  dim c5 as clStringDataSerie = c1.ToString()
		  
		  dim c6 as clStringDataSerie = c1.ToString(DateTime.FormatStyles.Medium)
		  
		  dim c7 as clStringDataSerie = c1.ToString("yyyy-MM")
		  
		  
		  log.end_exec(CurrentMethodName)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub test_io_001(log as itf_logmessage_writer)
		  
		  log.start_exec(CurrentMethodName)
		  
		  Dim k As Variant
		  
		  Dim fld_folder As New FolderItem
		  Dim fld_file As FolderItem
		  
		  fld_folder = fld_folder.Child("test-data")
		  
		  fld_file = fld_folder.Child("myfile3_10K_tab.txt")
		  
		  Dim ss1 As  clDataSerie = clDataSerie(append_textfile_to_DataSerie(fld_file, new clDataSerie(""), true))
		  
		  Dim k2 As Integer = 1
		  
		  
		  log.end_exec(CurrentMethodName)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub test_io_005(log as itf_logmessage_writer)
		  
		  log.start_exec(CurrentMethodName)
		  
		  
		  Dim k As Variant
		  
		  Dim fld_folder As New FolderItem
		  Dim fld_file_in As FolderItem
		  Dim fld_file_out As FolderItem
		  
		  fld_folder = fld_folder.Child("test-data")
		  
		  fld_file_in = fld_folder.Child("myfile3_10K_tab.txt")
		  
		  fld_file_out =  fld_folder.Child("mytest.txt")
		  
		  
		  Dim ss1 As  clDataSerie = clDataSerie(append_textfile_to_DataSerie(fld_file_in, new clDataSerie(""), true))
		  
		  save_DataSerie_to_textfile(fld_file_out, ss1, True)
		  
		  
		  
		  log.end_exec(CurrentMethodName)
		  
		End Sub
	#tag EndMethod


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
End Module
#tag EndModule
