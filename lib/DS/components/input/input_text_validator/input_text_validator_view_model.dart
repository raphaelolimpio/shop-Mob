import 'package:flutter/material.dart';

enum InputTextSize { small, medium, large }

// Remover InputTextType daqui, pois o validator já define o comportamento
// Para o login, geralmente são email e password.

class InputTextValidatorViewModel {
  final InputTextSize size;
  final String hintText;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final bool obscureText; // Controla se o texto é ocultado (true para senhas)
  final bool isEnabled;
  final String? Function(String?)? validator; // Validator para o campo

  // Ícones agora podem ser passados diretamente, mais flexível
  final Widget? prefixIcon; // Novo: Ícone à esquerda
  final Widget? suffixIcon; // Novo: Ícone à direita, para senhas, etc.

  InputTextValidatorViewModel({
    required this.size,
    required this.hintText,
    required this.controller,
    this.keyboardType = TextInputType.text, // Definir um padrão
    this.obscureText = false, // Definir um padrão
    this.isEnabled = true, // Definir um padrão
    this.validator,
    this.prefixIcon, // Novo
    this.suffixIcon, // Novo
  });
}
