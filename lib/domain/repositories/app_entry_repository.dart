import 'package:project_a/utils/local_storage/storage_service.dart';

import '../entities/app_entry_status.dart';

abstract class AppEntryRepository {

  Future<AppEntryStatus> checkAppEntry();
  Future<void> setOnboardingSeen();
}



