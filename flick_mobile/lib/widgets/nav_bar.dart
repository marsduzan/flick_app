import 'package:flutter/material.dart';
import 'package:flick_app/main.dart';

class NavBar extends StatelessWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final tx = Theme.of(context).textTheme;
    final clr = Theme.of(context).colorScheme;

    return BottomAppBar(
      color: clr.primary,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/home');
              },
              icon: Icon(Icons.home, size: 30),
            ),
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/search');
              },
              icon: Icon(Icons.search, size: 30),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.library_books, size: 30),
            ),
            IconButton(onPressed: () {}, icon: Icon(Icons.person, size: 30)),
          ],
        ),
      ),
    );
  }
}
