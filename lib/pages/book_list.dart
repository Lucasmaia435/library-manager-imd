import 'package:flutter/material.dart';
import 'package:library_manager/db/book_db.dart';
import 'package:library_manager/models/book.dart';
import 'package:library_manager/pages/book_details.dart';

class ListBookScreen extends StatefulWidget {
  const ListBookScreen({super.key});

  @override
  State<ListBookScreen> createState() => _ListBookScreenState();
}

class _ListBookScreenState extends State<ListBookScreen> {
  Future<List<Book>> _getBooks() async {
    List<Book> books = await BookDB.instance.readAllBooks();

    return books;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: const Text(
          'Todos os Livros',
        ),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder<List<Book>>(
                future: _getBooks(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    return const Center(
                      child: Text('Erro ao carregar os livros.'),
                    );
                  }

                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(
                      child: Text('Nenhum livro cadastrado.'),
                    );
                  }

                  final books = snapshot.data!;
                  return ListView.builder(
                    itemCount: books.length,
                    itemBuilder: (context, index) {
                      final book = books[index];
                      return ListTile(
                        leading: Image.network(
                          book.coverUrl,
                          frameBuilder:
                              (context, child, frame, wasSynchronouslyLoaded) =>
                                  SizedBox(
                            height: 50,
                            width: 50,
                            child: child,
                          ),
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              width: 50,
                              height: 50,
                              color: Colors.grey.shade300,
                              child: const Icon(
                                Icons.book,
                                color: Colors.grey,
                              ),
                            );
                          },
                        ),
                        title: Text(book.title),
                        subtitle: Text(book.author),
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => BookDetailsScreen(
                              book: book,
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
