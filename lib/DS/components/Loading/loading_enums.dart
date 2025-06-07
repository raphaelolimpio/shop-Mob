// lib/desygn_system/components/loading/loading_enums.dart

/// Define os estados possíveis do componente de carregamento de dados.
enum DataLoaderState {
  /// O dado está sendo carregado.
  loading,

  /// O dado foi carregado com sucesso.
  success,

  /// Houve um erro ao carregar o dado.
  error,

  /// Nenhuma informação foi encontrada (dados vazios).
  empty,
}

/// Define o tipo de indicador de progresso visual.
enum ProgressIndicatorType {
  /// Indicador circular padrão (Flutter CircularProgressIndicator).
  circular,

  /// Um indicador de proguração customizado (ex: uma bolinha colorida).
  customDot,
}
