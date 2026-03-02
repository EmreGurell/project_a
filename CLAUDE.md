# Project A — Claude Code Kılavuzu

## Proje Özeti
Flutter uygulaması. Kalori takibi, AI destekli yemek analizi (Cımbıl), barkod tarayıcı, kullanıcı profili.
Backend: REST API, ngrok üzerinden (Android) veya localhost:8080 (diğer).

## Mimari — Clean Architecture
```
lib/
  common/bloc/          # Paylaşılan BLoC (auth, button, app_entry)
  core/
    di/                 # GetIt service locator → service_locator.dart
    network/            # DioClient, ApiEndpoints
    router/             # GoRouter (app_router.dart), RouteNames
    validation/         # FormValidators
    errors/             # ErrorMapper
    usecase/            # Base Usecase sınıfı
  data/
    models/             # JSON model'lar (.fromJson / .toEntity())
    repository/         # Repository impl'leri
    source/             # API servis impl'leri (Dio) + local storage
  domain/
    entities/           # Saf entity sınıfları
    repositories/       # Abstract repository interface'leri
    usecases/           # Use case sınıfları (Usecase<Either, Param>)
  presentation/
    bloc/               # Sayfa-bazlı BLoC/Cubit'ler
    screens/            # Ekranlar
    widgets/            # Ekrana özel widget'lar
    navigation/         # Navigation scaffold (StatefulShell)
  shared/widgets/       # Tüm uygulamada kullanılan widget'lar
  l10n/                 # Lokalizasyon (TR + EN)
  utils/                # Sabitler (colors, sizes, image_paths), helpers, themes
```

## State Management Kuralları
- **Auth form akışları** → `ButtonStateCubit` (sl<ButtonStateCubit>())
- **Login / logout** → `AuthStateCubit`
- **App entry / onboarding** → `AppEntryCubit`
- **Sayfa-bazlı** → ilgili BLoC (HomeBloc, ProfileBloc, CimbilBloc, vb.)
- Başarı/hata `BlocListener` ile dinlenir, `BlocBuilder` sadece UI günceller
- Snackbar → `AppSnackbar.showError(context, message: ...)`

## Navigasyon (GoRouter v17)
- Route isimleri: `RouteNames` sınıfı (`route_names.dart`)
- Sayfalar arası veri: `context.go/push(route, extra: Map<String, dynamic>)`
- Router'da `state.extra as Map<String, dynamic>` ile alınır

## Mevcut Route'lar
| Route | Dosya | Notlar |
|---|---|---|
| `/` | splash.dart | AppEntryCubit yönlendirir |
| `/login` | auth/login.dart | |
| `/register` | auth/register.dart | |
| `/forgot-password` | auth/forgot_password.dart | |
| `/verify-account` | auth/verify_account.dart | extra: {email, isForReset} |
| `/reset-password` | auth/reset_password.dart | extra: {email, code} |
| `/onboarding` | onboarding/onboarding.dart | |
| `/home` | home/home.dart | StatefulShell tab 1 |
| `/recipes` | — | Placeholder tab 2 |
| `/community` | — | Placeholder tab 3 |
| `/profile` | profile/profile.dart | StatefulShell tab 4 |
| `/form` | form/form.dart | Profil kurulum formu |

## Auth Akışları
- **Login** → home
- **Register** → verify-account (isForReset: false) → home
- **Forgot Password** → verify-account (isForReset: true) → reset-password → login

## API Endpoint'leri (`ApiEndpoints`)

### Base URL'ler
- Android emülatör: `http://10.0.2.2:8080`
- Diğer: `http://localhost:8080`
- AI Servis: `https://skillful-perfection-production.up.railway.app`
- AI Chat: `https://cimbil-production.up.railway.app/api/chat`

### Backend Endpoint'leri
| Sabit | URL | Metod |
|---|---|---|
| `register` | api/v1/users/register | POST |
| `login` | api/v1/users/login | POST |
| `currentUser` | api/v1/users/me | GET |
| `forgotPassword` | api/v1/users/forgot-password | POST |
| `resetPassword` | api/v1/users/reset-password | POST |
| `verifyAccount` | api/v1/users/verify | POST |
| `resendVerification` | api/v1/users/resend-verification | POST |
| `nutritionDataByDate` | api/v1/nutrition/get-by-date?date=yyyy-MM-dd | GET |

### AI Endpoint'leri
| Sabit | Path |
|---|---|
| `aiAnalyzeText` | /analyze/text |
| `aiAnalyzeBarcode` | /analyze/barcode |
| `aiAnalyzeBarcodeImage` | /analyze/barcode_image |
| `aiAnalyzeImage` | /analyze |

## Domain Entities

| Entity | Alanlar |
|---|---|
| `UserEntity` | id, username, email, firstName, lastName, role, status, profilePicture? |
| `NutritionEntity` | id, totalCalories, protein, carbs, fat, date |
| `AuthEntity` | token |
| `AppEntryStatus` | enum: onboarding, authenticated, unauthenticated, profileSetup |

## Use Case'ler

**Auth** (`domain/usecases/auth/`):
- `SignInUseCase(SignInReqParam)` → `Either<String, AuthEntity>`
- `SignUpUseCase(SignUpReqParam)` → `Either<String, AuthEntity>`
- `LogoutUseCase()` → `Either<String, void>`
- `IsAuthenticatedUseCase()` → `bool`
- `ForgotPasswordUseCase(ForgotPasswordReqParam)` → `Either<String, void>`
- `ResetPasswordUseCase(ResetPasswordReqParam)` → `Either<String, void>`
- `VerifyAccountUseCase(VerifyAccountReqParam)` → `Either<String, void>`
- `ResendVerificationCodeUseCase(ResendVerificationReqParam)` → `Either<String, void>`

**User** (`domain/usecases/user/`):
- `GetCurrentUserUseCase()` → `Either<String, UserEntity>`

**Home** (`domain/usecases/home/`):
- `GetNutritionDataByDate(DateTime)` → `Either<String, NutritionEntity>`

**Onboarding**: `CompleteOnboardingUseCase()`, `CheckAppEntry()`

## BLoC / Cubit Listesi

| Sınıf | Tür | Dosya |
|---|---|---|
| `AppEntryCubit` | Cubit | common/bloc/app_entry/ |
| `AuthStateCubit` | Cubit | common/bloc/auth/ |
| `ButtonStateCubit` | Cubit | common/bloc/button/ |
| `HomeBloc` | BLoC | presentation/bloc/home/ |
| `ProfileBloc` | BLoC | presentation/bloc/profile/ |
| `ProfileSetupBloc` | BLoC | presentation/bloc/form/ |
| `CimbilBloc` | BLoC | presentation/bloc/cimbil/ |
| `NutritionResultBloc` | BLoC | presentation/bloc/nutrition/ |

### HomeBloc
- Events: `LoadCurrentUser()`, `ChangeDate(date)`
- `HomeLoaded`: user, nutrition (nullable), dateRange, selectedDate, isNutritionLoading
- `copyWith()` ile partial güncellemeler yapılır

### CimbilBloc
- Events: `SendMessage(text)`, `ClearChat()`
- `CimbilLoaded`: messages, isTyping, userContext

### NutritionResultBloc
- Events: `AnalyzeBarcode(barcode)`, `AnalyzeImage(imagePath)`

### ProfileSetupBloc
- Events: `LoadFormProgress()`, `AnswerUpdated(key, value)`, `FormPageChanged(page)`, `SubmitForm()`
- Form keys: goal, gender, age, height, weight, activityLevel

## Lokalizasyon
- `lib/l10n/app_tr.arb` ve `app_en.arb` → kaynak
- `app_localizations.dart` → abstract getter'lar (manuel ekleniyor)
- `app_localizations_tr.dart` / `app_localizations_en.dart` → implementasyon
- Kullanım: `AppLocalizations.of(context)!.key`
- **flutter gen-l10n çalıştırılmıyor**, 4 dosya manuel güncelleniyor

## Önemli Widget'lar
| Widget | Konum | Açıklama |
|---|---|---|
| `Button3D` | shared/widgets/buttons/ | Ana buton; text, isLoading, onPressed, leadingIcon |
| `AppSnackbar.showError` | shared/widgets/snackbar/ | Hata bildirimi (**showSuccess yok**) |
| `ShadowedTextField` | presentation/widgets/auth/ | Form input |
| `FormTitles` | presentation/widgets/auth/ | Başlık + alt başlık |
| `DatePicker` | presentation/widgets/home/ | onDateSelected callback var |
| `CalorieSummaryCard` | presentation/widgets/home/ | isLoading flag var |
| `GoogleButton` | shared/widgets/buttons/ | Google giriş butonu |
| `RoundedImage` | shared/widgets/image/ | Köşe yuvarlama ile görsel |

## Data Sources (API Servisleri)
| Servis | Dosya |
|---|---|
| `AuthApiService` | data/source/auth/ |
| `AuthLocalService` | data/source/auth/ (token: SharedPrefs) |
| `UserApiService` | data/source/user/ |
| `NutritionApiService` | data/source/nutrition/ |
| `AiApiService` | data/source/ai/ (SSE stream + Dio) |

## Bağımlılık Ekleme (Yeni UseCase)
1. UseCase sınıfı oluştur (`domain/usecases/`)
2. Repository interface'e metod ekle (`domain/repositories/`)
3. Repository impl'i güncelle (`data/repository/`)
4. API service'e ekle (`data/source/`)
5. `service_locator.dart`'a `sl.registerLazySingleton` ekle
6. İlgili BLoC/Cubit'e inject et

## Paketler (Önemli)
- `flutter_bloc` / `get_it` / `dartz` / `dio` / `go_router` / `phosphor_flutter`
- `intl` / `shared_preferences` / `lottie` / `shimmer` / `equatable`
- `image_picker` / `camera` / `google_mlkit_barcode_scanning`
- `smooth_page_indicator` / `carousel_slider` / `percent_indicator`
- `hydrated_bloc` / `flutter_dotenv` / `formz`

## Platform
- Windows 11, Flutter, Dart SDK ^3.8.1
- Android için ngrok / `10.0.2.2:8080`, diğerleri için `localhost:8080`

                                                                                                                                   1.Endpoint
