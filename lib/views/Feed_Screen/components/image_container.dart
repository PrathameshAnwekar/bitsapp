import 'package:bitsapp/constants/size_config.dart';
import 'package:bitsapp/services/logger_service.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:photo_view/photo_view.dart';

class ImageContainer extends StatelessWidget {
  const ImageContainer({super.key, required this.url});
  final String url;

  @override
  Widget build(BuildContext context) {
    return Container(
      
      width: 300,
      child: PhotoView(
        imageProvider: CachedNetworkImageProvider(

          url,
          cacheKey: url,
          
          maxWidth: 300,
          errorListener: () {
            dlog("error loading image");
          },
        ),
      ),
    );
  }
}