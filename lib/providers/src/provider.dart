import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import './nested/nested.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';

part './inherited_provider.dart';
part './deferred_inherited_provider.dart';

/// A provider that merges multiple providers into a single linear widget tree.
/// It is used to improve readability and reduce boilerplate code of having to
/// nest multiple layers of providers.
///
/// As such, we're going from:
///
/// ```dart
/// Provider<Something>(
///   create: (_) => Something(),
///   child: Provider<SomethingElse>(
///     create: (_) => SomethingElse(),
///     child: Provider<AnotherThing>(
///       create: (_) => AnotherThing(),
///       child: someWidget,
///     ),
///   ),
/// ),
/// ```
///
/// To:
///
/// ```dart
/// MultiProvider(
///   providers: [
///     Provider<Something>(create: (_) => Something()),
///     Provider<SomethingElse>(create: (_) => SomethingElse()),
///     Provider<AnotherThing>(create: (_) => AnotherThing()),
///   ],
///   child: someWidget,
/// )
/// ```
///
/// The widget tree representation of the two approaches are identical.
class MultiProvider extends Nested {
  /// Build a tree of providers from a list of [SingleChildWidget].
  MultiProvider({
    Key key,
    @required List<SingleChildWidget> providers,
    Widget child,
  })  : assert(providers != null),
        super(key: key, children: providers, child: child);
}

/// A [Provider] that manages the lifecycle of the value it provides by
/// delegating to a pair of [Create] and [Dispose].
///
/// It is usually used to avoid making a [StatefulWidget] for something trivial,
/// such as instantiating a BLoC.
///
/// [Provider] is the equivalent of a [State.initState] combined with
/// [State.dispose]. [Create] is called only once in [State.initState].
/// We cannot use [InheritedWidget] as it requires the value to be
/// constructor-initialized and final.
///
/// The following example instantiates a `Model` once, and disposes it when
/// [Provider] is removed from the tree.
///
/// ```dart
/// class Model {
///   void dispose() {}
/// }
///
/// class Stateless extends StatelessWidget {
///   @override
///   Widget build(BuildContext context) {
///     return Provider<Model>(
///       create: (context) =>  Model(),
///       dispose: (context, value) => value.dispose(),
///       child: ...,
///     );
///   }
/// }
/// ```
///
/// It is worth noting that the `create` callback is lazily called.
/// It is called the first time the value is read, instead of the first time
/// [Provider] is inserted in the widget tree.
///
/// This behavior can be disabled by passing `lazy: false` to [Provider].
///
/// ## Testing
///
/// When testing widgets that consumes providers, it is necessary to
/// add the proper providers in the widget tree above the tested widget.
///
/// A typical test may look like this:
///
/// ```dart
/// final foo = MockFoo();
///
/// await tester.pumpWidget(
///   Provider<Foo>.value(
///     value: foo,
///     child: TestedWidget(),
///   ),
/// );
/// ```
///
/// Note this example purposefully specified the object type, instead of having
/// it infered.
/// Since we used a mocked class (typically using `mockito`), then we have to
/// downcast the mock to the type of the mocked class.
/// Otherwise, the type inference will resolve to `Provider<MockFoo>` instead of
/// `Provider<Foo>`, which will cause `Provider.of<Foo>` to fail.
class Provider<T> extends InheritedProvider<T> {
  /// Creates a value, store it, and expose it to its descendants.
  ///
  /// The value can be optionally disposed using [dispose] callback.
  /// This callback which will be called when [Provider] is unmounted from the
  /// widget tree.
  Provider({
    Key key,
    @required Create<T> create,
    Dispose<T> dispose,
    bool lazy,
    Widget child,
  })  : assert(create != null),
        super(
          key: key,
          lazy: lazy,
          create: create,
          dispose: dispose,
          debugCheckInvalidValueType:
              kReleaseMode ? null : (T value) => Provider.debugCheckInvalidValueType?.call<T>(value),
          child: child,
        );

  /// Expose an existing value without disposing it.
  ///
  /// {@template provider.updateshouldnotify}
  /// `updateShouldNotify` can optionally be passed to avoid unnecessarily
  /// rebuilding dependents when [Provider] is rebuilt but `value` did not change.
  ///
  /// Defaults to `(previous, next) => previous != next`.
  /// See [InheritedWidget.updateShouldNotify] for more information.
  /// {@endtemplate}
  Provider.value({
    Key key,
    @required T value,
    UpdateShouldNotify<T> updateShouldNotify,
    Widget child,
  })  : assert(() {
          Provider.debugCheckInvalidValueType?.call<T>(value);
          return true;
        }()),
        super.value(
          key: key,
          value: value,
          updateShouldNotify: updateShouldNotify,
          child: child,
        );

  /// Obtains the nearest [Provider<T>] up its widget tree and returns its
  /// value.
  ///
  /// If [listen] is `true`, later value changes will trigger a new
  /// [State.build] to widgets, and [State.didChangeDependencies] for
  /// [StatefulWidget].
  ///
  /// `listen: false` is necessary to be able to call `Provider.of` inside
  /// [State.initState] or the `create` method of providers like so:
  ///
  /// ```dart
  /// Provider(
  ///   create: (context) {
  ///     return Model(Provider.of<Something>(context, listen: false)),
  ///   },
  /// )
  /// ```
  static T of<T>(BuildContext context, {bool listen = true}) {
    assert(
      T != dynamic,
      '''
Tried to call Provider.of<dynamic>. This is likely a mistake and is therefore
unsupported.

If you want to expose a variable that can be anything, consider changing
`dynamic` to `Object` instead.
''',
    );
    assert(
      context.owner.debugBuilding || listen == false || _debugIsInInheritedProviderUpdate,
      '''
Tried to listen to a value exposed with provider, from outside of the widget tree.

This is likely caused by an event handler (like a button's onPressed) that called
Provider.of without passing `listen: false`.

To fix, write:
Provider.of<$T>(context, listen: false);

It is unsupported because may pointlessly rebuild the widget associated to the
event handler, when the widget tree doesn't care about the value.

The context used was: $context
''',
    );

    InheritedContext<T> inheritedElement;

    if (context.widget is _DefaultInheritedProviderScope<T>) {
      // An InheritedProvider<T>'s update tries to obtain a parent provider of
      // the same type.
      context.visitAncestorElements((parent) {
        inheritedElement = parent.getElementForInheritedWidgetOfExactType<_DefaultInheritedProviderScope<T>>()
            as _DefaultInheritedProviderScopeElement<T>;
        return false;
      });
    } else {
      inheritedElement = context.getElementForInheritedWidgetOfExactType<_DefaultInheritedProviderScope<T>>()
          as _DefaultInheritedProviderScopeElement<T>;
    }

    if (inheritedElement == null) {
      throw ProviderNotFoundException(T, context.widget.runtimeType);
    }

    if (listen) {
      context.dependOnInheritedElement(inheritedElement as InheritedElement);
    }

    return inheritedElement.value;
  }

  /// A sanity check to prevent misuse of [Provider] when a variant should be
  /// used instead.
  ///
  /// By default, [debugCheckInvalidValueType] will throw if `value` is a
  /// [Listenable] or a [Stream]. In release mode, [debugCheckInvalidValueType]
  /// does nothing.
  ///
  /// This check can be disabled altogether by setting
  /// [debugCheckInvalidValueType] to `null` like so:
  ///
  /// ```dart
  /// void main() {
  ///   Provider.debugCheckInvalidValueType = null;
  ///   runApp(MyApp());
  /// }
  /// ```
  static void Function<T>(T value) debugCheckInvalidValueType = <T>(T value) {
    assert(() {
      if (value is Listenable || value is Stream) {
        throw FlutterError('''
Tried to use Provider with a subtype of Listenable/Stream ($T).

This is likely a mistake, as Provider will not automatically update dependents
when $T is updated. Instead, consider changing Provider for more specific
implementation that handles the update mechanism, such as:

- ListenableProvider
- ChangeNotifierProvider
- ValueListenableProvider
- StreamProvider

Alternatively, if you are making your own provider, consider using InheritedProvider.

If you think that this is not an error, you can disable this check by setting
Provider.debugCheckInvalidValueType to `null` in your main file:

```
void main() {
  Provider.debugCheckInvalidValueType = null;

  runApp(MyApp());
}
```
''');
      }
      return true;
    }());
  };
}

/// The error that will be thrown if [Provider.of] fails to find a [Provider]
/// as an ancestor of the [BuildContext] used.
class ProviderNotFoundException implements Exception {
  /// The type of the value being retrieved
  final Type valueType;

  /// The type of the Widget requesting the value
  final Type widgetType;

  /// Create a ProviderNotFound error with the type represented as a String.
  ProviderNotFoundException(
    this.valueType,
    this.widgetType,
  );

  @override
  String toString() {
    return '''
Error: Could not find the correct Provider<$valueType> above this $widgetType Widget

To fix, please:

  * Ensure the Provider<$valueType> is an ancestor to this $widgetType Widget
  * Provide types to Provider<$valueType>
  * Provide types to Consumer<$valueType>
  * Provide types to Provider.of<$valueType>()
  * Ensure the correct `context` is being used.

If none of these solutions work, please file a bug at:
https://github.com/rrousselGit/provider/issues
''';
  }
}
