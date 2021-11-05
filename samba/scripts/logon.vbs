On Error Resume Next
set objNetwork= CreateObject("WScript.Network")
objNetwork.MapNetworkDrive "P:", "\\ad\public"
objNetwork.MapNetworkDrive "N:", "\\ad\lixeiras"

strDom = objNetwork.UserDomain
strUser = objNetwork.UserName
Set objUser = GetObject("WinNT://" & strDom & "/" & strUser & ",user")

For Each objGroup In objUser.Groups
  Select Case ucase(objGroup.Name)
    Case "OWNER"
      objNetwork.RemoveNetworkDrive "G","true"
      objNetwork.MapNetworkDrive "G:","\\ad\owner","true"
	Case "SECURITY"
      objNetwork.RemoveNetworkDrive "I","true"
      objNetwork.MapNetworkDrive "I:","\\ad\security","true"
	Case "INFRASTRUCTURE"
      objNetwork.RemoveNetworkDrive "J","true"
      objNetwork.MapNetworkDrive "J:","\\ad\infra","true"
	Case "MANAGER"
      objNetwork.RemoveNetworkDrive "K","true"
      objNetwork.MapNetworkDrive "K:","\\ad\manager","true"
	Case "MARKETING"
      objNetwork.RemoveNetworkDrive "L","true"
      objNetwork.MapNetworkDrive "L:","\\ad\marketing","true"
	Case "DEVEL"
      objNetwork.RemoveNetworkDrive "N","true"
      objNetwork.MapNetworkDrive "N:","\\ad\devel","true"	
  End Select
Next	  
