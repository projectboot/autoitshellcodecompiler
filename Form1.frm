VERSION 5.00
Begin VB.Form Form1 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "ShellCode Encryptor & Compiler"
   ClientHeight    =   9345
   ClientLeft      =   45
   ClientTop       =   390
   ClientWidth     =   8700
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   9345
   ScaleWidth      =   8700
   StartUpPosition =   3  'Windows Default
   Begin VB.CheckBox Check2 
      Caption         =   "Use UPX"
      Height          =   255
      Left            =   2280
      TabIndex        =   11
      Top             =   4080
      Width           =   1455
   End
   Begin VB.Frame Frame2 
      Caption         =   "Shellcode Arch"
      Height          =   735
      Left            =   120
      TabIndex        =   8
      Top             =   3720
      Width           =   2055
      Begin VB.OptionButton Option2 
         Caption         =   "x64"
         Enabled         =   0   'False
         Height          =   255
         Left            =   1080
         TabIndex        =   10
         Top             =   360
         Width           =   615
      End
      Begin VB.OptionButton Option1 
         Caption         =   "x86"
         Height          =   195
         Left            =   120
         TabIndex        =   9
         Top             =   360
         Value           =   -1  'True
         Width           =   735
      End
   End
   Begin VB.TextBox Text4 
      Height          =   1575
      Left            =   9480
      Locked          =   -1  'True
      MultiLine       =   -1  'True
      ScrollBars      =   2  'Vertical
      TabIndex        =   7
      Text            =   "Form1.frx":0000
      Top             =   720
      Width           =   2535
   End
   Begin VB.CheckBox Check1 
      Caption         =   "Auto Build (exe)"
      Height          =   195
      Left            =   2280
      TabIndex        =   6
      Top             =   3840
      Value           =   1  'Checked
      Width           =   1575
   End
   Begin VB.TextBox Text3 
      Appearance      =   0  'Flat
      Height          =   285
      Left            =   6960
      TabIndex        =   5
      Text            =   "Pass"
      Top             =   3200
      Width           =   1575
   End
   Begin VB.TextBox Text2 
      Appearance      =   0  'Flat
      Height          =   4695
      Left            =   120
      MultiLine       =   -1  'True
      ScrollBars      =   2  'Vertical
      TabIndex        =   3
      Top             =   4560
      Width           =   8415
   End
   Begin VB.CommandButton Command1 
      Caption         =   "Generate && Build"
      Height          =   495
      Left            =   120
      TabIndex        =   2
      Top             =   3120
      Width           =   2055
   End
   Begin VB.Frame Frame1 
      Caption         =   "Shellcode"
      Height          =   2895
      Left            =   120
      TabIndex        =   0
      Top             =   120
      Width           =   8535
      Begin VB.TextBox Text1 
         Appearance      =   0  'Flat
         Height          =   2535
         Left            =   120
         MultiLine       =   -1  'True
         ScrollBars      =   2  'Vertical
         TabIndex        =   1
         Top             =   240
         Width           =   8295
      End
   End
   Begin VB.Label Label2 
      BackColor       =   &H8000000D&
      BackStyle       =   0  'Transparent
      Caption         =   "www.tolgasezer.com.tr"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   13.5
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00C00000&
      Height          =   495
      Left            =   5280
      TabIndex        =   12
      Top             =   4080
      Width           =   3855
   End
   Begin VB.Label Label1 
      BackStyle       =   0  'Transparent
      Caption         =   "Encrypt Password:"
      Height          =   375
      Left            =   5520
      TabIndex        =   4
      Top             =   3240
      Width           =   1935
   End
End
Attribute VB_Name = "Form1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub Command1_Click()
On Error Resume Next
Kill App.Path & "\tmp.tmp"
Kill App.Path & "\build.exe"
Kill App.Path & "\build_x64.exe"
Text2.Text = Replace(Replace(Text4.Text, "<shellcode>", StringToHex(XORCipher(Text1.Text, Text3.Text))), "<pass>", Text3.Text)
Open App.Path & "\tmp.tmp" For Binary As #1
Put #1, , Text2.Text
Close #1


If Check1.Value = 1 Then
    If Option1.Value = True Then
        If Check2.Value = 1 Then
        Shell Chr(34) & App.Path & "\Files\x86.exe" & Chr(34) & " /in " & Chr(34) & App.Path & "\tmp.tmp" & Chr(34) & " /out " & Chr(34) & App.Path & "\build.exe" & Chr(34) & " /comp 4 /pack", vbHide
        End If
        If Check2.Value = 0 Then
        Shell Chr(34) & App.Path & "\Files\x86.exe" & Chr(34) & " /in " & Chr(34) & App.Path & "\tmp.tmp" & Chr(34) & " /out " & Chr(34) & App.Path & "\build.exe" & Chr(34) & " /comp 4", vbHide
        End If
    MsgBox "Done!" & vbCrLf & vbCrLf & "Check file from: " & Chr(34) & App.Path & "\build.exe" & Chr(34)
    End If
    If Option2.Value = True Then
        If Check2.Value = 1 Then
        Shell Chr(34) & App.Path & "\Files\x64.exe" & Chr(34) & " /in " & Chr(34) & App.Path & "\tmp.tmp" & Chr(34) & " /out " & Chr(34) & App.Path & "\build_x64.exe" & Chr(34) & " /comp 4 /pack", vbHide
        End If
        If Check2.Value = 0 Then
        Shell Chr(34) & App.Path & "\Files\x64.exe" & Chr(34) & " /in " & Chr(34) & App.Path & "\tmp.tmp" & Chr(34) & " /out " & Chr(34) & App.Path & "\build_x64.exe" & Chr(34) & " /comp 4", vbHide
        End If
        MsgBox "Done!" & vbCrLf & vbCrLf & "Check file from: " & Chr(34) & App.Path & "\build_x64.exe" & Chr(34)
    End If
End If

Kill App.Path & "\tmp.tmp"
End Sub

Function XORCipher(ByVal sData As String, ByVal sKey As String) As String
    Dim sResult As String
    Dim iKeyLen As Integer
    Dim i As Integer
    Dim c As String
    Dim k As String

    sResult = ""
    iKeyLen = Len(sKey)

    For i = 1 To Len(sData)
        c = Mid(sData, i, 1)
        k = Mid(sKey, ((i - 1) Mod iKeyLen) + 1, 1)
        sResult = sResult & Chr(Asc(c) Xor Asc(k))
    Next i

    XORCipher = sResult
End Function
Function StringToHex(ByVal sData As String) As String
    Dim i As Integer
    Dim sHex As String
    sHex = ""

    For i = 1 To Len(sData)
        sHex = sHex & Right$("0" & Hex(Asc(Mid$(sData, i, 1))), 2)
    Next i

    StringToHex = sHex
End Function

