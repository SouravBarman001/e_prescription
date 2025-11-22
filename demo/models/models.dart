class DoctorInfo {
  final String name;
  final String qualification;
  final String registration;
  final String phone;
  final String email;
  final String address;

  DoctorInfo({
    required this.name,
    required this.qualification,
    required this.registration,
    required this.phone,
    required this.email,
    required this.address,
  });
}

class PatientInfo {
  final String name;
  final String age;
  final String date;

  PatientInfo({
    required this.name,
    required this.age,
    required this.date,
  });
}

class Medicine {
  final String name;
  final String generic;
  final String dose;
  final String frequency;
  final String duration;

  Medicine({
    required this.name,
    required this.generic,
    required this.dose,
    required this.frequency,
    required this.duration,
  });
}

class RxInfo {
  final String diagnosis;
  final String notes;

  RxInfo({
    required this.diagnosis,
    required this.notes,
  });
}