#tag Module
Protected Module clDataSerie_tests
	#tag Method, Flags = &h0
		Function filter01(the_row as integer, the_row_count as integer, the_column as string, the_value as variant, paramarray function_param as variant) As Boolean
		  Return True
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function filter02(the_row as integer, the_row_count as integer, the_column as string, the_value as variant, paramarray function_param as variant) As Boolean
		  Return the_value <> "aaa"
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub tests()
		  
		  System.DebugLog("START "+CurrentMethodName)
		  
		  test_001
		  test_003
		  test_004
		  test_005
		  test_006
		  test_007
		  test_008
		  test_009
		  test_010
		  test_011
		  test_012
		  test_014
		  test_015
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub test_001()
		  System.DebugLog("START "+CurrentMethodName)
		  
		  Dim test  As clDataSerie
		  
		  
		  test = New clDataSerie("test")
		  
		  test.append_element("hello")
		  test.append_element("world")
		  
		  
		  System.DebugLog("return " + Str(test.row_count))
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub test_003()
		  System.DebugLog("START "+CurrentMethodName)
		  
		  Dim test  As clDataSerie
		  
		  test = New clDataSerie("test", variant_array("aaa",123,True))
		  
		  Dim k As Integer =1
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub test_004()
		  System.DebugLog("START "+CurrentMethodName)
		  
		  Dim k As Variant
		  
		  Dim fld_folder As New FolderItem
		  Dim fld_file As FolderItem
		  
		  fld_folder = fld_folder.Child("test-data")
		  
		  fld_file = fld_folder.Child("myfile3_10K_tab.txt")
		  
		  
		  Dim ss1 As New clDataSerie(fld_file)
		  
		  Dim k2 As Integer = 1
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub test_005()
		  System.DebugLog("START "+CurrentMethodName)
		  
		  Dim k As Variant
		  
		  Dim fld_folder As New FolderItem
		  Dim fld_file_in As FolderItem
		  Dim fld_file_out As FolderItem
		  
		  fld_folder = fld_folder.Child("test-data")
		  
		  fld_file_in = fld_folder.Child("myfile3_10K_tab.txt")
		  
		  fld_file_out =  fld_folder.Child("mytest.txt")
		  
		  Dim ss1 As New clDataSerie(fld_file_in)
		  
		  ss1.save_as_text(fld_file_out, True)
		  
		  Dim k2 As Integer = 1
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub test_006()
		  
		  System.DebugLog("START "+CurrentMethodName)
		  
		  Dim c1 As New clDataSerie("premier") 
		  Dim c2 As New clDataSerie("second") 
		  
		  c1.append_element("aaa1")
		  c1.append_element("bb1")
		  c1.append_element("cccc1")
		  c1.append_element("aaa2")
		  c1.append_element("bb2")
		  c1.append_element("cccc2")
		  c1.append_element("aaa3")
		  c1.append_element("bb3")
		  c1.append_element("cccc3")
		  c1.append_element("aaa4")
		  c1.append_element("bb4")
		  c1.append_element("cccc4")
		  
		  c2.append_element(12)
		  c2.append_element(345)
		  c2.append_element(5678)
		  
		  Dim f1() As variant
		  Dim f2() As variant
		  Dim f3() As Variant
		  
		  f1 = c1.filter_apply_function(AddressOf filter01)
		  
		  f2 = c1.filter_apply_function(AddressOf retain_serie_head, 7)
		  
		  f3 = c1.filter_apply_function(AddressOf retain_serie_tail)
		  
		  Dim c3 As New clDataSerie("test001", f1)
		  Dim c4 As New clDataSerie("test002", f1)
		  
		  
		  c1.debug_dump
		  
		  c2.debug_dump
		  
		  c3.debug_dump
		  
		  c4.debug_dump
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub test_007()
		  System.DebugLog("START "+CurrentMethodName)
		  
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
		  
		  
		  c1.debug_dump
		  
		  c2.debug_dump
		  
		  System.DebugLog(Str(d1))
		  System.DebugLog(str(d2))
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub test_008()
		  System.DebugLog("START "+CurrentMethodName)
		  
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
		  
		  Dim d1 As Double
		  Dim d2 As Double
		  
		  
		  c1.debug_dump
		  
		  c2.debug_dump
		  
		  c3.debug_dump 
		  
		  c4.debug_dump 
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub test_009()
		  System.DebugLog("START "+CurrentMethodName)
		  
		  Dim c1 As New clDataSerieMultiValued(Array("aaaa","bbbb"))
		  
		  System.DebugLog(c1.name)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub test_010()
		  System.DebugLog("START "+CurrentMethodName)
		  
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
		  
		  c1.copy_to(c2)
		  
		  
		  Dim f1() As variant
		  Dim f2() As variant
		  Dim f3() As Variant
		  
		  f1 = c1.filter_apply_function(AddressOf filter02)
		  
		  f2 = c2.filter_apply_function(AddressOf filter02)
		  
		  Dim c3 As New clDataSerie("test001", f1)
		  Dim c4 As New clDataSerie("test002", f2)
		  
		  
		  c1.debug_dump
		  
		  c2.debug_dump
		  
		  c3.debug_dump
		  
		  c4.debug_dump
		  
		  for i as integer = 0 to c1.upper_bound
		    System.DebugLog(str(i) + ": " + c1.get_element(i) + "    " + c2.get_element(i))
		    
		  next
		  
		  System.DebugLog("Done with "+CurrentMethodName)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub test_011()
		  System.DebugLog("START "+CurrentMethodName)
		  
		  Dim test  As clNumberDataSerie
		  
		  
		  test = New clNumberDataSerie("test")
		  
		  test.append_element(125)
		  test.append_element(142)
		  
		  
		  System.DebugLog("return " + Str(test.row_count))
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub test_012()
		  System.DebugLog("START "+CurrentMethodName)
		  
		  Dim test  As clNumberDataSerie
		  
		  
		  test = New clNumberDataSerie("test")
		  
		  test.append_element("125")
		  test.append_element(142)
		  
		  
		  System.DebugLog("return " + Str(test.row_count))
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub test_014()
		  System.DebugLog("START "+CurrentMethodName)
		  
		  Dim test  As clNumberDataSerie
		  
		  
		  test = New clNumberDataSerie("test")
		  
		  test.append_element("abc")
		  test.append_element(142)
		  
		  
		  System.DebugLog("return " + Str(test.row_count))
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub test_015()
		  System.DebugLog("START "+CurrentMethodName)
		  
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
		  
		  System.DebugLog("return " + Str(test0.row_count))
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
