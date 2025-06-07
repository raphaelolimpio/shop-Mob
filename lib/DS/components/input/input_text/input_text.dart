import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loja/DS/components/input/input_text/input_text_view_model.dart';
import 'package:loja/DS/shared/color/colors.dart';
import 'package:loja/DS/shared/style/style.dart'; // Para formatadores de input

class InputText extends StatefulWidget {
  final InputTextViewModel viewModel;

  const InputText({super.key, required this.viewModel});

  @override
  InputTextState createState() => InputTextState();

  static Widget instantiate(InputTextViewModel viewModel) {
    return InputText(viewModel: viewModel);
  }
}

class InputTextState extends State<InputText> {
  // Lógica de validação simples baseada no inputType
  String? _validateInput(String? value) {
    if (value == null || value.isEmpty) {
      return null; // A validação de campo vazio pode ser feita no formulário
    }

    switch (widget.viewModel.inputType) {
      case InputTextType.phone:
        // Remove todos os caracteres não numéricos para validação
        final String cleanedValue = value.replaceAll(RegExp(r'\D'), '');
        if (cleanedValue.length < 10 || cleanedValue.length > 11) {
          return 'Telefone inválido (10 ou 11 dígitos)';
        }
        break;
      case InputTextType.email:
        if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
          return 'E-mail inválido';
        }
        break;
      case InputTextType.password:
        if (value.length < 6) {
          return 'A senha deve ter pelo menos 6 caracteres';
        }
        break;
      case InputTextType.string:
      default:
        return null;
    }
    return null;
  }

  // Obter formatadores de input (para telefone)
  List<TextInputFormatter>? _getInputFormatters(InputTextType type) {
    switch (type) {
      case InputTextType.phone:
        // Exemplo de máscara para telefone (DD) XXXXX-XXXX
        // Você pode usar pacotes como 'mask_text_input_formatter' para mais robustez
        return [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(11),
        ];
      default:
        return null;
    }
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
        borderSide = const BorderSide(
          color: kGray200,
        ); // Use 200 para borda mais visível
        textStyle = smallStyle.copyWith(
          color: kFontColorBlack,
        ); // Garante cor do texto
        break;
      case InputTextSize.medium:
        horizontalPadding = 24.0;
        verticalPadding = 12.0;
        borderRadius = BorderRadius.circular(8); // Um pouco mais arredondado
        borderSide = const BorderSide(color: kGray200);
        textStyle = normalStyle.copyWith(color: kFontColorBlack);
        break;
      case InputTextSize.large:
        horizontalPadding = 32.0;
        verticalPadding = 16.0; // Aumentar padding vertical para large
        borderRadius = BorderRadius.circular(12); // Mais arredondado ainda
        borderSide = const BorderSide(color: kGray200);
        textStyle = headingStyle.copyWith(
          fontSize: 18.0,
          color: kFontColorBlack,
        ); // Use um tamanho maior para o texto
        break;
    }

    InputDecoration decoration = InputDecoration(
      labelText: widget.viewModel.hintText,
      // Usando prefixIcon do ViewModel ou fallback para ícone padrão
      prefixIcon:
          widget.viewModel.prefixIcon ??
          _getIconFromKeyboardType(widget.viewModel.keyboardType),
      // Usando suffixIcon do ViewModel
      suffixIcon: widget.viewModel.suffixIcon,
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
      // Mantenha o erroText para o estado de erro
      errorText: widget.viewModel.errorText, // Usando o errorText do ViewModel
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
      // Estilo para quando o campo está desabilitado
      disabledBorder: OutlineInputBorder(
        borderRadius: borderRadius,
        borderSide: BorderSide(color: kGray300, width: 1.0), // Borda mais suave
      ),
      fillColor:
          widget.viewModel.isEnabled
              ? kFontColorWhite
              : kGray100, // Fundo cinza quando desabilitado
      filled: true,
    );

    return TextField(
      controller: widget.viewModel.controller,
      decoration: decoration,
      style: textStyle,
      obscureText: widget.viewModel.obscureText,
      keyboardType: widget.viewModel.keyboardType,
      enabled: widget.viewModel.isEnabled,
      onChanged: widget.viewModel.onChanged, // Passa o onChanged do ViewModel
      inputFormatters: _getInputFormatters(
        widget.viewModel.inputType,
      ), // Aplica formatadores
      // Adicione um validator se for usar em um Form
      // validator: _validateInput, // Descomente se usar com Form
    );
  }

  // Função auxiliar para obter ícone baseado no keyboardType
  Icon? _getIconFromKeyboardType(TextInputType type) {
    switch (type) {
      case TextInputType.name:
        return const Icon(Icons.person, color: kGray600);
      case TextInputType.phone:
        return const Icon(Icons.phone, color: kGray600);
      case TextInputType.emailAddress:
        return const Icon(Icons.email, color: kGray600);
      case TextInputType
          .visiblePassword: // Geralmente não é usado para `keyboardType` diretamente
        return const Icon(Icons.lock, color: kGray600);
      default:
        return null;
    }
  }
}
