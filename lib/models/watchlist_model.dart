class WatchlistModel {
  final String id;
  String name;
  List<String> symbols;
  int sortOrder;

  WatchlistModel({
    required this.id,
    required this.name,
    List<String>? symbols,
    this.sortOrder = 0,
  }) : symbols = symbols ?? [];

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'sort_order': sortOrder,
      };

  factory WatchlistModel.fromMap(Map<String, dynamic> map) => WatchlistModel(
        id: map['id'] as String,
        name: map['name'] as String,
        sortOrder: (map['sort_order'] as int?) ?? 0,
      );
}
