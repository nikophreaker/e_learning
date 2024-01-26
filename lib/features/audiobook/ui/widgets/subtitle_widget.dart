import 'package:e_learning/features/audiobook/bloc/audio_details/audio_details_bloc.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SubtitleWidget extends StatelessWidget {
  const SubtitleWidget({super.key, required this.data});
  final AudioDetailsSuccessFetch data;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0, left: 16.0),
              child: Container(
                height: 20,
                padding:
                    const EdgeInsets.symmetric(vertical: 1.0, horizontal: 10.0),
                decoration: BoxDecoration(
                  color: const Color(0xff222326),
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "asset/image/tag.png",
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 2.0),
                      child: DefaultTextStyle(
                        style: TextStyle(
                          fontFamily: 'HindGuntur',
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                        child: Text("Soft SKill"),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Visibility(
              visible: data.audioDetails?.isPremium == "yes" ? true : false,
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 8.0),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      vertical: 1.0, horizontal: 10.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    border: Border.all(
                      color: const Color(0xffFFE485),
                    ),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const DefaultTextStyle(
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                      color: Color(0xffFFE485),
                    ),
                    child: Text("Premium"),
                  ),
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0, top: 10.0, right: 16.0),
          child: DefaultTextStyle(
            style: const TextStyle(
              fontFamily: 'HindGuntur',
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
            child: Text(
              "${DateFormat('MMMd', 'en_US').format(DateTime.parse(data.audioDetails!.createdAt.toString())).toString()} • ${data.audioDetails?.time} • min read • in ${data.audioDetails?.languange}",
            ),
          ),
        ),
      ],
    );
  }
}
