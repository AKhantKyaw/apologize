import 'dart:math';
import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const ApologyApp());
}

class ApologyApp extends StatelessWidget {
  const ApologyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final baseTheme = ThemeData.light();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'I’m Truly Sorry',
      theme: baseTheme.copyWith(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFFFF6F8),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFE9AFC1),
          brightness: Brightness.light,
        ),
        textTheme: GoogleFonts.sourceSans3TextTheme(
          baseTheme.textTheme,
        ).apply(bodyColor: const Color(0xFF5A3B44)),
      ),
      home: const ApologyHomePage(),
    );
  }
}

class ApologyHomePage extends StatefulWidget {
  const ApologyHomePage({super.key});

  @override
  State<ApologyHomePage> createState() => _ApologyHomePageState();
}

class _ApologyHomePageState extends State<ApologyHomePage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _entranceController;
  bool _musicOn = false;

  @override
  void initState() {
    super.initState();
    _entranceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1700),
    )..forward();
  }

  @override
  void dispose() {
    _entranceController.dispose();
    super.dispose();
  }

  void _toggleMusic() {
    setState(() {
      _musicOn = !_musicOn;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScrollConfiguration(
        behavior: const SmoothScrollBehavior(),
        child: Stack(
          children: [
            const Positioned.fill(child: RomanticBackground()),
            const FloatingHeartsLayer(),
            SafeArea(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    LayoutBuilder(
                      builder: (context, constraints) {
                        final isWide = constraints.maxWidth > 900;
                        return HeroSection(
                          isWide: isWide,
                          controller: _entranceController,
                        );
                      },
                    ),
                    Section(
                      controller: _entranceController,
                      intervalStart: 0.22,
                      intervalEnd: 0.46,
                      title: 'Apology Message',
                      child: const ApologyLetter(),
                    ),
                    Section(
                      controller: _entranceController,
                      intervalStart: 0.38,
                      intervalEnd: 0.62,
                      title: 'Memories That Still Feel Close',
                      child: const MemoriesSection(),
                    ),
                    Section(
                      controller: _entranceController,
                      intervalStart: 0.48,
                      intervalEnd: 0.72,
                      title: 'A Photo I Still Treasure',
                      child: const PhotoRevealSection(),
                    ),
                    Section(
                      controller: _entranceController,
                      intervalStart: 0.52,
                      intervalEnd: 0.76,
                      title: 'Why I’m Sorry',
                      child: const WhySorrySection(),
                    ),
                    Section(
                      controller: _entranceController,
                      intervalStart: 0.66,
                      intervalEnd: 0.9,
                      title: 'Final Message',
                      child: const FinalMessageSection(),
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 20,
              right: 20,
              child: MusicToggle(isOn: _musicOn, onTap: _toggleMusic),
            ),
          ],
        ),
      ),
    );
  }
}

class SmoothScrollBehavior extends MaterialScrollBehavior {
  const SmoothScrollBehavior();

  @override
  Set<PointerDeviceKind> get dragDevices => {
    PointerDeviceKind.touch,
    PointerDeviceKind.mouse,
    PointerDeviceKind.trackpad,
    PointerDeviceKind.stylus,
  };
}

class RomanticBackground extends StatelessWidget {
  const RomanticBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFFFFF5F7),
            const Color(0xFFFCE9EE).withOpacity(0.9),
            const Color(0xFFF8EFE8),
          ],
        ),
      ),
      child: Stack(
        children: const [
          SoftGlow(
            alignment: Alignment(-0.85, -0.6),
            size: 280,
            color: Color(0xFFF6CAD7),
          ),
          SoftGlow(
            alignment: Alignment(0.9, -0.4),
            size: 260,
            color: Color(0xFFF1D9C8),
          ),
          SoftGlow(
            alignment: Alignment(0.0, 0.8),
            size: 320,
            color: Color(0xFFF9DDE5),
          ),
        ],
      ),
    );
  }
}

class SoftGlow extends StatelessWidget {
  const SoftGlow({
    super.key,
    required this.alignment,
    required this.size,
    required this.color,
  });

  final Alignment alignment;
  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(
            colors: [color.withOpacity(0.65), color.withOpacity(0.0)],
          ),
        ),
      ),
    );
  }
}

class FloatingHeartsLayer extends StatelessWidget {
  const FloatingHeartsLayer({super.key});

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Stack(
        children: const [
          Positioned(
            top: 90,
            left: 30,
            child: FloatingIcon(
              icon: Icons.favorite,
              size: 20,
              color: Color(0xFFF1A9BC),
              amplitude: 10,
            ),
          ),
          Positioned(
            top: 180,
            right: 60,
            child: FloatingIcon(
              icon: Icons.favorite_border,
              size: 26,
              color: Color(0xFFE4A4B6),
              amplitude: 12,
              delay: 300,
            ),
          ),
          Positioned(
            top: 380,
            left: 90,
            child: FloatingIcon(
              icon: Icons.auto_awesome,
              size: 22,
              color: Color(0xFFF3C9D5),
              amplitude: 8,
              delay: 600,
            ),
          ),
          Positioned(
            bottom: 140,
            right: 80,
            child: FloatingIcon(
              icon: Icons.favorite,
              size: 18,
              color: Color(0xFFEFC2D0),
              amplitude: 10,
              delay: 500,
            ),
          ),
        ],
      ),
    );
  }
}

class FloatingIcon extends StatefulWidget {
  const FloatingIcon({
    super.key,
    required this.icon,
    required this.size,
    required this.color,
    required this.amplitude,
    this.delay = 0,
  });

  final IconData icon;
  final double size;
  final Color color;
  final double amplitude;
  final int delay;

  @override
  State<FloatingIcon> createState() => _FloatingIconState();
}

class _FloatingIconState extends State<FloatingIcon>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3200),
    );
    Future.delayed(Duration(milliseconds: widget.delay), () {
      if (mounted) {
        _controller.repeat(reverse: true);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final offset = sin(_controller.value * pi) * widget.amplitude;
        return Transform.translate(offset: Offset(0, offset), child: child);
      },
      child: Icon(widget.icon, size: widget.size, color: widget.color),
    );
  }
}

class HeroSection extends StatelessWidget {
  const HeroSection({
    super.key,
    required this.isWide,
    required this.controller,
  });

  final bool isWide;
  final AnimationController controller;

  @override
  Widget build(BuildContext context) {
    final titleStyle = GoogleFonts.playfairDisplay(
      fontSize: isWide ? 56 : 42,
      fontWeight: FontWeight.w600,
      color: const Color(0xFF5A3B44),
    );
    final subtitleStyle = GoogleFonts.sourceSans3(
      fontSize: isWide ? 20 : 18,
      height: 1.6,
      color: const Color(0xFF6D4A55),
    );

    return SizedBox(
      height: isWide ? 600 : 680,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 980),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: isWide ? 80 : 24,
              vertical: isWide ? 40 : 24,
            ),
            child: FadeSlide(
              controller: controller,
              intervalStart: 0.0,
              intervalEnd: 0.35,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: isWide
                    ? CrossAxisAlignment.start
                    : CrossAxisAlignment.center,
                children: [
                  Text('I’m Truly Sorry', style: titleStyle),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: isWide ? 520 : double.infinity,
                    child: Text(
                      'I’m writing this with care, honesty, and a lot of respect for you. '
                      'I regret the ways I fell short, and I want you to know that I still '
                      'hold you and our memories close.',
                      style: subtitleStyle,
                      textAlign: isWide ? TextAlign.left : TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 18),
                  SizedBox(
                    width: isWide ? 520 : double.infinity,
                    child: TypewriterText(
                      text:
                          'I never wanted to hurt you, and I’m learning from every part of it.',
                      style: subtitleStyle.copyWith(
                        fontStyle: FontStyle.italic,
                        color: const Color(0xFF8A5C69),
                      ),
                      textAlign: isWide ? TextAlign.left : TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 28),
                  Wrap(
                    spacing: 16,
                    runSpacing: 12,
                    alignment: isWide
                        ? WrapAlignment.start
                        : WrapAlignment.center,
                    children: const [
                      SoftBadge(text: 'Sincere'),
                      SoftBadge(text: 'Respectful'),
                      SoftBadge(text: 'From the Heart'),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SoftBadge extends StatelessWidget {
  const SoftBadge({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.7),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withOpacity(0.7)),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFE5B7C6).withOpacity(0.25),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Text(
        text,
        style: GoogleFonts.sourceSans3(
          fontSize: 14,
          letterSpacing: 0.3,
          color: const Color(0xFF8A5C69),
        ),
      ),
    );
  }
}

class Section extends StatelessWidget {
  const Section({
    super.key,
    required this.title,
    required this.child,
    required this.controller,
    required this.intervalStart,
    required this.intervalEnd,
  });

  final String title;
  final Widget child;
  final AnimationController controller;
  final double intervalStart;
  final double intervalEnd;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth > 900;
        return Padding(
          padding: EdgeInsets.symmetric(
            horizontal: isWide ? 80 : 24,
            vertical: 28,
          ),
          child: FadeSlide(
            controller: controller,
            intervalStart: intervalStart,
            intervalEnd: intervalEnd,
            child: Column(
              crossAxisAlignment: isWide
                  ? CrossAxisAlignment.start
                  : CrossAxisAlignment.center,
              children: [
                Text(
                  title,
                  textAlign: isWide ? TextAlign.left : TextAlign.center,
                  style: GoogleFonts.playfairDisplay(
                    fontSize: isWide ? 32 : 26,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF5A3B44),
                  ),
                ),
                const SizedBox(height: 18),
                SizedBox(width: double.infinity, child: child),
              ],
            ),
          ),
        );
      },
    );
  }
}

class ApologyLetter extends StatelessWidget {
  const ApologyLetter({super.key});

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      child: Text(
        'စိတ်ရင်းနဲ့ တောင်းပန်ပါတယ်။ အမ ကိုနာကျင်စေခဲ့တဲ့အတွက် တကယ်စိတ်အရင်းနဲ့ကို တောင်းပန်တာပါ။အစကတော့ ဒေါသတွေ မာန တွေနဲ့ အမြဲတမ်းကျနော်လည်းမှန်တယ်ထင်ခဲ့မိတာပါ "\n'
        'သေချာ ခေါင်းအေးအေးစဥ်းစားမိတော့ ကျနော်မှားခဲ့တာတွေကြောင့်သာ အမလည်း နာကျင်ရတာပါ. အစကနေပြန်ကြည့်ရင် အမအနားကိုရောက်လာတာက အခုလိုဖြစ်လာမယ်ဆိုပြီိးလည်း မမျှော်လင့်ခဲ့ပါဘူး"\n\n'
        "အမ အပေါ်မှာ အမရဲ့ ဂုဏ်သိက္ခာ ကိုရော ချစ်ခြင်းမေတ္တာ တွေကိုရော စော်ကားလိုစိတ်တစ်ကယ်မရှီခဲ့ပါဘူး" "ချစ်ပေးခဲ့တာတွေအတွက်လည်း အမြဲတမ်းကျေးဇူးတင်နေမိမှာပါ"
        "\n"
        "တစ်ကယ်တော့ ကျနော်လည်းအကြိမ်ကြိမ်သည်းခံဖို့ ကြိုးစားခဲ့ပါတယ် ဒါပေမဲ့ ခဏတာ ဖြစ်သွားတဲ့ ဒေါသ တွေကို မထိန်းနိုင်ပဲ နောက်ဆုံးအကြိမ်မှာ"
        "တော်တော် လူမဆန်တာတွေလည်းပြောမိခဲ့တယ် ကိုယ့်ကိုကိုယ် ရှက်တာလည်းပါမိပါတယ်\n အခုတော့တစ်ကယ် ဘာမှမတွေးပဲ ကိုယ့်ကြောင့်သာ ဆိုတာ တွေးလိုက်တော့ အမ အပေါ်မှာ တောင်းပန်ချင်တဲ့ စိတ်ဖြစ်လို့ ရေးခဲ့တာပါ"
        "အခုလို တောင်းပန်တာကလည်း အမဆီက ဘာခွင့်လွတ်မှု့ မှ လိုချင်တာ မဟုတ်ပဲ အမကို ယောက်ျားတစ်ယောက်မတန်ပဲ ရိုင်းစိုင်းမှု့တွေအတွက် ကျနော့်ဘက်က တောင်းပန်တာပါ \n"
        "စာတွေအပြန်အလှန်ရိုက်နေ ရရင် အမှားတွေပဲ ထပ်ပါမိဦးမယ်ထင်လို့ တစ်ယောက်ထဲ ပဲ တောင်းပန်ပါတယ်" 
        "\n" "ကျနော် ဒီပြသနာတွေဖြစ်နေစဥ်အတွင်း တစ်ကယ်လည်း ထူပူပြီး ကောင်းခဲ့တာတွေမစဥ်းစားပဲ စိတ်ရှုပ်စေပါတယ်ဆိုပြီး တွေးမိလို့ တွေ့ရတာ နောင်တရတယ်ဆိုပြီးလည်းပြောထွက်ခဲ့တယ်" "တစ်ကယ်တော့ နောင်တ မရပါဘူး အမှတ်ရနေမှာပါ" 
        "စစ်ဖြစ်ခဲ့တဲ့လူတွေတောင် မုန်းနိုင်ချင်မှ မုန်းနိုင်မှာလေ ကျနော်တို့က စစ်ဖြစ်ခဲ့တာမှ မဟုတ်တာပဲ အမအပေါ်မှာ စိတ်မလုံမိတာကလွဲရင် မမုန်းသွားပါဘူး" 
         "\n" "အဲ့လိုတောင်းပန်လိုက်တော့ ငါက အရင်အတိုင်းဖြစ်သွားရောလား အောင်ခန့်ကျော်ရလို့ တွေးမိရင် ဘယ်ဖြစ်တော့မလဲနော် သိပါတယ် ဒီကနေပဲ ကျနော်လည်းပြီးပြီးရောစကားတွေပြောမထွက်မိစေဖို့"
         "သင်ခန်းစာတွေရနေပါပြီ" "အခုလို တောင်းပန်မှု့တွေ အတွက် အမ ဆီက ဘာခွင့်လွတ်မှု့မှ မျှော်လင့်ပြီး တောင်းပန်တာလည်းမဟုတ်ပါဘူး" "အမဘက်ကတော့ အရင်အတိုင်း ဆက်ပြီး နာကျဥ်းနေပေးပါ"
         "ကျနော်ဘက်ကတော့ လူတစ်ယောက်က ဘယ်ချိန်ဘာဖြစ်မလဲ မသိတဲ့ ကာလကြီးမှာ"
         "ကျနော်မှားခဲ့တာတွေ တောင်းပန်ရရင်ကို ကျေနပ်ပါပြီး" 
         "အတူတူ ဆက်မရှီသွားနိုင်တာကလွဲရင် ကျနော်လည်း အမပေါ်မှာ ဘယ်အရာမှ ဟန်ဆောင်လုပ်ယူပြီး ချည်းမကပ်ခဲ့ပါဘူး  စိတ်ရင်းနဲ့ပါ" 
         "အများကြီးတောင်းပန်တယ်နော် ရိုင်းစိုင်းမိတာတွေ အတွက် 😥" "ထပ်ပြီးစဥ်းစားမိရင် ထပ်ဖြည့်ပြီးတောင်းပန်ပါ့မယ်",
        style: GoogleFonts.sourceSans3(
          fontSize: 17,
          height: 1.7,
          color: const Color(0xFF5A3B44),
        ),
      ),
    );
  }
}

class MemoriesSection extends StatelessWidget {
  const MemoriesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth > 900;
        final cardWidth = isWide ? (constraints.maxWidth - 40) / 3 : null;
        return Wrap(
          spacing: 20,
          runSpacing: 20,
          children: [
            SizedBox(
              width: cardWidth,
              child: MemoryCard(
                icon: Icons.wb_sunny,
                title: 'Soft mornings',
                description:
                    'The gentle routines we created together that made ordinary days feel warm.',
              ),
            ),
            SizedBox(
              width: cardWidth,
              child: MemoryCard(
                icon: Icons.chat_bubble_outline,
                title: 'Late-night talks',
                description:
                    'How we listened, shared dreams, and made each other feel understood.',
              ),
            ),
            SizedBox(
              width: cardWidth,
              child: MemoryCard(
                icon: Icons.auto_awesome,
                title: 'Small kindnesses',
                description:
                    'The quiet ways you showed love that still stay with me.',
              ),
            ),
          ],
        );
      },
    );
  }
}

class MemoryCard extends StatelessWidget {
  const MemoryCard({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
  });

  final IconData icon;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: const Color(0xFFB36A7C), size: 28),
          const SizedBox(height: 14),
          Text(
            title,
            style: GoogleFonts.playfairDisplay(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF5A3B44),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            description,
            style: GoogleFonts.sourceSans3(
              fontSize: 15,
              height: 1.6,
              color: const Color(0xFF6D4A55),
            ),
          ),
        ],
      ),
    );
  }
}

class PhotoRevealSection extends StatelessWidget {
  const PhotoRevealSection({super.key});

  void _openPhoto(BuildContext context) {
    showDialog<void>(
      context: context,
      barrierColor: Colors.black.withOpacity(0.35),
      builder: (context) {
        return const PhotoRevealDialog();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth > 700;
        final iconButton = HoverScale(
          child: InkWell(
            onTap: () => _openPhoto(context),
            borderRadius: BorderRadius.circular(30),
            child: Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: const Color(0xFFF5D3DC).withOpacity(0.7),
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white.withOpacity(0.8)),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFFE3A9B9).withOpacity(0.35),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: const Icon(
                Icons.heart_broken,
                color: Color(0xFFB36A7C),
                size: 26,
              ),
            ),
          ),
        );

        final textBlock = Column(
          crossAxisAlignment: isWide
              ? CrossAxisAlignment.start
              : CrossAxisAlignment.center,
          children: [
            Text(
              'A quiet memory that still means a lot to me.',
              textAlign: isWide ? TextAlign.left : TextAlign.center,
              style: GoogleFonts.sourceSans3(
                fontSize: 16,
                height: 1.6,
                color: const Color(0xFF6D4A55),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'If you tap the heart, a photo will open.',
              textAlign: isWide ? TextAlign.left : TextAlign.center,
              style: GoogleFonts.sourceSans3(
                fontSize: 14,
                color: const Color(0xFF8A5C69),
              ),
            ),
          ],
        );

        return GlassCard(
          child: isWide
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: textBlock),
                    const SizedBox(width: 16),
                    iconButton,
                  ],
                )
              : Column(
                  children: [textBlock, const SizedBox(height: 16), iconButton],
                ),
        );
      },
    );
  }
}

class PhotoRevealDialog extends StatefulWidget {
  const PhotoRevealDialog({super.key});

  @override
  State<PhotoRevealDialog> createState() => _PhotoRevealDialogState();
}

class _PhotoRevealDialogState extends State<PhotoRevealDialog> {
  bool _showGift = true;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        setState(() => _showGift = false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.all(24),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 30,
                    offset: const Offset(0, 16),
                  ),
                ],
              ),
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: 720,
                  maxHeight: 520,
                ),
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 600),
                  switchInCurve: Curves.easeOutCubic,
                  switchOutCurve: Curves.easeInCubic,
                  child: _showGift
                      ? Image.asset(
                          'assets/images/sad_duck.gif',
                          key: const ValueKey('gift'),
                          fit: BoxFit.contain,
                        )
                      : Image.asset(
                          'assets/images/IMG_9200.JPG',
                          key: const ValueKey('photo'),
                          width: double.infinity,
                          fit: BoxFit.contain,
                        ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 12,
            right: 12,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(18),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                child: IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Icons.close),
                  color: const Color(0xFF5A3B44),
                  style: IconButton.styleFrom(
                    backgroundColor: Colors.white.withOpacity(0.7),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 14,
            left: 20,
            child: AnimatedOpacity(
              opacity: _showGift ? 1 : 0,
              duration: const Duration(milliseconds: 400),
              child: Text(
                'A small gift before the memory.',
                style: GoogleFonts.sourceSans3(
                  fontSize: 14,
                  color: const Color(0xFF7B5560),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class WhySorrySection extends StatelessWidget {
  const WhySorrySection({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth > 900;
        final cardWidth = isWide ? (constraints.maxWidth - 20) / 2 : null;
        return Wrap(
          spacing: 20,
          runSpacing: 20,
          children: [
            SizedBox(
              width: cardWidth,
              child: ReasonCard(
                icon: Icons.favorite_border,
                title: 'I recognize my mistakes',
                description:
                    'I see the moments where I was inattentive or spoke without care.',
              ),
            ),
            SizedBox(
              width: cardWidth,
              child: ReasonCard(
                icon: Icons.spa,
                title: 'I’ve been reflecting',
                description:
                    'I’ve taken time to understand how my actions affected you.',
              ),
            ),
            SizedBox(
              width: cardWidth,
              child: ReasonCard(
                icon: Icons.auto_fix_high,
                title: 'My words are sincere',
                description:
                    'I’m not asking for anything, only offering truth and care.',
              ),
            ),
          ],
        );
      },
    );
  }
}

class ReasonCard extends StatelessWidget {
  const ReasonCard({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
  });

  final IconData icon;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: const Color(0xFFB36A7C), size: 26),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.playfairDisplay(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF5A3B44),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  description,
                  style: GoogleFonts.sourceSans3(
                    fontSize: 15,
                    height: 1.5,
                    color: const Color(0xFF6D4A55),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class FinalMessageSection extends StatelessWidget {
  const FinalMessageSection({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth > 900;
        return GlassCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'အရင်းနှီးဆုံးလူတွေ ကနေ သူစိမ်းတွေ ပြန်ဖြစ်သွားရင် သူစိမ်းထက်တောင် ပိုစိမ်းသွားတယ်တဲဲ့ အခုလည်းအဲ့လိုပါပဲ',
                style: GoogleFonts.sourceSans3(
                  fontSize: 17,
                  height: 1.7,
                  color: const Color(0xFF5A3B44),
                ),
              ),
              const SizedBox(height: 20),
              Align(
                alignment: isWide ? Alignment.centerLeft : Alignment.center,
                child: HoverScale(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFB97385),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 28,
                        vertical: 14,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      elevation: 8,
                      shadowColor: const Color(0xFFE4A4B6),
                    ),
                    child: Text(
                      'စိတ်ရင်းနဲ့တောင်းပန်ပါတယ်',
                      style: GoogleFonts.sourceSans3(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.3,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class GlassCard extends StatelessWidget {
  const GlassCard({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(28),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.6),
            borderRadius: BorderRadius.circular(28),
            border: Border.all(color: Colors.white.withOpacity(0.6)),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFFE6B8C5).withOpacity(0.25),
                blurRadius: 30,
                offset: const Offset(0, 16),
              ),
            ],
          ),
          padding: const EdgeInsets.all(24),
          child: child,
        ),
      ),
    );
  }
}

class MusicToggle extends StatelessWidget {
  const MusicToggle({super.key, required this.isOn, required this.onTap});

  final bool isOn;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(24),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                isOn ? Icons.music_note : Icons.music_off,
                size: 18,
                color: const Color(0xFFB36A7C),
              ),
              const SizedBox(width: 8),
              Text(
                isOn ? 'Music On' : 'Music Off',
                style: GoogleFonts.sourceSans3(
                  fontSize: 13,
                  color: const Color(0xFF6D4A55),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FadeSlide extends StatelessWidget {
  const FadeSlide({
    super.key,
    required this.child,
    required this.controller,
    required this.intervalStart,
    required this.intervalEnd,
  });

  final Widget child;
  final AnimationController controller;
  final double intervalStart;
  final double intervalEnd;

  @override
  Widget build(BuildContext context) {
    final animation = CurvedAnimation(
      parent: controller,
      curve: Interval(intervalStart, intervalEnd, curve: Curves.easeOutCubic),
    );

    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        final value = animation.value;
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, (1 - value) * 30),
            child: child,
          ),
        );
      },
      child: child,
    );
  }
}

class TypewriterText extends StatefulWidget {
  const TypewriterText({
    super.key,
    required this.text,
    required this.style,
    this.textAlign = TextAlign.left,
  });

  final String text;
  final TextStyle style;
  final TextAlign textAlign;

  @override
  State<TypewriterText> createState() => _TypewriterTextState();
}

class _TypewriterTextState extends State<TypewriterText>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<int> _typing;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 40 * widget.text.length),
    )..forward();
    _typing = IntTween(
      begin: 0,
      end: widget.text.length,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _typing,
      builder: (context, child) {
        final visible = widget.text.substring(0, _typing.value);
        return Text(visible, style: widget.style, textAlign: widget.textAlign);
      },
    );
  }
}

class HoverScale extends StatefulWidget {
  const HoverScale({super.key, required this.child});

  final Widget child;

  @override
  State<HoverScale> createState() => _HoverScaleState();
}

class _HoverScaleState extends State<HoverScale> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedScale(
        scale: _hovered ? 1.02 : 1.0,
        duration: const Duration(milliseconds: 180),
        child: widget.child,
      ),
    );
  }
}
