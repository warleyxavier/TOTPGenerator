object Form1: TForm1
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'TOTPGenerator - By Warley Xavier'
  ClientHeight = 310
  ClientWidth = 685
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Verdana'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 14
  object GBGenerator: TGroupBox
    Left = 7
    Top = 8
    Width = 329
    Height = 289
    Caption = ' Generator '
    TabOrder = 0
    object LBSecretKey: TLabel
      Left = 40
      Top = 48
      Width = 28
      Height = 14
      Caption = 'Key:'
    end
    object LBDurationToken: TLabel
      Left = 10
      Top = 88
      Width = 58
      Height = 28
      Alignment = taRightJustify
      Caption = 'Duration Token:'
      FocusControl = EDTDurationToken
      WordWrap = True
    end
    object EDTKey: TEdit
      Left = 80
      Top = 45
      Width = 233
      Height = 22
      TabOrder = 0
    end
    object EDTDurationToken: TEdit
      Left = 80
      Top = 90
      Width = 233
      Height = 22
      NumbersOnly = True
      TabOrder = 1
    end
    object BTNGenerate: TButton
      Left = 80
      Top = 136
      Width = 169
      Height = 33
      Caption = 'GENERATE'
      TabOrder = 2
      OnClick = BTNGenerateClick
    end
    object PNResult: TPanel
      Left = -29
      Top = 200
      Width = 390
      Height = 41
      ParentCustomHint = False
      BiDiMode = bdLeftToRight
      Color = clSilver
      Ctl3D = True
      DoubleBuffered = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentBiDiMode = False
      ParentBackground = False
      ParentCtl3D = False
      ParentDoubleBuffered = False
      ParentFont = False
      ParentShowHint = False
      ShowHint = False
      TabOrder = 3
    end
    object CBAutoGeneration: TCheckBox
      Left = 80
      Top = 22
      Width = 169
      Height = 17
      Caption = 'Enable Auto Generation'
      TabOrder = 4
      OnClick = CBAutoGenerationClick
    end
  end
  object GBValidator: TGroupBox
    Left = 347
    Top = 8
    Width = 329
    Height = 289
    Caption = ' Validator '
    TabOrder = 1
    object LBKeyValidate: TLabel
      Left = 45
      Top = 23
      Width = 28
      Height = 14
      Caption = 'Key:'
    end
    object LBToken: TLabel
      Left = 30
      Top = 68
      Width = 43
      Height = 14
      Alignment = taRightJustify
      Caption = 'Token:'
      WordWrap = True
    end
    object Label1: TLabel
      Left = 9
      Top = 107
      Width = 58
      Height = 28
      Alignment = taRightJustify
      Caption = 'Duration Token:'
      FocusControl = EDTDurationTimeValidation
      WordWrap = True
    end
    object EDTKeyValidate: TEdit
      Left = 79
      Top = 20
      Width = 233
      Height = 22
      TabOrder = 0
    end
    object EDTToken: TEdit
      Left = 79
      Top = 65
      Width = 233
      Height = 22
      TabOrder = 1
    end
    object BTNValidate: TButton
      Left = 79
      Top = 144
      Width = 169
      Height = 33
      Caption = 'VALIDATE'
      TabOrder = 2
      OnClick = BTNValidateClick
    end
    object PNResultValidation: TPanel
      Left = -21
      Top = 200
      Width = 398
      Height = 41
      ParentCustomHint = False
      BiDiMode = bdLeftToRight
      Color = clSilver
      Ctl3D = True
      DoubleBuffered = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentBiDiMode = False
      ParentBackground = False
      ParentCtl3D = False
      ParentDoubleBuffered = False
      ParentFont = False
      ParentShowHint = False
      ShowHint = False
      TabOrder = 3
    end
    object EDTDurationTimeValidation: TEdit
      Left = 79
      Top = 109
      Width = 233
      Height = 22
      NumbersOnly = True
      TabOrder = 4
    end
  end
  object TMAutoGeneration: TTimer
    Enabled = False
    OnTimer = TMAutoGenerationTimer
    Left = 32
    Top = 24
  end
end
