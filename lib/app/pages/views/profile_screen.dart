import 'dart:typed_data';
import 'package:eservices/app/components/custom_button.dart';
import 'package:eservices/app/components/custom_row.dart';
import 'package:eservices/app/routes/app_pages.dart';
import 'package:eservices/config/theme/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:eservices/app/data/local/my_shared_pref.dart';
import 'package:eservices/app/data/models/users/user.dart';
import 'package:get/get.dart';
import 'package:eservices/config/theme/app_colors.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../components/id_card.dart';

@immutable
class ProfileScreen extends StatelessWidget {
  final String userType;
  final dynamic user;
  final Uint8List? image;
  const ProfileScreen(
      {super.key, required this.userType, required this.user, this.image});

  @override
  Widget build(BuildContext context) {
    return user is User
        ? IDCard(
            user: user,
            image: image,
            userType: userType,
          )
        : IDCard(
            user: user,
            userType: userType,
          );
  }
}
