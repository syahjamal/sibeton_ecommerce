import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sibeton_ecommerce/api/db_api.dart';
import 'package:sibeton_ecommerce/models/category.dart';
import 'package:sibeton_ecommerce/widgets/bloc_provider.dart';

class CategoriesBloc implements BlocBase{
  List<Category> _categories = List();

  StreamController<List<Category>> _categoriesController = StreamController<List<Category>>();
  Sink<List<Category>> get _inCategories => _categoriesController.sink;
  Stream<List<Category>> get outCategories => _categoriesController.stream;

  CategoriesBloc(){
    _getCategories();
  }

  void _getCategories(){
    DbApi dbApi = DbApi();
    dbApi.getCategories().listen((snapshot){
      List<Category> tempCategories = List();
      for(DocumentSnapshot doc in snapshot.documents){
        Category category = Category.fromFirestore(doc.data);
        category.id = doc.documentID;
        tempCategories.add(category);
      }
      _categories.clear();
      _categories.addAll(tempCategories);
      _inCategories.add(_categories);
    });
  }

  @override
  void dispose() {
    _categoriesController.close();
  }

}