import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/models.dart';


final doctorInfoProvider = StateProvider<DoctorInfo?>((ref) => null);
final patientInfoProvider = StateProvider<PatientInfo?>((ref) => null);
final medicinesProvider = StateProvider<List<Medicine>>((ref) => []);
final rxInfoProvider = StateProvider<List<RxInfo>>((ref) => []);
final appStateProvider = StateProvider<AppState>((ref) => AppState.splash);

enum AppState { splash, doctorInfo, patientInfo, prescription }