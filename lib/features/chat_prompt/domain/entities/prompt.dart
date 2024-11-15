import 'dart:convert';
import 'enum_prompt.dart';

class Prompt {
  final String id;
  final String title;
  final String description;
  final String content;
  //
  final String language;
  final String category;
  final bool isPublic;
  //
  final String userName;
  final bool isFavorite;

  Prompt({
    required this.id,
    required this.title,
    required this.content,
    required this.description,
    this.language = 'English',
    required this.category,
    required this.isPublic,
    required this.userName,
    required this.isFavorite,
  });

  // Factory constructor to create an instance from a JSON map
  factory Prompt.fromMap(Map<String, dynamic> json) {
    return Prompt(
      id: json['_id'] ?? '',
      title: json['title'] ?? '',
      content: json['content'] ?? '',
      description: json['description'] ?? '',
      language: json['language'] ?? '',
      category: json['category'],
      isPublic: json['isPublic'] ?? true,
      userName: json['userName'] ?? '',
      isFavorite: json['isFavorite'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'content': content,
      'description': description,
      'language': language,
      'category': category,
      'isPublic': isPublic,
    };
  }

  toMapString() {
    // Just return title and content
    return 'title: $title, content: $content';
  }

  static initial() {
    return Prompt(
        id: '-1',
        title: '-1',
        content: '-1',
        description: '-1',
        category: '-1',
        isPublic: false,
        userName: '-1',
        isFavorite: false);
  }
}
