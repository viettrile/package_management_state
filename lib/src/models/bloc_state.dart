class BlocState<T> {
  final T data;
  final bool isLoading;
  final String? error;
  final DateTime lastUpdated;

   BlocState({
    required this.data,
    this.isLoading = false,
    this.error,
    DateTime? lastUpdated,
  }) : lastUpdated = lastUpdated ?? DateTime.now();

   BlocState<T> copyWith({
    T? data,
    bool? isLoading,
    String? error,
    DateTime? lastUpdated,
  }) {
    return BlocState<T>(
      data: data ?? this.data,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      lastUpdated: lastUpdated ?? DateTime.now(),
    );
  }


  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is BlocState<T> &&
        other.data == data &&
        other.isLoading == isLoading &&
        other.error == error;
  }

  @override
  int get hashCode => Object.hash(data, isLoading, error);
}
