import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:popular_people_app/features/person_details/presentation/pages/person_details_view_arguments.dart';

import '../../../../dependencies/service_locator.dart';
import '../../../../utils/constants.dart';
import '../../../image_viewer/presentation/pages/image_viewer_arguments.dart';
import '../../../image_viewer/presentation/pages/image_viewer_view.dart';
import '../bloc/person_details_bloc.dart';

class PersonDetailsView extends StatefulWidget {
  static const String routeName = '/personDetails';
  final PersonDetailsViewArguments arguments;
  const PersonDetailsView({Key? key, required this.arguments})
      : super(key: key);

  @override
  State<PersonDetailsView> createState() => _PersonDetailsViewState();
}

class _PersonDetailsViewState extends State<PersonDetailsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Person Info"),
        ),
        backgroundColor: backgroundColor,
        body: BlocProvider<PersonDetailsBloc>(
          create: (_) => serviceLocator()
            ..add(FetchPersonImagesListEvent(
                personID: widget.arguments.person.personID)),
          child: BlocConsumer<PersonDetailsBloc, PersonDetailsState>(
              listener: (context, state) {},
              builder: (context, state) {
                return Container(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Container(
                        height: 75,
                        decoration: const BoxDecoration(
                            boxShadow: liteBoxShadow,
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(16))),
                        child: Center(
                          child: ListTile(
                            leading: CircleAvatar(
                              radius: 30,
                              backgroundImage: NetworkImage(imageBaseURL +
                                  widget.arguments.person.imageURL!),
                            ),
                            title: Text(widget.arguments.person.name),
                            subtitle: Text(widget.arguments.person.department),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      const SizedBox(
                        width: double.infinity,
                        child: Text(
                          "Gallery",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      ),
                      const SizedBox(height: 8),
                      state is FetchPersonImagesSuccessState
                          ? Expanded(
                              child: GridView.builder(
                                  itemCount: state.imagesList.length,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 8.0,
                                    mainAxisSpacing: 8.0,
                                  ),
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      onTap: () => Navigator.pushNamed(
                                          context, ImageViewerView.routeName,
                                          arguments: ImageViewerViewArguments(
                                              imageURL: state.imagesList[index],
                                              name: widget
                                                  .arguments.person.name)),
                                      child: CachedNetworkImage(
                                        imageBuilder:
                                            (context, imageProvider) =>
                                                Container(
                                          // width: 60.0,
                                          // height: 60.0,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            image: DecorationImage(
                                                image: imageProvider,
                                                fit: BoxFit.cover),
                                          ),
                                        ),
                                        imageUrl: imageBaseURL +
                                            state.imagesList[index],
                                        placeholder: (context, url) =>
                                            const CircularProgressIndicator(
                                          color: Colors.blue,
                                        ),
                                        errorWidget: (context, url, error) =>
                                            const Icon(
                                          Icons.error,
                                          color: Colors.white,
                                        ),
                                      ) /*  Image(
                                        image: NetworkImage(
                                            state.imagesList[index]),
                                      ) */
                                      ,
                                    );
                                  }),
                            )
                          : const SizedBox()
                    ],
                  ),
                );
              }),
        ));
  }
}
