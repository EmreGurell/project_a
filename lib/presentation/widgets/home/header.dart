import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_a/common/bloc/user/user_bloc.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        final displayName = state is UserLoaded
            ? state.user.displayName
            : '...';

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  child: CircleAvatar(
                    radius: 24,
                    backgroundColor: Colors.grey.withValues(alpha: 0.1),
                    backgroundImage: const AssetImage('assets/images/csa.png'),
                  ),
                ),
                SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Merhaba',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      displayName,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                Spacer(),
                GestureDetector(
                  child: Badge.count(
                    count: 3,
                    child: Icon(
                      Icons.notifications_outlined,
                      size: 28,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
