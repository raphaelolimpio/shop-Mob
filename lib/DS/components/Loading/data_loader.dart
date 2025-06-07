// lib/desygn_system/components/loading/data_loader.dart

import 'package:flutter/material.dart';
import 'package:loja/DS/components/Loading/data_loader_view_model.dart';
import 'package:loja/DS/components/Loading/loading_enums.dart';

class DataLoader<T> extends StatefulWidget {
  final DataLoaderViewModel<T> viewModel;

  const DataLoader({super.key, required this.viewModel});

  @override
  State<DataLoader<T>> createState() => _DataLoaderState<T>();
}

class _DataLoaderState<T> extends State<DataLoader<T>> {
  DataLoaderState _currentState = DataLoaderState.loading;
  T? _data;
  String? _errorMessage;
  int _currentRetry = 0;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  // Função principal para carregar os dados
  Future<void> _loadData() async {
    setState(() {
      _currentState = DataLoaderState.loading;
      _errorMessage = null; // Limpa a mensagem de erro anterior
    });

    try {
      // Simula um delay de carregamento
      await Future.delayed(
        Duration(milliseconds: widget.viewModel.simulatedLoadingDurationMs),
      );

      final result = await widget.viewModel.futureBuilder();

      if (result is List && result.isEmpty) {
        _currentState = DataLoaderState.empty;
      } else {
        _data = result;
        _currentState = DataLoaderState.success;
      }
    } catch (e) {
      _errorMessage = e.toString(); // Captura a mensagem de erro
      _currentRetry++; // Incrementa o contador de tentativas

      if (_currentRetry <= widget.viewModel.maxRetries) {
        // Se ainda há tentativas, mostra erro com opção de re-tentar
        _currentState = DataLoaderState.error;
      } else {
        // Se as tentativas se esgotaram, chama o callback de limite
        widget.viewModel.onMaxRetriesReached?.call();
        // Pode-se optar por manter o estado de erro ou ir para uma tela padrão
        _currentState =
            DataLoaderState
                .error; // Mantém em erro para exibir a mensagem final
        _errorMessage =
            "Erro persistente após ${widget.viewModel.maxRetries} tentativas. Por favor, tente novamente mais tarde.";
      }
    } finally {
      setState(() {
        // Atualiza o estado da UI
      });
    }
  }

  // Função para re-tentar o carregamento
  void _retryLoading() {
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    switch (_currentState) {
      case DataLoaderState.loading:
        return widget.viewModel.loadingBuilder(
          widget.viewModel.progressIndicatorType,
          widget.viewModel.progressIndicatorColor,
        );
      case DataLoaderState.success:
        if (_data != null) {
          return widget.viewModel.successBuilder(_data as T);
        }
        // Fallback caso _data seja null mesmo em sucesso (improvável com a verificação de empty)
        return widget.viewModel.emptyBuilder();
      case DataLoaderState.error:
        return widget.viewModel.errorBuilder(
          _errorMessage ??
              widget
                  .viewModel
                  .genericErrorMessage, // Exibe o erro específico ou o genérico
          _retryLoading,
        );
      case DataLoaderState.empty:
        return widget.viewModel.emptyBuilder();
      default:
        return const Center(child: Text('Estado desconhecido.'));
    }
  }
}
