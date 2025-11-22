import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// Models
class ComplaintItem {
  String id;
  String name;
  String? duration;
  String? note;

  ComplaintItem({
    required this.id,
    required this.name,
    this.duration,
    this.note,
  });
}

class MedicineItem {
  String id;
  String medicineName;
  String? dosage;
  String? quantity;
  String? frequency;
  String? duration;
  String? note;

  MedicineItem({
    required this.id,
    required this.medicineName,
    this.dosage,
    this.quantity,
    this.frequency,
    this.duration,
    this.note,
  });
}

class PrescriptionScreenNew extends StatefulWidget {
  const PrescriptionScreenNew({super.key});

  @override
  State<PrescriptionScreenNew> createState() => _PrescriptionScreenState();
}

class _PrescriptionScreenState extends State<PrescriptionScreenNew> {
  // Data lists
  List<ComplaintItem> chiefComplaints = [
    ComplaintItem(
      id: '1',
      name: 'Chest pain & excertain',
      duration: '(for 5 days)',
      note: 'Pain liregular',
    ),
    ComplaintItem(
      id: '2',
      name: 'No angina',
      duration: '(for 10 days)',
    ),
    ComplaintItem(
      id: '3',
      name: 'Tiriedness',
      duration: '(for 1 month)',
      note: 'Most of the time',
    ),
  ];

  List<ComplaintItem> historyItems = [
    ComplaintItem(
      id: '1',
      name: 'CUD',
      duration: '(for 5 days)',
      note: 'Pain liregular',
    ),
    ComplaintItem(
      id: '2',
      name: 'HID/CAD',
      duration: '(for 10 days)',
    ),
    ComplaintItem(
      id: '3',
      name: 'Cholesterol',
      duration: '(for 1 month)',
      note: 'Most of the time',
    ),
  ];

  List<ComplaintItem> diagnosisItems = [
    ComplaintItem(
      id: '1',
      name: 'Pop smear',
      note: 'Pain liregular',
    ),
    ComplaintItem(
      id: '2',
      name: 'Lumbar puncture',
    ),
  ];

  List<ComplaintItem> investigationItems = [
    ComplaintItem(
      id: '1',
      name: 'CBC',
      note: 'Note here',
    ),
    ComplaintItem(
      id: '2',
      name: 'Blood grouping',
    ),
    ComplaintItem(
      id: '3',
      name: 'RBC Count',
      note: 'Show note of the investigation',
    ),
  ];

  List<MedicineItem> medicines = [
    MedicineItem(
      id: '1',
      medicineName: 'Tab. Pantonix 40 mg',
      quantity: '০০ Ph',
      dosage: '১ x ১ বেলা',
      frequency: 'খাবার পরে',
      duration: '১৫ দিন',
      note: 'Note: খালি হলে খাবেন',
    ),
    MedicineItem(
      id: '2',
      medicineName: 'In. Osertill 100 mg (Capsule)',
      quantity: '১৫ Pcs',
      dosage: '.৫ x ১ বেলা',
      frequency: 'খাবার পরে',
      duration: 'চলবে',
    ),
    MedicineItem(
      id: '3',
      medicineName: 'Tab. Pantonix 40 mg',
      quantity: '০০ Ph',
      dosage: '১ x ১২ ঘন্টা পর পর',
      duration: '১৫ দিন',
      note: 'Note: খালি হলে খাবেন',
    ),
  ];

  String advice = '';
  String followUp = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      // appBar: AppBar(
      //   backgroundColor: Colors.white,
      //   elevation: 0,
      //   title: Row(
      //     children: [
      //       Text(
      //         'Prescriptions',
      //         style: TextStyle(
      //           fontSize: 16,
      //           color: Colors.grey.shade600,
      //           fontWeight: FontWeight.normal,
      //         ),
      //       ),
      //       Padding(
      //         padding: EdgeInsets.symmetric(horizontal: 8.w),
      //         child: Icon(
      //           Icons.chevron_right,
      //           color: Colors.grey.shade400,
      //           size: 20,
      //         ),
      //       ),
      //       const Text(
      //         'Add new',
      //         style: TextStyle(
      //           fontSize: 16,
      //           color: Color(0xFF2C3E50),
      //           fontWeight: FontWeight.w600,
      //         ),
      //       ),
      //     ],
      //   ),
      //   actions: [
      //     Padding(
      //       padding: EdgeInsets.only(right: 16.w),
      //       child: Container(
      //         padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
      //         decoration: BoxDecoration(
      //           color: const Color(0xFF4A9B8E),
      //           borderRadius: BorderRadius.circular(25.r),
      //         ),
      //         child: Row(
      //           mainAxisSize: MainAxisSize.min,
      //           children: [
      //             const Text(
      //               'Template Type',
      //               style: TextStyle(
      //                 fontSize: 14,
      //                 color: Colors.white,
      //                 fontWeight: FontWeight.w500,
      //               ),
      //             ),
      //             SizedBox(width: 8.w),
      //             const Icon(
      //               Icons.keyboard_arrow_down,
      //               color: Colors.white,
      //               size: 20,
      //             ),
      //           ],
      //         ),
      //       ),
      //     ),
      //   ],
      // ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(24.w),
            child: _buildA4PrescriptionForm(),
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomActionBar(),
    );
  }

  Widget _buildA4PrescriptionForm() {
    return Container(
      width: 794.w,
      constraints: BoxConstraints(minHeight: 1123.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: EdgeInsets.all(40.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          SizedBox(height: 30.h),
          _buildPatientInfo(),
          SizedBox(height: 30.h),
          _buildMainContent(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Dr Rashid Khan',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF4A9B8E),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'MBBS, FCPS, PGT (Diploma)',
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey.shade600,
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'Assitent professor, Medicine',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF4CAF50),
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'Popular diagnosis center and hospital, Mirpur 10',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade600,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                'Email: doctor@neeramoy.com',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade600,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                'Cell: +01293347324, +01293347324,',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade600,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'BMDC: Dnf874',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade800,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        Container(
          width: 100.w,
          height: 100.w,
          decoration: BoxDecoration(
            color: const Color(0xFF4CAF50),
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: const Center(
            child: Text(
              'POPULAR',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPatientInfo() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: Colors.grey.shade300),
          bottom: BorderSide(color: Colors.grey.shade300),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [
                Text(
                  'Patient: ',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey.shade600,
                  ),
                ),
                const Text(
                  'Abdus Sattar Rahim',
                  style: TextStyle(
                    fontSize: 13,
                    color: Color(0xFF2C3E50),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(width: 16.w),
                Text(
                  'Age: ',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey.shade600,
                  ),
                ),
                const Text(
                  '35 years',
                  style: TextStyle(
                    fontSize: 13,
                    color: Color(0xFF2C3E50),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(width: 16.w),
                Text(
                  'Weight: ',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey.shade600,
                  ),
                ),
                const Text(
                  '55kg',
                  style: TextStyle(
                    fontSize: 13,
                    color: Color(0xFF2C3E50),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Text(
                'Date: ',
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey.shade600,
                ),
              ),
              const Text(
                '13 September, 2022',
                style: TextStyle(
                  fontSize: 13,
                  color: Color(0xFF2C3E50),
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(width: 16.w),
              Text(
                'Time: ',
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey.shade600,
                ),
              ),
              const Text(
                '10:20 am',
                style: TextStyle(
                  fontSize: 13,
                  color: Color(0xFF2C3E50),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMainContent() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Left Column
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildChiefComplaints(),
              SizedBox(height: 30.h),
              _buildHistory(),
              SizedBox(height: 30.h),
              _buildDiagnosis(),
              SizedBox(height: 30.h),
              _buildInvestigation(),
            ],
          ),
        ),
        SizedBox(width: 24.w),
        // Right Column
        Expanded(
          flex: 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildMedicine(),
              SizedBox(height: 30.h),
              _buildAdvice(),
              SizedBox(height: 30.h),
              _buildFollowUp(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSectionHeader(String title, VoidCallback onAdd) {
    return Row(
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xFF4A9B8E),
          ),
        ),
        SizedBox(width: 8.w),
        InkWell(
          onTap: onAdd,
          child: FaIcon(
            FontAwesomeIcons.circlePlus,
            size: 16,
            color: Colors.grey.shade500,
          ),
        ),
      ],
    );
  }

  Widget _buildChiefComplaints() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader('Chief Complaints', () {
          _showComplaintDialog(
            title: 'Add Chief Complaint',
            onSave: (item) {
              setState(() {
                chiefComplaints.add(item);
              });
            },
          );
        }),
        SizedBox(height: 12.h),
        ...chiefComplaints.map((item) =>
            Padding(
              padding: EdgeInsets.only(bottom: 8.h),
              child: _buildComplaintItem(
                item,
                onEdit: () {
                  _showComplaintDialog(
                    title: 'Edit Chief Complaint',
                    item: item,
                    onSave: (updatedItem) {
                      setState(() {
                        int index = chiefComplaints.indexOf(item);
                        chiefComplaints[index] = updatedItem;
                      });
                    },
                  );
                },
                onDelete: () {
                  setState(() {
                    chiefComplaints.remove(item);
                  });
                },
              ),
            )),
      ],
    );
  }

  Widget _buildHistory() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader('History', () {
          _showComplaintDialog(
            title: 'Add History',
            onSave: (item) {
              setState(() {
                historyItems.add(item);
              });
            },
          );
        }),
        SizedBox(height: 12.h),
        ...historyItems.map((item) =>
            Padding(
              padding: EdgeInsets.only(bottom: 8.h),
              child: _buildComplaintItem(
                item,
                onEdit: () {
                  _showComplaintDialog(
                    title: 'Edit History',
                    item: item,
                    onSave: (updatedItem) {
                      setState(() {
                        int index = historyItems.indexOf(item);
                        historyItems[index] = updatedItem;
                      });
                    },
                  );
                },
                onDelete: () {
                  setState(() {
                    historyItems.remove(item);
                  });
                },
              ),
            )),
      ],
    );
  }

  Widget _buildDiagnosis() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader('Diagnosis', () {
          _showComplaintDialog(
            title: 'Add Diagnosis',
            onSave: (item) {
              setState(() {
                diagnosisItems.add(item);
              });
            },
          );
        }),
        SizedBox(height: 12.h),
        ...diagnosisItems.map((item) =>
            Padding(
              padding: EdgeInsets.only(bottom: 8.h),
              child: _buildComplaintItem(
                item,
                onEdit: () {
                  _showComplaintDialog(
                    title: 'Edit Diagnosis',
                    item: item,
                    onSave: (updatedItem) {
                      setState(() {
                        int index = diagnosisItems.indexOf(item);
                        diagnosisItems[index] = updatedItem;
                      });
                    },
                  );
                },
                onDelete: () {
                  setState(() {
                    diagnosisItems.remove(item);
                  });
                },
              ),
            )),
      ],
    );
  }

  Widget _buildInvestigation() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader('Investigation', () {
          _showComplaintDialog(
            title: 'Add Investigation',
            onSave: (item) {
              setState(() {
                investigationItems.add(item);
              });
            },
          );
        }),
        SizedBox(height: 12.h),
        ...investigationItems.map((item) =>
            Padding(
              padding: EdgeInsets.only(bottom: 8.h),
              child: _buildComplaintItem(
                item,
                onEdit: () {
                  _showComplaintDialog(
                    title: 'Edit Investigation',
                    item: item,
                    onSave: (updatedItem) {
                      setState(() {
                        int index = investigationItems.indexOf(item);
                        investigationItems[index] = updatedItem;
                      });
                    },
                  );
                },
                onDelete: () {
                  setState(() {
                    investigationItems.remove(item);
                  });
                },
              ),
            )),
      ],
    );
  }

  Widget _buildComplaintItem(ComplaintItem item, {
    required VoidCallback onEdit,
    required VoidCallback onDelete,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 6,
          height: 6,
          margin: const EdgeInsets.only(top: 6),
          decoration: const BoxDecoration(
            color: Color(0xFF2C3E50),
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: 8.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Text(
                          item.name,
                          style: const TextStyle(
                            fontSize: 13,
                            color: Color(0xFF2C3E50),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        if (item.duration != null &&
                            item.duration!.isNotEmpty) ...[
                          SizedBox(width: 6.w),
                          Text(
                            item.duration!,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey.shade600,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: onEdit,
                    child: Padding(
                      padding: EdgeInsets.all(4.w),
                      child: FaIcon(
                        FontAwesomeIcons.penToSquare,
                        size: 12,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ),
                  SizedBox(width: 4.w),
                  InkWell(
                    onTap: onDelete,
                    child: Padding(
                      padding: EdgeInsets.all(4.w),
                      child: FaIcon(
                        FontAwesomeIcons.trashCan,
                        size: 12,
                        color: Colors.red.shade400,
                      ),
                    ),
                  ),
                ],
              ),
              if (item.note != null && item.note!.isNotEmpty) ...[
                const SizedBox(height: 2),
                Text(
                  item.note!,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade500,
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMedicine() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader('Medicine (Rx)', () {
          _showMedicineDialog(
            title: 'Add Medicine',
            onSave: (item) {
              setState(() {
                medicines.add(item);
              });
            },
          );
        }),
        SizedBox(height: 12.h),
        ...medicines
            .asMap()
            .entries
            .map((entry) {
          int index = entry.key;
          MedicineItem item = entry.value;
          return Padding(
            padding: EdgeInsets.only(bottom: 2.h),
            child: _buildMedicineItem(index + 1, item),
          );
        }),
      ],
    );
  }

  Widget _buildMedicineItem(int number, MedicineItem item) {
    String dosageText = '';
    List<String> dosageParts = [];

    if (item.dosage != null && item.dosage!.isNotEmpty) {
      dosageParts.add(item.dosage!);
    }
    if (item.frequency != null && item.frequency!.isNotEmpty) {
      dosageParts.add(item.frequency!);
    }
    if (item.duration != null && item.duration!.isNotEmpty) {
      dosageParts.add(item.duration!);
    }

    dosageText = dosageParts.join(' _________________ ');

    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
       // border: Border.all(color: Colors.grey.shade300),
       // borderRadius: BorderRadius.circular(6.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '$number.',
                style: const TextStyle(
                  fontSize: 13,
                  color: Color(0xFF2C3E50),
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            '${item.medicineName}${item.quantity != null &&
                                item.quantity!.isNotEmpty ? ' ---- ${item
                                .quantity}' : ''}',
                            style: const TextStyle(
                              fontSize: 13,
                              color: Color(0xFF2C3E50),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    if (dosageText.isNotEmpty) ...[
                      const SizedBox(height: 4),
                      Text(
                        dosageText,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade700,
                        ),
                      ),
                    ],
                    if (item.note != null && item.note!.isNotEmpty) ...[
                      const SizedBox(height: 4),
                      Text(
                        item.note!,
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.grey.shade600,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  _showMedicineDialog(
                    title: 'Edit Medicine',
                    item: item,
                    onSave: (updatedItem) {
                      setState(() {
                        int index = medicines.indexOf(item);
                        medicines[index] = updatedItem;
                      });
                    },
                  );
                },
                child: Padding(
                  padding: EdgeInsets.all(4.w),
                  child: FaIcon(
                    FontAwesomeIcons.penToSquare,
                    size: 12,
                    color: Colors.grey.shade600,
                  ),
                ),
              ),
              SizedBox(width: 4.w),
              InkWell(
                onTap: () {
                  setState(() {
                    medicines.remove(item);
                  });
                },
                child: Padding(
                  padding: EdgeInsets.all(4.w),
                  child: FaIcon(
                    FontAwesomeIcons.trashCan,
                    size: 12,
                    color: Colors.red.shade400,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAdvice() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Advice',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xFF4A9B8E),
          ),
        ),
        SizedBox(height: 12.h),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(6.r),
          ),
          child: TextField(
            maxLines: 2,
            onChanged: (value) {
              advice = value;
            },
            decoration: InputDecoration(
              hintText: 'Enter advice...',
              hintStyle: TextStyle(
                fontSize: 13,
                color: Colors.grey.shade400,
              ),
              border: InputBorder.none,
              contentPadding: EdgeInsets.all(12.w),
            ),
            style: const TextStyle(
              fontSize: 13,
              color: Color(0xFF2C3E50),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFollowUp() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Follow up',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xFF4A9B8E),
          ),
        ),
        SizedBox(height: 12.h),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(6.r),
          ),
          child: TextField(
            maxLines: 2,
            onChanged: (value) {
              followUp = value;
            },
            decoration: InputDecoration(
              hintText: 'Enter follow up details...',
              hintStyle: TextStyle(
                fontSize: 13,
                color: Colors.grey.shade400,
              ),
              border: InputBorder.none,
              contentPadding: EdgeInsets.all(12.w),
            ),
            style: const TextStyle(
              fontSize: 13,
              color: Color(0xFF2C3E50),
            ),
          ),
        ),
      ],
    );
  }

  // Dialog for Chief Complaints, History, Diagnosis, Investigation
  void _showComplaintDialog({
    required String title,
    ComplaintItem? item,
    required Function(ComplaintItem) onSave,
  }) {
    final nameController = TextEditingController(text: item?.name ?? '');
    final durationController = TextEditingController(
        text: item?.duration ?? '');
    final noteController = TextEditingController(text: item?.note ?? '');

    showDialog(
      context: context,
      builder: (context) =>
          Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Container(
              width: 500.w,
              padding: EdgeInsets.all(24.w),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF4A9B8E),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  _buildDialogTextField(
                    controller: nameController,
                    label: 'Name*',
                    hint: 'Enter name',
                  ),
                  SizedBox(height: 16.h),
                  _buildDialogTextField(
                    controller: durationController,
                    label: 'Duration',
                    hint: 'e.g., (for 5 days)',
                  ),
                  SizedBox(height: 16.h),
                  _buildDialogTextField(
                    controller: noteController,
                    label: 'Note',
                    hint: 'Enter note',
                    maxLines: 3,
                  ),
                  SizedBox(height: 24.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      OutlinedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.grey.shade700,
                          padding: EdgeInsets.symmetric(
                              horizontal: 20.w, vertical: 12.h),
                          side: BorderSide(color: Colors.grey.shade300),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                        ),
                        child: const Text(
                          'Cancel',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w600),
                        ),
                      ),
                      SizedBox(width: 12.w),
                      ElevatedButton(
                        onPressed: () {
                          if (nameController.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Please enter a name')),
                            );
                            return;
                          }

                          final newItem = ComplaintItem(
                            id: item?.id ?? DateTime.now().toString(),
                            name: nameController.text,
                            duration: durationController.text.isEmpty
                                ? null
                                : durationController.text,
                            note: noteController.text.isEmpty
                                ? null
                                : noteController.text,
                          );

                          onSave(newItem);
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF4A9B8E),
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(
                              horizontal: 20.w, vertical: 12.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                        ),
                        child: const Text(
                          'Save',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
    );
  }

  // Dialog for Medicine
  void _showMedicineDialog({
    required String title,
    MedicineItem? item,
    required Function(MedicineItem) onSave,
  }) {
    final medicineNameController = TextEditingController(
        text: item?.medicineName ?? '');
    final dosageController = TextEditingController(text: item?.dosage ?? '');
    final quantityController = TextEditingController(
        text: item?.quantity ?? '');
    final frequencyController = TextEditingController(
        text: item?.frequency ?? '');
    final durationController = TextEditingController(
        text: item?.duration ?? '');
    final noteController = TextEditingController(text: item?.note ?? '');

    showDialog(
      context: context,
      builder: (context) =>
          Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Container(
              width: 600.w,
              padding: EdgeInsets.all(24.w),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF4A9B8E),
                      ),
                    ),
                    SizedBox(height: 20.h),
                    _buildDialogTextField(
                      controller: medicineNameController,
                      label: 'Medicine Name*',
                      hint: 'Enter medicine name',
                    ),
                    SizedBox(height: 16.h),
                    Row(
                      children: [
                        Expanded(
                          child: _buildDialogTextField(
                            controller: dosageController,
                            label: 'Dosage',
                            hint: 'e.g., ১ x ১ বেলা',
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: _buildDialogTextField(
                            controller: quantityController,
                            label: 'Quantity',
                            hint: 'e.g., ০০ Ph',
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.h),
                    Row(
                      children: [
                        Expanded(
                          child: _buildDialogTextField(
                            controller: frequencyController,
                            label: 'Frequency',
                            hint: 'e.g., খাবার পরে',
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: _buildDialogTextField(
                            controller: durationController,
                            label: 'Duration',
                            hint: 'e.g., ১৫ দিন',
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.h),
                    _buildDialogTextField(
                      controller: noteController,
                      label: 'Note',
                      hint: 'Enter note',
                      maxLines: 3,
                    ),
                    SizedBox(height: 24.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        OutlinedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.grey.shade700,
                            padding: EdgeInsets.symmetric(
                                horizontal: 20.w, vertical: 12.h),
                            side: BorderSide(color: Colors.grey.shade300),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                          ),
                          child: const Text(
                            'Cancel',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w600),
                          ),
                        ),
                        SizedBox(width: 12.w),
                        ElevatedButton(
                          onPressed: () {
                            if (medicineNameController.text.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text(
                                    'Please enter medicine name')),
                              );
                              return;
                            }

                            final newItem = MedicineItem(
                              id: item?.id ?? DateTime.now().toString(),
                              medicineName: medicineNameController.text,
                              dosage: dosageController.text.isEmpty
                                  ? null
                                  : dosageController.text,
                              quantity: quantityController.text.isEmpty
                                  ? null
                                  : quantityController.text,
                              frequency: frequencyController.text.isEmpty
                                  ? null
                                  : frequencyController.text,
                              duration: durationController.text.isEmpty
                                  ? null
                                  : durationController.text,
                              note: noteController.text.isEmpty
                                  ? null
                                  : noteController.text,
                            );

                            onSave(newItem);
                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF4A9B8E),
                            foregroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(
                                horizontal: 20.w, vertical: 12.h),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                          ),
                          child: const Text(
                            'Save',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
    );
  }

  Widget _buildDialogTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: Color(0xFF2C3E50),
          ),
        ),
        SizedBox(height: 8.h),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: TextField(
            controller: controller,
            maxLines: maxLines,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(
                fontSize: 13,
                color: Colors.grey.shade400,
              ),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(
                  horizontal: 12.w, vertical: 10.h),
            ),
            style: const TextStyle(
              fontSize: 13,
              color: Color(0xFF2C3E50),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBottomActionBar() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton.icon(
            onPressed: () {},
            icon: const FaIcon(FontAwesomeIcons.check, size: 16),
            label: const Text(
              'Save & Send',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF4A9B8E),
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 14.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.r),
              ),
            ),
          ),
          SizedBox(width: 12.w),
          OutlinedButton.icon(
            onPressed: () {},
            icon: const FaIcon(FontAwesomeIcons.eye, size: 16),
            label: const Text(
              'Preview',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.grey.shade700,
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 14.h),
              side: BorderSide(color: Colors.grey.shade300),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.r),
              ),
            ),
          ),
          SizedBox(width: 12.w),
          ElevatedButton.icon(
            onPressed: () {},
            icon: const FaIcon(FontAwesomeIcons.floppyDisk, size: 16),
            label: const Text(
              'Save as Template',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF7C4DFF),
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 14.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.r),
              ),
            ),
          ),
          SizedBox(width: 12.w),
          OutlinedButton.icon(
            onPressed: () {},
            icon: const FaIcon(FontAwesomeIcons.print, size: 16),
            label: const Text(
              'Print',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.grey.shade700,
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 14.h),
              side: BorderSide(color: Colors.grey.shade300),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.r),
              ),
            ),
          ),
          SizedBox(width: 12.w),
          OutlinedButton.icon(
            onPressed: () {},
            icon: const FaIcon(FontAwesomeIcons.xmark, size: 16),
            label: const Text(
              'Cancel',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.grey.shade700,
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 14.h),
              side: BorderSide(color: Colors.grey.shade300),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.r),
              ),
            ),
          ),
        ],
      ),
    );
  }
}