import 'package:flutter/widgets.dart';

enum ViewState { idle, loading, error }

abstract class ViewModel extends ChangeNotifier {
  ViewState _currentState = ViewState.idle;
  bool _mounted = true;

  ViewState get state => _currentState;

  void _setState(ViewState newState) {
    if (_mounted) {
      _currentState = newState;
      notifyListeners();
    }
  }

  void update() {
    if (_mounted) {
      notifyListeners();
    }
  }

  void setLoading() => _setState(ViewState.loading);

  void setIdle() => _setState(ViewState.idle);

  void setError() => _setState(ViewState.error);

  bool get isLoading => _currentState == ViewState.loading;

  bool get hasError => _currentState == ViewState.error;

  @override
  void dispose() {
    _mounted = false;
    super.dispose();
  }
}
