
import 'package:project_a/core/usecase/usecase.dart';

import '../../repositories/app_entry_repository.dart';


class CompleteOnboardingUseCase implements Usecase<void,void>{

  final AppEntryRepository repository;

  CompleteOnboardingUseCase({required this.repository});

  @override
  Future<void> call({void param}) async {
    await repository.setOnboardingSeen();
  }

}