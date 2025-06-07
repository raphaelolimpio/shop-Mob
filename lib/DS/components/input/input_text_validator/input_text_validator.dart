import 'package:flutter/material.dart';
import 'package:loja/DS/components/input/input_text_validator/input_text_validator_view_model.dart';
import 'package:loja/DS/shared/color/colors.dart';
import 'package:loja/DS/shared/style/style.dart';

class InputTextValidator extends StatefulWidget {
  final InputTextValidatorViewModel viewModel;

  const InputTextValidator({super.key, required this.viewModel});

  @override
  InputTextValidatorState createState() => InputTextValidatorState();

  static Widget instantiate(InputTextValidatorViewModel viewModel) {
    return InputTextValidator(viewModel: viewModel);
  }
}

class InputTextValidatorState extends State<InputTextValidator> {
  // obscureText será controlada internamente para o toggle de senha
  late bool _internalObscureText;
  String? _errorMsg; // Renomeado para consistência

  @override
  void initState() {
    super.initState();
    _internalObscureText =
        widget.viewModel.obscureText; // Inicializa com o valor do ViewModel
    // O listener só faz sentido se houver um validator
    if (widget.viewModel.validator != null) {
      widget.viewModel.controller.addListener(_validateInput);
    }
  }

  @override
  void dispose() {
    // É crucial remover o listener para evitar vazamentos de memória
    if (widget.viewModel.validator != null) {
      widget.viewModel.controller.removeListener(_validateInput);
    }
    super.dispose();
  }

  // Função interna de validação que atualiza o estado
  void _validateInput() {
    final errorText = widget.viewModel.validator?.call(
      widget.viewModel.controller.text,
    );
    setState(() {
      _errorMsg = errorText;
    });
  }

  // Função auxiliar para obter ícone padrão baseado no keyboardType
  Icon? _getIconFromKeyboardType(TextInputType type) {
    switch (type) {
      case TextInputType.name:
        return const Icon(Icons.person, color: kGray600);
      case TextInputType.phone:
        return const Icon(Icons.phone, color: kGray600);
      case TextInputType.emailAddress:
        return const Icon(Icons.email, color: kGray600);
      case TextInputType
          .visiblePassword: // Geralmente não é usado para keyboardType diretamente em campos de senha
        return const Icon(Icons.lock, color: kGray600);
      default:
        return null;
    }
  }

  // Widget para o botão de toggle de senha
  Widget? _buildPasswordToggleIcon() {
    if (widget.viewModel.obscureText) {
      // Se o ViewModel indicar que o campo é para ser obscurecido
      return IconButton(
        icon: Icon(
          _internalObscureText ? Icons.visibility : Icons.visibility_off,
          color: kGray600,
        ),
        onPressed: () {
          setState(() {
            _internalObscureText = !_internalObscureText;
          });
        },
      );
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    double horizontalPadding = 20.0;
    double verticalPadding = 15.0;
    BorderRadius borderRadius = BorderRadius.circular(4);
    BorderSide borderSide = const BorderSide(color: kGray100);
    TextStyle textStyle = textFieldStyle;

    // Definição de estilos baseada no tamanho
    switch (widget.viewModel.size) {
      case InputTextSize.small:
        horizontalPadding = 16.0;
        verticalPadding = 8.0;
        borderRadius = BorderRadius.circular(4);
        borderSide = const BorderSide(color: kGray200);
        textStyle = smallStyle.copyWith(color: kFontColorBlack);
        break;
      case InputTextSize.medium:
        horizontalPadding = 24.0;
        verticalPadding = 12.0;
        borderRadius = BorderRadius.circular(8);
        borderSide = const BorderSide(color: kGray200);
        textStyle = normalStyle.copyWith(color: kFontColorBlack);
        break;
      case InputTextSize.large:
        horizontalPadding = 32.0;
        verticalPadding = 16.0;
        borderRadius = BorderRadius.circular(12);
        borderSide = const BorderSide(color: kGray200);
        textStyle = headingStyle.copyWith(
          fontSize: 18.0,
          color: kFontColorBlack,
        );
        break;
    }

    InputDecoration decoration = InputDecoration(
      labelText: widget.viewModel.hintText,
      // Prioriza o prefixIcon do ViewModel, senão tenta obter do keyboardType
      prefixIcon:
          widget.viewModel.prefixIcon ??
          _getIconFromKeyboardType(widget.viewModel.keyboardType),
      // Prioriza o suffixIcon do ViewModel, senão usa o toggle de senha
      suffixIcon: widget.viewModel.suffixIcon ?? _buildPasswordToggleIcon(),
      contentPadding: EdgeInsets.symmetric(
        horizontal: horizontalPadding,
        vertical: verticalPadding,
      ),
      border: OutlineInputBorder(
        borderRadius: borderRadius,
        borderSide: borderSide,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: borderRadius,
        borderSide: BorderSide(
          color: appNormalCyanColor,
          width: 2.0,
        ), // Cor primária ao focar
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: borderRadius,
        borderSide: borderSide,
      ),
      errorText: _errorMsg, // Usando o errorMsg interno do State
      errorBorder: OutlineInputBorder(
        borderRadius: borderRadius,
        borderSide: const BorderSide(
          color: kRed500,
          width: 2.0,
        ), // Cor de erro mais forte
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: borderRadius,
        borderSide: const BorderSide(color: kRed500, width: 2.0),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: borderRadius,
        borderSide: BorderSide(color: kGray300, width: 1.0),
      ),
      fillColor: widget.viewModel.isEnabled ? kFontColorWhite : kGray100,
      filled: true,
    );

    return TextField(
      controller: widget.viewModel.controller,
      obscureText: _internalObscureText, // Usa o estado interno para o toggle
      decoration: decoration,
      style: textStyle,
      keyboardType: widget.viewModel.keyboardType,
      enabled: widget.viewModel.isEnabled,
      // O onChanged não é necessário aqui, pois o listener já faz a validação
      // Mas se o consumidor precisar de um callback para outras ações, pode adicionar:
      // onChanged: (value) { /* suas ações aqui */ },
    );
  }
}
