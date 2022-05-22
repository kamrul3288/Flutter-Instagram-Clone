import 'package:flutter_instagram_clone/presenter/addpost/add_post_view_model.dart';
import 'package:flutter_instagram_clone/presenter/comment/CommentViewModel.dart';
import 'package:flutter_instagram_clone/presenter/feed/feed_list_viewmodel.dart';
import 'package:flutter_instagram_clone/utils/image_picker.dart';
import 'package:get_it/get_it.dart';

GetIt di = GetIt.instance;

void initializeDependencies(){
  di.registerLazySingleton(() => AppImagePicker());
  di.registerLazySingleton(() => AddPostViewModel());
  di.registerLazySingleton(() => FeedListViewModel());
  di.registerLazySingleton(() => CommentViewModel());
}