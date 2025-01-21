import 'package:flutter/material.dart';
import 'package:library_manager/db/book_db.dart';
import 'package:library_manager/models/book.dart';

class UpdateBookScreen extends StatefulWidget {
  const UpdateBookScreen({super.key});

  @override
  State<UpdateBookScreen> createState() => _UpdateBookScreenState();
}

class _UpdateBookScreenState extends State<UpdateBookScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  Book? _selectedBook;

  Future<List<Book>> _getBooks() async {
    List<Book> books = await BookDB.instance.readAllBooks();

    if (_searchQuery.isNotEmpty) {
      books = books.where((book) {
        return book.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
            book.author.toLowerCase().contains(_searchQuery.toLowerCase());
      }).toList();
    }

    return books;
  }

  Future<void> _updateBook(Book book) async {
    if (_formKey.currentState!.validate()) {
      final updatedBook = Book(
        id: book.id,
        title: _titleController?.text ?? '',
        author: _authorController?.text ?? '',
        publisher: _publisherController?.text ?? '',
        isbn: _isbnController?.text ?? '',
        description: _descriptionController?.text ?? '',
        coverUrl: _coverUrlController?.text ?? '',
      );

      await BookDB.instance.update(updatedBook);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Book updated successfully!')),
      );

      setState(() {
        _selectedBook = null;
      });
    }
  }

  // Controladores do formulário
  final _formKey = GlobalKey<FormState>();
  late TextEditingController? _titleController;
  late TextEditingController? _authorController;
  late TextEditingController? _publisherController;
  late TextEditingController? _isbnController;
  late TextEditingController? _descriptionController;
  late TextEditingController? _coverUrlController;

  void _populateForm(Book book) {
    _titleController = TextEditingController(text: book.title);
    _authorController = TextEditingController(text: book.author);
    _publisherController = TextEditingController(text: book.publisher);
    _isbnController = TextEditingController(text: book.isbn);
    _descriptionController = TextEditingController(text: book.description);
    _coverUrlController = TextEditingController(text: book.coverUrl);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _titleController?.dispose();
    _authorController?.dispose();
    _publisherController?.dispose();
    _isbnController?.dispose();
    _descriptionController?.dispose();
    _coverUrlController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: const Text(
          'Atualizar livro',
        ),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            if (_selectedBook == null) ...[
              TextField(
                controller: _searchController,
                onChanged: (query) {
                  setState(() {
                    _searchQuery = query;
                  });
                },
                decoration: const InputDecoration(
                  labelText: 'Buscar por titulo',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: FutureBuilder<List<Book>>(
                  future: _getBooks(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (snapshot.hasError) {
                      return const Center(
                          child: Text('Erro ao carregar os livros.'));
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
                          title: Text(book.title),
                          subtitle: Text(book.author),
                          onTap: () {
                            setState(() {
                              _selectedBook = book;
                              _populateForm(book);
                            });
                          },
                        );
                      },
                    );
                  },
                ),
              ),
            ] else ...[
              Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TextFormField(
                        controller: _titleController,
                        decoration: const InputDecoration(labelText: 'Título'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Digite o título';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: _authorController,
                        decoration:
                            const InputDecoration(labelText: 'Autor(a)'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Digite o/a autor(a)';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: _publisherController,
                        decoration: const InputDecoration(labelText: 'Editora'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Digite a editora';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: _isbnController,
                        decoration: const InputDecoration(labelText: 'ISBN'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Digite o ISBN';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: _descriptionController,
                        decoration:
                            const InputDecoration(labelText: 'Descrição'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Digite uma descrição';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: _coverUrlController,
                        decoration:
                            const InputDecoration(labelText: 'URL da capa'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Digite a URL da capa';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () => _updateBook(_selectedBook!),
                        child: const Text('Atualizar livro'),
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _selectedBook = null;
                          });
                        },
                        child: const Text('Cancelar'),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
