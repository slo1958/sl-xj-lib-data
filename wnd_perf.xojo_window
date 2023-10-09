#tag Window
Begin Window wnd_perf
   Backdrop        =   0
   BackgroundColor =   &cFFFFFF00
   Composite       =   False
   DefaultLocation =   0
   FullScreen      =   False
   HasBackgroundColor=   False
   HasCloseButton  =   True
   HasFullScreenButton=   False
   HasMaximizeButton=   True
   HasMinimizeButton=   True
   Height          =   400
   ImplicitInstance=   True
   MacProcID       =   0
   MaximumHeight   =   32000
   MaximumWidth    =   32000
   MenuBar         =   0
   MenuBarVisible  =   True
   MinimumHeight   =   64
   MinimumWidth    =   64
   Resizeable      =   True
   Title           =   "Untitled"
   Type            =   0
   Visible         =   True
   Width           =   600
   Begin Label Label2
      AllowAutoDeactivate=   True
      Bold            =   False
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   223
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Multiline       =   False
      Scope           =   0
      Selectable      =   False
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "x 10K rows"
      TextAlignment   =   0
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   198
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   100
   End
   Begin Label Label3
      AllowAutoDeactivate=   True
      Bold            =   False
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   427
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Multiline       =   False
      Scope           =   0
      Selectable      =   False
      TabIndex        =   1
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Columns"
      TextAlignment   =   0
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   198
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   100
   End
   Begin PushButton PushButton1
      AllowAutoDeactivate=   True
      Bold            =   False
      Cancel          =   False
      Caption         =   "Test Inserts"
      Default         =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   20
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      MacButtonStyle  =   0
      Scope           =   0
      TabIndex        =   2
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   198
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   99
   End
   Begin TextField tf_cols
      AllowAutoDeactivate=   True
      AllowFocusRing  =   True
      AllowSpellChecking=   False
      AllowTabs       =   False
      BackgroundColor =   &cFFFFFF00
      Bold            =   False
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Format          =   ""
      HasBorder       =   True
      Height          =   22
      Hint            =   ""
      Index           =   -2147483648
      Italic          =   False
      Left            =   335
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      MaximumCharactersAllowed=   0
      Password        =   False
      ReadOnly        =   False
      Scope           =   0
      TabIndex        =   3
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "20"
      TextAlignment   =   0
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   196
      Transparent     =   False
      Underline       =   False
      ValidationMask  =   "##"
      Visible         =   True
      Width           =   80
   End
   Begin TextField tf_rows
      AllowAutoDeactivate=   True
      AllowFocusRing  =   True
      AllowSpellChecking=   False
      AllowTabs       =   False
      BackgroundColor =   &cFFFFFF00
      Bold            =   False
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Format          =   ""
      HasBorder       =   True
      Height          =   22
      Hint            =   ""
      Index           =   -2147483648
      Italic          =   False
      Left            =   131
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      MaximumCharactersAllowed=   0
      Password        =   False
      ReadOnly        =   False
      Scope           =   0
      TabIndex        =   4
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "10"
      TextAlignment   =   0
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   196
      Transparent     =   False
      Underline       =   False
      ValidationMask  =   "####"
      Visible         =   True
      Width           =   80
   End
   Begin Listbox Listbox1
      AllowAutoDeactivate=   True
      AllowAutoHideScrollbars=   True
      AllowExpandableRows=   False
      AllowFocusRing  =   True
      AllowResizableColumns=   False
      AllowRowDragging=   False
      AllowRowReordering=   False
      Bold            =   False
      ColumnCount     =   1
      ColumnWidths    =   ""
      DataField       =   ""
      DataSource      =   ""
      DefaultRowHeight=   -1
      DropIndicatorVisible=   False
      Enabled         =   True
      FontName        =   "Verdana"
      FontSize        =   11.0
      FontUnit        =   0
      GridLinesHorizontalStyle=   0
      GridLinesVerticalStyle=   0
      HasBorder       =   True
      HasHeader       =   False
      HasHorizontalScrollbar=   False
      HasVerticalScrollbar=   True
      HeadingIndex    =   -1
      Height          =   164
      Index           =   -2147483648
      InitialParent   =   ""
      InitialValue    =   ""
      Italic          =   False
      Left            =   20
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      RequiresSelection=   False
      RowSelectionType=   0
      Scope           =   0
      TabIndex        =   5
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   10
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   445
      _ScrollOffset   =   0
      _ScrollWidth    =   -1
   End
End
#tag EndWindow

#tag WindowCode
	#tag Method, Flags = &h0
		Function test_inserts(nbr_columns as integer, nbr_rows as integer) As double()
		  dim nbr_int_cols as integer
		  dim nbr_str_cols as integer
		  
		  dim int_values() as integer
		  dim str_values() as string
		  
		  nbr_int_cols = nbr_columns / 2
		  nbr_str_cols = nbr_columns - nbr_int_cols
		  
		  for i as integer = 0 to nbr_int_cols-1
		    int_values.Add(i*123)
		    
		  next
		  
		  
		  
		  dim tmp_str as string = "AZERTYUIOPQSDFGHJKLMWXCVBNAZERTYUIOPQSDFGHJKLMWXCVBNAZERTYUIOPQSDFGHJKLMWXCVBNAZERTYUIOPQSDFGHJKLMWXCVBN"
		  
		  
		  for i as integer = 0 to nbr_str_cols-1
		    str_values.Add(left(tmp_str, len(tmp_str) - i - i ))
		    
		    
		  next
		  
		  dim tstart as Double  = System.Microseconds
		  
		  // create the structure
		  
		  
		  dim int_col_list() as clIntegerDataSerie
		  dim str_col_list() as clDataSerie
		  
		  dim col_list() as clAbstractDataSerie
		  
		  for i as integer = 0 to nbr_int_cols-1
		    dim tmp as new clIntegerDataSerie("intcol" + str(i))
		    col_list.Add(tmp)
		    int_col_list.Add(tmp)
		  next
		  
		  
		  for i as integer = 0 to nbr_str_cols-1
		    dim tmp as new clDataSerie("strcol" + str(i))
		    col_list.Add(tmp)
		    str_col_list.Add(tmp)
		    
		  next
		  
		  dim tbl as new clDataTable("MYTABLE", col_list)
		  
		  dim tcreate as double = System.Microseconds
		  
		  
		  // load data
		  
		  for row as integer = 0 to nbr_rows
		    
		    for i as integer = 0 to nbr_int_cols-1
		      int_col_list(i).append_element(int_values(i))
		      
		    next
		    
		    
		    for i as integer = 0 to nbr_str_cols-1
		      str_col_list(i).append_element(str_values(i))
		    next
		    
		  next
		  
		  dim tload as double = System.Microseconds
		  
		  dim ret() as double
		  ret.Add tstart
		  ret.Add tcreate
		  ret.Add tload
		  
		  return ret
		  
		  
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub writemessage(Paramarray vprint as string)
		  Dim tmp As String
		  tmp = join(vprint, " ")
		  Listbox1.AddRow tmp
		  
		  
		End Sub
	#tag EndMethod


#tag EndWindowCode

#tag Events PushButton1
	#tag Event
		Sub Action()
		  
		  writemessage "Starting insert tests"
		  
		  dim ret() as double
		  
		  dim time_to_create as string
		  dim time_to_load as String
		  
		  
		  dim nbr_rows as integer = tf_rows.Text.ToInteger
		  dim nbr_cols as integer = tf_cols.Text.ToInteger
		  
		  if nbr_rows < 1 then nbr_rows = 1
		  nbr_rows = nbr_rows * 10000
		  
		  if nbr_cols < 1 then nbr_cols = 1
		  
		  
		  writemessage "Preparing " + str(nbr_rows) + " rows and " + str(nbr_cols) + " columns."
		  ret = test_inserts(nbr_cols, nbr_rows)
		  
		  time_to_create = "Time to create " + format(ret(1)  - ret(0),"0.0") + " microseconds"
		  
		  time_to_load = "Time to load " + format(ret(2)  - ret(1),"0.0") + " microseconds"
		  
		  writemessage time_to_create
		  writemessage time_to_load
		End Sub
	#tag EndEvent
#tag EndEvents
