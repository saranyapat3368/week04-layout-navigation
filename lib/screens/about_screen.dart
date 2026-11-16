import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('เกี่ยวกับ')),
      body: const Center(child: Padding(
        padding: EdgeInsets.all(24),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Icon(Icons.travel_explore, size: 64, color: Colors.blue),
          SizedBox(height: 16),
          Text('Travel App', style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          Text('แอปแนะนำสถานที่ท่องเที่ยว\nFlutter Layout & Navigation — Week 04',
            textAlign: TextAlign.center),
        ]),
      )),
    );
  }
}
