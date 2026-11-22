
import 'package:flutter/material.dart';

import '../models/activity_model.dart';
import '../viewmodels/activity_viewmodel.dart';

class ActivityFormView extends StatefulWidget {
  final ActivityViewModel viewModel;
  final ActivityModel? activity;

  const ActivityFormView({
    super.key,
    required this.viewModel,
    this.activity,
  });

  @override
  State<ActivityFormView> createState() => _ActivityFormViewState();
}

class _ActivityFormViewState extends State<ActivityFormView> {
  late final TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(
      text: widget.activity?.name ?? '',
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void saveActivity() {
    final name = controller.text.trim();

    if (name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Nama aktivitas tidak boleh kosong.'),
        ),
      );
      return;
    }

    if (widget.activity == null) {
      widget.viewModel.addActivity(name);
    } else {
      widget.viewModel.updateActivity(widget.activity!.id, name);
    }

    Navigator.pop(context, widget.activity == null);
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.activity != null;

    return Scaffold(
      backgroundColor: const Color(0xFF100D12),
      appBar: AppBar(
        title: Text(isEditing ? 'Edit Aktivitas' : 'Tambah Aktivitas'),
        foregroundColor: Colors.white,
        backgroundColor: const Color(0xFF100D12),
      ),
      body: Padding(
        padding: const EdgeInsets.all(22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Nama Aktivitas',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 14),
            TextField(
              controller: controller,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Contoh: Olahraga',
                hintStyle: const TextStyle(color: Colors.white38),
                filled: true,
                fillColor: const Color(0xFF211B24),
                prefixIcon: const Icon(
                  Icons.edit,
                  color: Color(0xFFFF3D9A),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(
                    color: Color(0xFF493044),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(
                    color: Color(0xFFFF3D9A),
                    width: 2,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 25),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: saveActivity,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFF3D9A),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.all(17),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: Text(
                  isEditing ? 'Simpan Perubahan' : 'Simpan Aktivitas',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
