import 'package:flutter/material.dart';

import '../core/app_colors.dart';

import '../models/location_model.dart';

class LocationTile extends StatelessWidget {
  const LocationTile({
    super.key,
    required this.location,
    required this.favorite,
    required this.onTap,
    required this.onFavorite,
  });
  final LocationModel location;
  final bool favorite;
  final VoidCallback onTap, onFavorite;
  @override
  Widget build(BuildContext context) => ListTile(
    onTap: onTap,
    leading: CircleAvatar(
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      child: const Icon(Icons.location_on_outlined),
    ),
    title: Text(
      location.name,
      style: const TextStyle(fontWeight: FontWeight.w700),
    ),
    subtitle: Text(
      location.subtitle.isEmpty
          ? '${location.latitude.toStringAsFixed(2)}, ${location.longitude.toStringAsFixed(2)}'
          : location.subtitle,
    ),
    trailing: IconButton(
      onPressed: onFavorite,
      icon: Icon(
        favorite ? Icons.favorite : Icons.favorite_border,
        color: favorite ? AppColors.error : null,
      ),
    ),
  );
}
