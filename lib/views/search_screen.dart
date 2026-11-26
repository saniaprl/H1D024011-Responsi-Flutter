import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/view_state.dart';
import '../models/location_model.dart';
import '../viewmodels/location_viewmodel.dart';
import '../widgets/location_tile.dart';
import '../widgets/state_message.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController controller = TextEditingController();
  Timer? _debounce;

  @override
  void dispose() {
    _debounce?.cancel();
    controller.dispose();
    super.dispose();
  }

  void _search(String value) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      if (mounted) context.read<LocationViewModel>().search(value);
    });
  }

  Future<void> _choose(LocationModel location) async {
    final vm = context.read<LocationViewModel>();
    await vm.selectLocation(location);
    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cari lokasi')),
      body: Consumer<LocationViewModel>(
        builder: (context, vm, _) => ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextField(
              controller: controller,
              autofocus: true,
              onChanged: (value) {
                setState(() {});
                _search(value);
              },
              onSubmitted: vm.search,
              textInputAction: TextInputAction.search,
              decoration: InputDecoration(
                hintText: 'Ketik nama kota...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: controller.text.isEmpty
                    ? null
                    : IconButton(
                        onPressed: () {
                          controller.clear();
                          vm.search('');
                          setState(() {});
                        },
                        icon: const Icon(Icons.clear),
                      ),
              ),
            ),
            const SizedBox(height: 20),
            if (vm.favorites.isNotEmpty) ...[
              Text(
                'Lokasi favorit',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              ...vm.favorites.map(
                (location) => LocationTile(
                  location: location,
                  favorite: true,
                  onTap: () => _choose(location),
                  onFavorite: () => vm.toggleFavorite(location),
                ),
              ),
              const SizedBox(height: 20),
            ],
            if (vm.searchState == ViewState.loading)
              const Center(
                child: Padding(
                  padding: EdgeInsets.all(30),
                  child: CircularProgressIndicator(),
                ),
              ),
            if (vm.searchState == ViewState.error)
              StateMessage(
                icon: Icons.wifi_off,
                title: 'Pencarian gagal',
                message: vm.errorMessage ?? '',
                onRetry: () => vm.search(controller.text),
              ),
            if (vm.searchState == ViewState.empty)
              const StateMessage(
                icon: Icons.location_off,
                title: 'Lokasi tidak ditemukan',
                message: 'Coba gunakan nama kota yang lebih umum.',
              ),
            if (vm.searchState == ViewState.success) ...[
              Text(
                'Hasil pencarian',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              ...vm.results.map(
                (location) => LocationTile(
                  location: location,
                  favorite: vm.isFavorite(location),
                  onTap: () => _choose(location),
                  onFavorite: () => vm.toggleFavorite(location),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
