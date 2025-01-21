// Modelo do Livro
class Book {
  final int? id;
  final String title;
  final String author;
  final String publisher;
  final String isbn;
  final String description;
  final String coverUrl;

  Book({
    this.id,
    required this.title,
    required this.author,
    required this.publisher,
    required this.isbn,
    required this.description,
    required this.coverUrl,
  });

  // Converter Livro para Mapa
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'author': author,
      'publisher': publisher,
      'isbn': isbn,
      'description': description,
      'coverUrl': coverUrl,
    };
  }

  // Criar Livro a partir de um Mapa
  factory Book.fromMap(Map<String, dynamic> map) {
    return Book(
      id: map['id'],
      title: map['title'],
      author: map['author'],
      publisher: map['publisher'],
      isbn: map['isbn'],
      description: map['description'],
      coverUrl: map['coverUrl'],
    );
  }
}
