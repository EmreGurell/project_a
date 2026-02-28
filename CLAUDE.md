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
  data/
    models/             # JSON model'lar (.fromJson / .toEntity())
    repository/         # Repository impl'leri
    source/             # API servis impl'leri (Dio)
  domain/
    entities/           # Saf entity sınıfları
    repositories/       # Abstract repository interface'leri
    usecases/           # Use case sınıfları (Usecase<Either, Param>)
  presentation/
    bloc/               # Sayfa-bazlı BLoC/Cubit'ler
    screens/            # Ekranlar
    widgets/            # Ekrana özel widget'lar
  shared/widgets/       # Tüm uygulamada kullanılan widget'lar
  l10n/                 # Lokalizasyon (TR + EN)
  utils/                # Sabitler (colors, sizes, image_paths), helpers
```

## State Management Kuralları
- **Auth akışları** → `ButtonStateCubit` (sl<ButtonStateCubit>())
- **Login** → `AuthStateCubit`
- **Sayfa-bazlı** → ilgili BLoC (HomeBloc, ProfileBloc vb.)
- Başarı/hata `BlocListener` ile dinlenir, `BlocBuilder` sadece UI günceller
- Snackbar → `AppSnackbar.showError(context, message: ...)`

## Navigasyon (GoRouter v17)
- Route isimleri: `RouteNames` sınıfı (`route_names.dart`)
- Sayfalar arası veri: `context.go/push(route, extra: Map<String, dynamic>)`
- Router'da `state.extra as Map<String, dynamic>` ile alınır

## Mevcut Route'lar
| Route | Dosya |
|---|---|
| `/` | splash |
| `/login` | auth/login.dart |
| `/register` | auth/register.dart |
| `/forgot-password` | auth/forgot_password.dart |
| `/verify-account` | auth/verify_account.dart → extra: {email, isForReset} |
| `/reset-password` | auth/reset_password.dart → extra: {email, code} |
| `/onboarding` | onboarding/onboarding.dart |
| `/home` | home/home.dart (StatefulShell) |
| `/profile` | profile/profile.dart (StatefulShell) |

## Auth Akışları
- **Login** → home
- **Register** → verify-account (isForReset: false) → home
- **Forgot Password** → verify-account (isForReset: true) → reset-password → login

## API Endpoint'leri (`ApiEndpoints`)
| Sabit | URL |
|---|---|
| `register` | api/v1/users/register |
| `login` | api/v1/users/login |
| `currentUser` | api/v1/users/me |
| `forgotPassword` | api/v1/users/forgot-password |
| `resetPassword` | api/v1/users/reset-password |
| `verifyAccount` | api/v1/users/verify |
| `resendVerification` | api/v1/users/resend-verification |
| `nutritionDataByDate` | api/v1/nutrition/get-by-date?date=yyyy-MM-dd |

## Lokalizasyon
- `lib/l10n/app_tr.arb` ve `app_en.arb` → kaynak
- `app_localizations.dart` → abstract getter'lar (manuel ekleniyor)
- `app_localizations_tr.dart` / `app_localizations_en.dart` → implementasyon
- Kullanım: `AppLocalizations.of(context)!.key`
- **flutter gen-l10n çalıştırılmıyor**, 4 dosya manuel güncelleniyor

## Önemli Widget'lar
| Widget | Konum | Açıklama |
|---|---|---|
| `Button3D` | shared/widgets/buttons/ | Ana buton, isLoading parametresi var |
| `ShadowedTextField` | presentation/widgets/auth/ | Form input |
| `FormTitles` | presentation/widgets/auth/ | Başlık + alt başlık |
| `AppSnackbar.showError` | shared/widgets/snackbar/ | Hata bildirimi (showSuccess yok) |
| `DatePicker` | presentation/widgets/home/ | onDateSelected callback var |
| `CalorieSummaryCard` | presentation/widgets/home/ | isLoading flag var |

## Home Sayfası Akışı
- `HomeBloc`: `LoadCurrentUser` → kullanıcı + nutrition çeker
- `ChangeDate(date)` event → sadece nutrition yeniden çeker
- `HomeState.HomeLoaded`: user, nutrition (nullable), dateRange, selectedDate, isNutritionLoading
- `copyWith()` ile partial güncellemeler yapılır

## Bağımlılık Ekleme (Yeni UseCase)
1. UseCase sınıfı oluştur (`domain/usecases/`)
2. Repository interface'e metod ekle (`domain/repositories/`)
3. Repository impl'i güncelle (`data/repository/`)
4. API service'e ekle (`data/source/`)
5. `service_locator.dart`'a `sl.registerLazySingleton` ekle
6. İlgili BLoC/Cubit'e inject et

## Paketler (Önemli)
- `flutter_bloc` / `get_it` / `dartz` / `dio` / `go_router` / `phosphor_flutter`
- `intl` / `shared_preferences` / `lottie` / `shimmer`

## Platform
- Windows 11, Flutter, Dart SDK ^3.8.1
- Android için ngrok, diğerleri için localhost:8080
