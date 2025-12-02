#tag Module
Protected Module mdLogManagerConstants
	#tag Note, Name = Description
		
		Support for message logging.
		
		Supports:
		- four levels of severity (Information, Warning, Error, Fatal error)
		- supports multiple log writer, a logwriter is expected to support the itfLogingWriter interface
		- add filter to enable/disable each level
		- add a limit counter for errors and warning
		- add support to measure execution time of different tasks
		- add support to track execution of methods
		
		
		The class provides a default clLoging instance and a default logWriter, sending the output to debuglog.
		
		The default logWriter can be enabled and disabled by calling EnableWriter() and DisableWriter() without parameters
		
	#tag EndNote

	#tag Note, Name = License
		MIT License
		
		sl-xj-lib-loger Library
		Copyright (c) 2021-2025 Serge Louvet
		
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


	#tag Constant, Name = cDefaultFormatExecutionTime, Type = String, Dynamic = False, Default = \"###\x2C###.000", Scope = Public
	#tag EndConstant

	#tag Constant, Name = cDefaultFormatNumberParam, Type = String, Dynamic = False, Default = \"-####0.000##", Scope = Public
	#tag EndConstant

	#tag Constant, Name = cstInternalSource, Type = String, Dynamic = False, Default = \"Internal", Scope = Public
	#tag EndConstant

	#tag Constant, Name = cstInternalWriterId, Type = String, Dynamic = False, Default = \"DEFAULT", Scope = Public
	#tag EndConstant

	#tag Constant, Name = cstMsgEndTask, Type = String, Dynamic = False, Default = \"Ending task %0 after %1 second(s).", Scope = Public
	#tag EndConstant

	#tag Constant, Name = cstMsgErrorMsgDisabled, Type = String, Dynamic = False, Default = \"Error messages disabled.", Scope = Public
	#tag EndConstant

	#tag Constant, Name = cstMsgMethodStats, Type = String, Dynamic = False, Default = \"Method %0 called %1 time(s)\x2C total execution time %2 second(s)\x2C average %3 second(s).", Scope = Public
	#tag EndConstant

	#tag Constant, Name = cstMsgReachedErrorLimit, Type = String, Dynamic = False, Default = \"Reached maximum number of errors (set to %0)", Scope = Public
	#tag EndConstant

	#tag Constant, Name = cstMsgResetErrorCounter, Type = String, Dynamic = False, Default = \"Reset error counter.", Scope = Public
	#tag EndConstant

	#tag Constant, Name = cstMsgResetWarningCounter, Type = String, Dynamic = False, Default = \"Reset warning counter.", Scope = Public
	#tag EndConstant

	#tag Constant, Name = cstMsgSetErrorLimit, Type = String, Dynamic = False, Default = \"Set error limit to %0.", Scope = Public
	#tag EndConstant

	#tag Constant, Name = cstMsgSetWarningLimit, Type = String, Dynamic = False, Default = \"Set warning limit to %0.", Scope = Public
	#tag EndConstant

	#tag Constant, Name = cstMsgStartTask, Type = String, Dynamic = False, Default = \"Starting task %0.", Scope = Public
	#tag EndConstant

	#tag Constant, Name = cstMsgStatusMessage, Type = String, Dynamic = False, Default = \"Found %0 warning(s)\x2C %1 error(s).", Scope = Public
	#tag EndConstant

	#tag Constant, Name = cstMsgTaskNotFound, Type = String, Dynamic = False, Default = \"Cannot find task %0\x2C called from %1.", Scope = Public
	#tag EndConstant

	#tag Constant, Name = cstMsgWarningMsgDisabled, Type = String, Dynamic = False, Default = \"Warning messages disabled.", Scope = Public
	#tag EndConstant

	#tag Constant, Name = cstMsgWriterAlreadyDefined, Type = String, Dynamic = False, Default = \"WriterId %0 already in use.", Scope = Public
	#tag EndConstant

	#tag Constant, Name = cstMsgWriterNotFound, Type = String, Dynamic = False, Default = \"WriterId %0 not found.", Scope = Public
	#tag EndConstant

	#tag Constant, Name = cstSeverityError, Type = String, Dynamic = False, Default = \"ERR", Scope = Public
	#tag EndConstant

	#tag Constant, Name = cstSeverityFatalError, Type = String, Dynamic = False, Default = \"FE", Scope = Public
	#tag EndConstant

	#tag Constant, Name = cstSeverityInformation, Type = String, Dynamic = False, Default = \"INF", Scope = Public
	#tag EndConstant

	#tag Constant, Name = cstSeverityMessage, Type = String, Dynamic = False, Default = \"MSG", Scope = Public
	#tag EndConstant

	#tag Constant, Name = cstSeverityStatistics, Type = String, Dynamic = False, Default = \"STS", Scope = Public
	#tag EndConstant

	#tag Constant, Name = cstSeverityWarning, Type = String, Dynamic = False, Default = \"WNG", Scope = Public
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
End Module
#tag EndModule
