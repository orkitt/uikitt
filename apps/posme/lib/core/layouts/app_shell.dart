import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:posme/features/home/views/common.dart';
import 'package:posme/features/home/views/home_page.dart';

// StateProvider for the selected index
final posTabProvider = StateProvider<int>((ref) => 0);

class PosShell extends ConsumerWidget {
  static const String route = '/shell';
  const PosShell({super.key});

  final List<Widget> _pages = const [
    HomePage(),
    SalesPage(),
    ReportsPage(),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(posTabProvider);

    return Scaffold(
      body: IndexedStack(index: selectedIndex, children: _pages),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (index) => ref.read(posTabProvider.notifier).state = index,
        selectedItemColor: Colors.deepPurple,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Sales',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'Reports',
          ),
        ],
      ),
    );
  }
}

// class PosShell extends StatefulWidget {
//   static const String route = '/shell';
//   const PosShell({super.key});

//   @override
//   State<PosShell> createState() => _PosShellState();
// }

// class _PosShellState extends State<PosShell> {
//   int _selectedIndex = 0;

//   final List<Widget> _pages = const [
//     DashboardPage(),
//     SalesPage(),
//     ReportsPage(),
//   ];

//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: IndexedStack(index: _selectedIndex, children: _pages),
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: _selectedIndex,
//         onTap: _onItemTapped,
//         selectedItemColor: Colors.deepPurple,
//         unselectedItemColor: Colors.grey,
//         items: const [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.dashboard),
//             label: 'Dashboard',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.shopping_cart),
//             label: 'Sales',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.bar_chart),
//             label: 'Reports',
//           ),
//         ],
//       ),
//     );
//   }
// }
