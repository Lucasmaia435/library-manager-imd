import 'package:library_manager/db/book_db.dart';
import 'package:library_manager/models/book.dart';

Future<void> addSampleBooks() async {
  final sampleBooks = [
    Book(
      title: 'O Senhor dos Anéis: A Sociedade do Anel',
      author: 'J.R.R. Tolkien',
      publisher: 'HarperCollins Brasil',
      isbn: '9780007522903',
      description:
          'O início épico da jornada de Frodo Bolseiro e seus companheiros em sua missão para destruir o Um Anel e salvar a Terra Média das forças sombrias de Sauron.',
      coverUrl: 'https://m.media-amazon.com/images/I/91TW9Z7fTWL.jpg',
    ),
    Book(
      title: 'Dom Casmurro',
      author: 'Machado de Assis',
      publisher: 'Globo Livros',
      isbn: '9788525056078',
      description:
          'Um clássico da literatura brasileira que explora temas como ciúmes, traição e a dúvida eterna sobre o que realmente aconteceu entre Capitu e Escobar.',
      coverUrl: 'https://m.media-amazon.com/images/I/71UNyBvP7PL.jpg',
    ),
    Book(
      title: 'Harry Potter e a Pedra Filosofal',
      author: 'J.K. Rowling',
      publisher: 'Rocco',
      isbn: '9788532530783',
      description:
          'O início da aventura mágica de Harry Potter, um jovem bruxo que descobre seu destino e começa sua jornada na Escola de Magia e Bruxaria de Hogwarts.',
      coverUrl: 'https://m.media-amazon.com/images/I/81YOuOGFCJL.jpg',
    ),
    Book(
      title: 'Percy Jackson e o Ladrão de Raios',
      author: 'Rick Riordan',
      publisher: 'Intrínseca',
      isbn: '9788598078397',
      description:
          'Percy descobre que é um semideus e embarca em uma jornada para salvar o mundo ao lado de seus amigos, enfrentando deuses e criaturas mitológicas.',
      coverUrl: 'https://m.media-amazon.com/images/I/91MoXXUQGcL.jpg',
    ),
    Book(
      title: 'A Menina que Roubava Livros',
      author: 'Markus Zusak',
      publisher: 'Intrínseca',
      isbn: '9788579800245',
      description:
          'Narrado pela Morte, este romance retrata a vida de Liesel durante a Segunda Guerra Mundial, destacando a força dos livros como símbolo de resistência.',
      coverUrl: 'https://m.media-amazon.com/images/I/81+uH9o3s1L.jpg',
    ),
    Book(
      title: 'O Código Da Vinci',
      author: 'Dan Brown',
      publisher: 'Arqueiro',
      isbn: '9788599296363',
      description:
          'Um thriller cheio de mistérios e enigmas que leva o simbologista Robert Langdon a desvendar segredos escondidos pela história e pela Igreja.',
      coverUrl: 'https://m.media-amazon.com/images/I/81nElSgdPuL.jpg',
    ),
  ];

  for (var book in sampleBooks) {
    await BookDB.instance.create(book);
  }
}
