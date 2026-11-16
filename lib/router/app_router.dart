import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../models/destination.dart';
import '../screens/home_screen.dart';
import '../screens/explore_screen.dart';
import '../screens/destination_detail_screen.dart';
import '../screens/saved_screen.dart';
import '../screens/profile_screen.dart';
import '../screens/about_screen.dart';

class ScaffoldWithNavBar extends StatelessWidget {
  final StatefulNavigationShell navigationShell;
  const ScaffoldWithNavBar({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: navigationShell.currentIndex,
        onDestinationSelected: (index) => navigationShell.goBranch(index,
          initialLocation: index == navigationShell.currentIndex),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home), label: 'หน้าหลัก'),
          NavigationDestination(icon: Icon(Icons.explore_outlined),
            selectedIcon: Icon(Icons.explore), label: 'สำรวจ'),
          NavigationDestination(icon: Icon(Icons.favorite_border),
            selectedIcon: Icon(Icons.favorite), label: 'บันทึก'),
          NavigationDestination(icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person), label: 'โปรไฟล์'),
          NavigationDestination(icon: Icon(Icons.info_outline),
            selectedIcon: Icon(Icons.info), label: 'เกี่ยวกับ'),
        ],
      ),
    );
  }
}

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  debugLogDiagnostics: true,
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) =>
        ScaffoldWithNavBar(navigationShell: navigationShell),
      branches: [
        StatefulShellBranch(routes: [
          GoRoute(path: '/', name: 'home',
            builder: (context, state) => const HomeScreen()),
        ]),
        StatefulShellBranch(routes: [
          GoRoute(path: '/explore', name: 'explore',
            builder: (context, state) => const ExploreScreen(),
            routes: [
              GoRoute(
                path: 'destinations/:id', name: 'destination-detail',
                // Checkpoint 5.1: ใช้ ID จาก URL เป็นข้อมูลหลัก
                // ไม่ต้องพึ่ง extra เพราะ deep link/refresh อาจไม่มี extra
                pageBuilder: (context, state) {
                  final id = state.pathParameters['id'];
                  final destination = destinationById(id);
                  // Checkpoint 5.1: Unknown IDs must not silently show the first item.
                  final Widget content = destination == null
                      ? Scaffold(
                          appBar: AppBar(title: const Text('ไม่พบข้อมูล')),
                          body: const Center(child: Text('ไม่พบข้อมูลที่ต้องการ',
                            style: TextStyle(fontSize: 20))),
                        )
                      : DestinationDetailScreen(destination: destination);
                  // Experiment 7.2: slide-in transition; keeps deep-link fallback.
                  return CustomTransitionPage<void>(
                    key: state.pageKey,
                    child: content,
                    transitionsBuilder: (context, animation, secondaryAnimation, child) {
                      return SlideTransition(
                        position: Tween<Offset>(
                          begin: const Offset(1, 0), end: Offset.zero,
                        ).animate(CurvedAnimation(
                          parent: animation, curve: Curves.easeInOut,
                        )),
                        child: child,
                      );
                    },
                  );
                },
              ),
            ]),
        ]),
        StatefulShellBranch(routes: [
          GoRoute(path: '/saved', name: 'saved',
            builder: (context, state) => const SavedScreen()),
        ]),
        StatefulShellBranch(routes: [
          GoRoute(path: '/profile', name: 'profile',
            builder: (context, state) => const ProfileScreen()),
        ]),
        StatefulShellBranch(routes: [
          GoRoute(path: '/about', name: 'about',
            builder: (context, state) => const AboutScreen()),
        ]),
      ],
    ),
  ],
  errorBuilder: (context, state) => Scaffold(
    appBar: AppBar(title: const Text('ไม่พบหน้า')),
    body: Center(child: Text('ไม่พบหน้าที่ต้องการ: ${state.uri.path}')),
  ),
);
