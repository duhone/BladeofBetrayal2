object Form1: TForm1
  Left = 667
  Top = 221
  Width = 1015
  Height = 749
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -14
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  OnClose = onClose
  PixelsPerInch = 120
  TextHeight = 16
  object Splitter1: TSplitter
    Left = 0
    Top = 540
    Width = 1007
    Height = 11
    Cursor = crVSplit
    Align = alBottom
    Beveled = True
    Constraints.MaxHeight = 200
  end
  object Splitter2: TSplitter
    Left = 80
    Top = 0
    Width = 12
    Height = 540
    Cursor = crHSplit
    Beveled = True
  end
  object TabSheet: TPageControl
    Left = 92
    Top = 0
    Width = 915
    Height = 540
    ActivePage = HFF
    Align = alClient
    ParentShowHint = False
    ShowHint = True
    Style = tsFlatButtons
    TabOrder = 0
    Visible = False
    object HGF: TTabSheet
      Caption = 'HGF'
      object Label1: TLabel
        Left = 866
        Top = 10
        Width = 93
        Height = 25
        Caption = 'HGF Files:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -20
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Frame_Rate: TLabel
        Left = 158
        Top = 345
        Width = 87
        Height = 20
        Caption = 'Frame Rate'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -18
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label2: TLabel
        Left = 148
        Top = 305
        Width = 95
        Height = 20
        Caption = 'Frames / Set'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -18
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object FrameSets: TLabel
        Left = 158
        Top = 266
        Width = 86
        Height = 20
        Caption = 'Frame Sets'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -18
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object textHeight: TLabel
        Left = 138
        Top = 207
        Width = 101
        Height = 20
        Caption = 'Frame Height'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -18
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object textWidth: TLabel
        Left = 148
        Top = 177
        Width = 95
        Height = 20
        Caption = 'Frame Width'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -18
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label5: TLabel
        Left = 148
        Top = 108
        Width = 92
        Height = 16
        Caption = 'Image Location'
      end
      object Label4: TLabel
        Left = 167
        Top = 69
        Width = 68
        Height = 16
        Caption = 'Description'
      end
      object R: TLabel
        Left = 414
        Top = 177
        Width = 12
        Height = 20
        Caption = 'R'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -18
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object G: TLabel
        Left = 414
        Top = 207
        Width = 13
        Height = 20
        Caption = 'G'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -18
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object B: TLabel
        Left = 414
        Top = 236
        Width = 12
        Height = 20
        Caption = 'B'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -18
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label3: TLabel
        Left = 443
        Top = 158
        Width = 134
        Height = 20
        Hint = 'Color Key Transparency in RGB value'
        Caption = 'Transparency Key'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -18
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
      end
      object Label6: TLabel
        Left = 404
        Top = 315
        Width = 197
        Height = 16
        Caption = 'example: (frames  in set 1, 2,3,4,5)'
      end
      object Label7: TLabel
        Left = 286
        Top = 650
        Width = 194
        Height = 25
        Caption = 'HGF Location / Name:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -20
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object framerate: TEdit
        Left = 246
        Top = 345
        Width = 149
        Height = 24
        Hint = 'Frame Rate'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 13
      end
      object HGFImages: TComboBox
        Left = 414
        Top = 0
        Width = 385
        Height = 21
        Hint = 'Images belonging to the current HGF'
        ItemHeight = 0
        ParentShowHint = False
        ShowHint = True
        TabOrder = 2
        Text = 'Current Images'
        OnChange = HGFImagesChange
      end
      object DescriptionEdit: TEdit
        Left = 246
        Top = 69
        Width = 346
        Height = 24
        Hint = 'Description of Image -- shows up in the image drop down box'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 6
      end
      object ImageLocEdit: TEdit
        Left = 246
        Top = 108
        Width = 444
        Height = 24
        Hint = 'Full path location of the image'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 7
      end
      object imagelocbut: TButton
        Left = 699
        Top = 108
        Width = 90
        Height = 31
        Caption = 'Browse'
        TabOrder = 8
        OnClick = imagelocbutClick
      end
      object red: TEdit
        Left = 433
        Top = 177
        Width = 149
        Height = 24
        TabOrder = 15
      end
      object green: TEdit
        Left = 433
        Top = 207
        Width = 149
        Height = 24
        TabOrder = 16
      end
      object blue: TEdit
        Left = 433
        Top = 236
        Width = 149
        Height = 24
        TabOrder = 17
      end
      object frameset: TEdit
        Left = 246
        Top = 266
        Width = 149
        Height = 24
        Hint = '# of frame sets'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 11
      end
      object framesperset: TEdit
        Left = 246
        Top = 305
        Width = 149
        Height = 24
        Hint = 'Frames in EACH frame set -- seperated by commas'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 12
      end
      object autoanimate: TCheckBox
        Left = 246
        Top = 374
        Width = 149
        Height = 31
        Caption = 'Auto Animate'
        TabOrder = 14
      end
      object applysettingsbut: TButton
        Left = 364
        Top = 423
        Width = 120
        Height = 31
        Hint = 'Apply above settings to the current image'
        Caption = 'Apply Settings'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 18
        OnClick = applysettingsbutClick
      end
      object height: TEdit
        Left = 246
        Top = 207
        Width = 149
        Height = 24
        Hint = 'Height of a single frame'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 10
      end
      object width: TEdit
        Left = 246
        Top = 177
        Width = 149
        Height = 24
        Hint = 'Width of a single frame'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 9
      end
      object addimagebut: TButton
        Left = 0
        Top = 0
        Width = 119
        Height = 31
        Hint = 'Add Image to Current HGF'
        Caption = 'Add Image'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
        OnClick = addimagebutClick
      end
      object removeimagebut: TButton
        Left = 0
        Top = 30
        Width = 119
        Height = 30
        Hint = 'Remove Image From Current HGF'
        Caption = 'Remove Image'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 1
        OnClick = removeimagebutClick
      end
      object hgflocname: TEdit
        Left = 482
        Top = 650
        Width = 445
        Height = 24
        Hint = 'Location and name of the current HGF file'
        ReadOnly = True
        TabOrder = 4
      end
      object hgflocbut: TButton
        Left = 935
        Top = 650
        Width = 90
        Height = 31
        Caption = 'Browse'
        TabOrder = 5
        OnClick = hgflocbutClick
      end
      object HGFFiles: TListBox
        Left = 857
        Top = 39
        Width = 168
        Height = 376
        Hint = 'HGF files in current game project'
        ItemHeight = 13
        ParentShowHint = False
        ShowHint = True
        TabOrder = 3
        OnClick = HGFFilesClick
      end
      object palletentry: TEdit
        Left = 364
        Top = 0
        Width = 41
        Height = 24
        Hint = 'Pallet entry of the current image'
        ParentShowHint = False
        ReadOnly = True
        ShowHint = True
        TabOrder = 19
      end
    end
    object HLFHTF: TTabSheet
      Caption = 'HLF / HTF'
      ImageIndex = 1
      object Levels: TLabel
        Left = 837
        Top = -2
        Width = 63
        Height = 25
        Caption = 'Levels:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -20
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label20: TLabel
        Left = 138
        Top = 49
        Width = 59
        Height = 16
        Caption = 'Map Data'
      end
      object Label23: TLabel
        Left = 166
        Top = 428
        Width = 33
        Height = 16
        Caption = 'Level'
      end
      object LevelsList: TListBox
        Left = 817
        Top = 23
        Width = 189
        Height = 392
        ItemHeight = 13
        TabOrder = 0
        OnClick = LevelsListClick
      end
      object GroupBox1: TGroupBox
        Left = 79
        Top = 79
        Width = 737
        Height = 159
        Caption = 'Front Layer'
        TabOrder = 1
        object Label11: TLabel
          Left = 49
          Top = 43
          Width = 74
          Height = 16
          Caption = 'Tile'#39's Image'
        end
        object Label12: TLabel
          Left = 62
          Top = 81
          Width = 55
          Height = 16
          Alignment = taRightJustify
          Caption = 'Tile Data'
        end
        object Label21: TLabel
          Left = 30
          Top = 123
          Width = 95
          Height = 16
          Caption = 'Number of Tiles'
        end
        object fronttileimageedit: TEdit
          Left = 128
          Top = 39
          Width = 494
          Height = 24
          Enabled = False
          ReadOnly = True
          TabOrder = 0
        end
        object fronttiledataedit: TEdit
          Left = 128
          Top = 79
          Width = 494
          Height = 24
          Enabled = False
          ReadOnly = True
          TabOrder = 1
        end
        object fronttibut: TButton
          Left = 630
          Top = 37
          Width = 92
          Height = 31
          Caption = 'Browse'
          Enabled = False
          TabOrder = 2
          OnClick = fronttibutClick
        end
        object fronttdbut: TButton
          Left = 630
          Top = 76
          Width = 92
          Height = 31
          Caption = 'Browse'
          Enabled = False
          TabOrder = 3
          OnClick = fronttdbutClick
        end
        object frontlayernumbertiles: TEdit
          Left = 128
          Top = 118
          Width = 119
          Height = 24
          Enabled = False
          TabOrder = 4
        end
      end
      object GroupBox2: TGroupBox
        Left = 79
        Top = 246
        Width = 737
        Height = 169
        Caption = 'Scrolling Background'
        TabOrder = 2
        object Label16: TLabel
          Left = 62
          Top = 80
          Width = 55
          Height = 16
          Alignment = taRightJustify
          Caption = 'Tile Data'
        end
        object Label19: TLabel
          Left = 49
          Top = 42
          Width = 74
          Height = 16
          Caption = 'Tile'#39's Image'
        end
        object Label22: TLabel
          Left = 30
          Top = 123
          Width = 95
          Height = 16
          Caption = 'Number of Tiles'
        end
        object backtileimageedit: TEdit
          Left = 128
          Top = 39
          Width = 494
          Height = 24
          Enabled = False
          ReadOnly = True
          TabOrder = 0
        end
        object backtiledataedit: TEdit
          Left = 128
          Top = 79
          Width = 494
          Height = 24
          Enabled = False
          ReadOnly = True
          TabOrder = 1
        end
        object backtdbut: TButton
          Left = 630
          Top = 76
          Width = 92
          Height = 31
          Caption = 'Browse'
          Enabled = False
          TabOrder = 2
          OnClick = backtdbutClick
        end
        object backtibut: TButton
          Left = 630
          Top = 37
          Width = 92
          Height = 31
          Caption = 'Browse'
          Enabled = False
          TabOrder = 3
          OnClick = backtibutClick
        end
        object scrollinglayernumbertiles: TEdit
          Left = 128
          Top = 118
          Width = 119
          Height = 24
          Enabled = False
          TabOrder = 4
        end
      end
      object mapdataedit: TEdit
        Left = 207
        Top = 49
        Width = 493
        Height = 24
        Enabled = False
        ReadOnly = True
        TabOrder = 3
      end
      object mapdatabut: TButton
        Left = 709
        Top = 47
        Width = 92
        Height = 31
        Caption = 'Browse'
        Enabled = False
        TabOrder = 4
        OnClick = mapdatabutClick
      end
      object leveloutputedit: TEdit
        Left = 207
        Top = 423
        Width = 493
        Height = 24
        Enabled = False
        ReadOnly = True
        TabOrder = 5
      end
      object leveloutputbut: TButton
        Left = 709
        Top = 421
        Width = 92
        Height = 31
        Caption = 'Browse'
        Enabled = False
        TabOrder = 6
      end
    end
    object HSF: TTabSheet
      Caption = 'HSF'
      ImageIndex = 2
      object SoundFiles: TLabel
        Left = 866
        Top = 10
        Width = 92
        Height = 25
        Caption = 'HSF Files:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -20
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label8: TLabel
        Left = 148
        Top = 108
        Width = 93
        Height = 16
        Caption = 'Sound Location'
      end
      object Label9: TLabel
        Left = 167
        Top = 69
        Width = 68
        Height = 16
        Caption = 'Description'
      end
      object Label10: TLabel
        Left = 286
        Top = 650
        Width = 193
        Height = 25
        Caption = 'HSF Location / Name:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -20
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object HSFFiles: TListBox
        Left = 857
        Top = 39
        Width = 168
        Height = 376
        ItemHeight = 13
        TabOrder = 0
        OnClick = HSFFilesClick
      end
      object HSFSounds: TComboBox
        Left = 295
        Top = 0
        Width = 297
        Height = 21
        Hint = 'Sounds in current HSF'
        ItemHeight = 0
        TabOrder = 1
        Text = 'HSFSounds'
        OnChange = HSFSoundsChange
      end
      object SDescriptionEdit: TEdit
        Left = 246
        Top = 69
        Width = 346
        Height = 21
        Hint = 'Description / Name of the current sound'
        TabOrder = 2
      end
      object spalletnumber: TEdit
        Left = 246
        Top = 0
        Width = 41
        Height = 21
        Hint = 'Pallet entry of current sound'
        ReadOnly = True
        TabOrder = 3
      end
      object SoundLocEdit: TEdit
        Left = 246
        Top = 108
        Width = 444
        Height = 21
        Hint = 'Location of current sound'
        TabOrder = 4
      end
      object hsflocname: TEdit
        Left = 482
        Top = 650
        Width = 445
        Height = 21
        Hint = 'Location of current HSF file'
        ReadOnly = True
        TabOrder = 5
      end
      object addsoundbut: TButton
        Left = 0
        Top = 10
        Width = 119
        Height = 31
        Hint = 'Add sound to current HSF'
        Caption = 'Add Sound'
        TabOrder = 6
        OnClick = addsoundbutClick
      end
      object removesoundbut: TButton
        Left = 0
        Top = 39
        Width = 119
        Height = 31
        Hint = 'Remove sound from current HSF'
        Caption = 'Remove Sound'
        TabOrder = 7
        OnClick = removesoundbutClick
      end
      object sapplysettingbut: TButton
        Left = 246
        Top = 217
        Width = 129
        Height = 30
        Hint = 'Apply setting to current sound'
        Caption = 'Apply Settings'
        TabOrder = 8
        OnClick = sapplysettingbutClick
      end
      object hsflocbut: TButton
        Left = 935
        Top = 650
        Width = 90
        Height = 31
        Caption = 'Browse'
        TabOrder = 9
        OnClick = hsflocbutClick
      end
      object soundlocbut: TButton
        Left = 709
        Top = 108
        Width = 80
        Height = 31
        Caption = 'Browse'
        TabOrder = 10
        OnClick = soundlocbutClick
      end
    end
    object HFF: TTabSheet
      Caption = 'HFF'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ImageIndex = 3
      ParentFont = False
      object Label13: TLabel
        Left = 71
        Top = 148
        Width = 71
        Height = 30
        AutoSize = False
        Caption = 'RED'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -27
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label14: TLabel
        Left = 69
        Top = 187
        Width = 90
        Height = 31
        AutoSize = False
        Caption = 'GREEN'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -27
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label15: TLabel
        Left = 69
        Top = 226
        Width = 90
        Height = 31
        AutoSize = False
        Caption = 'BLUE'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -27
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label17: TLabel
        Left = 866
        Top = 10
        Width = 55
        Height = 25
        Caption = 'Fonts:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -20
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label18: TLabel
        Left = 286
        Top = 650
        Width = 191
        Height = 25
        Caption = 'HFF Location / Name:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -20
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object KeyRedEdit: TEdit
        Left = 187
        Top = 158
        Width = 159
        Height = 24
        TabOrder = 1
        Text = '0'
        OnChange = KeyRedEditChange
        OnClick = coloreditClick
        OnExit = KeyRedEditExit
      end
      object KeyGreenEdit: TEdit
        Left = 187
        Top = 197
        Width = 159
        Height = 24
        TabOrder = 2
        Text = '0'
        OnChange = KeyGreenEditChange
        OnClick = coloreditClick
        OnExit = KeyGreenEditExit
      end
      object KeyBlueEdit: TEdit
        Left = 187
        Top = 236
        Width = 159
        Height = 24
        TabOrder = 3
        Text = '0'
        OnChange = KeyBlueEditChange
        OnClick = coloreditClick
        OnExit = KeyBlueEditExit
      end
      object ColorRedEdit: TEdit
        Left = 404
        Top = 158
        Width = 149
        Height = 24
        TabOrder = 4
        Text = '0'
        OnChange = ColorRedEditChange
        OnClick = coloreditClick
        OnExit = ColorRedEditExit
      end
      object ColorGreenEdit: TEdit
        Left = 404
        Top = 197
        Width = 149
        Height = 24
        TabOrder = 5
        Text = '0'
        OnChange = ColorGreenEditChange
        OnClick = coloreditClick
        OnExit = ColorGreenEditExit
      end
      object ColorBlueEdit: TEdit
        Left = 404
        Top = 236
        Width = 149
        Height = 24
        TabOrder = 6
        Text = '0'
        OnChange = ColorBlueEditChange
        OnClick = coloreditClick
        OnExit = ColorBlueEditExit
      end
      object HFFFiles: TListBox
        Left = 857
        Top = 39
        Width = 168
        Height = 376
        ItemHeight = 16
        TabOrder = 7
        OnClick = HFFFilesClick
      end
      object hfflocedit: TEdit
        Left = 482
        Top = 650
        Width = 445
        Height = 24
        Hint = 'Location of current HFF'
        ReadOnly = True
        TabOrder = 8
      end
      object choosefontbut: TButton
        Left = 0
        Top = 0
        Width = 119
        Height = 31
        Hint = 'Change font settings for current HSF'
        Caption = 'Choose Font'
        TabOrder = 9
        OnClick = choosefontbutClick
      end
      object Button2: TButton
        Left = 0
        Top = 30
        Width = 119
        Height = 30
        Hint = 'Generate the font (must be done before saving HFF)'
        Caption = 'Create HPT Font'
        TabOrder = 0
        OnClick = Button2Click
      end
      object hfflocbut: TButton
        Left = 935
        Top = 650
        Width = 90
        Height = 31
        Caption = 'Browse'
        TabOrder = 10
        OnClick = hfflocbutClick
      end
      object backgroundcolorbut: TButton
        Left = 177
        Top = 108
        Width = 179
        Height = 41
        Caption = 'Background Color'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -18
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 11
        OnClick = backgroundcolorbutClick
      end
      object foregroundcolorbut: TBitBtn
        Left = 384
        Top = 108
        Width = 188
        Height = 41
        Caption = 'Foreground Color'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -18
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 12
        OnClick = foregroundcolorbutClick
      end
      object fringingcheckbox: TCheckBox
        Left = 601
        Top = 118
        Width = 21
        Height = 21
        TabOrder = 13
        OnClick = fringcolorcheckOnClick
      end
      object fringingcolorbut: TButton
        Left = 630
        Top = 108
        Width = 139
        Height = 41
        Caption = 'Fringing Color'
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -18
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 14
        OnClick = fringingcolorbutClick
      end
      object FringRedEdit: TEdit
        Left = 620
        Top = 158
        Width = 149
        Height = 24
        Enabled = False
        TabOrder = 15
        Text = '0'
      end
      object FringGreenEdit: TEdit
        Left = 620
        Top = 197
        Width = 149
        Height = 24
        Enabled = False
        TabOrder = 17
        Text = '0'
      end
      object FringBlueEdit: TEdit
        Left = 620
        Top = 236
        Width = 149
        Height = 24
        Enabled = False
        TabOrder = 16
        Text = '0'
      end
      inline fontscroll1: Tfontscroll
        Left = 10
        Top = 453
        Width = 1015
        Height = 129
        TabOrder = 18
        inherited Image1: TImage
          Left = 10
          Top = 10
          Width = 984
          Height = 118
          AutoSize = True
        end
      end
    end
  end
  object Messages: TListBox
    Left = 0
    Top = 551
    Width = 1007
    Height = 128
    Align = alBottom
    ItemHeight = 16
    TabOrder = 1
  end
  object TreeView1: TTreeView
    Left = 0
    Top = 0
    Width = 80
    Height = 540
    Align = alLeft
    Indent = 19
    TabOrder = 2
  end
  object MainMenu1: TMainMenu
    Left = 328
    Top = 448
    object MenuFile: TMenuItem
      Caption = 'File'
      object NewGame: TMenuItem
        Caption = 'New Game'
        OnClick = NewGameClick
      end
      object OpenGame: TMenuItem
        Caption = 'Open Game'
        OnClick = OpenGameClick
      end
      object SaveGame: TMenuItem
        Caption = 'Save Game'
        OnClick = SaveGameClick
      end
      object CloseGame: TMenuItem
        Caption = 'Close Game'
        OnClick = CloseGameClick
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object BuildProject1: TMenuItem
        Caption = 'Build Game'
        Hint = 'Creates all game files'
        OnClick = BuildProject1Click
      end
      object Options: TMenuItem
        Caption = 'Options...'
        OnClick = OptionsClick
      end
      object N2: TMenuItem
        Caption = '-'
      end
      object Exit: TMenuItem
        Caption = 'Exit'
        OnClick = ExitClick
      end
    end
    object MenuHGF: TMenuItem
      Caption = 'HGF'
      object NewHGF: TMenuItem
        Caption = 'New HGF'
        OnClick = NewHGFClick
      end
      object RemoveHGF: TMenuItem
        Caption = 'Remove HGF'
        OnClick = RemoveHGFClick
      end
      object SaveHGF: TMenuItem
        Caption = 'Save HGF'
        OnClick = SaveHGFClick
      end
      object SaveAllHGFS: TMenuItem
        Caption = 'Save All HGF'#39's'
        OnClick = SaveAllHGFSClick
      end
    end
    object MenuHLFHTF: TMenuItem
      Caption = 'H&LF / HTF'
      object CreateNewLevel: TMenuItem
        Caption = 'Create New Level'
        OnClick = CreateNewLevelClick
      end
      object RemoveLevel: TMenuItem
        Caption = 'Remove Level'
      end
      object SaveLevel: TMenuItem
        Caption = 'Save Level'
        OnClick = SaveLevelClick
      end
      object SaveAllLevels: TMenuItem
        Caption = 'Save All Level'#39's'
      end
    end
    object MenuHSF: TMenuItem
      Caption = 'HSF'
      object NewHSF: TMenuItem
        Caption = 'New HSF'
        OnClick = NewHSFClick
      end
      object RemoveHSF: TMenuItem
        Caption = 'Remove HSF'
        OnClick = RemoveHSFClick
      end
      object SaveHSF: TMenuItem
        Caption = 'Save HSF'
        OnClick = SaveHSFClick
      end
      object SaveAllHSFS: TMenuItem
        Caption = 'Save All HSF'#39's'
        OnClick = SaveAllHSFSClick
      end
    end
    object HFF1: TMenuItem
      Caption = 'HFF'
      object AddFont1: TMenuItem
        Caption = 'New HFF'
        OnClick = AddFont1Click
      end
      object RemoveHFF1: TMenuItem
        Caption = 'Remove HFF'
        OnClick = RemoveHFF1Click
      end
      object SaveHFF1: TMenuItem
        Caption = 'Save HFF'
        OnClick = SaveHFFClick
      end
      object SaveAllHFFs1: TMenuItem
        Caption = 'Save All HFF'#39's'
        OnClick = SaveAllHFFs1Click
      end
    end
  end
  object ImageLocationDialog: TOpenDialog
    Left = 256
    Top = 24
  end
  object AddImage: TOpenDialog
    Filter = 'PNG|*.PNG|BMP|*.BMP|JPG|*.JPG'
    Left = 232
    Top = 24
  end
  object DialogNewHGF: TSaveDialog
    DefaultExt = '.hgf'
    Filter = 'HGF|*.hgf'
    Options = [ofOverwritePrompt, ofHideReadOnly, ofEnableSizing]
    Left = 480
    Top = 424
  end
  object DialogNewGame: TSaveDialog
    DefaultExt = '.hgp'
    Filter = 'HPT Game Project|*.hgp'
    Options = [ofOverwritePrompt, ofHideReadOnly, ofEnableSizing]
    Left = 376
    Top = 440
  end
  object DialogOpenGame: TOpenDialog
    DefaultExt = '.hgp'
    Filter = 'HPT Game Project|*.hgp'
    Options = [ofHideReadOnly, ofCreatePrompt, ofEnableSizing]
    Left = 520
    Top = 416
  end
  object DialogHGFLoc: TOpenDialog
    DefaultExt = '.hgf'
    Filter = 'HGF|*.HGF'
    Options = [ofOverwritePrompt, ofHideReadOnly, ofEnableSizing]
    Left = 284
    Top = 24
  end
  object DialogSaveHSF: TSaveDialog
    DefaultExt = '.hsf'
    Filter = 'HSF|*.hsf'
    Options = [ofOverwritePrompt, ofHideReadOnly, ofEnableSizing]
    Left = 552
    Top = 416
  end
  object DialogAddSound: TOpenDialog
    DefaultExt = '.wav'
    Filter = 'WAV|*.wav'
    Left = 552
  end
  object DialogHSFLoc: TOpenDialog
    DefaultExt = '.hsf'
    Filter = 'HPT Sound File|*.hsf'
    Left = 576
  end
  object DialogSoundLocation: TOpenDialog
    DefaultExt = '.wav'
    Filter = 'WAV|*.wav'
    Options = [ofOverwritePrompt, ofHideReadOnly, ofEnableSizing]
    Left = 600
  end
  object FontDialog1: TFontDialog
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    MinFontSize = 0
    MaxFontSize = 0
    Left = 688
  end
  object SaveDialog1: TSaveDialog
    DefaultExt = 'HFF'
    Filter = '*.HFF|*.HFF'
    Options = [ofOverwritePrompt, ofHideReadOnly, ofEnableSizing]
    Left = 712
  end
  object DialogNewHFF: TSaveDialog
    DefaultExt = '*.hff'
    Filter = 'HPT Font File|*.HFF'
    Options = [ofOverwritePrompt, ofHideReadOnly, ofEnableSizing]
    Left = 584
    Top = 424
  end
  object DialogBackGroundColor: TColorDialog
    Ctl3D = True
    Options = [cdFullOpen]
    Left = 740
  end
  object DialogForegroundColor: TColorDialog
    Ctl3D = True
    Options = [cdFullOpen]
    Left = 768
  end
  object TimerAutoSave: TTimer
    Interval = 300000
    OnTimer = AutoSave
    Left = 616
    Top = 424
  end
  object DialogFringingColor: TColorDialog
    Ctl3D = True
    Options = [cdFullOpen]
    Left = 792
  end
  object DialogMapData: TOpenDialog
    DefaultExt = '.map'
    Filter = 'Map Data|*.dat'
    Left = 368
  end
  object DialogTileData: TOpenDialog
    DefaultExt = '.td'
    Filter = 'Tile Data|*.td'
    Left = 392
  end
  object NewLevelDialog: TSaveDialog
    Left = 287
    Top = 443
  end
end
