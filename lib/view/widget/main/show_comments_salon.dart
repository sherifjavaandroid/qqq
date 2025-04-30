import 'package:easycut/core/constant/dimensions.dart';
import 'package:easycut/core/shared/widgets/big_text.dart';
import 'package:easycut/core/shared/widgets/small_text.dart';
import 'package:easycut/data/model/comment_model.dart';
import 'package:flutter/material.dart';

class ShowCommentsSalon extends StatelessWidget {
  final List<CommentModel> comments;
  const ShowCommentsSalon({
    super.key,
    required this.comments,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constr) {
        return SizedBox(
          height: constr.maxHeight,
          width: constr.maxWidth,
          child: GridView.builder(
            padding: EdgeInsets.symmetric(
              vertical: Dimensions.height20,
            ),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: Dimensions.height15,
              crossAxisSpacing: Dimensions.height15,
              childAspectRatio: 3 / 4,
            ),
            itemCount: comments.length,
            itemBuilder: (context, index) {
              return Card(
                child: Padding(
                  padding: EdgeInsets.all(Dimensions.height10),
                  child: Column(
                    children: [
                      Expanded(
                        child: SizedBox(
                          width: double.infinity,
                          child: Text(
                            comments[index].body!,
                            maxLines: 5,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: Dimensions.font16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      const Divider(),
                      Expanded(
                        child: SizedBox(
                          width: double.infinity,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: Dimensions.width5,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                BigText(
                                  text: comments[index].name!,
                                ),
                                SmallText(
                                  text: comments[index].email!,
                                  size: Dimensions.font16,
                                ),
                                SmallText(
                                  text: comments[index].phone!,
                                  size: Dimensions.font16,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
