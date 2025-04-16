import 'package:instrabaho_app/domain/data/category_model.dart';
import 'package:instrabaho_app/gen/assets.gen.dart';

List<CategoryModel> categories = [
  CategoryModel(
      id: '1', name: 'Electrician', imageUrl: Assets.categories.category1.path),
  CategoryModel(
      id: '2', name: 'Plumbers', imageUrl: Assets.categories.category2.path),
  CategoryModel(
      id: '3', name: 'Carpenters', imageUrl: Assets.categories.category3.path),
  CategoryModel(
      id: '4', name: 'Painters', imageUrl: Assets.categories.category4.path),
  CategoryModel(
      id: '5',
      name: 'House Cleaner',
      imageUrl: Assets.categories.category5.path),
];
