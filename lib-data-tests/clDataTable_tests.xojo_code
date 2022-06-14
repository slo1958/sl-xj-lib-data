#tag Module
Protected Module clDataTable_tests
	#tag Method, Flags = &h0
		Function alloc_series(column_name as string) As clAbstractDataSerie
		  if column_name = "Alpha" then
		    Return new clCompressedDataSerie(column_name)
		    
		  else
		    return new clDataSerie(column_name)
		    
		  end if
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function filter_008(the_row_index as integer, the_row_count as integer, the_column_names() as string, the_cell_values() as variant, paramarray function_param as variant) As Boolean
		  dim idx as integer = the_column_names.IndexOf("cc2")
		  
		  return the_cell_values(idx) = function_param(0)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub tests()
		  System.DebugLog("START "+CurrentMethodName)
		  
		  test_001
		  test_002
		  test_003
		  test_004
		  test_005
		  test_006
		  test_007
		  test_008
		  test_009
		  test_010
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub test_001()
		  System.DebugLog("START "+CurrentMethodName)
		  
		  Dim rtst As clDataRow
		  
		  Dim ttst As New clDataTable("T1")
		  
		  rtst = New clDataRow
		  rtst.set_cell("aaa",1234)
		  rtst.set_cell("bbb","abcd")
		  rtst.set_cell("ccc",123.456)
		  
		  ttst.append_row(rtst)
		  
		  rtst = New clDataRow
		  rtst.set_cell("aaa",1235)
		  rtst.set_cell("bbb","abce")
		  rtst.set_cell("ddd",987.654)
		  
		  ttst.append_row(rtst)
		  
		  System.DebugLog("Expecting aaa/bbb/ccc/ddd")
		  ttst.debug_dump
		  
		  Dim k As Integer = 1
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub test_002()
		  System.DebugLog("START "+CurrentMethodName)
		  
		  Dim rtst As clDataRow
		  
		  Dim ttst1 As New clDataTable("T1")
		  
		  rtst = New clDataRow
		  rtst.set_cell("aaa",1234)
		  rtst.set_cell("bbb","abcd")
		  rtst.set_cell("ccc",123.456)
		  
		  ttst1.append_row(rtst)
		  
		  rtst = New clDataRow
		  rtst.set_cell("aaa",1235)
		  rtst.set_cell("bbb","abce")
		  rtst.set_cell("ddd",987.654)
		  
		  ttst1.append_row(rtst)
		  
		  ttst1.debug_dump
		  
		  
		  Dim ttst2 As New clDataTable("T2")
		  
		  rtst = New clDataRow
		  rtst.set_cell("aaa",81234)
		  rtst.set_cell("bbb","zabcd")
		  rtst.set_cell("zccc",8123.456)
		  
		  ttst2.append_row(rtst)
		  
		  rtst = New clDataRow
		  rtst.set_cell("aaa",81235)
		  rtst.set_cell("bbb","zabce")
		  rtst.set_cell("zddd",8987.654)
		  
		  ttst2.append_row(rtst)
		  
		  ttst2.debug_dump
		  
		  ttst1.append_table(ttst2)
		  ttst1.debug_dump
		  
		  Dim ttst3 As clDataTable = ttst1.select_columns(Array("aaa","zccc"))
		  ttst3.debug_dump
		  
		  Dim k As Integer = 1
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub test_003()
		  System.DebugLog("START "+CurrentMethodName)
		  
		  Dim rtst As clDataRow
		  Dim ttst1 As New clDataTable("T1")
		  
		  
		  rtst = New clDataRow
		  rtst.set_cell("aaa",1234)
		  rtst.set_cell("bbb","abcd")
		  rtst.set_cell("ccc",123.456)
		  
		  ttst1.append_row(rtst)
		  
		  rtst = New clDataRow
		  rtst.set_cell("aaa",1235)
		  rtst.set_cell("bbb","abce")
		  rtst.set_cell("ddd",987.654)
		  
		  ttst1.append_row(rtst)
		  
		  ttst1.debug_dump
		  
		  Dim k As Integer = 1
		  
		  Dim my_col As clDataSerie
		  Dim ttst3 As clDataTable = ttst1.select_columns(Array("aaa","zccc"))
		  ttst3.debug_dump
		  
		  my_col = ttst3.add_column("xyz")
		  
		  ttst3.debug_dump
		  
		  
		  ttst1.debug_dump
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub test_004()
		  System.DebugLog("START "+CurrentMethodName)
		  
		  Dim k As Variant
		  
		  Dim fld_folder As New FolderItem
		  Dim fld_file1 As FolderItem
		  Dim fld_file2 As FolderItem
		  Dim fld_file3 As FolderItem
		  
		  fld_folder = fld_folder.Child("test-data")
		  
		  fld_file1 = fld_folder.Child("myfile3_10K_tab.txt")
		  fld_file2  = fld_folder.Child("myfile3_10K_comma.txt")
		  fld_file3  = fld_folder.Child("myfile3_10K_output.txt")
		  
		  Dim ttst3 As New clDataTable("x")
		  
		  ttst3.load_from_text(fld_file1, New clRowParser_full(Chr(9)), True)
		  
		  Dim ttst4 As New clDataTable("x")
		  
		  ttst4.load_from_text(fld_file2, New clRowParser_full(","), True)
		  
		  ttst4.save_as_text(fld_file3, New clRowParser_full(";"), True)
		  
		  dim ttst5  as new clDataTable("x")
		  
		  ttst5.load_from_text(fld_file1, New clRowParser_full(Chr(9)), True, AddressOf alloc_series)
		  
		  
		  System.DebugLog(join(ttst3.column_names,";"))
		  
		  System.DebugLog("DONE WITH "+CurrentMethodName)
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub test_005()
		  System.DebugLog("START "+CurrentMethodName)
		  
		  Dim rtst As clDataRow
		  
		  Dim ttst As New clDataTable("T1")
		  
		  rtst = New clDataRow
		  rtst.set_cell("aaa",1234)
		  rtst.set_cell("bbb","abcd")
		  rtst.set_cell("ccc",123.456)
		  
		  ttst.append_row(rtst)
		  
		  rtst = New clDataRow
		  rtst.set_cell("aaa",1235)
		  rtst.set_cell("bbb","abce")
		  rtst.set_cell("ddd",987.654)
		  
		  ttst.append_row(rtst)
		  
		  ttst.debug_dump
		  
		  
		  Dim cols() As clAbstractDataSerie
		  
		  cols = ttst.get_columns("aaa","bbb","ddd")
		  
		  cols(1).rename("bB1")
		  
		  
		  
		  
		  Dim k As Integer = 1
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub test_006()
		  System.DebugLog("START "+CurrentMethodName)
		  
		  Dim c1 As New clDataSerie("premier")
		  Dim c2 As New clDataSerie("second")
		  
		  c1.append_element("aaa")
		  c1.append_element("bbb")
		  c1.append_element("ccc")
		  
		  
		  c2.append_element(12)
		  c2.append_element(34)
		  c2.append_element(56)
		  c2.append_element(78)
		  
		  Dim t1 As New clDataTable("mytable1", serie_array(c1, c2))
		  
		  Dim t2 As New clDataTable("mytable2", serie_array(c1, c2), True)
		  
		  Dim r1 As clDataRow
		  r1 = New clDataRow
		  r1.set_cell("premier","dddd")
		  r1.set_cell("second",90)
		  
		  t1.append_row(r1)
		  
		  r1.set_cell("troisieme",True)
		  t2.append_row(r1)
		  
		  
		  t1.debug_dump
		  
		  t2.debug_dump
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub test_007()
		  System.DebugLog("START "+CurrentMethodName)
		  
		  Dim rtst As clDataRow
		  
		  Dim ttst As New clDataTable("T1")
		  
		  call ttst.add_columns(Array("cc1","cc2","cc3"))
		  
		  ttst.append_row(Array("aaa0","bbb0","ccc0"))
		  ttst.append_row(Array("aaa1","bbb1","ccc1"))
		  ttst.append_row(Array("aaa2","bbb2","ccc2"))
		  ttst.append_row(Array("aaa3","bbb3","ccc3"))
		  
		  Dim tmp1 As Integer = ttst.find_first_matching_row("cc2","bbb2")
		  Dim tmp2 As Integer = ttst.find_first_matching_row("cc2","zzz2")
		  Dim tmp3 As Integer = ttst.find_first_matching_row("zz2","bbb2")
		  
		  ttst.debug_dump
		  
		  
		  Dim k As Integer = 1
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub test_008()
		  System.DebugLog("START "+CurrentMethodName)
		  
		  
		  Dim ttst As New clDataTable("T1")
		  
		  call ttst.add_columns(Array("cc1","cc2","cc3"))
		  
		  ttst.append_row(Array("aaa0","bbb0","ccc0"))
		  ttst.append_row(Array("aaa1","bbb1","ccc1"))
		  ttst.append_row(Array("aaa2","bbb0","ccc2"))
		  ttst.append_row(Array("aaa3","bbb3","ccc3"))
		  
		  ' The function is filtering on column cc2. The parameter is the value to look for
		  
		  dim tmp1() as variant = ttst.apply_filter(AddressOf filter_008,"bbb0")
		  
		  call ttst.add_column(new clDataSerie("is_bbb0", tmp1))
		  
		  call ttst.add_column(new clDataSerie("is_bbb3",  ttst.apply_filter(AddressOf filter_008, "bbb3")))
		  ttst.debug_dump
		  
		  Dim k As Integer = 1
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub test_009()
		  System.DebugLog("START "+CurrentMethodName)
		  
		  Dim rtst As clDataRow
		  
		  Dim ttst1 As New clDataTable("T1")
		  Dim ttst2 as New clDataTable("T2")
		  
		  for i as integer = 1 to 4
		    rtst = New clDataRow
		    rtst.set_cell("aaa",I*1000)
		    rtst.set_cell("bbb","abcd")
		    rtst.set_cell("ccc",123.456)
		    
		    ttst1.append_row(rtst)
		    
		  next
		  
		  
		  for i as integer = 5 to 9
		    rtst = New clDataRow
		    rtst.set_cell("aaa",I*1000)
		    rtst.set_cell("bbb","xyz")
		    rtst.set_cell("ddd",567.89)
		    
		    ttst2.append_row(rtst)
		    
		  next
		  
		  dim ttst3 as clDataTable = ttst1.clone()
		  
		  ttst3.append_table(ttst2)
		  
		  
		  System.DebugLog("Expecting aaa/bbb/ccc/ddd")
		  ttst3.debug_dump
		  
		  Dim k As Integer = 1
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub test_010()
		  System.DebugLog("START "+CurrentMethodName)
		  
		  Dim rtst As clDataRow
		  Dim ttst1 As New clDataTable("T1")
		  
		  call ttst1.add_column(new clDataSerie("name"))
		  call ttst1.add_column(new clNumberDataSerie("quantity"))
		  call ttst1.add_column(new clNumberDataSerie("unit_price"))
		  
		  
		  rtst = New clDataRow
		  rtst.set_cell("name","alpha")
		  rtst.set_cell("quantity",50)
		  rtst.set_cell("unit_price",6)
		  ttst1.append_row(rtst)
		  
		  rtst = New clDataRow
		  rtst.set_cell("name","alpha")
		  rtst.set_cell("quantity",20)
		  rtst.set_cell("unit_price",8)
		  ttst1.append_row(rtst)
		  
		  dim sr as clAbstractDataSerie = ttst1.add_column(clNumberDataSerie(ttst1.get_column("unit_price")) * clNumberDataSerie(ttst1.get_column("quantity")))
		  
		  ttst1.debug_dump
		  
		  Dim k As Integer = 1
		  
		End Sub
	#tag EndMethod


	#tag ViewBehavior
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
	#tag EndViewBehavior
End Module
#tag EndModule
