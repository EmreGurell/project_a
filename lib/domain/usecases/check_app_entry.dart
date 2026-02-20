import 'package:project_a/core/usecase/usecase.dart';
import '../entities/app_entry_status.dart';
import '../repositories/app_entry_repository.dart';

class CheckAppEntry implements Usecase<AppEntryStatus, void> {

  final AppEntryRepository repository;

  CheckAppEntry(this.repository);

  @override
  Future<AppEntryStatus> call({void param}) async {
    return await repository.checkAppEntry();
  }
}