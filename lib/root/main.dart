import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:template/di/di.dart';
import 'package:template/root/bloc_observer.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'app.dart';

FutureOr<void> main() async {
  config();

  try {
    await dotenv.load(fileName: '.env');
  } catch (e) {
    print('Load .env fail');
  }

  runApp(const App());
}

Future<void> config() async {
  Bloc.observer = AppBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  configDependencies();
}
