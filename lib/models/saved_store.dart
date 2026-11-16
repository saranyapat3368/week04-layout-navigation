import 'package:flutter/foundation.dart';

// Checkpoint 8: ใช้ ChangeNotifier เพื่อแชร์สถานะ Favorite ข้ามหลายหน้า
class SavedStore extends ChangeNotifier {
  final Set<String> savedIds = <String>{};

  bool isSaved(String id) => savedIds.contains(id);

  void toggle(String id) {
    if (!savedIds.add(id)) {
      savedIds.remove(id);
    }
    // แจ้งทุกหน้าที่ฟังอยู่ ให้แสดงหัวใจและรายการใหม่ทันที
    notifyListeners();
  }
}

final savedStore = SavedStore();
