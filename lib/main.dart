import 'package:flutter/material.dart';
import 'package:flutter_prescription/features/splash/view/splash_screen.dart';
// import 'package:flutter_prescription/providers/state_provider.dart';
// import 'package:flutter_prescription/views/doctor_info_screen.dart';
// import 'package:flutter_prescription/views/patient_info_screen.dart';
// import 'package:flutter_prescription/views/prescription_screen.dart';
// import 'package:flutter_prescription/views/splash_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// void main() {
//   runApp(const ProviderScope(child: MyApp()));
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'E-Prescription',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         primaryColor: const Color(0xFF2C3E8F),
//         scaffoldBackgroundColor: Colors.white,
//         useMaterial3: true,
//       ),
//       home: const AppNavigator(),
//     );
//   }
// }
//
// class AppNavigator extends ConsumerWidget {
//   const AppNavigator({super.key});
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final appState = ref.watch(appStateProvider);
//
//     switch (appState) {
//       case AppState.splash:
//         return const SplashScreen();
//       case AppState.doctorInfo:
//         return const DoctorInfoScreen();
//       case AppState.patientInfo:
//         return const PatientInfoScreen();
//       case AppState.prescription:
//         return const PrescriptionScreen();
//     }
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import 'core/route/router.dart';
import 'core/theme/theme.dart';
import 'features/dashboard/views/main_layout_dashboard_screen.dart' hide AppTheme;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(1440, 900),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp.router(
          title: 'Medical Dashboard',
          theme: AppTheme.lightTheme,
          debugShowCheckedModeBanner: false,
          routerConfig: appRouter,
        );
      },
    );
  }
}
