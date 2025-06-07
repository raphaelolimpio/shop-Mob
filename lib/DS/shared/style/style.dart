// Importe suas cores
import 'package:flutter/material.dart';
import 'package:loja/DS/shared/color/colors.dart';
import 'package:google_fonts/google_fonts.dart';

// Sugestão: Defina um fontFamily padrão se você estiver usando um customizado
// const String kDefaultFontFamily = 'Inter'; // Exemplo, se você tiver a fonte 'Inter'

// Base Style (opcional, para reduzir repetição se muitos estilos compartilharem propriedades)
// TextStyle _kBaseTextStyle = const TextStyle(
//   fontFamily: kDefaultFontFamily, // Descomente se usar um fontFamily padrão
//   fontWeight: FontWeight.normal,
//   color: kFontColorBlack,
// );

TextStyle headingStyle = GoogleFonts.playfairDisplay(
  // Exemplo de fonte serifada
  fontSize: 28,
  fontWeight: FontWeight.bold,
  color: kFontColorBlack, // Cor padrão, será sobrescrita
);
TextStyle sectionHeadingStyle = GoogleFonts.playfairDisplay(
  fontSize: 22,
  fontWeight: FontWeight.bold,
  color: kFontColorBlack,
);

// Estilo para corpo de texto e descrições (sans-serif)
TextStyle normalStyle = GoogleFonts.openSans(
  // Exemplo de fonte sans-serif
  fontSize: 16,
  fontWeight: FontWeight.normal,
  color: kGray700, // Cor padrão, será sobrescrita
);

// Estilo para textos pequenos (descrições curtas, preços)
TextStyle smallStyle = GoogleFonts.openSans(
  fontSize: 14,
  fontWeight: FontWeight.normal,
  color: kGray600,
);

// Estilo para preços, pode ser mais negrito e com cor de destaque
TextStyle priceStyle = GoogleFonts.openSans(
  fontSize: 18,
  fontWeight: FontWeight.bold,
  color: kAccentColor, // Use a cor dourada para o preço
);

TextStyle subHeadingStyle = GoogleFonts.playfairDisplay(
  fontSize: 20,
  fontWeight: FontWeight.bold,
  color: kFontColorBlack,
);

TextStyle titleStyle = GoogleFonts.playfairDisplay(
  fontSize: 18,
  fontWeight: FontWeight.bold,
  color: kFontColorBlack, // Usando a constante
);

TextStyle subTitleStyle = const TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.bold,
  color: kFontColorBlack, // Usando a constante
);

TextStyle buttonStyle1 = const TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.bold,
  color: kFontColorWhite, // Usando a constante
);

TextStyle buttonStyle2 = const TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.bold,
  color: kFontColorBlack, // Usando a constante
);

TextStyle textFieldStyle = const TextStyle(
  fontSize: 16,
  // fontWeight: FontWeight.normal, // Considerar se o bold é realmente necessário aqui
  color: kFontColorBlack, // Usando a constante
);

TextStyle errorStyle = const TextStyle(
  fontSize: 14,
  fontWeight:
      FontWeight.bold, // Ou talvez FontWeight.w500 para não ser tão forte
  color: appRedColor, // Usando sua constante de cor vermelha
);

TextStyle successStyle = const TextStyle(
  fontSize: 14,
  fontWeight: FontWeight.bold,
  color: appGreenColor, // Usando sua constante de cor verde
);

TextStyle infoStyle = const TextStyle(
  fontSize: 14,
  fontWeight: FontWeight.bold,
  color: kBlueColor, // Usando sua constante de cor azul
);

TextStyle warningStyle = const TextStyle(
  fontSize: 14,
  fontWeight: FontWeight.bold,
  color: kYellowColor, // Usando sua constante de cor amarela
);

// Se a fonte 'Inter' for de fato usada, certifique-se de que ela está configurada no pubspec.yaml
// e que os pesos de fonte (w600, w500) estão disponíveis.
const TextStyle button2Semibold = TextStyle(
  fontFamily: 'Inter',
  fontSize: 14,
  fontWeight: FontWeight.w600, // FontWeight.w600 é Semibold
  color: appRedColor, // Usando sua constante de cor vermelha
);

const TextStyle label2Semibold = TextStyle(
  fontFamily: 'Inter',
  fontSize: 10,
  height: 1.6, // height é geralmente um multiplicador (ex: 16/10 = 1.6)
  fontWeight:
      FontWeight
          .w500, // FontWeight.w500 é Medium (ou Semibold, dependendo da fonte)
  color: appRedColor, // Usando sua constante de cor vermelha
);
