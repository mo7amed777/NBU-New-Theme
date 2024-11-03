import 'package:eservices/app/data/models/salary.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:qr_flutter/qr_flutter.dart';

Future<pw.Document> createPDF(
    { //required String selected,
    required String nationality,
    required SalaryDefinition salaryDefinition,
    Uint8List? qr}) async {
  final fontDataBold =
      await rootBundle.load("assets/fonts/Traditional-Arabic-Bold.ttf");
  final ttfBold = pw.Font.ttf(fontDataBold);

  final pdf = pw.Document();

  Future<Uint8List> _readImageData(String path) async {
    final data = await rootBundle.load(path);
    return data.buffer.asUint8List();
  }

  final Uint8List imageData = await _readImageData('assets/images/header.jpg');
  final Uint8List signImage = await _readImageData('assets/images/sign.jpg');
  final Uint8List rowImage = await _readImageData('assets/images/row.jpg');

  final header = pw.MemoryImage(imageData);
  final signature = pw.MemoryImage(signImage);
  final rowText = pw.MemoryImage(rowImage);

  pw.Container getRowCell(
      {required String cellText,
      String cellTextEN = "",
      double cellWidth = 90}) {
    return pw.Container(
      padding: pw.EdgeInsets.all(4.sp),
      width: cellWidth,
      child: cellWidth == 90
          ? pw.Text(
              cellText,
              textDirection: pw.TextDirection.rtl,
              textAlign: pw.TextAlign.center,
              style: pw.TextStyle(
                fontSize: 10.sp,
              ),
            )
          : pw.Row(
              mainAxisAlignment: cellTextEN == "Grade"
                  ? pw.MainAxisAlignment.spaceBetween
                  : pw.MainAxisAlignment.spaceAround,
              children: [
                pw.Text(
                  cellText,
                  textDirection: pw.TextDirection.rtl,
                  textAlign: pw.TextAlign.center,
                  style: pw.TextStyle(
                    fontSize: 10.sp,
                  ),
                ),
                pw.Text(
                  cellTextEN,
                  textDirection: pw.TextDirection.rtl,
                  textAlign: pw.TextAlign.center,
                  style: pw.TextStyle(
                    fontSize: 10.sp,
                  ),
                ),
              ],
            ),
    );
  }

  pdf.addPage(
    pw.Page(
      theme: pw.ThemeData.withFont(bold: ttfBold, base: ttfBold),
      textDirection: pw.TextDirection.rtl,
      margin: pw.EdgeInsets.all(4.sp),
      pageFormat: PdfPageFormat.a4,
      build: (pw.Context context) {
        return pw.Column(
          children: [
            pw.Image(header),
            pw.SizedBox(height: 5.h),
            pw.Padding(
              padding: pw.EdgeInsets.symmetric(horizontal: 8.w),
              child: pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text(
                    'التاريخ: ${DateTime.now().toString().substring(0, 10)}',
                    textDirection: pw.TextDirection.rtl,
                  ),
                  pw.Text(
                    'شهادة تعريف الراتب',
                    textDirection: pw.TextDirection.rtl,
                    style: pw.TextStyle(
                      fontSize: 12.sp,
                    ),
                  ),
                  pw.Text(
                      'Date: ${DateTime.now().toString().substring(0, 10)}'),
                ],
              ),
            ),
            pw.Text('Salary Certificate',
                style: pw.TextStyle(fontSize: 15.sp),
                textAlign: pw.TextAlign.center),
            pw.SizedBox(height: 5.h),
            pw.Table(
              border: pw.TableBorder.all(),
              children: [
                pw.TableRow(children: [
                  getRowCell(cellText: 'Employee Name'),
                  getRowCell(
                      cellTextEN: salaryDefinition.englishName ?? '',
                      cellText: salaryDefinition.empName ?? '',
                      cellWidth: 180),
                  getRowCell(cellText: 'اسم الموظف'),
                ]),
                pw.TableRow(children: [
                  getRowCell(cellText: 'ID No'),
                  getRowCell(
                      cellTextEN: salaryDefinition.nid ?? '',
                      cellText: salaryDefinition.nid ?? '',
                      cellWidth: 180),
                  getRowCell(cellText: 'رقم الهوية'),
                ]),
                pw.TableRow(children: [
                  getRowCell(cellText: 'Employee No'),
                  getRowCell(
                      cellTextEN: salaryDefinition.emNo ?? '',
                      cellText: salaryDefinition.emNo ?? '',
                      cellWidth: 180),
                  getRowCell(cellText: 'رقم الموظف'),
                ]),
                pw.TableRow(children: [
                  getRowCell(cellText: 'Nationality'),
                  getRowCell(
                      cellTextEN: salaryDefinition.englishNationalityName ?? '',
                      cellText: salaryDefinition.nationalityName ?? '',
                      cellWidth: 180),
                  getRowCell(cellText: 'الجنسية'),
                ]),
                pw.TableRow(children: [
                  getRowCell(cellText: 'Job Title'),
                  getRowCell(
                      cellTextEN: salaryDefinition.jobNameEN ?? '',
                      cellText: salaryDefinition.jobName ?? '',
                      cellWidth: 180),
                  getRowCell(cellText: 'مسمى الوظيفة'),
                ]),
                pw.TableRow(children: [
                  getRowCell(cellText: 'Grade'),
                  getRowCell(
                      cellText: getSalaryRankandDegree(
                          salaryDefinition.degree, salaryDefinition.rankName),
                      cellTextEN: getSalaryRankandDegree(
                          salaryDefinition.rankName, salaryDefinition.degree),
                      cellWidth: 180),
                  getRowCell(cellText: 'المرتبة / الدرجة'),
                ]),
                pw.TableRow(children: [
                  getRowCell(cellText: 'Seniority Date'),
                  getRowCell(
                      cellTextEN: salaryDefinition.governmentalHireDate ?? '',
                      cellText: salaryDefinition.governmentalHireDate ?? '',
                      cellWidth: 180),
                  getRowCell(cellText: 'تاريخ الالتحاق بالعمل'),
                ]),
                pw.TableRow(children: [
                  getRowCell(cellText: 'Basic Salary'),
                  getRowCell(
                      cellTextEN: salaryDefinition.salary!.toString(),
                      cellText: salaryDefinition.salary!.toString(),
                      cellWidth: 180),
                  getRowCell(cellText: 'الراتب الأساسي'),
                ]),
                pw.TableRow(children: [
                  getRowCell(cellText: 'Allowances'),
                  getRowCell(
                      cellTextEN: salaryDefinition.monthlyAllowance!.toString(),
                      cellText: salaryDefinition.monthlyAllowance!.toString(),
                      cellWidth: 180),
                  getRowCell(cellText: 'البدلات'),
                ]),
                pw.TableRow(children: [
                  getRowCell(cellText: 'Deductions'),
                  getRowCell(
                      cellTextEN: salaryDefinition.totalDeduction!.toString(),
                      cellText: salaryDefinition.totalDeduction!.toString(),
                      cellWidth: 180),
                  getRowCell(cellText: 'الحسميات'),
                ]),
                pw.TableRow(children: [
                  getRowCell(cellText: 'Total Salary'),
                  getRowCell(
                      cellTextEN: '${salaryDefinition.netSalary!}       SAR',
                      cellText: '${salaryDefinition.netSalary!}     ريال سعودي',
                      cellWidth: 180),
                  getRowCell(cellText: 'صافي الراتب'),
                ]),
              ],
            ),
            // selected == salaryTypes[2]
            //     ? pw.Row(
            //         children: [
            //           pw.Column(children: [
            //             pw.Container(
            //               margin: pw.EdgeInsets.symmetric(vertical: 4.0),
            //               padding: pw.EdgeInsets.symmetric(vertical: 4.0),
            //               width: 200,
            //               decoration: pw.BoxDecoration(
            //                 border: pw.Border.all(
            //                   width: 1,
            //                 ),
            //                 color:
            //                     PdfColor(0.862745098, 0.862745098, 0.862745098),
            //               ),
            //               child: pw.Text(
            //                 'تفصيل الحسميات',
            //                 textDirection: pw.TextDirection.rtl,
            //                 textAlign: pw.TextAlign.center,
            //                 style: pw.TextStyle(
            //
//
            //                 ),
            //               ),
            //             ),
            //             pw.Table(
            //               border: pw.TableBorder.all(),
            //               children: [
            //                 pw.TableRow(children: [
            //                   getRowCell(cellText: '700.00', cellWidth: 100),
            //                   getRowCell(
            //                       cellText: 'تقاعد / تأمينات', cellWidth: 100),
            //                 ]),
            //                 pw.TableRow(children: [
            //                   getRowCell(cellText: '700.00', cellWidth: 100),
            //                   getRowCell(
            //                       cellText: 'حسم بنك التنمية الإجتماعية',
            //                       cellWidth: 100),
            //                 ]),
            //                 pw.TableRow(children: [
            //                   getRowCell(cellText: '700.00', cellWidth: 100),
            //                   getRowCell(
            //                       cellText: 'حسم لصالح الجهة نفسها',
            //                       cellWidth: 100),
            //                 ]),
            //                 pw.TableRow(children: [
            //                   getRowCell(cellText: '700.00', cellWidth: 100),
            //                   getRowCell(
            //                       cellText: 'حسم صندوق التنيمة العقارية',
            //                       cellWidth: 100),
            //                 ]),
            //                 pw.TableRow(children: [
            //                   getRowCell(cellText: '700.00', cellWidth: 100),
            //                   getRowCell(
            //                       cellText: 'حسم لصالح الحقوق الخاصة',
            //                       cellWidth: 100),
            //                 ]),
            //                 pw.TableRow(children: [
            //                   getRowCell(cellText: '700.00', cellWidth: 100),
            //                   getRowCell(
            //                       cellText: 'جزاءات وغرامات', cellWidth: 100),
            //                 ]),
            //                 pw.TableRow(children: [
            //                   getRowCell(cellText: '700.00', cellWidth: 100),
            //                   getRowCell(
            //                       cellText: 'حسم صندوق التنمية الزراعية',
            //                       cellWidth: 100),
            //                 ]),
            //                 pw.TableRow(children: [
            //                   getRowCell(cellText: '700.00', cellWidth: 100),
            //                   getRowCell(cellText: 'حسم سكن', cellWidth: 100),
            //                 ]),
            //                 pw.TableRow(children: [
            //                   getRowCell(cellText: '700.00', cellWidth: 100),
            //                   getRowCell(
            //                       cellText: 'تقاعد مسترد', cellWidth: 100),
            //                 ]),
            //               ],
            //             ),
            //           ]),
            //           pw.SizedBox(width: 15),
            //           pw.Column(children: [
            //             pw.Container(
            //               margin: pw.EdgeInsets.symmetric(vertical: 4.0),
            //               padding: pw.EdgeInsets.symmetric(vertical: 4.0),
            //               width: 362,
            //               decoration: pw.BoxDecoration(
            //                 border: pw.Border.all(
            //                   width: 1,
            //                 ),
            //                 color:
            //                     PdfColor(0.862745098, 0.862745098, 0.862745098),
            //               ),
            //               child: pw.Text(
            //                 'تفصيل البدلات',
            //                 textDirection: pw.TextDirection.rtl,
            //                 textAlign: pw.TextAlign.center,
            //                 style: pw.TextStyle(
            //
//
            //                 ),
            //               ),
            //             ),
            //             pw.Table(
            //               border: pw.TableBorder.all(),
            //               children: [
            //                 pw.TableRow(children: [
            //                   getRowCell(cellText: 'مكافأة حاسب آلى'),
            //                   getRowCell(cellText: '700.00'),
            //                   getRowCell(cellText: '500.00'),
            //                   getRowCell(cellText: 'نقل شهري'),
            //                 ]),
            //                 pw.TableRow(children: [
            //                   getRowCell(cellText: 'تعليم جامعي'),
            //                   getRowCell(cellText: '700.00'),
            //                   getRowCell(cellText: '500.00'),
            //                   getRowCell(cellText: 'بدل سفر متواصل'),
            //                 ]),
            //                 pw.TableRow(children: [
            //                   getRowCell(cellText: 'ردم فجوة'),
            //                   getRowCell(cellText: '700.00'),
            //                   getRowCell(cellText: '500.00'),
            //                   getRowCell(cellText: 'مكافأة سائق معالي'),
            //                 ]),
            //                 pw.TableRow(children: [
            //                   getRowCell(cellText: 'عدوى'),
            //                   getRowCell(cellText: '700.00'),
            //                   getRowCell(cellText: '500.00'),
            //                   getRowCell(cellText: 'تفرغ وساعات إضافية'),
            //                 ]),
            //                 pw.TableRow(children: [
            //                   getRowCell(cellText: 'ندرة'),
            //                   getRowCell(cellText: '700.00'),
            //                   getRowCell(cellText: '500.00'),
            //                   getRowCell(cellText: 'قيادة سيارة اسعاف'),
            //                 ]),
            //                 pw.TableRow(children: [
            //                   getRowCell(cellText: 'جامعة ناشئة'),
            //                   getRowCell(cellText: '700.00'),
            //                   getRowCell(cellText: '500.00'),
            //                   getRowCell(cellText: 'فرق ساعات عمل'),
            //                 ]),
            //                 pw.TableRow(children: [
            //                   getRowCell(cellText: 'بدل طبيعة عمل'),
            //                   getRowCell(cellText: '700.00'),
            //                   getRowCell(cellText: '500.00'),
            //                   getRowCell(cellText: 'منصب اداري'),
            //                 ]),
            //                 pw.TableRow(children: [
            //                   getRowCell(cellText: 'بدل خطر'),
            //                   getRowCell(cellText: '700.00'),
            //                   getRowCell(cellText: '500.00'),
            //                   getRowCell(cellText: 'نقل مسائي'),
            //                 ]),
            //                 pw.TableRow(children: [
            //                   getRowCell(cellText: 'البقاء على المرتبة'),
            //                   getRowCell(cellText: '700.00'),
            //                   getRowCell(cellText: '500.00'),
            //                   getRowCell(cellText: 'مكافأة التميز'),
            //                 ]),
            //               ],
            //             ),
            //           ]),
            //         ],
            //       )
            //     : pw.SizedBox(height: 15),
            // pw.SizedBox(height: 30),

            // pw.Text(
            //   'السادة : ${salaryDefinition.bankName}            المحترمين \n\n'
            //   ' السلام عليكم ورحمة الله وبركاته'
            //   '\nنفيدكم بأن الموضح اسمه وبياناته أعلاه يعمل لدينا بالجامعة ويتم تحويل راتبه لديكم على رقم الحساب الموضح بعاليه ، ولن'
            //   '\nيتغير هذا الحساب إلا بعد إحضاره إخلاء طرف من قبلكم ، دون أدنى مسؤولية على الجامعة  ',
            //   style: pw.TextStyle(
            //
//
            //     lineSpacing: 7,
            //
            //   ),
            //   textDirection: pw.TextDirection.rtl,
            // ),
            pw.SizedBox(height: 5.h),

            pw.Image(rowText, height: 120.h),
            pw.Padding(
              padding: pw.EdgeInsets.symmetric(horizontal: 8.sp),
              child: pw.Row(
                children: [
                  qr != null
                      ? pw.Image(pw.MemoryImage(qr), width: 75.w, height: 75.h)
                      : pw.Container(),
                  pw.SizedBox(width: 75.w),
                  pw.Image(signature, height: 120.h),
                ],
              ),
            ),

            pw.Text(
              'هذه الوثيقة صادرة عن طريق الحاسب الآلى ولا تحتاج الى توقيع أو ختم',
              textDirection: pw.TextDirection.rtl,
              textAlign: pw.TextAlign.center,
              style: pw.TextStyle(
                fontSize: 10.sp,
              ),
            ),
            pw.Text(
              'This document is issued by computer and dose not need stamp or signature',
              textDirection: pw.TextDirection.rtl,
              textAlign: pw.TextAlign.center,
              style: pw.TextStyle(
                fontSize: 10.sp,
              ),
            ),
            pw.SizedBox(height: 5.h),
            pw.Text(
              '* تنويه: هذا المستند لا يعتد به في الإستخدام الرسمي *',
              textDirection: pw.TextDirection.rtl,
              textAlign: pw.TextAlign.center,
              style: pw.TextStyle(
                fontSize: 14.sp,
                fontWeight: pw.FontWeight.bold,
                color: PdfColors.red,
              ),
            ),
            // Replace with your QR code image
          ],
        );
      },
    ),
  );
  return pdf;
}

String getSalaryRankandDegree(String? rankName, String? degree) {
  rankName ??= '';
  degree ??= '';
  return '   $rankName        /        $degree   ';
}

Future<Uint8List> generateQRCode(String data) async {
  final image = await QrPainter(
          data: data,
          version: QrVersions.auto,
          color: Colors.black,
          emptyColor: Colors.white)
      .toImageData(400);
  return image!.buffer.asUint8List();
}

// const salaryTypes = [
//   'شهادة تعريف بالراتب',
//   'شهادة تثبيت الراتب',
//   //'شهادة تعريف بالراتب ',
// ];

// class SalaryTypeController extends GetxController {
//   String type = salaryTypes[0];
//   void changeType(String newType) {
//     type = newType;
//     update();
//   }
//}
