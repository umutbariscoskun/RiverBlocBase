import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverbloc/riverbloc.dart';

abstract class BaseState {}

abstract class BaseCubit<S extends BaseState> extends Cubit<S> {
  BaseCubit(super.initialState) {
    onInitialized();
  }

  void onInitialized() {}

  void safeEmit(S state) {
    if (!isClosed) {
      emit(state);
    }
  }
}

abstract class BaseWidget<C extends BaseCubit<S>, S extends BaseState>
    extends ConsumerWidget {
  const BaseWidget({super.key});

  Widget buildWidget(BuildContext context, C cubit, S state);

  BlocProvider<C, S> getProvider();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cubit = ref.watch(getProvider().bloc);
    final state = ref.watch(getProvider());
    return buildWidget(context, cubit, state);
  }
}

class CounterState extends BaseState {
  final int count;
  CounterState(this.count);
}

class CounterCubit extends BaseCubit<CounterState> {
  CounterCubit() : super(CounterState(0));

  void increment() => safeEmit(CounterState(state.count + 1));
}

final counterProvider =
    BlocProvider<CounterCubit, CounterState>((ref) => CounterCubit());

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends BaseWidget<CounterCubit, CounterState> {
  final String title;

  const MyHomePage({required this.title, super.key});

  @override
  BlocProvider<CounterCubit, CounterState> getProvider() => counterProvider;

  @override
  Widget buildWidget(
      BuildContext context, CounterCubit cubit, CounterState state) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Current count: ${state.count}',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: cubit.increment,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
