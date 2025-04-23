import 'package:flutter/material.dart';
import 'package:flutter_client/routes.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final destination = destinations[_selectedIndex];

    return MaterialApp(
      // Lesson 4
      home: Scaffold(
        appBar: AppBar(title: Text(destination.title), centerTitle: false),
        body: SafeArea(child: destination.view(context)),
        bottomNavigationBar: NavigationBar(
          selectedIndex: _selectedIndex,
          onDestinationSelected: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          destinations:
              destinations
                  .map(
                    (d) => NavigationDestination(
                      icon: Icon(d.icon),
                      label: d.label,
                    ),
                  )
                  .toList(),
        ),
      ),
    );
  }
}
