import 'dart:io';

import 'package:mason/mason.dart';

Future<void> run(HookContext context) async {
  final flutterVersion = context.vars['flutterVersion']?.toString();

  if (flutterVersion == null || flutterVersion.isEmpty) {
    context.logger.err('flutterVersion variable is required but was not provided.');
    exit(1);
  }

  final progress = context.logger.progress(
    'Running pub get and build_runner build 🚀',
  );

  final fvmUse = await Process.run(
    'fvm',
    ['use', flutterVersion],
    runInShell: true,
  );
  if (fvmUse.exitCode != 0) {
    progress.fail('fvm use $flutterVersion failed:\n${fvmUse.stderr}');
    exit(fvmUse.exitCode);
  }

  final pubGet = await Process.run(
    'fvm',
    ['flutter', 'pub', 'get'],
    runInShell: true,
  );
  if (pubGet.exitCode != 0) {
    progress.fail('flutter pub get failed:\n${pubGet.stderr}');
    exit(pubGet.exitCode);
  }

  final makeInit = await Process.run(
    'make',
    ['init'],
    runInShell: true,
  );
  if (makeInit.exitCode != 0) {
    progress.fail('make init failed:\n${makeInit.stderr}');
    exit(makeInit.exitCode);
  }

  progress.complete('All done! 🎉');
}
