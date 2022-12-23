import 'dart:async';

import 'package:bloc_learn/counter_event.dart';

class CounterBloc {
  int _counter = 0;

  //State Controller
  final _counterStateController = StreamController<int>();

  //sink and stream
  StreamSink<int> get _intCounter => _counterStateController.sink;

  Stream<int> get counter => _counterStateController.stream;

  //Event Controller
  final _counterEventController = StreamController<CounterEvent>();

  Sink<CounterEvent> get counterEventSink => _counterEventController.sink;

  CounterBloc() {
    _counterEventController.stream.listen(_mapToCounterState);
  }

  void _mapToCounterState(CounterEvent event) {
    if (event is IncrementEvent) {
      _counter++;
    } else {
      _counter--;
    }

    _intCounter.add(_counter);
  }

  void dispose() {
    _counterEventController.close();
    _counterStateController.close();
  }
}
