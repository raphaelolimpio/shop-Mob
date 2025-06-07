import 'package:flutter/material.dart';
import 'package:loja/DS/components/button/button_view_model.dart';
import 'package:loja/DS/shared/color/colors.dart';
import 'package:loja/DS/shared/style/style.dart';

class Button extends StatelessWidget {
  final ButtonViewModel viewModel;

  const Button._({required this.viewModel});

  static Widget instantiate(ButtonViewModel viewModel) {
    return Button._(viewModel: viewModel);
  }

  @override
  Widget build(BuildContext context) {
    double horizontalPadding = 32.0;
    double verticalPadding = 12.0;
    Color buttonColor = kCyan100;
    double iconSize = 32.0;
    TextStyle buttonTextStyle = buttonStyle1;

    double buttonWidth = double.infinity;
    double textFontSize = 16.0;

    switch (viewModel.size) {
      case ButtonSize.small:
        horizontalPadding =
            10.0; // Reduzido para dar mais espaço ao texto (antes 12.0)
        verticalPadding = 6.0;
        iconSize = 16.0;
        buttonWidth = 145; // Aumentado ligeiramente para 145 (antes 140)
        textFontSize = 12.0;
        break;
      case ButtonSize.medium:
        horizontalPadding = 24.0;
        verticalPadding = 12.0;
        iconSize = 20.0;
        buttonWidth = 220;
        textFontSize = 14.0;
        break;
      case ButtonSize.large:
        horizontalPadding = 32.0;
        verticalPadding = 16.0;
        iconSize = 24.0;
        buttonWidth = double.infinity;
        textFontSize = 16.0;
        break;
    }

    switch (viewModel.style) {
      case ButtonStyleColor.redColor:
        buttonColor = kRed500;
        break;
      case ButtonStyleColor.greenColor:
        buttonColor = appGreenColor;
        break;
      case ButtonStyleColor.cyanColor:
        buttonColor = appNormalCyanColor;
        break;
      case ButtonStyleColor.orangeColor:
        buttonColor = kOrangeColor;
        break;
    }

    switch (viewModel.textStyle) {
      case ButtonTextStyle.buttonStyle1:
        buttonTextStyle = buttonStyle1.copyWith(fontSize: textFontSize);
        break;
      case ButtonTextStyle.buttonStyle2:
        buttonTextStyle = buttonStyle2.copyWith(fontSize: textFontSize);
        break;
    }

    final Color iconColor = buttonTextStyle.color ?? kFontColorWhite;

    return SizedBox(
      width: buttonWidth,
      child: ElevatedButton(
        onPressed: viewModel.onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonColor,
          foregroundColor: iconColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: horizontalPadding,
            vertical: verticalPadding,
          ),
          textStyle: buttonTextStyle,
        ),
        child:
            viewModel.icon != null
                ? Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(viewModel.icon, size: iconSize, color: iconColor),
                    const SizedBox(width: 8.0),
                    Text(viewModel.title),
                  ],
                )
                : Text(viewModel.title),
      ),
    );
  }
}
