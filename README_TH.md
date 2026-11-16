# Travel App — ใบงาน Flutter Layout & Navigation Week 04

## เปิดใช้ใน Windows / VS Code

1. แตก ZIP เป็นโฟลเดอร์ `travel_app_complete`
2. เปิดโฟลเดอร์นั้นใน VS Code (`File > Open Folder`)
3. เปิด Terminal (PowerShell) ที่โฟลเดอร์เดียวกัน และพิมพ์คำสั่งต่อไปนี้ทีละบรรทัด:

```powershell
flutter create --project-name travel_app .
flutter pub get
flutter run -d chrome
```

> **สำคัญ**: `flutter create .` จะสร้างโฟลเดอร์ native ที่จำเป็น (web/android/windows ฯลฯ) ให้ เนื่องจาก ZIP รวมไฟล์แอปต้นฉบับเท่านั้น หากโปรแกรมถาม overwrite ไฟล์ ให้ตรวจสอบว่าไฟล์ lib/ และ pubspec.yaml ของชุดนี้ยังอยู่

หรือรันสคริปต์ `./INSTALL_WINDOWS.ps1` ใน PowerShell แล้วจึงรัน `flutter run -d chrome`

## งานที่รวมไว้แล้ว

- การทดลอง 1–6: Model, Card, Home, Explore, Detail, Saved, Profile, GoRouter, 5 Tabs
- Checkpoint 3: ดาวมุมซ้ายล่าง + เตียงพร้อมเข้าพัก + คอมเมนต์ Stack/Positioned
- Checkpoint 4.1: 4 Breakpoints (2/3/4/5 Columns) + MediaQuery เทียบ LayoutBuilder
- Checkpoint 4.3: Featured 6 รายการ + รีวิว 3 อันดับสูงสุด + คอมเมนต์ Nested ListView
- Checkpoint 5.1: เพิ่ม About + Unknown ID 999 แสดงไม่พบข้อมูล
- การทดลอง 7.1: Category Filter และ Search ทำงานร่วมกัน
- การทดลอง 8: กดหัวใจได้ทุก Card / Detail, Saved Grid ทำงานร่วมกัน, Responsive, Empty State
- Deep link URL: `/explore/destinations/999` ไม่แสดงข้อมูลผิดตัว

- การทดลอง 7.2: เพิ่ม Slide Transition เมื่อเข้า Detail พร้อมรองรับ ID ที่ไม่มีจริง

## ทดสอบ

```powershell
flutter analyze
flutter run -d chrome
```

- เปิด Explore และค้นหา `โตเกียว`
- กด Filter `ทะเล` ดูว่าเหลือภูเก็ตและบาหลี
- กดหัวใจแล้วเปิด Saved; กดซ้ำเพื่อเอาออก
- ย่อ/ขยาย Chrome ให้เห็นจำนวนคอลัมน์เปลี่ยน
- เปิด URL `/explore/destinations/999` และ Refresh หน้า Detail
- ทดสอบ Tab `เกี่ยวกับ`

## หมายเหตุ

- URL รูปภาพ `picsum.photos` เป็นภาพสุ่มตัวอย่าง ไม่ใช่ภาพจริงของสถานที่
- ระบบจองเป็นเพียง Dialog จำลอง ไม่ใช่การจองจริง
- รายการบันทึกเก็บในหน่วยความจำ จึงรีเซ็ตหลัง Refresh/Restart
- โค้ดยังไม่ได้รัน `flutter analyze` ในสภาพแวดล้อมที่สร้าง ZIP เพราะไม่มี Flutter SDK; ให้รันบนเครื่องตัวเองก่อนส่งงาน
