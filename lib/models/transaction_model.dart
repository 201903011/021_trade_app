enum TransactionType { add, withdraw }

class TransactionModel {
  final String id;
  final TransactionType type;
  final double amount;
  final DateTime createdAt;

  TransactionModel({
    required this.id,
    required this.type,
    required this.amount,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() => {
        'id': id,
        'type': type.name,
        'amount': amount,
        'created_at': createdAt.millisecondsSinceEpoch,
      };

  factory TransactionModel.fromMap(Map<String, dynamic> map) => TransactionModel(
        id: map['id'] as String,
        type: map['type'] == 'add' ? TransactionType.add : TransactionType.withdraw,
        amount: (map['amount'] as num).toDouble(),
        createdAt: DateTime.fromMillisecondsSinceEpoch(map['created_at'] as int),
      );
}
