import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:library_manager/pages/book_create.dart';
import 'package:library_manager/pages/book_delete.dart';
import 'package:library_manager/pages/book_list.dart';
import 'package:library_manager/pages/book_update.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(34.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Spacer(),
            Center(
              child: SvgPicture.network(
                "https://portal.imd.ufrn.br/portal/assets/images/nova-marca/1A-Primaria-Gradiente.svg",
                height: 48,
              ),
            ),
            const Spacer(),
            const SizedBox(
              height: 16,
            ),
            const Text(
              "Bem vindo",
              style: TextStyle(fontSize: 32),
            ),
            const Text(
              "O que deseja fazer?",
              style: TextStyle(fontSize: 16),
            ),
            Expanded(
              flex: 4,
              child: GridView.count(
                physics:
                    const NeverScrollableScrollPhysics(), // Disable scrolling

                crossAxisCount: 2,
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
                children: [
                  _buildMenuButton(
                    context,
                    icon: Icons.list,
                    label: 'Listar livros',
                    destination: const ListBookScreen(),
                  ),
                  _buildMenuButton(
                    context,
                    icon: Icons.add,
                    label: 'Criar Livro',
                    destination: const CreateBookScreen(),
                  ),
                  _buildMenuButton(
                    context,
                    icon: Icons.edit,
                    label: 'Atualizar Livro',
                    destination: const UpdateBookScreen(),
                  ),
                  _buildMenuButton(
                    context,
                    icon: Icons.delete,
                    label: 'Deletar Livro',
                    destination: const DeleteBookScreen(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuButton(
    BuildContext context, {
    required IconData icon,
    required String label,
    required Widget destination,
  }) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => destination),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: Colors.white,
              size: 48.0,
            ),
            const SizedBox(height: 8.0),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
