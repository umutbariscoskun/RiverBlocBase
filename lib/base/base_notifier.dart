// import 'package:flutter/material.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';

// // BaseState sınıfı
// abstract class BaseState {
//   const BaseState();
// }

// // BaseNotifier sınıfı
// abstract class BaseNotifier<T extends BaseState> extends StateNotifier<T> {
//   BaseNotifier(T initialState) : super(initialState) {
//     onInitialized();
//   }

//   void onInitialized() {}

//   void safeUpdate(T Function(T state) update) {
//     if (!mounted) return;
//     state = update(state);
//   }
// }

// abstract class BaseWidget<N extends BaseNotifier<S>, S extends BaseState, P extends StateNotifierProvider<N, S>> extends HookConsumerWidget {
//   const BaseWidget({Key? key}) : super(key: key);

//   Widget buildWidget(BuildContext context, N notifier, S state);

//   P getProvider();

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final notifier = ref.watch(getProvider().notifier);
//     final state = ref.watch(getProvider());
//     return buildWidget(context, notifier, state);
//   }
// }
// // BaseView sınıfı
// abstract class BaseView<N extends BaseNotifier<S>, S extends BaseState>
//     extends HookConsumerWidget {
//   const BaseView({Key? key}) : super(key: key);

//   Widget builder(BuildContext context, N notifier, S state);

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final notifier = ref.watch(getProvider().notifier);
//     final state = ref.watch(getProvider());
//     return builder(context, notifier as N, state as S);
//   }

//   AutoDisposeStateNotifierProvider<BaseNotifier<BaseState>, BaseState>
//       getProvider();
// }

