import 'package:flutter/material.dart';

class CustomTextFormField extends StatefulWidget {
  final void Function(String) onSend;

  const CustomTextFormField({super.key, required this.onSend});

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool _canSend = false;
  static const Color mainBlue = Color(0xFF3446EA);
  static const Color mainGrey = Color(0xFFA2A2B2);
  static const Color blueGrey = Color(0xffEDEFFF);

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onTextChanged);
  }

  void _onTextChanged() {
    setState(() {
      _canSend = _controller.text.isNotEmpty;
    });
  }

  void _sendMessage() {
    if (_canSend) {
      widget.onSend(_controller.text); // 콜백을 통해 메시지 전달
      _controller.clear(); // 전송 후 입력창 비우기
      setState(() {
        _canSend = false; // 버튼 비활성화
      });
    }
  }

  void _onMicButtonPressed() {
    print('Mic button pressed');
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: _onMicButtonPressed,
          child: Container(
            width: 44,
            height: 44,
            decoration: const BoxDecoration(
              color: blueGrey,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.mic,
              color: mainBlue,
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            decoration: BoxDecoration(
              color: const Color(0xFFF6F6F9),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Scrollbar(
                    controller: _scrollController,
                    child: SingleChildScrollView(
                      controller: _scrollController,
                      scrollDirection: Axis.vertical,
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(
                          maxHeight: 100,
                        ),
                        child: TextField(
                          controller: _controller,
                          cursorColor: mainBlue,
                          style: const TextStyle(
                            color: mainGrey,
                          ),
                          maxLines: null,
                          decoration: const InputDecoration(
                            hintText: '메시지를 입력하세요',
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.send,
                    color: _canSend ? mainBlue : mainGrey,
                  ),
                  onPressed: _canSend ? _sendMessage : null,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
