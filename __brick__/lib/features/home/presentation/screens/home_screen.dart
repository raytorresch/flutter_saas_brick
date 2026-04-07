import 'package:{{projectName}}/core/core.dart';
import 'package:{{projectName}}/features/home/blocs/example/example_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ExampleBloc(const Initial()),
      child: const _HomeView(),
    );
  }
}

class _HomeView extends StatelessWidget {
  const _HomeView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.helloWorld),
      ),
      body: BlocBuilder<ExampleBloc, ExampleState>(
        builder: (context, state) {
          return switch (state) {
            LoadInProgress() => const Center(child: CircularProgressIndicator()),
            LoadSuccess(:final data) => Center(child: Text(data)),
            LoadFailure(:final message) => Center(child: Text(message)),
            _ => Center(child: Text(context.l10n.helloWorld)),
          };
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            context.read<ExampleBloc>().add(const ExampleEvent.loaded(42)),
        child: const Icon(Icons.play_arrow),
      ),
    );
  }
}
