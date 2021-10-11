object MainForm: TMainForm
  Left = 215
  Top = 123
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'StatUtils Demo'
  ClientHeight = 266
  ClientWidth = 362
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -14
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 120
  TextHeight = 16
  object InfoBox: TGroupBox
    Left = 128
    Top = 8
    Width = 225
    Height = 193
    Caption = ' List info '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -15
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    object MinLbl: TLabel
      Left = 10
      Top = 30
      Width = 63
      Height = 17
      Caption = 'Minimum:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object MaxLbl: TLabel
      Left = 10
      Top = 49
      Width = 67
      Height = 17
      Caption = 'Maximum:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object MoyLbl: TLabel
      Left = 10
      Top = 89
      Width = 57
      Height = 17
      Caption = 'Average:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object MedLbl: TLabel
      Left = 10
      Top = 108
      Width = 58
      Height = 17
      Caption = 'Mediane:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object RangeLbl: TLabel
      Left = 10
      Top = 69
      Width = 41
      Height = 17
      Caption = 'Scale:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object SigmaLbl: TLabel
      Left = 10
      Top = 128
      Width = 46
      Height = 17
      Caption = 'Sigma:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object FreqLbl: TLabel
      Left = 10
      Top = 167
      Width = 126
      Height = 17
      Caption = 'Element frequency:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Bevel1: TBevel
      Left = 10
      Top = 158
      Width = 208
      Height = 2
    end
  end
  object ListBox: TGroupBox
    Left = 8
    Top = 8
    Width = 113
    Height = 193
    Caption = ' List '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -15
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    object List: TListBox
      Left = 10
      Top = 24
      Width = 95
      Height = 116
      Style = lbOwnerDrawFixed
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -15
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      IntegralHeight = True
      ItemHeight = 16
      ParentFont = False
      PopupMenu = ListOptionsPopup
      TabOrder = 0
      OnClick = ListClick
      OnDrawItem = ListDrawItem
    end
    object ListOptionsBtn: TButton
      Left = 10
      Top = 152
      Width = 95
      Height = 25
      Caption = 'Options ...'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnClick = ListOptionsBtnClick
    end
  end
  object QuitBtn: TButton
    Left = 10
    Top = 232
    Width = 343
    Height = 25
    Caption = 'Exit'
    TabOrder = 2
    OnClick = QuitBtnClick
  end
  object FloatingChk: TCheckBox
    Left = 8
    Top = 208
    Width = 345
    Height = 17
    Caption = 'Chiffres a virgule inclus dans la creation de la liste'
    Checked = True
    State = cbChecked
    TabOrder = 3
  end
  object ListOptionsPopup: TPopupMenu
    Left = 24
    Top = 40
    object NewListBtn: TMenuItem
      Caption = 'Nouvelle liste'
      OnClick = NewListBtnClick
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object SortBtn: TMenuItem
      Caption = 'Trier'
      OnClick = SortBtnClick
    end
    object AddBtn: TMenuItem
      Tag = 1
      Caption = 'Ajouter x a chaque element'
      OnClick = AlgebricBtns
    end
    object SubBtn: TMenuItem
      Tag = 2
      Caption = 'Retrancher x a chaque element'
      OnClick = AlgebricBtns
    end
    object MulBtn: TMenuItem
      Tag = 3
      Caption = 'Multiplier chaque element par x'
      OnClick = AlgebricBtns
    end
    object DivBtn: TMenuItem
      Tag = 4
      Caption = 'Diviser chaque element par x'
      OnClick = AlgebricBtns
    end
  end
end
