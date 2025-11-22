import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/state_provider.dart';


class SplashScreen extends ConsumerWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF2C3E8F), Color(0xFF1A5C7A)],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: const Color(0xFFB8D946),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Icon(
                  Icons.medical_services,
                  size: 60,
                  color: Color(0xFF2C3E8F),
                ),
              ),
              const SizedBox(height: 30),
              const Text(
                'Healthcare',
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const Text(
                'Medical Clinic',
                style: TextStyle(
                  fontSize: 18,
                  color: Color(0xFFB8D946),
                  letterSpacing: 2,
                ),
              ),
              const SizedBox(height: 60),
              ElevatedButton(
                onPressed: () {
                  ref.read(appStateProvider.notifier).state = AppState.doctorInfo;
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFB8D946),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 50,
                    vertical: 15,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Get Started',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2C3E8F),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}