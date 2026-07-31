class WatchlistModel {
  final String id;
  String name;
  List<String> symbols;

  WatchlistModel({
    required this.id,
    required this.name,
    List<String>? symbols,
  }) : symbols = symbols ?? [];
}
