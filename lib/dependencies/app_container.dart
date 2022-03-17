import 'package:popular_people_app/dependencies/image_viewer_container.dart';
import 'package:popular_people_app/dependencies/person_details_container.dart';
import 'package:popular_people_app/dependencies/popular_people_list_container.dart';
import 'core_container.dart';

init(){
  CoreContainer();
  PopularPeopleListContainer();
  PersonDetailsContainer();
  ImageViewerContainer();
}