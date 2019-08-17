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
    Left = 8
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
    object Label1: TLabel
      Left = 3
      Top = 88
      Width = 65
      Height = 28
      Alignment = taRightJustify
      Caption = 'Duration Token:'
      WordWrap = True
    end
    object EDTKey: TEdit
      Left = 80
      Top = 45
      Width = 233
      Height = 22
      TabOrder = 0
    end
    object Edit1: TEdit
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
  end
  object GBValidator: TGroupBox
    Left = 348
    Top = 8
    Width = 329
    Height = 289
    Caption = ' Validator '
    TabOrder = 1
  end
end
