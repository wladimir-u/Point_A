If MsgBox("Создать ярлыки к программе Kontrol-A?",4+32,"Создание ярлыков")<>6 Then
    WScript.Quit
End If
strPath = Wscript.ScriptFullName
Set objFSO = CreateObject("Scripting.FileSystemObject")
Set objFile = objFSO.GetFile(strPath)
strFolder = objFSO.GetParentFolderName(objFile)
set WshShell = CreateObject("WScript.Shell")


strOsBits = "\runtime\x32"
strShortcutName = "Kontrol-A.lnk"
strStartmenuName = "Kontrol-A"
strShortcutWorkingDir = strFolder & strOsBits
strShortcutTargetPath = strFolder & strOsBits & "\CrossMachine.exe"
bolEnableCustomIcon = true
strShortcutIconLocation = strFolder & "\alcotest.ico"
strShortcutArguments = "..\..\chpclnt.sm9"
strFonts = WshShell.SpecialFolders("Fonts") & "\"
strDesktopLocation = WshShell.SpecialFolders("Desktop") & "\"
strStartMenuLocation = WshShell.SpecialFolders("Programs") & "\"
'MsgBox  strFolder & " | " & strDesktopLocation & " | " & strStartMenuLocation
' *********************************************************************************
 
'Create a shortcut in Public Desktop
set oMyShortcut = WshShell.CreateShortcut(strDesktopLocation + strShortcutName)
oMyShortcut.TargetPath = strShortcutTargetPath
oMyShortcut.Arguments = strShortcutArguments
oMyShortcut.WorkingDirectory = strShortcutWorkingDir
if bolEnableCustomIcon = true Then
    oMyShortcut.IconLocation = strShortcutIconLocation
End if
oMyShortCut.Save
 
'Create a folder in the Start Menu (if it does not exist)
If  Not objFSO.FolderExists(strStartMenuLocation + strStartmenuName) Then
   newfolder = objFSO.CreateFolder (strStartMenuLocation + strStartmenuName)
End If
 
'Create a shortcut in Public Start Menu.
set oMyShortcut = WshShell.CreateShortcut(strStartMenuLocation + strStartmenuName + "\" + strShortcutName)
oMyShortcut.TargetPath = strShortcutTargetPath
oMyShortcut.Arguments = strShortcutArguments
oMyShortcut.WorkingDirectory = strShortcutWorkingDir
if bolEnableCustomIcon = true Then
    oMyShortcut.IconLocation = strShortcutIconLocation
End if
oMyShortCut.Save

set oMyShortcut = WshShell.CreateShortcut(strStartMenuLocation + strStartmenuName & "\Руководство по программному обеспечению АРМ «Контроль-А».lnk")
oMyShortcut.TargetPath = strFolder & "\Руководство по программному обеспечению АРМ «Контроль-А».pdf"
oMyShortCut.Save

'==================================================== FONTS
'Option Explicit
Dim objShell, objFSO, wshShell
Dim strFontSourcePath, objFolder, objFont, objNameSpace, objFile

Set objShell = CreateObject("Shell.Application")
Set wshShell = CreateObject("WScript.Shell")
Set objFSO = createobject("Scripting.Filesystemobject")

strFontSourcePath = Replace(WScript.ScriptFullName, WScript.ScriptName, "") & "Cuprum\"

If objFSO.FolderExists(strFontSourcePath) Then

	Set objNameSpace = objShell.Namespace(strFontSourcePath)
	Set objFolder = objFSO.getFolder(strFontSourcePath)
	
	For Each objFile In objFolder.files
		
		If LCase(right(objFile,4)) = ".ttf" OR LCase(right(objFile,4)) = ".otf" Then
			If objFSO.FileExists(wshShell.SpecialFolders("Fonts") & objFile.Name) = False Then
				Set objFont = objNameSpace.ParseName(objFile.Name)
				objFont.InvokeVerb("Install")
				
				Set objFont = Nothing
			End If
		End If
	Next
Else
	'Wscript.Echo "Font Source Path does not exists"
End If

MsgBox "Выполнено", 0+64, "Создание ярлыков"
