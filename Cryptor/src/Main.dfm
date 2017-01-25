object Form1: TForm1
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Cryptor'
  ClientHeight = 217
  ClientWidth = 218
  Color = clBtnFace
  Constraints.MaxHeight = 246
  Constraints.MaxWidth = 224
  Constraints.MinHeight = 246
  Constraints.MinWidth = 224
  DefaultMonitor = dmPrimary
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object cyLed1: TcyLed
    Left = 183
    Top = 183
    Width = 25
    Height = 25
    Hint = 'Status; Green: Idle, Red: Busy'
    ShowHint = True
    Color = cl3DDkShadow
    OnClick = cyLed1Click
    LedValue = False
    Bevels = <
      item
        HighlightColor = clBlack
        ShadowColor = clBlack
      end
      item
        Width = 3
      end
      item
        Style = bcLowered
      end
      item
        HighlightColor = clBlack
        ShadowColor = clBlack
      end>
    LedColorOn = clRed
    LedColorOff = clLime
    LedColorDisabled = 22963
    ShapeLedColorOn = clMaroon
    ShapeLedColorOff = 16384
    ShapeLedColorDisabled = 13416
  end
  object cyAdvButton1: TcyAdvButton
    Left = 40
    Top = 88
    Width = 137
    Height = 41
    Action = Action3
    Caption = 'Encrypt Files'
    TabOrder = 0
    BordersNormal = <
      item
        HighlightColor = clBtnFace
      end>
    BordersHot = <
      item
        HighlightColor = clBtnShadow
        ShadowColor = clBtnFace
      end>
    BordersDown = <
      item
        HighlightColor = clBtnFace
      end>
    BordersDisabled = <
      item
        HighlightColor = clMaroon
        ShadowColor = clMaroon
      end>
    ButtonNormal.Degrade.FromColor = clBtnFace
    ButtonNormal.Degrade.SpeedPercent = 90
    ButtonNormal.Degrade.ToColor = clBtnShadow
    ButtonNormal.Font.Charset = DEFAULT_CHARSET
    ButtonNormal.Font.Color = clWindowText
    ButtonNormal.Font.Height = -11
    ButtonNormal.Font.Name = 'Tahoma'
    ButtonNormal.Font.Style = [fsBold]
    ButtonNormal.Wallpaper.Transparent = False
    ButtonHot.Degrade.BalanceMode = bmReverseFromColor
    ButtonHot.Degrade.FromColor = clBtnFace
    ButtonHot.Degrade.SpeedPercent = 100
    ButtonHot.Degrade.ToColor = clBtnShadow
    ButtonHot.Font.Charset = DEFAULT_CHARSET
    ButtonHot.Font.Color = clWindowText
    ButtonHot.Font.Height = -11
    ButtonHot.Font.Name = 'Tahoma'
    ButtonHot.Font.Style = []
    ButtonHot.Wallpaper.Transparent = False
    ButtonDown.Degrade.FromColor = clBtnShadow
    ButtonDown.Degrade.SpeedPercent = 100
    ButtonDown.Degrade.ToColor = clBtnFace
    ButtonDown.Font.Charset = DEFAULT_CHARSET
    ButtonDown.Font.Color = clWindowText
    ButtonDown.Font.Height = -11
    ButtonDown.Font.Name = 'Tahoma'
    ButtonDown.Font.Style = []
    ButtonDown.Wallpaper.Transparent = False
    ButtonDisabled.Degrade.FromColor = clRed
    ButtonDisabled.Degrade.SpeedPercent = 90
    ButtonDisabled.Degrade.ToColor = clMaroon
    ButtonDisabled.Font.Charset = DEFAULT_CHARSET
    ButtonDisabled.Font.Color = clWindowText
    ButtonDisabled.Font.Height = -11
    ButtonDisabled.Font.Name = 'Tahoma'
    ButtonDisabled.Font.Style = []
    ButtonDisabled.Wallpaper.Transparent = False
    Wallpaper.Transparent = False
    GlyphX.Data = {
      0954506E67496D61676589504E470D0A1A0A0000000D49484452000000200000
      00200806000000737A7AF4000000017352474200AECE1CE90000000467414D41
      0000B18F0BFC6105000000097048597300000EC300000EC301C76FA864000000
      1974455874536F667477617265007061696E742E6E657420342E302E31324304
      6BEC000001A44944415478DAED964B6E83301086CD324BB639462F10A31C8B4A
      385273AC0873811EA1CB6CE98E653BBF655B83A17868492345190919C68FF9E6
      C140D15F6A3D944A2BA5ECFEE56C6954A47363793C6BFFECD6EC7A6549E7E6B6
      92E2FA5E1B1A1BBA3A32606080745F982420CCC3B0218003A94EA4339B0278EF
      70E82140D073EBE72B663CCC41C27A27A4EF30E29C104531000B71840887E3E0
      601C4619CC92B8B5529022DC00021BE1210C79757C466A12D045A13D95A45E90
      02CBBDE21BBDC196CD2122C6031ABECEC372B08EA2A0B300546476E451BFABF6
      C75777F0F5F2A65539B4D2430904100D5355B954C414B06A77A10F29209DB8B8
      868F5AF79FA31465A35024C6678B90855EE5F29AA60DAFF2224092BF1F5F43FF
      AA991C009CA1410E906B4409A0A81185FDE208A46DD61726366B7F0FA3E256BC
      0A40184E84DF4ADBF09F01D6341CA1C4F44A01ACA0E5AE121471F8BA66017808
      B794B974FC1A803C3AD1607DE382674D6ECF9600930E3769E9370698F48399EF
      C0634760140589F7B7008807AE5DFF0478023C0EC05A1103DCFD6B98FE586E04
      5089FF07FE53EE0EF00DB0D571309214554A0000000049454E44AE426082}
  end
  object cyAdvButton2: TcyAdvButton
    Left = 40
    Top = 135
    Width = 137
    Height = 42
    Action = Action4
    Caption = 'Decrypt Files'
    TabOrder = 1
    BordersNormal = <
      item
        HighlightColor = clBtnFace
      end>
    BordersHot = <
      item
        HighlightColor = clBtnFace
      end>
    BordersDown = <
      item
        HighlightColor = clBtnShadow
        ShadowColor = clBtnFace
      end>
    BordersDisabled = <
      item
        HighlightColor = clMaroon
        ShadowColor = clMaroon
      end>
    ButtonNormal.Degrade.FromColor = clBtnFace
    ButtonNormal.Degrade.SpeedPercent = 90
    ButtonNormal.Degrade.ToColor = clBtnShadow
    ButtonNormal.Font.Charset = DEFAULT_CHARSET
    ButtonNormal.Font.Color = clWindowText
    ButtonNormal.Font.Height = -11
    ButtonNormal.Font.Name = 'Tahoma'
    ButtonNormal.Font.Style = [fsBold]
    ButtonNormal.Wallpaper.Transparent = False
    ButtonHot.Degrade.BalanceMode = bmReverseFromColor
    ButtonHot.Degrade.FromColor = clBtnFace
    ButtonHot.Degrade.SpeedPercent = 100
    ButtonHot.Degrade.ToColor = clBtnShadow
    ButtonHot.Font.Charset = DEFAULT_CHARSET
    ButtonHot.Font.Color = clWindowText
    ButtonHot.Font.Height = -11
    ButtonHot.Font.Name = 'Tahoma'
    ButtonHot.Font.Style = []
    ButtonHot.Wallpaper.Transparent = False
    ButtonDown.Degrade.FromColor = clBtnShadow
    ButtonDown.Degrade.SpeedPercent = 100
    ButtonDown.Degrade.ToColor = clBtnFace
    ButtonDown.Font.Charset = DEFAULT_CHARSET
    ButtonDown.Font.Color = clWindowText
    ButtonDown.Font.Height = -11
    ButtonDown.Font.Name = 'Tahoma'
    ButtonDown.Font.Style = []
    ButtonDown.Wallpaper.Transparent = False
    ButtonDisabled.Degrade.FromColor = clRed
    ButtonDisabled.Degrade.SpeedPercent = 90
    ButtonDisabled.Degrade.ToColor = clMaroon
    ButtonDisabled.Font.Charset = DEFAULT_CHARSET
    ButtonDisabled.Font.Color = clWindowText
    ButtonDisabled.Font.Height = -11
    ButtonDisabled.Font.Name = 'Tahoma'
    ButtonDisabled.Font.Style = []
    ButtonDisabled.Wallpaper.Transparent = False
    Wallpaper.Transparent = False
    GlyphX.Data = {
      0954506E67496D61676589504E470D0A1A0A0000000D49484452000000200000
      00200806000000737A7AF4000000017352474200AECE1CE90000000467414D41
      0000B18F0BFC6105000000097048597300000EC300000EC301C76FA864000000
      1974455874536F667477617265007061696E742E6E657420342E302E31324304
      6BEC000002064944415478DAD5972157C33010C73339B7499048246E8A04BE05
      96AF80ABD845E0F80A583E020E96AA39E4E6904CAE6E12EE4AC2CBB26B9335ED
      03F2DE5E5FBBE4EE77FFBB5CD391F8E531FA77001F6F85C40BE0EFD23D1B6F45
      49D7DD54C0E9C5BD19048073DC30082619240960FB52488C6E714C64A88A9A5E
      C7219200307A230E2507E78000E91E217D754A5441660384D1A3738D8EA1612E
      41CCBD472A968A1400E345564E2702C667BCD1DD7B21B7D55E9D44558802A0FC
      9F5EF4D1BC868A2140AB8FDE01EC6E19062066ACCB9ABF0D70AC9CBD01D84202
      11EF7AA9A3C4FA01AE7E9A004CD054B207352F04904900BE8411A31A415D5464
      7CDE369F4B470E80AE1E96E41CEC3D4CEE6642B4BCB0FA04A83BDCEAE62A9C57
      BF234E6E673268C90700B89614935D01341A0334621AA2550841D70582848A49
      FBA3752A4B011B0949CEE55E634A9C4383CEE91958C79A9E9D3FBD9AAC1A2015
      3C399DF1BD39E428F84F916337216B17B89CD27981F6F9E6712945F34EA8EBC3
      77DE27809BAFACD4E1E98975DE2B803B25B5A8A01100860280EA796DC4AA2207
      7BC7B2E05E0D92828622ACB722A348BF45689D873957B8059D63AA0B1FA24400
      990D4039DF2CD7C0C8AE984E1816E78F0A9DDF86743CE3E4F5220F070BD1761E
      68FB1029D11804D2BBCEC7AE73E749AF73D6BBA2F3C769D082D92D96B056E500
      48F1DDE76918AEC92440C82F050460B87BA51A920000000049454E44AE426082}
  end
  object cyAdvStaticText1: TcyAdvStaticText
    Left = 16
    Top = 16
    Width = 185
    Height = 57
    Hint = 'Brought to you by: Thimo Braker'
    Caption = 'Cryptor'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -43
    Font.Name = 'Magneto'
    Font.Style = [fsBold]
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 2
    CaptionAlignment = taCenter
    Bevels = <>
    CaptionLayout = tlCenter
    Degrade.FromColor = clWhite
    Degrade.SpeedPercent = 100
    Degrade.ToColor = clBtnFace
    Wallpaper.Transparent = False
  end
  object ActionManager1: TActionManager
    ActionBars = <
      item
        Items = <
          item
            ChangesAllowed = []
            Items = <
              item
                Caption = '-'
                NewRow = True
                CommandProperties.GroupPosition = gpMiddle
              end>
            Caption = '&ActionClientItem0'
            KeyTip = 'F'
          end>
        AutoSize = False
      end
      item
        AutoSize = False
      end
      item
        Items = <
          item
            Action = Action3
            Caption = '&Encrypt Files'
            ImageIndex = 8
            NewCol = True
            NewRow = True
            CommandProperties.GroupPosition = gpStart
          end
          item
            Action = Action4
            Caption = '&Decrypt Files'
            ImageIndex = 9
            NewRow = True
            CommandProperties.GroupPosition = gpEnd
          end>
      end
      item
      end
      item
      end>
    Left = 88
    Top = 184
    StyleName = 'Platform Default'
    object Action3: TAction
      Category = 'Encryption'
      Caption = 'Encrypt Files'
      ImageIndex = 8
      OnExecute = Action3Execute
    end
    object Action4: TAction
      Category = 'Encryption'
      Caption = 'Decrypt Files'
      ImageIndex = 9
      OnExecute = Action4Execute
    end
  end
end
