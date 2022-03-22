import 'package:flutter/material.dart';
import 'package:happy_plants/services/authentication.dart';
import 'tabs/garden.dart';
import 'tabs/timeline.dart';
import 'tabs/options.dart';

class Home extends StatefulWidget{
  const Home({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    Garden(),
    Timeline(),
    Options(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final AuthService _auth = AuthService();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.title),
        actions: <Widget>[
          ElevatedButton.icon(
              onPressed: () async {
                await _auth.signOut();
              },
              icon: const Icon(Icons.logout_outlined),
              label: const Text('Logout'))
        ],
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.local_florist),
            label: 'Garden',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shower),
            label: 'Events',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Theme.of(context).primaryColor,
        onTap: _onItemTapped,
      ),
    );
  }
}
