import 'package:cached_network_image/cached_network_image.dart';
import 'package:caution_companion/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class NetworkImageWidget extends StatelessWidget {
  final String url;
  final String name;
  const NetworkImageWidget({super.key, required this.url, required this.name});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(9999),
      child: CachedNetworkImage(
        imageUrl: url,
        fit: BoxFit.cover,
        imageBuilder: (context, imageProvider) => Container(
          height: 146,
          width: 146,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: grey400,
            image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover
            )
          ),
        ),
        placeholder: (ctx, url)=> Shimmer.fromColors( 
          baseColor: grey100, 
          highlightColor: grey400,
          child: Container(
            height: 146,
            width: 146,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: grey400
            ),
          ),
        ),
        errorWidget: (context, url, error) => Container(
          height: 146,
          width: 146,
          decoration: BoxDecoration(
            color: grey400,
            shape: BoxShape.circle
          ),
          alignment: Alignment.center,
          child: Text(name.substring(0,1), style: const TextStyle(fontSize: 50, fontFamily: "Inter", fontWeight: FontWeight.w700, color: Colors.white),),
        ),
      ),
    ); 
  }
}