import 'package:first_flutter/apps/refresh_loadmore_gridview/models/color.dart';
import 'package:first_flutter/apps/refresh_loadmore_gridview/widgets/color_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RefreshLoadmoreGridviewBody extends StatefulWidget {
  const RefreshLoadmoreGridviewBody({super.key});

  @override
  State<RefreshLoadmoreGridviewBody> createState() =>
      _RefreshLoadmoreGridviewBodyState();
}

class _RefreshLoadmoreGridviewBodyState
    extends State<RefreshLoadmoreGridviewBody> {
  static const double _endReachedThreshold = 200;
  static const int _itemsPerPage = 20;

  final ScrollController _controller = ScrollController();

  final List<ColorInformation> _colors = [];
  int _nextPage = 1;
  bool _loading = true;
  bool _canLoadMore = true;

  @override
  void initState() {
    _controller.addListener(_onScroll);

    _getColors();

    super.initState();
  }

  Future<void> _getColors() async {
    _loading = true;

    final newColors =
        await getColorsFromServer(page: _nextPage, limit: _itemsPerPage);

    setState(() {
      _colors.addAll(newColors);

      _nextPage++;

      if (newColors.length < _itemsPerPage) {
        _canLoadMore = false;
      }

      _loading = false;
    });
  }

  void _onScroll() {
    if (!_controller.hasClients || _loading) return;

    final thresholdReached =
        _controller.position.extentAfter < _endReachedThreshold;

    if (thresholdReached) {
      _getColors();
    }
  }

  Future<void> _refresh() async {
    setState(() {
      _canLoadMore = true;
      _colors.clear();
      _nextPage = 1;
    });
    await _getColors();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: _controller,
      slivers: <Widget>[
        CupertinoSliverRefreshControl(
          onRefresh: _refresh,
        ),
        SliverPadding(
          padding: const EdgeInsets.all(16),
          sliver: SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 1.6,
              crossAxisCount: 2,
              crossAxisSpacing: 3,
              mainAxisSpacing: 16,
            ),
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return ColorItem(_colors[index]);
              },
              childCount: _colors.length,
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: _canLoadMore
              ? Container(
                  padding: const EdgeInsets.only(bottom: 16),
                  alignment: Alignment.center,
                  child: const CircularProgressIndicator(),
                )
              : const SizedBox(),
        ),
      ],
    );
  }
}
