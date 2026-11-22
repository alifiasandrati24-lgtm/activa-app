
import 'package:flutter/material.dart';

import '../models/activity_model.dart';
import '../viewmodels/activity_viewmodel.dart';
import 'activity_form_view.dart';
import 'activity_detail_view.dart';

class HomeView extends StatelessWidget {
  final ActivityViewModel viewModel;

  const HomeView({
    super.key,
    required this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    const pink = Color(0xFFFF3D9A);
    const darkCard = Color(0xFF211B24);

    return Scaffold(
      backgroundColor: const Color(0xFF100D12),
      appBar: AppBar(
        title: const Text(
          'ACTIVA',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            letterSpacing: 3,
            color: pink,
          ),
        ),
        centerTitle: true,
      ),
      body: AnimatedBuilder(
        animation: viewModel,
        builder: (context, child) {
          final List<ActivityModel> activities = viewModel.activities;

          final int total = activities.fold(
            0,
            (sum, item) => sum + item.counter,
          );

          return Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFF30202E),
                        Color(0xFF171219),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(22),
                    border: Border.all(
                      color: pink.withValues(alpha: 0.5),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: pink.withValues(alpha: 0.12),
                        blurRadius: 18,
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'HALO, SELAMAT DATANG!',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Pantau aktivitas harianmu.',
                        style: TextStyle(color: Colors.white70),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        '$total',
                        style: const TextStyle(
                          color: pink,
                          fontSize: 42,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Text(
                        'TOTAL AKTIVITAS TERCATAT',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 11,
                          letterSpacing: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 28),
                const Row(
                  children: [
                    Text(
                      'Aktivitas Saya',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 21,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Spacer(),
                    Icon(
                      Icons.favorite,
                      color: pink,
                      size: 19,
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                Expanded(
                  child: activities.isEmpty
                      ? const Center(
                          child: Text(
                            'Belum ada aktivitas.',
                            style: TextStyle(color: Colors.white70),
                          ),
                        )
                      : ListView.builder(
                          itemCount: activities.length,
                          itemBuilder: (context, index) {
                            final activity = activities[index];

                            return Card(
                              color: darkCard,
                              elevation: 0,
                              margin: const EdgeInsets.only(bottom: 13),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(17),
                                side: BorderSide(
                                  color: pink.withValues(alpha: 0.2),
                                ),
                              ),
                              child: ListTile(
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 8,
                                ),
                                leading: const CircleAvatar(
                                  backgroundColor: Color(0xFF3B2031),
                                  child: Icon(
                                    Icons.check_circle,
                                    color: pink,
                                  ),
                                ),
                                title: Text(
                                  activity.name,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                subtitle: Text(
                                  'Jumlah: ${activity.counter}',
                                  style: const TextStyle(
                                    color: Colors.white60,
                                  ),
                                ),
                                trailing: const Icon(
                                  Icons.arrow_forward_ios,
                                  color: pink,
                                  size: 17,
                                ),
                                onTap: () async {
                                  final result = await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          ActivityDetailView(
                                        viewModel: viewModel,
                                        activity: activity,
                                      ),
                                    ),
                                  );

                                  if (result == 'deleted' &&
                                      context.mounted) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                          'Aktivitas berhasil dihapus.',
                                        ),
                                      ),
                                    );
                                  }
                                },
                              ),
                            );
                          },
                        ),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: const Color(0xFFFF3D9A),
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add),
        label: const Text(
          'Tambah Aktivitas',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ActivityFormView(
                viewModel: viewModel,
              ),
            ),
          );

          if (result == true && context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Aktivitas berhasil ditambahkan.'),
              ),
            );
          }
        },
      ),
    );
  }
}
