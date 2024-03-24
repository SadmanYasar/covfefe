import 'package:covfefe/datamanager.dart';
import 'package:covfefe/pages/menupage.dart';
import 'package:covfefe/pages/offerspage.dart';
import 'package:covfefe/pages/orderspage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class HelloWorld extends StatefulWidget {
  const HelloWorld({super.key});

  @override
  State<HelloWorld> createState() => _HelloWorldState();
}

class _HelloWorldState extends State<HelloWorld> {
  var name = "";

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("Hello, $name!"),
        Text("Hello, $name!"),
        Text("Hello, $name!"),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            onChanged: (value) {
              setState(() {
                name = value;
              });
            },
          ),
        ),
      ],
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Covfefe',
      themeMode: ThemeMode.system,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.brown,
        ),
        useMaterial3: true,
      ),
      darkTheme: ThemeData.dark(
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var dataManager = DataManager();
  var _selectedIndex = 0;

  void _onSelect(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget currentPage = const Text('Home');

    switch (_selectedIndex) {
      case 0:
        currentPage = MenuPage(
          dataManager: dataManager,
        );
        break;
      case 1:
        currentPage = const OffersPage();
        break;
      case 2:
        currentPage = OrdersPage(
          dataManager: dataManager,
        );
        break;
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Image.asset('images/logo.png'),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          _onSelect(index);
        },
        backgroundColor: Theme.of(context).primaryColor,
        selectedItemColor: Colors.yellow.shade400,
        unselectedItemColor: Colors.brown.shade50,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.coffee),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_offer),
            label: "Offers",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_checkout_outlined),
            label: "Order",
          )
        ],
      ),
      body: currentPage,
    );
  }
}
