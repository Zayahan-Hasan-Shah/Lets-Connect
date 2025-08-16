import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/src/app/my_app.dart';
import 'package:frontend/src/core/color_assets.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: ColorAssets.backgroundColor));
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}
