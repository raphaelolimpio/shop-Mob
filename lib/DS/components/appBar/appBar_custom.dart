import 'package:flutter/material.dart';
import 'package:loja/DS/components/cards/enum/AppPage.dart';
import 'package:loja/DS/shared/color/colors.dart';
import 'package:loja/DS/shared/style/style.dart';
import 'package:loja/screens/Favoricts_screen.dart';
import 'package:loja/screens/buy_Screen.dart';
import 'package:loja/screens/history_screen%20.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String brandName;
  final Color backgroundColor;
  final List<Widget>? actions;
  final double elevation;
  final Color? iconColor;

  const CustomAppBar({
    super.key,
    required this.brandName,
    this.backgroundColor = kPrimaryAppColor,
    this.actions,
    this.elevation = 4.0,
    this.iconColor = kBackgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    // Define um limite mínimo de largura para o conteúdo do AppBar
    final minWidth = 320.0;

    return AppBar(
      backgroundColor: backgroundColor,
      elevation: elevation,
      title: ConstrainedBox(
        constraints: BoxConstraints(minWidth: minWidth),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset('assets/Logo.png', width: 40, height: 40),
            const SizedBox(width: 8),
            Flexible(
              child: Text(
                brandName,
                style: headingStyle.copyWith(
                  fontSize: 18,
                  color: kFontColorWhite,
                  fontWeight: FontWeight.normal,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

Drawer buildAppDrawer(BuildContext context) {
  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: [
        DrawerHeader(
          decoration: BoxDecoration(color: kPrimaryAppColor),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset('assets/Logo.png', width: 90, height: 90),
              const SizedBox(height: 10),
              Text(
                'Seu Estilo',
                style: headingStyle.copyWith(
                  color: kFontColorWhite,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        ...AppPage.values.map(
          (page) => ListTile(
            leading: Icon(page.icon),
            title: Text(page.label),
            onTap: () {
              Navigator.of(context).pop(); // Fecha o Drawer
              Navigator.of(
                context,
              ).pushReplacement(MaterialPageRoute(builder: (_) => page.page));
            },
          ),
        ),
      ],
    ),
  );
}
