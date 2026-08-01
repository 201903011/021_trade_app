class WalletModel {
  double balance;

  WalletModel({required this.balance});

  Map<String, dynamic> toMap() => {'id': 1, 'balance': balance};

  factory WalletModel.fromMap(Map<String, dynamic> map) => WalletModel(balance: (map['balance'] as num).toDouble());
}
