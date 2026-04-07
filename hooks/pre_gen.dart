import 'package:mason/mason.dart';

void run(HookContext context) {
  final projectName = context.vars['projectName']?.toString() ?? '';
  final appName = context.vars['appName']?.toString() ?? '';
  final bundleId = context.vars['bundleId']?.toString() ?? '';
  final flutterVersion = context.vars['flutterVersion']?.toString() ?? '';
  final projectDescription =
      context.vars['projectDescription']?.toString() ?? '';

  final packageNameRegex = RegExp(r'^[a-z][a-z0-9_]*$');
  if (projectName.trim().isEmpty || !packageNameRegex.hasMatch(projectName)) {
    context.logger.err(
      'projectName "$projectName" is invalid. '
      'Must be lowercase snake_case (e.g. my_saas_app).',
    );
    throw ArgumentError('Invalid projectName: $projectName');
  }

  if (appName.trim().isEmpty) {
    context.logger.err('appName cannot be empty.');
    throw ArgumentError('appName cannot be empty.');
  }

  if (projectDescription.trim().isEmpty) {
    context.logger.err('projectDescription cannot be empty.');
    throw ArgumentError('projectDescription cannot be empty.');
  }

  final bundleIdRegex =
      RegExp(r'^[a-zA-Z][a-zA-Z0-9_]*(\.[a-zA-Z][a-zA-Z0-9_]*){2,}$');
  if (!bundleIdRegex.hasMatch(bundleId)) {
    context.logger.err(
      'bundleId "$bundleId" is invalid. '
      'Expected format: com.example.app (at least 3 segments).',
    );
    throw ArgumentError('Invalid bundleId: $bundleId');
  }

  final versionRegex = RegExp(r'^\d+\.\d+\.\d+$');
  if (!versionRegex.hasMatch(flutterVersion)) {
    context.logger.err(
      'flutterVersion "$flutterVersion" is invalid. '
      'Expected format: X.Y.Z (e.g. 3.13.6).',
    );
    throw ArgumentError('Invalid flutterVersion: $flutterVersion');
  }

  context.logger.info('✓ Variables validated successfully.');
}
