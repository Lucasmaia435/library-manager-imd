import 'package:flutter/material.dart';
import 'package:library_manager/models/book.dart';

class BookDetailsScreen extends StatelessWidget {
  final Book book;

  const BookDetailsScreen({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: Colors.blue,
        title: Text(book.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  book.coverUrl,
                  height: 200,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: 200,
                      height: 200,
                      color: Colors.grey.shade300,
                      child: const Icon(
                        Icons.book,
                        color: Colors.grey,
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              book.title,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              book.author,
              style:
                  TextStyle(fontSize: 16, color: Colors.black.withOpacity(0.6)),
            ),
            const SizedBox(height: 12),
            Text(
              book.description,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 12),
            const Divider(),
            Text(
              'Publicado por: ${book.publisher}',
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'ISBN: ${book.isbn}',
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}
