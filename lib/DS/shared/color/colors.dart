// lib/DS/shared/color/colors.dart (ATUALIZADO)
import 'package:flutter/material.dart';

// Palette: Cyan (Existing)
const Color kCyan50 = Color(0xffe0f7fa);
const Color kCyan100 = Color(0xffb2ebf2);
const Color kCyan200 = Color(0xff80deea);
const Color kCyan300 = Color(0xff4dd0e1);
const Color kCyan400 = Color(0xff26c6da);
const Color kCyan500 = Color(0xff00bcd4);
const Color kCyan600 = Color(0xff00acc1);
const Color kCyan700 = Color(0xff0097a7);
const Color kCyan800 = Color(0xff00838f);
const Color kCyan900 = Color(0xff006064);
const Color kCyanBlack = Color.fromARGB(255, 2, 37, 37);

// Cores Cyan específicas do seu código original - REVISADO PARA HARMONIA
const Color appCyanColor = Color.fromARGB(255, 8, 228, 228);
const Color appCyannoramlColor = Color(
  0xff00f3f3,
); // Cor principal do Cyan, talvez renomear para kCyanPrimary?
const Color appCyanBlackColor = Color.fromARGB(255, 2, 37, 37);
const Color appLightCyanColor = Color(0xff84ffff);
const Color appNormalCyanColor = Color(0xff18ffff); // Usado em botões e AppBar
const Color appDarkCyanColor = Color(0xff00e5ff);
const Color appDarkCyanColor2 = Color(0xff00b8d4);

// Palette: Red (Existing)
const Color kRed50 = Color(0xffffebee);
const Color kRed100 = Color(0xffffcdd2);
const Color kRed200 = Color(0xffef9a9a);
const Color kRed300 = Color(0xffe57373);
const Color kRed400 = Color(0xffef5350);
const Color kRed500 = Color(0xfff44336);
const Color kRed600 = Color(0xffe53935);
const Color kRed700 = Color(0xffd32f2f);
const Color kRed800 = Color(0xffc62828);
const Color kRed900 = Color(0xffb71c1c);

const Color appRedColor = Color(0xffff5252);

// Palette: Gray (Existing)
const Color kGray50 = Color(0xfffafafa);
const Color kGray100 = Color(0xfff5f5f5);
const Color kGray200 = Color(0xffeeeeee);
const Color kGray300 = Color(0xffe0e0e0);
const Color kGray400 = Color(0xffbdbdbd);
const Color kGray500 = Color(0xff9e9e9e);
const Color kGray600 = Color(0xff757575);
const Color kGray700 = Color(0xff616161);
const Color kGray800 = Color(0xff424242);
const Color kGray900 = Color(0xff212121);

// Palette: Green (Existing)
const Color kGreen50 = Color(0xffe8f5e9);
const Color kGreen100 = Color(0xffc8e6c9);
const Color kGreen200 = Color(0xffa5d6a7);
const Color kGreen300 = Color(0xff81c784);
const Color kGreen400 = Color(0xff66bb6a);
const Color kGreen500 = Color(0xff4caf50);
const Color kGreen600 = Color(0xff43a047);
const Color kGreen700 = Color(0xff388e3c);
const Color kGreen800 = Color(0xff2e7d32);
const Color kGreen900 = Color(0xff1b5e20);

const Color appGreenColor = Color.fromARGB(255, 13, 233, 20);
const Color appLightGreenColor = Color(0XFFB9f6ca);
const Color appNormalGreenColor = Color(0Xff69f0ae);
const Color appBalckGreenColor = Color(0XFF00e676);
const Color appBlackGreenColor2 = Color(0XFF00c853);

// Cores Únicas (Existing)
const Color kBlueColor = Color(0xff2196f3);
const Color kYellowColor = Color(0xffffeb3b);
const Color kOrangeColor = Color(0xffff9800);
const Color kPurpleColor = Color(0xff9c27b0);
const Color kPinkColor = Color(0xfff50057);

// Cores de texto padrão
const Color kFontColorWhite = Colors.white;
const Color kFontColorBlack = Colors.black;

// --- NOVAS PALETAS ---

// Deep Navy Blue
const Color kDeepNavyBlue1 = Color(0xFF0A1128); // Muito escuro, quase preto
const Color kDeepNavyBlue2 = Color(0xFF001F54);
const Color kDeepNavyBlue3 = Color(
  0xFF0F214A,
); // Usado para backgrounds ou elementos principais

// Elegant Golds
const Color kElegantGold1 = Color(0xFFB8860B); // Goldenrod, mais terroso
const Color kElegantGold2 = Color(0xFFDAA520); // Goldenrod claro
const Color kElegantGold3 = Color(
  0xFFC8AE7F,
); // Dourado mais suave, bege metálico
const Color kElegantGold4 = Color(0xFFE1AD01); // Dourado vibrante

// Soft Cream Tones
const Color kSoftCream1 = Color(0xFFF5F5DC); // Beige
const Color kSoftCream2 = Color(0xFFFDF5E6); // OldLace (bom para backgrounds)
const Color kSoftCream3 = Color(
  0xFFFAFAD2,
); // LightGoldenrodYellow, levemente amarelado
const Color kSoftCream4 = Color(0xFFFFFDD0); // Cream, puro

// Uma cor principal para a AppBar e botões (pode ser um dos Navy Blues ou o Cyan se preferir contraste)
// Decidi usar um dos Navy Blues para a AppBar e o botão de "Ver Todos os Produtos"
const Color kPrimaryAppColor = kDeepNavyBlue2; // Ou kDeepNavyBlue3
const Color kAccentColor = kElegantGold4; // Dourado para destaque

// Cor de fundo geral, se aplicável
const Color kBackgroundColor = kSoftCream2; // Ex: OldLace para um fundo suave
