import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:template/api/user/dto/searchUsers/ReqSearchUsers.dart';
import 'package:template/common/enums/loading_status.enum.dart';
import 'package:template/common/enums/newfeeds.enum.dart';
import 'package:template/common/utils/list.utils.dart';
import 'package:template/common/widgets/custom_search_bar.dart';
import 'package:template/data/models/user/user.model.dart';
import 'package:template/pages/newfeeds/bloc/newfeeds.bloc.dart';
import 'package:template/pages/newfeeds/user_info.item.dart';
import 'package:template/root/app_routers.dart';

class Newfeeds extends StatefulWidget {
  final NewfeedsBloc newfeedsBloc;
  const Newfeeds({super.key, required this.newfeedsBloc});

  @override
  State<Newfeeds> createState() => _NewfeedsState();
}

class _NewfeedsState extends State<Newfeeds> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.newfeedsBloc.add(const Inititalize());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewfeedsBloc, NewfeedsState>(
      builder: (context, state) => Scaffold(
        appBar: AppBar(
          title: const Text('Newfeeds'),
        ),
        body: Column(
          children: [
            CustomSearchBar(
              hintText: 'Tìm kiếm bạn bè',
              onChanged: (value) {
                widget.newfeedsBloc.add(
                  SearchUsersEvent(
                    ReqSearchUsers(username: value),
                  ),
                );
                // Handle search logic here
              },
              onSearch: (value) {},
            ),
            const SizedBox(height: 5),
            Expanded(
              child: state.searchUsersStatus == LoadingStatus.loading
                  ? const Center(child: CircularProgressIndicator())
                  : state.searchUsersStatus == LoadingStatus.error
                      ? const Center(child: Text('Lỗi khi tìm kiếm người dùng'))
                      : state.users == null || state.users!.isEmpty
                          ? const Center(child: Text('Không có người dùng'))
                          : !ListUtils.isNullOrEmpty(state.users)
                              ? ListView.separated(
                                  itemBuilder: (context, index) => UserInfoItem(
                                    user: state.users![index],
                                    onTap: () {
                                      User user = state.users![index];
                                      widget.newfeedsBloc.add(
                                        ToProfileScreenEvent(
                                          user: user,
                                        ),
                                      );
                                    },
                                  ),
                                  separatorBuilder: (context, index) =>
                                      const SizedBox(height: 5),
                                  itemCount: state.users!.length,
                                )
                              : const Text('Không có người dùng'),
            ),
          ],
        ),
      ),
    );
  }
}

class NewfeedsScreen extends StatelessWidget {
  const NewfeedsScreen({super.key});
  @override
  Widget build(BuildContext context) => BlocProvider<NewfeedsBloc>(
        create: (_) => NewfeedsBloc(),
        child: BlocListener<NewfeedsBloc, NewfeedsState>(
          listener: _listener,
          child: Builder(
            builder: (BuildContext context) => Newfeeds(
              newfeedsBloc: context.read<NewfeedsBloc>(),
            ),
          ),
        ),
      );
}

void _listener(BuildContext context, NewfeedsState state) {
  switch (state.newfeedsStatus) {
    case ENewFeeds.init:
      // Handle initialization logic if needed
      break;
    case ENewFeeds.toProfileScreen:
      if (state.selectedUser != null) {
        int? userId = state.selectedUser?.id;
        Navigator.pushNamed(
          context,
          AppRouters.profile,
          arguments: <String, dynamic>{
            'userId': userId,
          },
        );
        context.read<NewfeedsBloc>().add(
              ChangeStatusEvent(newfeedsStatus: ENewFeeds.init),
            );
      }
      break;
    default:
      break;
  }
}
