import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:grabit/features/home/model/repos/home_repo.dart';
import 'package:grabit/features/home/model/section_model.dart';

class HomeViewModel extends ChangeNotifier {
  final _repo = GetIt.instance<HomeRepo>();
  
  List<SectionModel> _sections = [];
  String? errorMessage;
  bool _isLoading = true;

  List<SectionModel> get sections => _sections;
  bool get isLoading => _isLoading;

  Future<void> loadHomeData() async {
    _isLoading = true;
    errorMessage = null;
    notifyListeners();
    log('Starting to load home data');

    final result = await _repo.getHomeSections();
    result.fold(
      (l) {
        log('Error loading sections: $l');
        errorMessage = l;
        _isLoading = false;
      },
      (r) {
        _sections = r;
        _isLoading = false;
        log('Sections loaded: ${_sections.length} items');
      },
    );
    notifyListeners();
  }
}