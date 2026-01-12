import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class TeamInfo extends StatelessWidget {
  final String? teamName;
  final String? teamLogoUrl;

  const TeamInfo({super.key, this.teamName, this.teamLogoUrl});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Image circular from url with CachedNetworkImage
        FadeInImage(
          placeholder: AssetImage('assets/images/soccer_placeholder.png'),
          image: CachedNetworkImageProvider(teamLogoUrl ?? ''),
          height: 50,
          width: 50,
          fit: BoxFit.cover,
        ),
        const SizedBox(height: 4),
        Text(teamName ?? 'Team Name'),
      ],
    );
  }
}
