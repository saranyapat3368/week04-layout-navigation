import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../models/destination.dart';
import '../widgets/destination_card.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});
  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  String _searchQuery = '';
  String _selectedTag = 'ทั้งหมด';
  final List<String> _allTags = const [
    'ทั้งหมด', 'ทะเล', 'ธรรมชาติ', 'วัฒนธรรม', 'อาหาร', 'ช้อปปิ้ง',
  ];

  List<Destination> get _filteredDestinations {
    final query = _searchQuery.trim().toLowerCase();
    return sampleDestinations.where((d) {
      final matchSearch = query.isEmpty ||
          d.name.toLowerCase().contains(query) ||
          d.country.toLowerCase().contains(query) ||
          d.tags.any((t) => t.toLowerCase().contains(query));
      final matchTag = _selectedTag == 'ทั้งหมด' || d.tags.contains(_selectedTag);
      return matchSearch && matchTag;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('สำรวจ')),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
          child: TextField(
            onChanged: (value) => setState(() => _searchQuery = value),
            decoration: InputDecoration(
              hintText: 'ค้นหาสถานที่ ประเทศ หรือหมวดหมู่...',
              prefixIcon: const Icon(Icons.search),
              filled: true, fillColor: Colors.grey.shade100,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none),
            ),
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(height: 46, child: ListView.separated(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemCount: _allTags.length,
          separatorBuilder: (_, __) => const SizedBox(width: 8),
          itemBuilder: (context, index) {
            final tag = _allTags[index];
            return FilterChip(label: Text(tag), selected: _selectedTag == tag,
              onSelected: (_) => setState(() => _selectedTag = tag));
          },
        )),
        const SizedBox(height: 8),
        Expanded(child: _filteredDestinations.isEmpty
          ? Center(child: Column(mainAxisSize: MainAxisSize.min, children: [
              Icon(Icons.search_off, size: 60, color: Colors.grey.shade400),
              const SizedBox(height: 12),
              const Text('ไม่พบ Destination ที่ค้นหา'),
            ]))
          : _buildGrid()),
      ]),
    );
  }

  Widget _buildGrid() {
    return LayoutBuilder(builder: (context, constraints) {
      // Checkpoint 4.1: MediaQuery คือความกว้างของทั้ง Flutter view
      // ส่วน LayoutBuilder คือพื้นที่ที่ Parent มอบให้ Grid โดยเฉพาะ
      // จึงเลือก LayoutBuilder เพื่อกำหนดจำนวนคอลัมน์ที่เหมาะกับ Grid
      final screenWidth = MediaQuery.of(context).size.width;
      debugPrint('MediaQuery Width: $screenWidth');
      debugPrint('LayoutBuilder Width: ${constraints.maxWidth}');

      final int columns;
      if (constraints.maxWidth < 600) {
        columns = 2;
      } else if (constraints.maxWidth < 840) {
        columns = 3;
      } else if (constraints.maxWidth < 1200) {
        columns = 4;
      } else {
        columns = 5; // Checkpoint 4.1: Large >= 1200 dp
      }
      return GridView.builder(
        key: const PageStorageKey<String>('explore-grid'),
        padding: const EdgeInsets.all(16),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: columns, crossAxisSpacing: 16, mainAxisSpacing: 16,
          childAspectRatio: 0.72,
        ),
        itemCount: _filteredDestinations.length,
        itemBuilder: (context, index) {
          final d = _filteredDestinations[index];
          return DestinationCard(
            destination: d,
            onTap: () => context.pushNamed('destination-detail',
              pathParameters: {'id': d.id}, extra: d),
          );
        },
      );
    });
  }
}
