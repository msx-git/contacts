class Contact {
  final int id;
  final String title;
  final String phoneNumber;

  const Contact({
    required this.id,
    required this.title,
    required this.phoneNumber,
  });

  @override
  String toString() {
    return 'Contact{id: $id, title: $title, phoneNumber: $phoneNumber}';
  }

  factory Contact.fromJson(Map<String, dynamic> json) {
    return Contact(
      id: json['id'],
      title: json['title'],
      phoneNumber: json['phoneNumber'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'phoneNumber': phoneNumber,
    };
  }
}
