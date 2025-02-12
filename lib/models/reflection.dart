// lib/models/reflection.dart

class Reflection {
  final String id;
  final String title;
  final String content;
  final DateTime createdAt;
  final String mood; // Add mood as a nullable String field

  Reflection({
    required this.id,
    required this.title,
    required this.content,
    required this.createdAt,
    required this.mood, // Include mood in the constructor
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'createdAt': createdAt.toIso8601String(),
      'mood': mood, // Add mood to the map
    };
  }

  factory Reflection.fromMap(Map<String, dynamic> map, String documentId) {
    return Reflection(
      id: documentId,
      title: map['title'] ?? '',
      content: map['content'] ?? '',
      createdAt: DateTime.parse(map['createdAt']),
      mood: map['mood'], // Retrieve mood from the map
    );
  }

  // Modify the copyWith method to include mood
  Reflection copyWith({
    String? id,
    String? title,
    String? content,
    DateTime? createdAt,
    String? mood,
  }) {
    return Reflection(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      createdAt: createdAt ?? this.createdAt,
      mood: mood ?? this.mood, // Copy the mood value
    );
  }
}
