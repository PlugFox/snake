import 'dart:collection';

import 'package:freezed_annotation/freezed_annotation.dart';

import 'coordinate.dart';

/// {@template snake}
/// Snake immutable collection.
/// Creates an unmodifiable list backed by source.
///
/// The source of the elements may be a [List] or any [Iterable] with
/// efficient [Iterable.length] and [Iterable.elementAt].
/// {@endtemplate}
@immutable
class Snake extends IterableBase<Coordinate> {
  /// {@macro snake}
  Snake(Iterable<Coordinate> source) : _source = List<Coordinate>.of(source, growable: false);

  /// {@macro snake}
  /// Empty collection
  const Snake.empty() : _source = const Iterable.empty();

  final Iterable<Coordinate> _source;

  @override
  int get length => _source.length;

  @override
  Coordinate get last => _source.last;

  @override
  Iterator<Coordinate> get iterator => _source.iterator;

  /// Adds [value] to the end of this list,
  /// Returns a new list with the element added.
  Snake add(Coordinate value) => Snake(List<Coordinate>.of(_source)..add(value));

  /// Appends all objects of [iterable] to the end of this list.
  /// Returns a new list with the elements added.
  Snake addAll(Iterable<Coordinate> iterable) => Snake(List<Coordinate>.of(_source)..addAll(iterable));

  /// Removes the first occurrence of [value] from this list.
  /// Returns a new list with removed element.
  Snake remove(Coordinate value) => Snake(
        List<Coordinate>.of(_source)..remove(value),
      );

  /// Removes all objects from this list that satisfy [test].
  /// Returns a new list with removed element.
  Snake removeWhere(bool Function(Coordinate) test) => Snake(
        List<Coordinate>.of(_source)..removeWhere(test),
      );

  /// Set element.
  /// Returns a new list with element.
  Snake upsert(Coordinate element) => Snake(
        List<Coordinate>.of(_source)
          ..remove(element)
          ..add(element),
      );

  /// Pop last element
  Snake pop() => Snake(
        _source.isNotEmpty ? List<Coordinate>.of(_source..take(_source.length - 1)) : <Coordinate>[],
      );

  /// Sorts this list according to the order specified by the [compare] function
  Snake sort([int Function(Coordinate a, Coordinate b)? compare]) => Snake(
        List<Coordinate>.of(_source, growable: false)..sort(compare),
      );

  /// Generate Map<String, Object?> from class
  List<Map<String, Object?>> toJson() => _source.map<Map<String, Object?>>((e) => e.toJson()).toList();

  /// Returns the element at the given [index] in the list
  ///  or throws an [RangeError]
  Coordinate operator [](int index) => _source.elementAt(index);

  @override
  int get hashCode => _source.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Snake &&
          runtimeType == other.runtimeType &&
          _source == other._source &&
          const DeepCollectionEquality().equals(_source, other._source);

  @override
  String toString() {
    final buffer = StringBuffer('[ ');
    for (final coordinate in _source) {
      buffer
        ..write(coordinate.dx)
        ..write('x')
        ..write(coordinate.dy)
        ..write(' ');
    }
    return (buffer..write(']')).toString();
  }
} // Snake
