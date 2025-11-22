import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/models.dart';
import '../providers/state_provider.dart';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:intl/intl.dart';

class PrescriptionScreen extends ConsumerStatefulWidget {
  const PrescriptionScreen({super.key});

  @override
  ConsumerState<PrescriptionScreen> createState() => _PrescriptionScreenState();
}

class _PrescriptionScreenState extends ConsumerState<PrescriptionScreen> {
  late TextEditingController diagnosisCtrl;
  late TextEditingController notesCtrl;
  late TextEditingController medNameCtrl;
  late TextEditingController medGenericCtrl;
  late TextEditingController medDoseCtrl;
  late TextEditingController medFreqCtrl;
  late TextEditingController medDurCtrl;
  
  final ScrollController _rxScrollController = ScrollController();
  final ScrollController _medScrollController = ScrollController();
  
  int selectedTab = 0;
  int? editingMedicineIndex;
  int? editingRxIndex;

  @override
  void initState() {
    super.initState();
    diagnosisCtrl = TextEditingController();
    notesCtrl = TextEditingController();
    medNameCtrl = TextEditingController();
    medGenericCtrl = TextEditingController();
    medDoseCtrl = TextEditingController();
    medFreqCtrl = TextEditingController();
    medDurCtrl = TextEditingController();
    
    // Add listeners to detect overflow
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkOverflow();
    });
    _rxScrollController.addListener(_checkOverflow);
    _medScrollController.addListener(_checkOverflow);
  }

  void _checkOverflow() {
    if (!mounted) return;
    bool overflow = false;
    if (_rxScrollController.hasClients && _rxScrollController.position.maxScrollExtent > 0) {
      overflow = true;
    }
    if (_medScrollController.hasClients && _medScrollController.position.maxScrollExtent > 0) {
      overflow = true;
    }
    
    if (overflow) {
       // Debounce or just show? 
       // Showing snackbar repeatedly is annoying. 
       // I'll just show it once per change? 
       // For now, let's just rely on the user seeing the scrollbar?
       // User explicitly asked for snackbar.
       // I will show it if I haven't shown it recently?
       // Or better, just show it when adding items?
    }
  }

  @override
  void dispose() {
    diagnosisCtrl.dispose();
    notesCtrl.dispose();
    medNameCtrl.dispose();
    medGenericCtrl.dispose();
    medDoseCtrl.dispose();
    medFreqCtrl.dispose();
    medDurCtrl.dispose();
    _rxScrollController.dispose();
    _medScrollController.dispose();
    super.dispose();
  }

  Future<void> _generatePdf(
    DoctorInfo? doctor,
    PatientInfo? patient,
    List<Medicine> medicines,
    List<RxInfo> rxInfo,
  ) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              // Header
              pw.Container(
                decoration: pw.BoxDecoration(
                  color: PdfColor.fromInt(0xFF2C3E8F),
                  borderRadius: pw.BorderRadius.circular(8),
                ),
                padding: const pw.EdgeInsets.all(20),
                child: pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Expanded(
                      child: pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Text(
                            'Dr. ${doctor?.name ?? 'Alex Justin'}',
                            style: pw.TextStyle(
                              fontSize: 24,
                              fontWeight: pw.FontWeight.bold,
                              color: PdfColors.white,
                            ),
                          ),
                          pw.Text(
                            doctor?.qualification ?? 'QUALIFICATION HERE',
                            style: pw.TextStyle(
                              fontSize: 12,
                              color: PdfColor.fromInt(0xFFB8D946),
                            ),
                          ),
                          pw.Text(
                            'Registration No-${doctor?.registration ?? '0000000'}',
                            style: pw.TextStyle(
                              fontSize: 12,
                              color: PdfColors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    pw.Container(
                      width: 80,
                      height: 80,
                      decoration: pw.BoxDecoration(
                        color: PdfColor.fromInt(0xFFB8D946),
                        borderRadius: pw.BorderRadius.circular(10),
                      ),
                      child: pw.Column(
                        mainAxisAlignment: pw.MainAxisAlignment.center,
                        children: [
                          pw.Text(
                            'H',
                            style: pw.TextStyle(
                              fontSize: 32,
                              fontWeight: pw.FontWeight.bold,
                              color: PdfColor.fromInt(0xFF2C3E8F),
                            ),
                          ),
                          pw.Text(
                            'Healthcare',
                            style: pw.TextStyle(
                              fontSize: 10,
                              color: PdfColor.fromInt(0xFF2C3E8F),
                              fontWeight: pw.FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              pw.SizedBox(height: 20),
              // Patient Info
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text('Patient Name: ${patient?.name ?? '_______________'}'),
                  pw.Text('Age: ${patient?.age ?? '___'}'),
                  pw.Text('Date: ${patient?.date ?? '__________'}'),
                ],
              ),
              pw.SizedBox(height: 30),
              // Content
              pw.Expanded(
                child: pw.Row(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    // Rx Info
                    pw.Expanded(
                      flex: 1,
                      child: pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Text(
                            'Rx',
                            style: pw.TextStyle(
                              fontSize: 48,
                              fontWeight: pw.FontWeight.bold,
                              color: PdfColor.fromInt(0xFFB8D946),
                            ),
                          ),
                          pw.SizedBox(height: 15),
                          ...rxInfo.map((rx) => pw.Padding(
                                padding: const pw.EdgeInsets.only(bottom: 10),
                                child: pw.Column(
                                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                                  children: [
                                    pw.Text(
                                      'Diagnosis: ${rx.diagnosis}',
                                      style: pw.TextStyle(
                                        fontSize: 12,
                                        fontWeight: pw.FontWeight.bold,
                                      ),
                                    ),
                                    pw.SizedBox(height: 2),
                                    pw.Text(
                                      'Notes: ${rx.notes}',
                                      style: const pw.TextStyle(fontSize: 12),
                                    ),
                                  ],
                                ),
                              )),
                        ],
                      ),
                    ),
                    pw.VerticalDivider(
                      color: PdfColor.fromInt(0xFFB8D946),
                      thickness: 1,
                      width: 30,
                    ),
                    // Medicines
                    pw.Expanded(
                      flex: 1,
                      child: pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Text(
                            'Medicines:',
                            style: pw.TextStyle(
                              fontSize: 14,
                              fontWeight: pw.FontWeight.bold,
                              color: PdfColor.fromInt(0xFF2C3E8F),
                            ),
                          ),
                          pw.SizedBox(height: 15),
                          ...medicines.map(
                            (med) => pw.Container(
                              margin: const pw.EdgeInsets.only(bottom: 12),
                              padding: const pw.EdgeInsets.all(10),
                              decoration: pw.BoxDecoration(
                                border: pw.Border.all(color: PdfColors.grey300),
                                borderRadius: pw.BorderRadius.circular(6),
                              ),
                              child: pw.Column(
                                crossAxisAlignment: pw.CrossAxisAlignment.start,
                                children: [
                                  pw.Text(
                                    '${med.name} (${med.generic})',
                                    style: pw.TextStyle(
                                      fontWeight: pw.FontWeight.bold,
                                      fontSize: 12,
                                      color: PdfColor.fromInt(0xFF2C3E8F),
                                    ),
                                  ),
                                  pw.SizedBox(height: 5),
                                  pw.Text('Dose: ${med.dose}', style: const pw.TextStyle(fontSize: 11)),
                                  pw.Text('Frequency: ${med.frequency}', style: const pw.TextStyle(fontSize: 11)),
                                  pw.Text('Duration: ${med.duration}', style: const pw.TextStyle(fontSize: 11)),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              // Footer
              pw.Container(
                decoration: pw.BoxDecoration(
                  border: pw.Border(top: pw.BorderSide(color: PdfColors.grey300)),
                ),
                padding: const pw.EdgeInsets.only(top: 15),
                child: pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text('Phone: ${doctor?.phone ?? 'Phone'}', style: const pw.TextStyle(fontSize: 10)),
                    pw.Text('Email: ${doctor?.email ?? 'Email'}', style: const pw.TextStyle(fontSize: 10)),
                    pw.Text('Address: ${doctor?.address ?? 'Address'}', style: const pw.TextStyle(fontSize: 10)),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );

    final String fileName = '${patient?.name ?? 'patient'}_prescription_${patient?.date ?? 'date'}.pdf'
        .replaceAll(' ', '_')
        .replaceAll('/', '-');

    await Printing.sharePdf(bytes: await pdf.save(), filename: fileName);
  }

  @override
  Widget build(BuildContext context) {
    final doctor = ref.watch(doctorInfoProvider);
    final patient = ref.watch(patientInfoProvider);
    final medicines = ref.watch(medicinesProvider);
    final rxInfo = ref.watch(rxInfoProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF2C3E8F),
        title: const Text('E-Prescription Editor',style: TextStyle(
          color: Colors.white
        ),),
        actions: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: ElevatedButton.icon(
              onPressed: () async {
                await _generatePdf(doctor, patient, medicines, rxInfo);
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('PDF Generated Successfully!'),
                      backgroundColor: Color(0xFFB8D946),
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFB8D946),
              ),
              icon: const Icon(Icons.download, color: Color(0xFF2C3E8F)),
              label: const Text(
                'Download PDF',
                style: TextStyle(color: Color(0xFF2C3E8F)),
              ),
            ),
          ),
        ],
      ),
      body: Row(
        children: [

         // Left Panel - Input
          Expanded(
            flex: 2,
            child: Container(
              color: Colors.grey[50],
              child: Column(
                children: [
                  Container(
                    color: Colors.white,
                    child: Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () => setState(() => selectedTab = 0),
                            child: Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: selectedTab == 0
                                        ? const Color(0xFFB8D946)
                                        : Colors.transparent,
                                    width: 3,
                                  ),
                                ),
                              ),
                              child: Text(
                                'Rx Information',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: selectedTab == 0
                                      ? const Color(0xFF2C3E8F)
                                      : Colors.grey,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () => setState(() => selectedTab = 1),
                            child: Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: selectedTab == 1
                                        ? const Color(0xFFB8D946)
                                        : Colors.transparent,
                                    width: 3,
                                  ),
                                ),
                              ),
                              child: Text(
                                'Medicines',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: selectedTab == 1
                                      ? const Color(0xFF2C3E8F)
                                      : Colors.grey,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: selectedTab == 0
                          ? _buildRxTab()
                          : _buildMedicineTab(),
                    ),
                  ),
                ],
              ),
            ),
          ),
          //Right Panel - Preview
          Expanded(
            flex: 5,
            child: Container(
              color: Colors.white,
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Expanded(child: _buildPrescriptionPreview(doctor, patient, medicines)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRxTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Diagnosis',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Color(0xFF2C3E8F),
          ),
        ),
        const SizedBox(height: 5),
        TextField(
          controller: diagnosisCtrl,
          maxLines: 2,
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            contentPadding: const EdgeInsets.all(10),
            hintText: 'Enter diagnosis...',
            isDense: true,
          ),
        ),
        const SizedBox(height: 10),
        const Text(
          'Notes',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Color(0xFF2C3E8F),
          ),
        ),
        const SizedBox(height: 5),
        TextField(
          controller: notesCtrl,
          maxLines: 2,
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            contentPadding: const EdgeInsets.all(10),
            hintText: 'Enter additional notes...',
            isDense: true,
          ),
        ),
        const SizedBox(height: 15),
        ElevatedButton(
          onPressed: () {
            if (diagnosisCtrl.text.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Please enter diagnosis')),
              );
              return;
            }
            final rx = RxInfo(
              diagnosis: diagnosisCtrl.text,
              notes: notesCtrl.text,
            );
            
            final currentList = List<RxInfo>.from(ref.read(rxInfoProvider));
            
            if (editingRxIndex != null) {
              currentList[editingRxIndex!] = rx;
              setState(() {
                editingRxIndex = null;
              });
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Rx Information Updated!'),
                  backgroundColor: Color(0xFFB8D946),
                ),
              );
            } else {
              currentList.add(rx);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Rx Information Added!'),
                  backgroundColor: Color(0xFFB8D946),
                ),
              );
            }
            
            ref.read(rxInfoProvider.notifier).state = currentList;
            diagnosisCtrl.clear();
            notesCtrl.clear();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFB8D946),
            minimumSize: const Size(double.infinity, 40),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Text(
            editingRxIndex != null ? 'Update Rx Info' : 'Add to Prescription',
            style: const TextStyle(
              color: Color(0xFF2C3E8F),
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ),
        const SizedBox(height: 15),
        Expanded(
          child: ListView.builder(
            itemCount: ref.watch(rxInfoProvider).length,
            itemBuilder: (context, index) {
              final rx = ref.watch(rxInfoProvider)[index];
              return Card(
                margin: const EdgeInsets.only(bottom: 8),
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  title: Text(rx.diagnosis, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                  subtitle: Text(rx.notes, style: const TextStyle(fontSize: 12)),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit, color: Colors.blue, size: 20),
                        onPressed: () {
                          diagnosisCtrl.text = rx.diagnosis;
                          notesCtrl.text = rx.notes;
                          setState(() {
                            editingRxIndex = index;
                          });
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red, size: 20),
                        onPressed: () {
                          final list = List<RxInfo>.from(ref.read(rxInfoProvider));
                          list.removeAt(index);
                          ref.read(rxInfoProvider.notifier).state = list;
                          if (editingRxIndex == index) {
                             setState(() {
                               editingRxIndex = null;
                               diagnosisCtrl.clear();
                               notesCtrl.clear();
                             });
                          }
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildMedicineTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildMedicineField('Medicine Name', medNameCtrl),
        _buildMedicineField('Generic Name', medGenericCtrl),
        Row(
          children: [
            Expanded(child: _buildMedicineField('Dose', medDoseCtrl)),
            const SizedBox(width: 10),
            Expanded(child: _buildMedicineField('Frequency', medFreqCtrl)),
            const SizedBox(width: 10),
            Expanded(child: _buildMedicineField('Duration', medDurCtrl)),
          ],
        ),
        const SizedBox(height: 15),
        ElevatedButton(
          onPressed: () {
            if (medNameCtrl.text.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Please enter medicine name')),
              );
              return;
            }
            final medicine = Medicine(
              name: medNameCtrl.text,
              generic: medGenericCtrl.text,
              dose: medDoseCtrl.text,
              frequency: medFreqCtrl.text,
              duration: medDurCtrl.text,
            );
            
            final currentList = List<Medicine>.from(ref.read(medicinesProvider));
            
            if (editingMedicineIndex != null) {
              currentList[editingMedicineIndex!] = medicine;
              setState(() {
                editingMedicineIndex = null;
              });
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Medicine Updated!'),
                  backgroundColor: Color(0xFFB8D946),
                ),
              );
            } else {
              currentList.add(medicine);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Medicine Added!'),
                  backgroundColor: Color(0xFFB8D946),
                ),
              );
            }
            
            ref.read(medicinesProvider.notifier).state = currentList;
            medNameCtrl.clear();
            medGenericCtrl.clear();
            medDoseCtrl.clear();
            medFreqCtrl.clear();
            medDurCtrl.clear();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFB8D946),
            minimumSize: const Size(double.infinity, 40),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Text(
            editingMedicineIndex != null ? 'Update Medicine' : 'Add to Prescription',
            style: const TextStyle(
              color: Color(0xFF2C3E8F),
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ),
        const SizedBox(height: 15),
        Expanded(
          child: ListView.builder(
            itemCount: ref.watch(medicinesProvider).length,
            itemBuilder: (context, index) {
              final med = ref.watch(medicinesProvider)[index];
              return Card(
                margin: const EdgeInsets.only(bottom: 8),
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  title: Text(med.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                  subtitle: Text('${med.generic} - ${med.dose}', style: const TextStyle(fontSize: 12)),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit, color: Colors.blue, size: 20),
                        onPressed: () {
                          medNameCtrl.text = med.name;
                          medGenericCtrl.text = med.generic;
                          medDoseCtrl.text = med.dose;
                          medFreqCtrl.text = med.frequency;
                          medDurCtrl.text = med.duration;
                          setState(() {
                            editingMedicineIndex = index;
                          });
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red, size: 20),
                        onPressed: () {
                          final list = List<Medicine>.from(
                            ref.read(medicinesProvider),
                          );
                          list.removeAt(index);
                          ref.read(medicinesProvider.notifier).state = list;
                          if (editingMedicineIndex == index) {
                             setState(() {
                               editingMedicineIndex = null;
                               medNameCtrl.clear();
                               medGenericCtrl.clear();
                               medDoseCtrl.clear();
                               medFreqCtrl.clear();
                               medDurCtrl.clear();
                             });
                          }
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildMedicineField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2C3E8F),
            ),
          ),
          const SizedBox(height: 5),
          TextField(
            controller: controller,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              contentPadding: const EdgeInsets.all(10),
              hintText: 'Enter $label',
              isDense: true,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPrescriptionPreview(
    DoctorInfo? doctor,
    PatientInfo? patient,
    List<Medicine> medicines,
  ) {
    final rxInfo = ref.watch(rxInfoProvider);

    // Check overflow after build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if ((_rxScrollController.hasClients && _rxScrollController.position.maxScrollExtent > 0) ||
          (_medScrollController.hasClients && _medScrollController.position.maxScrollExtent > 0)) {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Warning: Content exceeds A4 page size!'),
            backgroundColor: Colors.orange,
            duration: Duration(seconds: 2),
          ),
        );
      }
    });

    return Center(
      child: SingleChildScrollView(
        child: AspectRatio(
          aspectRatio: 1 / 1.414, // A4 Aspect Ratio
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey[300]!),
              borderRadius: BorderRadius.circular(8),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header with gradient
                Container(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Color(0xFF2C3E8F), Color(0xFF1A5C7A)],
                    ),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8),
                    ),
                  ),
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Dr. ${doctor?.name ?? 'Alex Justin'}',
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              doctor?.qualification ?? 'QUALIFICATION HERE',
                              style: const TextStyle(
                                fontSize: 12,
                                color: Color(0xFFB8D946),
                              ),
                            ),
                            Text(
                              'Registration No-${doctor?.registration ?? '0000000'}',
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.white70,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: const Color(0xFFB8D946),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'H',
                              style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF2C3E8F),
                              ),
                            ),
                            Text(
                              'Healthcare',
                              style: TextStyle(
                                fontSize: 10,
                                color: Color(0xFF2C3E8F),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                // Patient Info Row
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Patient Name: ${patient?.name ?? '_______________'}',
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        'Age: ${patient?.age ?? '___'}',
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        'Date: ${patient?.date ?? '__________'}',
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                // Rx Section
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Left Side: Rx Information
                        Expanded(
                          flex: 1,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'ℜ',
                                style: TextStyle(
                                  fontSize: 48,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFFB8D946),
                                ),
                              ),
                              const SizedBox(height: 15),
                              Expanded(
                                child: ListView(
                                  controller: _rxScrollController,
                                  children: [
                                    if (rxInfo.isNotEmpty) ...[
                                      ...rxInfo.map((rx) => Padding(
                                        padding: const EdgeInsets.only(bottom: 10),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Diagnosis: ${rx.diagnosis}',
                                              style: const TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            const SizedBox(height: 2),
                                            Text(
                                              'Notes: ${rx.notes}',
                                              style: const TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                      )),
                                    ] else
                                      const Text(
                                        'No Rx information added yet',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey,
                                          fontStyle: FontStyle.italic,
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        
                        // Vertical Divider
                        const VerticalDivider(
                          color: Color(0xFFB8D946),
                          thickness: 1,
                          width: 30,
                        ),

                        // Right Side: Medicines
                        Expanded(
                          flex: 1,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Medicines:',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF2C3E8F),
                                ),
                              ),
                              const SizedBox(height: 15),
                              Expanded(
                                child: ListView(
                                  controller: _medScrollController,
                                  children: [
                                    if (medicines.isNotEmpty) ...[
                                      ...medicines.map(
                                        (med) => Container(
                                          margin: const EdgeInsets.only(bottom: 12),
                                          padding: const EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Colors.grey[300]!),
                                            borderRadius: BorderRadius.circular(6),
                                          ),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                '${med.name} (${med.generic})',
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 12,
                                                  color: Color(0xFF2C3E8F),
                                                ),
                                              ),
                                              const SizedBox(height: 5),
                                              Text(
                                                'Dose: ${med.dose}',
                                                style: const TextStyle(fontSize: 11),
                                              ),
                                              Text(
                                                'Frequency: ${med.frequency}',
                                                style: const TextStyle(fontSize: 11),
                                              ),
                                              Text(
                                                'Duration: ${med.duration}',
                                                style: const TextStyle(fontSize: 11),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ] else
                                      Container(
                                        padding: const EdgeInsets.all(15),
                                        decoration: BoxDecoration(
                                          color: Colors.grey[50],
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        child: const Text(
                                          'No medicines added yet',
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.grey,
                                            fontStyle: FontStyle.italic,
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 40),
                // Footer
                Container(
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(color: Colors.grey[300]!, width: 1),
                    ),
                  ),
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.phone,
                                size: 14,
                                color: Color(0xFF2C3E8F),
                              ),
                              const SizedBox(width: 5),
                              Text(
                                doctor?.phone ?? 'Phone',
                                style: const TextStyle(fontSize: 10),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.email,
                                size: 14,
                                color: Color(0xFF2C3E8F),
                              ),
                              const SizedBox(width: 5),
                              Text(
                                doctor?.email ?? 'Email',
                                style: const TextStyle(fontSize: 10),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.location_on,
                                size: 14,
                                color: Color(0xFF2C3E8F),
                              ),
                              const SizedBox(width: 5),
                              Text(
                                doctor?.address ?? 'Address',
                                style: const TextStyle(fontSize: 10),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
