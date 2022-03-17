import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../dependencies/service_locator.dart';
import '../../../../utils/constants.dart';
import '../bloc/image_viewer_bloc.dart';
import 'image_viewer_arguments.dart';

class ImageViewerView extends StatefulWidget {
  static const routeName = '/imageViewer';
  final ImageViewerViewArguments arguments;
  const ImageViewerView({Key? key, required this.arguments}) : super(key: key);

  @override
  State<ImageViewerView> createState() => _ImageViewerViewState();
}

class _ImageViewerViewState extends State<ImageViewerView> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<ImageViewerBloc>(
      create: (_) => serviceLocator(),
      child: BlocConsumer<ImageViewerBloc, ImageViewerState>(
          builder: (context, state) {
        return Scaffold(
          appBar: AppBar(title: Text(widget.arguments.name)),
          floatingActionButton: state is! DownloadImageLoadingState
              ? Container(
                  width: 130,
                  height: 50,
                  decoration: const BoxDecoration(
                      boxShadow: liteBoxShadow,
                      color: Colors.black,
                      borderRadius: BorderRadius.all(Radius.circular(16))),
                  child: TextButton.icon(
                    onPressed: () {
                      if (state is! DownloadImageLoadingState) {
                        BlocProvider.of<ImageViewerBloc>(context).add(
                            DownloadImageEvent(
                                imageURL:
                                    imageBaseURL + widget.arguments.imageURL));
                      }
                    },
                    icon: const Icon(
                      Icons.download,
                      color: Colors.white,
                    ),
                    label: const Text(
                      'Download',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                )
              : const SizedBox(),
          body: Stack(
            children: [
              SafeArea(
                  child: Center(
                      child: Image(
                          image: NetworkImage(
                              imageBaseURL + widget.arguments.imageURL)))),
              state is DownloadImageLoadingState
                  ? Container(
                      width: double.infinity,
                      height: double.infinity,
                      color: Colors.black.withOpacity(0.4),
                      child: Center(
                        child: Container(
                          width: 120,
                          height: 120,
                          decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16)),
                              color: Colors.white),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              SizedBox(
                                width: 30,
                                height: 30,
                                child: CircularProgressIndicator(
                                  color: Colors.blue,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text("Downloading..")
                            ],
                          ),
                        ),
                      ),
                    )
                  : const SizedBox()
            ],
          ),
        );
      }, listener: (context, state) {
        if (state is DownloadImageFailedState) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.failureMessage)));
        } else if (state is DownloadImageSuccessState) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Download Completed")));
        }
      }),
    );
  }
}
