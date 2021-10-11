object Form1: TForm1
  Left = 224
  Top = 158
  HelpContext = 2
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Simplex'
  ClientHeight = 428
  ClientWidth = 745
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  ShowHint = True
  OnCreate = FormCreate
  OnDblClick = FormDblClick
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object l1: TLabel
    Left = 24
    Top = 400
    Width = 149
    Height = 13
    Caption = #1054#1073#1097#1077#1077' '#1082#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1080#1090#1077#1088#1072#1094#1080#1081':'
    OnClick = l1Click
  end
  object l2: TLabel
    Left = 184
    Top = 400
    Width = 6
    Height = 13
    Caption = '0'
  end
  object Label4: TLabel
    Left = 257
    Top = 400
    Width = 71
    Height = 13
    Caption = #1058#1080#1087#1099' '#1089#1090#1072#1085#1082#1086#1074
  end
  object Label5: TLabel
    Left = 385
    Top = 400
    Width = 65
    Height = 13
    Caption = #1042#1080#1076#1099' '#1090#1082#1072#1085#1077#1081
  end
  object sg1: TStringGrid
    Left = 8
    Top = 203
    Width = 489
    Height = 182
    Hint = 
      #1042#1074#1086#1076#1080#1090#1077' '#1089#1074#1086#1080' '#1076#1072#1085#1085#1099#1077'. '#1052#1086#1078#1085#1086' '#1087#1088#1086#1089#1090#1086' '#1087#1077#1088#1077#1090#1072#1097#1080#1090#1100' '#1085#1091#1078#1085#1099#1081' '#1092#1072#1081#1083'  '#1074' '#1086#1082#1085#1086 +
      ' '#1087#1088#1086#1075#1088#1072#1084#1084#1099'!'
    ColCount = 8
    DefaultColWidth = 35
    DefaultRowHeight = 20
    FixedCols = 0
    RowCount = 6
    FixedRows = 0
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing]
    TabOrder = 0
    OnKeyPress = sg1KeyPress
  end
  object Button1: TButton
    Left = 512
    Top = 394
    Width = 226
    Height = 25
    Hint = #1055#1086#1082#1080#1085#1091#1090#1100' '#1087#1088#1086#1075#1088#1072#1084#1084#1091
    Caption = #1042#1099#1093#1086#1076
    TabOrder = 1
    OnClick = Button1Click
  end
  object stb: TButton
    Left = 512
    Top = 298
    Width = 226
    Height = 25
    Hint = #1056#1077#1096#1080#1090#1100' '#1079#1072#1076#1072#1095#1091
    Caption = #1055#1088#1086#1089#1090#1086' '#1088#1077#1096#1080#1090#1100
    TabOrder = 2
    OnClick = stbClick
  end
  object sg2: TStringGrid
    Left = 8
    Top = 432
    Width = 489
    Height = 182
    ColCount = 8
    DefaultColWidth = 35
    DefaultRowHeight = 20
    FixedCols = 0
    RowCount = 6
    FixedRows = 0
    PopupMenu = PopupMenu1
    TabOrder = 3
    Visible = False
  end
  object Edit1: TEdit
    Left = 465
    Top = 396
    Width = 33
    Height = 21
    Hint = #1059#1082#1072#1078#1080#1090#1077' '#1088#1072#1079#1084#1077#1088#1099' '#1089#1080#1084#1087#1083#1077#1082#1089'-'#1090#1072#1073#1083#1080#1094#1099
    TabOrder = 4
    Text = '3'
    OnKeyPress = Edit1KeyPress
  end
  object Edit2: TEdit
    Left = 337
    Top = 396
    Width = 33
    Height = 21
    Hint = #1059#1082#1072#1078#1080#1090#1077' '#1088#1072#1079#1084#1077#1088#1099' '#1089#1080#1084#1087#1083#1077#1082#1089'-'#1090#1072#1073#1083#1080#1094#1099
    TabOrder = 5
    Text = '2'
    OnKeyPress = Edit1KeyPress
  end
  object Button3: TButton
    Left = 512
    Top = 266
    Width = 226
    Height = 25
    Hint = #1056#1077#1096#1080#1090#1100' '#1079#1072#1076#1072#1095#1091' '#1074' '#1087#1086#1096#1072#1075#1086#1074#1086#1084' '#1088#1077#1078#1080#1084#1077
    Caption = #1055#1086#1096#1072#1075#1086#1074#1099#1081
    TabOrder = 6
    OnClick = Button3Click
  end
  object Button5: TButton
    Left = 512
    Top = 234
    Width = 226
    Height = 25
    Hint = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1076#1072#1085#1085#1099#1077' '#1074' '#1092#1072#1081#1083
    Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
    TabOrder = 7
    OnClick = Button5Click
  end
  object fn: TEdit
    Left = 512
    Top = 204
    Width = 226
    Height = 21
    Hint = #1059#1082#1072#1078#1080#1090#1077' '#1080#1084#1103' '#1092#1072#1081#1083#1072' '#1076#1083#1103' '#1089#1086#1093#1088#1072#1085#1077#1085#1080#1103
    TabOrder = 8
    Text = #1059#1082#1072#1078#1080#1090#1077' '#1080#1084#1103' '#1092#1072#1081#1083#1072' '#1076#1083#1103' '#1089#1086#1093#1088#1072#1085#1077#1085#1080#1103
    OnClick = fnClick
    OnKeyPress = fnKeyPress
  end
  object Memo1: TMemo
    Left = 8
    Top = 8
    Width = 729
    Height = 185
    Hint = #1047#1076#1077#1089#1100' '#1082#1086#1084#1084#1077#1085#1090#1080#1088#1091#1077#1090#1089#1103' '#1088#1077#1096#1077#1085#1080#1077' '#1079#1072#1076#1072#1095#1080
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Lines.Strings = (
      '')
    ParentFont = False
    PopupMenu = PopupMenu2
    ReadOnly = True
    ScrollBars = ssBoth
    TabOrder = 9
  end
  object Button2: TButton
    Left = 512
    Top = 330
    Width = 226
    Height = 25
    Hint = #1055#1086#1083#1091#1095#1080#1090#1100' '#1089#1087#1088#1072#1074#1086#1095#1085#1091#1102' '#1080#1085#1092#1086#1088#1084#1072#1094#1080#1102
    Caption = #1042#1099#1079#1074#1072#1090#1100' '#1089#1087#1088#1072#1074#1082#1091
    TabOrder = 10
    OnClick = Button2Click
  end
  object Button4: TButton
    Left = 512
    Top = 362
    Width = 226
    Height = 25
    Hint = #1055#1086#1083#1091#1095#1080#1090#1100' '#1076#1086#1087#1086#1083#1085#1080#1090#1077#1083#1100#1085#1091#1102' '#1080#1085#1092#1086#1088#1084#1072#1094#1080#1102' '#1086' '#1087#1088#1086#1075#1088#1072#1084#1084#1077
    Caption = #1054' '#1087#1088#1086#1075#1088#1072#1084#1084#1077
    TabOrder = 11
    OnClick = Button4Click
  end
  object StringGrid1: TStringGrid
    Left = 176
    Top = 240
    Width = 320
    Height = 120
    TabOrder = 12
    Visible = False
    OnDrawCell = StringGrid1DrawCell
  end
  object sSkinManager1: TsSkinManager
    Active = False
    InternalSkins = <>
    MenuSupport.IcoLineSkin = 'ICOLINE'
    MenuSupport.ExtraLineFont.Charset = DEFAULT_CHARSET
    MenuSupport.ExtraLineFont.Color = clWindowText
    MenuSupport.ExtraLineFont.Height = -11
    MenuSupport.ExtraLineFont.Name = 'MS Sans Serif'
    MenuSupport.ExtraLineFont.Style = []
    SkinDirectory = 'c:\Skins'
    SkinInfo = 'N/A'
    ThirdParty.ThirdEdits = 
      'TEdit'#13#10'TMemo'#13#10'TMaskEdit'#13#10'TLabeledEdit'#13#10'THotKey'#13#10'TListBox'#13#10'TCheck' +
      'ListBox'#13#10'TDBListBox'#13#10'TRichEdit'#13#10'TDBMemo'#13#10'TSynEdit'#13#10'TSynMemo'#13#10'TDB' +
      'SynEdit'#13#10'TDBLookupListBox'#13#10'TDBRichEdit'#13#10'TDBCtrlGrid'#13#10'TDateTimePi' +
      'cker'#13#10'TDBEdit'
    ThirdParty.ThirdButtons = 'TButton'
    ThirdParty.ThirdBitBtns = 'TBitBtn'
    ThirdParty.ThirdCheckBoxes = 
      'TCheckBox'#13#10'TRadioButton'#13#10'TDBCheckBox'#13#10'TDBCheckBoxEh'#13#10'TGroupButto' +
      'n'
    ThirdParty.ThirdGroupBoxes = 'TGroupBox'#13#10'TDBRadioGroup'#13#10'TRadioGroup'
    ThirdParty.ThirdListViews = 'TListView'
    ThirdParty.ThirdPanels = 'TPanel'#13#10'TDBCtrlPanel'
    ThirdParty.ThirdGrids = 
      'TStringGrid'#13#10'TDrawGrid'#13#10'TRichView'#13#10'TDBRichViewEdit'#13#10'TRichViewEdi' +
      't'#13#10'TDBRichView'#13#10'TwwDBGrid'#13#10'TAdvStringGrid'#13#10'TDBAdvGrid'#13#10'TValueLis' +
      'tEditor'#13#10'TDBGrid'
    ThirdParty.ThirdTreeViews = 'TTreeView'#13#10'TRzTreeView'#13#10'TDBTreeView'
    ThirdParty.ThirdComboBoxes = 'TComboBox'#13#10'TColorBox'#13#10'TDBComboBox'
    ThirdParty.ThirdWWEdits = 
      'TDBLookupComboBox'#13#10'TwwDBComboBox'#13#10'TwwDBCustomCombo'#13#10'TwwDBCustomL' +
      'ookupCombo'
    ThirdParty.ThirdVirtualTrees = 
      'TVirtualStringTree'#13#10'TVirtualStringTreeDB'#13#10'TEasyListview'#13#10'TVirtua' +
      'lExplorerListview'#13#10'TVirtualExplorerTreeview'#13#10'TVirtualExplorerTre' +
      'e'#13#10'TVirtualDrawTree'
    ThirdParty.ThirdGridEh = 'TDBGridEh'
    Left = 8
    Top = 240
  end
  object PopupMenu1: TPopupMenu
    Left = 40
    Top = 240
    object N1: TMenuItem
      Caption = #1057#1082#1088#1099#1090#1100
      OnClick = N1Click
    end
  end
  object sHintManager1: TsHintManager
    HintKind.Style = hsBalloon
    HintKind.Radius = 13
    HintKind.ExOffset = 13
    HintKind.Bevel = 1
    HintKind.Color = 12778748
    HintKind.ColorBorderTop = 4227200
    HintKind.ColorBorderBottom = 4227200
    HintKind.Transparency = 10
    HintKind.ShadowBlur = 6
    HintKind.ShadowEnabled = True
    HintKind.ShadowOffset = 8
    HintKind.ShadowTransparency = 70
    HintKind.MarginH = 6
    HintKind.MarginV = 6
    HintKind.MaxWidth = 240
    HintKind.Font.Charset = DEFAULT_CHARSET
    HintKind.Font.Color = clBlack
    HintKind.Font.Height = -11
    HintKind.Font.Name = 'Tahoma'
    HintKind.Font.Style = []
    HTMLMode = True
    SkinSection = 'HINT'
    Left = 72
    Top = 240
  end
  object PopupMenu2: TPopupMenu
    Left = 104
    Top = 240
  end
end
