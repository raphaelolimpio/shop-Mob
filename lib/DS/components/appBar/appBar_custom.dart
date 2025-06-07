// Seus estilos
import 'package:flutter/material.dart';
import 'package:loja/DS/shared/color/colors.dart';
import 'package:loja/DS/shared/style/style.dart';

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
    final itemWidth = screenWidth * 0.45;
    final itemPadding = 8.0;

    return AppBar(
      backgroundColor: backgroundColor,

      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset('assets/Logo.png', width: 40, height: 40),
          const SizedBox(width: 8),
          Text(
            brandName,
            style: headingStyle.copyWith(
              fontSize: 18,
              color: kFontColorWhite,
              fontWeight: FontWeight.normal,
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.search, color: iconColor),
          onPressed: () {},
        ),
        IconButton(
          icon: Icon(Icons.person_outline, color: iconColor),
          onPressed: () {},
        ),
        IconButton(
          icon: Icon(Icons.shopping_bag_outlined, color: iconColor),
          onPressed: () {},
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
