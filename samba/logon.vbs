On Error Resume Next
set objNetwork= CreateObject("WScript.Network")
objNetwork.MapNetworkDrive "P:", "\\asf\public"
objNetwork.MapNetworkDrive "L:", "\\asf\lixeiras"

strDom = objNetwork.UserDomain
strUser = objNetwork.UserName
Set objUser = GetObject("WinNT://" & strDom & "/" & strUser & ",user")

For Each objGroup In objUser.Groups
  Select Case ucase(objGroup.Name)
    Case "OWNER"
      objNetwork.RemoveNetworkDrive "G","true"
      objNetwork.MapNetworkDrive "G:","\\asf\owner","true"
	Case "PUBLIC"
      objNetwork.RemoveNetworkDrive "M","true"
      objNetwork.MapNetworkDrive "M:","\\asf\public","true"
	Case "SECURITY"
      objNetwork.RemoveNetworkDrive "I","true"
      objNetwork.MapNetworkDrive "I:","\\asf\security","true"
	Case "INFRASTRUCTURE"
      objNetwork.RemoveNetworkDrive "J","true"
      objNetwork.MapNetworkDrive "J:","\\asf\infrastructure","true"
	Case "MANAGER"
      objNetwork.RemoveNetworkDrive "K","true"
      objNetwork.MapNetworkDrive "K:","\\asf\manager","true"
	Case "MARKETING"
      objNetwork.RemoveNetworkDrive "L","true"
      objNetwork.MapNetworkDrive "L:","\\asf\marketing","true"
  End Select
Next	  
