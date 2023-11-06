# Flexible Theme for flutter projects.

This theme concept is inspired by the Factory Method pattern, which can change Flutter ThemeData and TextTheme by language. This document describes how to configure this concept in your Flutter project.

To use this theme concept, follow these steps:
1. Define a theme class for each supported locale. For example, if you support English and Chinese, you might define two classes:
```dart
class EnTextThemeFactory implements TextThemeFactory {
  @override
  TextTheme create() {
    return TextTheme(
        displayLarge: displayLarge,
        displayMedium: displayMedium,
        displaySmall: displaySmall,
        headlineLarge: headlineLarge,
        headlineMedium: headlineMedium,
        headlineSmall: headlineSmall,
        titleLarge: titleLarge,
        titleMedium: titleMedium,
        titleSmall: titleSmall,
        bodyLarge: bodyLarge,
        bodyMedium: bodyMedium,
        bodySmall: bodySmall,
        labelLarge: labelLarge,
        labelMedium: labelMedium,
        labelSmall: labelSmall);
  }

  ...

}

class ZhTextThemeFactory implements TextThemeFactory {}
```
Or, maybe reuse the old theme class and recreate a new variant:
```dart
class EnTextThemeFactory extends BaseTextThemeFactory {
   @override
  TextStyle get light => const TextStyle(
        color: ColorName.black,
        fontSize: 16,
        fontFamily: FontFamily.roboto,
        fontWeight: FontWeight.w300,
        letterSpacing: 0,
      );

      ...
}

class ZhTextThemeFactory implements BaseTextThemeFactory {}
```
2. Add the themes you defined to MaterialApp via AppThemeWrapper.
```dart
class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final router = getIt<AppRouter>();
    return BlocBuilder<LangCubit, Locale>(
      builder: (context, locale) {
        return AppThemeWrapper(
         appTheme: AppTheme.create(
              locale,
              mapper: {
                'en'.toLocale: EnTextThemeFactory(),
                'zh-Hant'.toLocale: ZhTextThemeFactory(),
              },
            ),
          builder: (context, themeData) => MaterialApp.router(
            localizationsDelegates: const [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: S.delegate.supportedLocales,
            locale: locale,
            theme: themeData,
            routerDelegate: router.delegate(),
            routeInformationParser: router.defaultRouteParser(),
          ),
        );
      },
    );
  }
}
```
By default, the theme concept will choose the theme that is appropriate for the current locale. However, you can override this behavior by using the filter property. For example, you could use the filter property to only use the Chinese theme for locales that start with `zh`, such as `zh-Hant` and `zh-Hans`.

```dart
appTheme: AppTheme.create(
              locale,
              mapper: {
                'en'.toLocale: EnglishTextThemeFactory(),
                'zh'.toLocale: ZhTextThemeFactory(),
              },
              filter: (mapper) {
                final map = mapper.map((k, v) => MapEntry(k.languageCode, v));
                return map[locale.languageCode];
              },
            ),
```


Everything is completed. And now you can use in the BuildContext property:
```dart
Text(`Hello World`, style: context.textTheme.bold)
```
