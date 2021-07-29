import 'dart:convert';

class Measures {
  Us us;
  Us metric;
  Measures({
    required this.us,
    required this.metric,
  });

  Map<String, dynamic> toMap() {
    return {
      'us': us.toMap(),
      'metric': metric.toMap(),
    };
  }

  factory Measures.fromMap(Map<String, dynamic> map) {
    return Measures(
      us: Us.fromMap(map['us']),
      metric: Us.fromMap(map['metric']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Measures.fromJson(String source) => Measures.fromMap(json.decode(source));
}

class Us {
  double amount;
  String unitShort;
  String unitLong;
  Us({
    required this.amount,
    required this.unitShort,
    required this.unitLong,
  });

  Map<String, dynamic> toMap() {
    return {
      'amount': amount,
      'unitShort': unitShort,
      'unitLong': unitLong,
    };
  }

  factory Us.fromMap(Map<String, dynamic> map) {
    return Us(
      amount: map['amount'],
      unitShort: map['unitShort'],
      unitLong: map['unitLong'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Us.fromJson(String source) => Us.fromMap(json.decode(source));
}
