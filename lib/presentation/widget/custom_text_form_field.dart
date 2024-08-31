import 'package:flutter/material.dart';
import 'package:speech_to_text_toggle_example/presentation/widget/speech_mode.dart';

class CustomTextFormField extends StatefulWidget {
  final void Function(String) onSend;
  final FocusNode focusNode;

  const CustomTextFormField(
      {super.key, required this.onSend, required this.focusNode});

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool _canSend = false;
  bool _showNewWidget = false;
  double _opacity = 0.0;

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
      widget.onSend(_controller.text);
      _controller.clear();
      setState(() {
        _canSend = false;
      });
    }
  }

  void _onMicButtonPressed() {
    FocusScope.of(context).unfocus(); // 키보드 비활성화

    setState(() {
      _showNewWidget = true;
    });

    Future.delayed(const Duration(milliseconds: 12), () {
      setState(() {
        _opacity = 1.0; // 애니메이션을 위해 opacity 설정
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (_showNewWidget)
          AnimatedOpacity(
            opacity: _opacity,
            duration: const Duration(milliseconds: 500),
            child: AnimatedSlide(
              offset: _opacity == 1.0 ? Offset.zero : const Offset(0, 1),
              duration: const Duration(milliseconds: 500),
              child: SpeechMode(
                onCircleButtonPressed: () {
                  setState(() {
                    _showNewWidget = false;
                    _opacity = 0.0;
                  });
                  widget.focusNode.requestFocus(); // 키보드 활성화
                },
              ),
            ),
          ),
        if (!_showNewWidget)
          Row(
            children: [
              GestureDetector(
                onTap: _onMicButtonPressed,
                child: Container(
                  width: 44,
                  height: 44,
                  decoration: const BoxDecoration(
                    color: Color(0xffEDEFFF),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.mic,
                    color: Color(0xFF3446EA),
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
                                focusNode: widget.focusNode,
                                controller: _controller,
                                cursorColor: const Color(0xFF3446EA),
                                style: const TextStyle(
                                  color: Color(0xFFA2A2B2),
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
                          color: _canSend
                              ? const Color(0xFF3446EA)
                              : const Color(0xFFA2A2B2),
                        ),
                        onPressed: _canSend ? _sendMessage : null,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
      ],
    );
  }
}
