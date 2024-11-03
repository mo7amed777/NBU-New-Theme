import 'package:eservices/config/theme/app_colors.dart';
import 'package:flutter/material.dart';

class DownloadCard extends StatelessWidget {
  final String title;
  final Function download;

  const DownloadCard({required this.title, required this.download});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        elevation: 2.0,
        child: ListTile(
          trailing: IconButton(
            icon: Icon(Icons.file_download, color: colorBlackLight),
            onPressed: () => download(),
          ),
          title: Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Text(title,
                softWrap: false,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: colorBlackLight,
                    fontSize: 16)),
          ),
        ),
      ),
    );
  }
}
