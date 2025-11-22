import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../features/auth/view/login_screen.dart';
import '../../features/dashboard/views/main_layout_dashboard_screen.dart';
import '../../features/prescription/views/prescription_screen.dart';
import '../../features/splash/view/splash_screen.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: 'splash',
      builder: (context, state) => const SplashScreen1(),
    ),
    GoRoute(
      path: '/login',
      name: 'login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/prescription',
      name: 'prescription',
      builder: (context, state) => const PrescriptionScreenNew(),
    ),
    GoRoute(
      path: '/dashboard',
      name: 'dashboard',
      builder: (context, state) => const MainLayoutDashboardScreen(),
    ),
  ],
);
