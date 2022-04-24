import 'package:flutter/material.dart';
import 'tabs/garden.dart';
import 'tabs/timeline.dart';
import 'tabs/options/options.dart';

class Home extends StatefulWidget{
  const Home({Key? key, required this.title, required this.changeColorScheme}) : super(key: key);
  final String title;
  final Function(ThemeMode newMode) changeColorScheme;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;



  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _widgetOptions = <Widget>[
      const Garden(),
      const Timeline(),
      Options(changeColorScheme: widget.changeColorScheme,),
    ];

    return Scaffold(
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
        backgroundColor: Theme.of(context).bottomAppBarColor,
        unselectedItemColor: Theme.of(context).unselectedWidgetColor,
      ),
    );
  }
}
