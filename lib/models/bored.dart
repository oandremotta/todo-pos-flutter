class Bored {
  final String activity;
  final String type;
  final int participants;
  final double price;
  final String link;
  final String key;
  final double accessibility;

  Bored({
    required this.activity,
    required this.type,
    required this.participants,
    required this.price,
    required this.link,
    required this.key,
    required this.accessibility,
  });

  factory Bored.fromJson(Map<String, dynamic> json) {
    return Bored(
      activity: json['activity'],
      type: json['type'],
      participants: json['participants'],
      price: json['price'].toDouble(),
      link: json['link'],
      key: json['key'],
      accessibility: json['accessibility'].toDouble(),
    );
  }
}
