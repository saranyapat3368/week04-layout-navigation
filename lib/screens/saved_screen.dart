import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../models/destination.dart';
import '../models/saved_store.dart';
import '../widgets/destination_card.dart';

class SavedScreen extends StatelessWidget {
  const SavedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('บันทึกไว้')),
      body: AnimatedBuilder(
        animation: savedStore,
        builder: (context, _) {
          // Checkpoint 8: กรองเฉพาะ Destination ที่มี ID อยู่ใน Set
          final saved = sampleDestinations.where((d) => savedStore.isSaved(d.id)).toList();
          if (saved.isEmpty) {
            return Center(child: Column(mainAxisSize: MainAxisSize.min, children: [
              Icon(Icons.favorite_border, size: 64, color: Colors.pink.shade200),
              const SizedBox(height: 16),
              const Text('ยังไม่มีรายการที่บันทึก'),
            ]));
          }
          return LayoutBuilder(builder: (context, constraints) {
            // Checkpoint 8: ใช้พื้นที่จริงของ Grid ในการปรับ Responsive
            final int count;
            if (constraints.maxWidth < 600) {
              count = 2;
            } else if (constraints.maxWidth < 840) {
              count = 3;
            } else if (constraints.maxWidth < 1200) {
              count = 4;
            } else {
              count = 5;
            }
            return GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: count, crossAxisSpacing: 16,
                mainAxisSpacing: 16, childAspectRatio: 0.72,
              ),
              itemCount: saved.length,
              itemBuilder: (context, index) {
                final d = saved[index];
                // Checkpoint 8: ใช้ Named Route และ ID ทำให้เปิด Detail ได้โดยตรง
                return DestinationCard(destination: d,
                  onTap: () => context.pushNamed('destination-detail',
                    pathParameters: {'id': d.id}, extra: d));
              },
            );
          });
        },
      ),
    );
  }
}
