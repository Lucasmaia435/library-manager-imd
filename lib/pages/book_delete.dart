import 'package:flutter/material.dart';
import 'package:library_manager/db/book_db.dart';
import 'package:library_manager/models/book.dart';

class DeleteBookScreen extends StatefulWidget {
  const DeleteBookScreen({super.key});

  @override
  State<DeleteBookScreen> createState() => _DeleteBookScreenState();
}

class _DeleteBookScreenState extends State<DeleteBookScreen> {
  Future<List<Book>> _getBooks() async {
    return await BookDB.instance.readAllBooks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: const Text(
          'Deletar livro',
        ),
        backgroundColor: Colors.blue,
      ),
      body: FutureBuilder<List<Book>>(
        future: _getBooks(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(child: Text('Erro ao carregar os livros.'));
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Nenhum livro cadastrado'));
          }

          final books = snapshot.data!;

          return ListView.builder(
            itemCount: books.length,
            itemBuilder: (context, index) {
              final book = books[index];
              return ListTile(
                title: Text(book.title),
                subtitle: Text(book.author),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    _deleteBookByISBN(context, book.isbn);
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }

  Future<void> _deleteBookByISBN(BuildContext context, String isbn) async {
    final confirmDelete = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Confirmar'),
          content:
              Text('Tem certeza que quer deletar o livro com ISBN: $isbn?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              style: TextButton.styleFrom(
                  backgroundColor: Colors.red, foregroundColor: Colors.white),
              child: const Text('Deletar'),
            ),
          ],
        );
      },
    );

    if (confirmDelete ?? false) {
      await BookDB.instance.delete(isbn);
      setState(() {});

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Livro deletado com sucesso!')),
      );
    }
  }
}
