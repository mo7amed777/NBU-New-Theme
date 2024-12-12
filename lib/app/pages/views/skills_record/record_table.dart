import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

Future<pw.Document> recordTablePdf() async {
  final fontDataBold =
      await rootBundle.load("assets/fonts/Traditional-Arabic-Bold.ttf");
  final ttfBold = pw.Font.ttf(fontDataBold);

  final pdf = pw.Document(
    pageMode: PdfPageMode.fullscreen,
    theme: pw.ThemeData.withFont(bold: ttfBold, base: ttfBold),
  );

  Future<Uint8List> _readImageData(String path) async {
    final data = await rootBundle.load(path);
    return data.buffer.asUint8List();
  }

  final Uint8List imageData = await _readImageData('assets/images/title.jpg');

  final header = pw.MemoryImage(imageData);

  pdf.addPage(
    pw.Page(
      textDirection: pw.TextDirection.rtl,
      margin: pw.EdgeInsets.all(4.sp),
      pageFormat: PdfPageFormat.a4,
      build: (pw.Context context) {
        return pw.Column(
          children: [
            pw.Image(header),
            pw.SizedBox(height: 10.sp),
            pw.Text(
              'سجل مهاري',
              textDirection: pw.TextDirection.rtl,
              style: pw.TextStyle(
                fontSize: 14.sp,
                color: PdfColors.green,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
            pw.SizedBox(height: 10.sp),
            buildHeadingInfo(
                infoAR: 'الموظف',
                infoEN: 'Employee',
                titleEN: 'Employee',
                titleAR: 'الموظف'),
            buildHeadingInfo(
                infoAR: 'الموظف',
                infoEN: 'Employee',
                titleEN: 'Employee',
                titleAR: 'الموظف'),
            buildHeadingInfo(
                infoAR: 'الموظف',
                infoEN: 'Employee',
                titleEN: 'Employee',
                titleAR: 'الموظف'),
            buildHeadingInfo(
                infoAR: 'الموظف',
                infoEN: 'Employee',
                titleEN: 'Employee',
                titleAR: 'الموظف'),
            pw.SizedBox(height: 10.h),
            buildTable(),
            pw.SizedBox(height: 10.h),
            buildTable(),
            pw.SizedBox(height: 10.h),
            buildTable(),
          ],
        );
      },
    ),
  );
  pdf.addPage(
    pw.Page(
      textDirection: pw.TextDirection.rtl,
      margin: pw.EdgeInsets.all(4.sp),
      pageFormat: PdfPageFormat.a4,
      build: (pw.Context context) {
        return pw.Column(
          children: [
            pw.Image(header),
            pw.SizedBox(height: 20.h),
            buildTable(),
            pw.SizedBox(height: 10.h),
            buildTable(),
            pw.SizedBox(height: 10.h),
            buildTable(),
            pw.SizedBox(height: 10.h),
            buildTable(),
          ],
        );
      },
    ),
  );
  pdf.addPage(
    pw.Page(
      textDirection: pw.TextDirection.rtl,
      margin: pw.EdgeInsets.all(4.sp),
      pageFormat: PdfPageFormat.a4,
      build: (pw.Context context) {
        return pw.Column(
          children: [
            pw.Image(header),
            pw.SizedBox(height: 20.h),
            buildTable(),
            pw.SizedBox(height: 10.h),
            buildTable(),
            pw.SizedBox(height: 10.h),
            buildTable(),
            pw.SizedBox(height: 50.h),
            pw.Text(
              'عميد شؤون الطلاب',
              textDirection: pw.TextDirection.rtl,
              textAlign: pw.TextAlign.center,
              style: pw.TextStyle(
                fontSize: 14.sp,
              ),
            ),
            pw.SizedBox(height: 30.h),
            pw.Text(
              'د. فرحان بن خلف العنزي',
              textDirection: pw.TextDirection.rtl,
              textAlign: pw.TextAlign.center,
              style: pw.TextStyle(
                fontSize: 14.sp,
              ),
            )
          ],
        );
      },
    ),
  );

  return pdf;
}

pw.Widget buildTable() {
  return pw.Column(
    children: [
      // First Row with 2 Cells
      pw.Row(
        children: [
          getRowCell(
              cellText: 'مجال الهوية الوطنية', cellWidth: Get.width * 0.7),
          getRowCell(cellText: 'National identity', cellWidth: Get.width * 0.7),
        ],
      ),
      pw.Row(children: [
        getRowCell(cellText: 'الرمز'),
        getRowCell(cellText: 'الاسم'),
        getRowCell(cellText: 'مكتسبة'),
        getRowCell(cellText: 'التقدير'),
        getRowCell(cellText: 'Grade'),
        getRowCell(cellText: 'U.E'),
        getRowCell(cellText: 'Title'),
        getRowCell(cellText: 'Code'),
      ]),
      pw.Row(children: [
        getRowCell(cellText: 'الرمز'),
        getRowCell(cellText: 'الاسم'),
        getRowCell(cellText: 'مكتسبة'),
        getRowCell(cellText: 'التقدير'),
        getRowCell(cellText: 'Grade'),
        getRowCell(cellText: 'U.E'),
        getRowCell(cellText: 'Title'),
        getRowCell(cellText: 'Code'),
      ]),
      pw.Row(children: [
        getRowCell(cellText: 'الرمز'),
        getRowCell(cellText: 'الاسم'),
        getRowCell(cellText: 'مكتسبة'),
        getRowCell(cellText: 'التقدير'),
        getRowCell(cellText: 'Grade'),
        getRowCell(cellText: 'U.E'),
        getRowCell(cellText: 'Title'),
        getRowCell(cellText: 'Code'),
      ]),
      pw.Row(children: [
        getRowCell(cellText: 'الرمز'),
        getRowCell(cellText: 'الاسم'),
        getRowCell(cellText: 'مكتسبة'),
        getRowCell(cellText: 'التقدير'),
        getRowCell(cellText: 'Grade'),
        getRowCell(cellText: 'U.E'),
        getRowCell(cellText: 'Title'),
        getRowCell(cellText: 'Code'),
      ]),
      // Second Row with 4 Cells
      pw.Row(
        children: [
          getRowCell(cellText: 'عدد الساعات', cellWidth: Get.width * 0.35),
          getRowCell(cellText: '18', cellWidth: Get.width * 0.35),
          getRowCell(cellText: '18', cellWidth: Get.width * 0.35),
          getRowCell(cellText: 'Total hours', cellWidth: Get.width * 0.35),
        ],
      ),
    ],
  );
}

pw.Container getRowCell({
  required String cellText,
  String cellTextEN = "",
  double? cellWidth,
}) {
  return pw.Container(
    decoration: pw.BoxDecoration(
      border: pw.TableBorder.all(),
    ),
    padding: pw.EdgeInsets.symmetric(vertical: 6, horizontal: 6),
    width: cellWidth ?? Get.width * 0.175,
    child: pw.Text(
      cellText,
      textDirection: pw.TextDirection.rtl,
      textAlign: pw.TextAlign.center,
      style: pw.TextStyle(
        fontSize: 10,
      ),
    ),
  );
}

buildHeadingInfo(
        {required String titleAR,
        required String titleEN,
        required String infoAR,
        required String infoEN}) =>
    pw.Padding(
      padding: pw.EdgeInsets.symmetric(horizontal: 8.sp),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Text(
            titleAR,
            textDirection: pw.TextDirection.rtl,
          ),
          pw.Text(
            infoAR,
            textDirection: pw.TextDirection.rtl,
          ),
          pw.Text(
            infoEN,
          ),
          pw.Text(
            titleEN,
          ),
        ],
      ),
    );
