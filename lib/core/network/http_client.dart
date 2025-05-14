// Here we will create a dio provider
// Which we will then pass to the restApiClient in params

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

final dioProvider = Provider<Dio>(
  (ref) {
    final dio = Dio();
    return dio..interceptors.add(PrettyDioLogger());
  },
);
