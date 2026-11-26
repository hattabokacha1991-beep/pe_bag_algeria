import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:share_plus/share_plus.dart';

void main() {
  runApp(const PeBagAlgeriaApp());
}

class PeBagAlgeriaApp extends StatefulWidget {
  const PeBagAlgeriaApp({super.key});

  @override
  State<PeBagAlgeriaApp> createState() => _PeBagAlgeriaAppState();
}

class _PeBagAlgeriaAppState extends State<PeBagAlgeriaApp> {
  bool isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'حقيبة التربية البدنية',
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: const Color(0xFF00796B),
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: const Color(0xFF00796B),
        brightness: Brightness.dark,
      ),
      builder: (context, child) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: child!,
        );
      },
      home: HomeScreen(
        isDarkMode: isDarkMode,
        onToggleTheme: () => setState(() => isDarkMode = !isDarkMode),
      ),
    );
  }
}

class MemoModel {
  final String id;
  final String level;
  final String unit;
  final String title;
  final String objective;
  final String warmUp;
  final String mainPart;
  final String coolDown;

  const MemoModel({
    required this.id,
    required this.level,
    required this.unit,
    required this.title,
    required this.objective,
    required this.warmUp,
    required this.mainPart,
    required this.coolDown,
  });
}

class HomeScreen extends StatefulWidget {
  final bool isDarkMode;
  final VoidCallback onToggleTheme;

  const HomeScreen({
    super.key,
    required this.isDarkMode,
    required this.onToggleTheme,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String teacherName = 'أستاذ التربية البدنية والرياضية';
  String schoolName = 'المؤسسة التربوية';

  final List<String> levels = const [
    'السنة الأولى',
    'السنة الثانية',
    'السنة الثالثة',
    'السنة الرابعة',
    'السنة الخامسة',
  ];

  final List<MemoModel> allMemos = const [
    MemoModel(
      id: 'M01',
      level: 'السنة الأولى',
      unit: 'الجري السريع',
      title: 'المذكرة 01: الانطلاق السريع ورد الفعل',
      objective: 'تحسين سرعة الاستجابة الحركية والانطلاق الصحيح عند سماع الإشارة.',
      warmUp: 'جري خفيف حول الميدان لمدة 5 دقائق + تمارين مرونة المفاصل.',
      mainPart: 'ألعاب تفاعلية للانطلاق من وضعيات مختلفة (الجلوس، الوقوف، الانبطاح) لمسافة 15م.',
      coolDown: 'مشي بطيء مع تمارين التنفس والاسترخاء العضلي.',
    ),
    MemoModel(
      id: 'M02',
      level: 'السنة الأولى',
      unit: 'القفز والوثب',
      title: 'المذكرة 02: التوازن والارتقاء بكلتا الرجلين',
      objective: 'تنسيق حركة الذراعين مع الرجلين أثناء الوثب الأمامي.',
      warmUp: 'تسخين عام + قفزات خفيفة في المكان.',
      mainPart: 'اجتياز حواجز منخفضة متتالية والهبوط المتوازن داخل الحلقات.',
      coolDown: 'تمارين إطالة خفيفة للطرفين السفليين.',
    ),
    MemoModel(
      id: 'M03',
      level: 'السنة الثانية',
      unit: 'الألعاب الجماعية',
      title: 'المذكرة 01: التمرير والاستلام في وضعية الحركة',
      objective: 'القدرة على تمرير الكرة بدقة نحو الزميل أثناء التنقل.',
      warmUp: 'تنقلات متنوعة بالكرة وبدون كرة.',
      mainPart: 'تمارين ثنائية للتمرير والاستلام ثم لعبة مصغرة 4 ضد 4.',
      coolDown: 'تهدئة عامة وتقييم الحصة مع التلاميذ.',
    ),
  ];

  void _editTeacherInfo() {
    final nameCtrl = TextEditingController(text: teacherName);
    final schoolCtrl = TextEditingController(text: schoolName);

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('بيانات الأستاذ والمؤسسة'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameCtrl,
              decoration: const InputDecoration(labelText: 'اسم الأستاذ'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: schoolCtrl,
              decoration: const InputDecoration(labelText: 'اسم المؤسسة'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('إلغاء'),
          ),
          FilledButton(
            onPressed: () {
              setState(() {
                teacherName = nameCtrl.text.trim();
                schoolName = schoolCtrl.text.trim();
              });
              Navigator.pop(ctx);
            },
            child: const Text('حفظ'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('حقيبة التربية البدنية'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(widget.isDarkMode ? Icons.light_mode : Icons.dark_mode),
            onPressed: widget.onToggleTheme,
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            color: Theme.of(context).colorScheme.primaryContainer,
            child: ListTile(
              contentPadding: const EdgeInsets.all(16),
              leading: const CircleAvatar(
                child: Icon(Icons.sports_soccer),
              ),
              title: Text(
                teacherName,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(schoolName),
              trailing: IconButton(
                icon: const Icon(Icons.edit),
                onPressed: _editTeacherInfo,
              ),
            ),
          ),
          const SizedBox(height: 16),
          ...List.generate(levels.length, (index) {
            final levelName = levels[index];
            final levelMemos =
                allMemos.where((m) => m.level == levelName).toList();

            return Card(
              margin: const EdgeInsets.only(bottom: 12),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Colors.white,
                  child: Text('L${index + 1}'),
                ),
                title: Text(
                  levelName,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text('${levelMemos.length} مذكرات متوفرة'),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => LevelMemosScreen(
                        levelName: levelName,
                        memos: levelMemos,
                        teacherName: teacherName,
                        schoolName: schoolName,
                      ),
                    ),
                  );
                },
              ),
            );
          }),
        ],
      ),
    );
  }
}

class LevelMemosScreen extends StatelessWidget {
  final String levelName;
  final List<MemoModel> memos;
  final String teacherName;
  final String schoolName;

  const LevelMemosScreen({
    super.key,
    required this.levelName,
    required this.memos,
    required this.teacherName,
    required this.schoolName,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(levelName)),
      body: memos.isEmpty
          ? const Center(child: Text('لا توجد مذكرات مضافة لهذا المستوى بعد'))
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: memos.length,
              itemBuilder: (context, index) {
                final memo = memos[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    title: Text(memo.title),
                    subtitle: Text('الوحدة: ${memo.unit}'),
                    trailing: const Icon(Icons.description_outlined),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => MemoDetailScreen(
                            memo: memo,
                            teacherName: teacherName,
                            schoolName: schoolName,
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
    );
  }
}

class MemoDetailScreen extends StatelessWidget {
  final MemoModel memo;
  final String teacherName;
  final String schoolName;

  const MemoDetailScreen({
    super.key,
    required this.memo,
    required this.teacherName,
    required this.schoolName,
  });

  Future<void> _exportPdf() async {
    final pdf = pw.Document();
    final arabicFont = await PdfGoogleFonts.cairoRegular();
    final arabicBold = await PdfGoogleFonts.cairoBold();

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        textDirection: pw.TextDirection.rtl,
        theme: pw.ThemeData.withFont(base: arabicFont, bold: arabicBold),
        build: (context) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text('المؤسسة: $schoolName', style: const pw.TextStyle(fontSize: 12)),
            pw.Text('الأستاذ: $teacherName', style: const pw.TextStyle(fontSize: 12)),
            pw.Divider(),
            pw.SizedBox(height: 8),
            pw.Text(memo.title,
                style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
            pw.Text('المستوى: ${memo.level} | الوحدة: ${memo.unit}'),
            pw.SizedBox(height: 16),
            _pdfSection('الهدف التعلمي:', memo.objective),
            _pdfSection('المرحلة التحضيرية:', memo.warmUp),
            _pdfSection('المرحلة التعليمية (الرئيسية):', memo.mainPart),
            _pdfSection('المرحلة الختامية:', memo.coolDown),
          ],
        ),
      ),
    );

    await Printing.layoutPdf(onLayout: (format) async => pdf.save());
  }

  pw.Widget _pdfSection(String title, String body) {
    return pw.Container(
      margin: const pw.EdgeInsets.only(bottom: 12),
      padding: const pw.EdgeInsets.all(10),
      decoration: pw.BoxDecoration(
        border: pw.Border.all(color: PdfColors.grey400),
        borderRadius: pw.BorderRadius.circular(6),
      ),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(title, style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
          pw.SizedBox(height: 4),
          pw.Text(body),
        ],
      ),
    );
  }

  Future<void> _exportWordDoc() async {
    final dir = await getTemporaryDirectory();
    final file = File('${dir.path}/${memo.id}.doc');

    final htmlContent = '''
<html dir="rtl" lang="ar">
<head><meta charset="utf-8"></head>
<body style="font-family: Arial, sans-serif; line-height: 1.6;">
  <p><strong>المؤسسة:</strong> $schoolName | <strong>الأستاذ:</strong> $teacherName</p>
  <hr>
  <h2>${memo.title}</h2>
  <p><strong>المستوى:</strong> ${memo.level} — <strong>الوحدة:</strong> ${memo.unit}</p>
  <table border="1" cellpadding="8" cellspacing="0" width="100%">
    <tr><th width="25%">المرحلة</th><th>المحتوى البيداغوجي</th></tr>
    <tr><td><strong>الهدف التعلمي</strong></td><td>${memo.objective}</td></tr>
    <tr><td><strong>المرحلة التحضيرية</strong></td><td>${memo.warmUp}</td></tr>
    <tr><td><strong>المرحلة التعليمية</strong></td><td>${memo.mainPart}</td></tr>
    <tr><td><strong>المرحلة الختامية</strong></td><td>${memo.coolDown}</td></tr>
  </table>
</body>
</html>
''';

    await file.writeAsString(htmlContent);
    await Share.shareXFiles([XFile(file.path)], text: memo.title);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(memo.id)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            memo.title,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 6),
          Text('${memo.level} • ${memo.unit}'),
          const Divider(height: 24),
          _buildStageCard('الهدف التعلمي', memo.objective, Icons.flag),
          _buildStageCard('المرحلة التحضيرية', memo.warmUp, Icons.directions_run),
          _buildStageCard('المرحلة التعليمية', memo.mainPart, Icons.sports),
          _buildStageCard('المرحلة الختامية', memo.coolDown, Icons.self_improvement),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: FilledButton.icon(
                  onPressed: _exportPdf,
                  icon: const Icon(Icons.picture_as_pdf),
                  label: const Text('تصدير PDF'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: _exportWordDoc,
                  icon: const Icon(Icons.article),
                  label: const Text('تصدير Word'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStageCard(String title, String content, IconData icon) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Icon(icon),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 6),
          child: Text(content),
        ),
      ),
    );
  }
}
