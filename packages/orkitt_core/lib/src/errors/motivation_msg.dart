import 'dart:math';

/// Developer Motivation System
///
/// A curated collection of inspirational messages designed to support
/// developers during challenging moments in their coding journey.
///
/// These messages serve as reminders of the impact, creativity, and
/// perseverance inherent in software development. Use them to maintain
/// momentum, celebrate progress, and reinforce positive development practices.
///
/// Remember: Great software is built not just through technical skill,
/// but through consistent effort and a growth mindset.
class DeveloperMotivation {
  /// Curated collection of professional motivational messages for developers
  static final List<String> messages = [
    '🔹 Every line of code contributes to shaping digital experiences.',
    '🔹 Each resolved issue strengthens your problem-solving capabilities.',
    '🔹 Technical challenges are opportunities for professional growth.',
    '🔹 Quality code reflects thoughtful architecture and attention to detail.',
    '🔹 Error resolution demonstrates your debugging expertise and persistence.',
    '🔹 Collaborative knowledge sharing elevates the entire development community.',
    '🔹 Development environments vary—focus on reproducible, consistent results.',
    '🔹 Your technical solutions demonstrate creative engineering thinking.',
    '🔹 Every project expands your technical repertoire and expertise.',
    '🔹 Consistent iteration drives continuous improvement and innovation.',
    '🔹 Debugging transforms complex problems into elegant solutions.',
    '🔹 Adaptive code structures demonstrate practical problem-solving.',
    '🔹 Sustainable development practices yield long-term project success.',
    '🔹 Interface preferences reflect individual workflow optimization.',
    '🔹 Version control enables fearless experimentation and collaboration.',
    '🔹 Strategic breaks enhance cognitive performance and problem-solving.',
    '🔹 Effective development balances careful planning with focused execution.',
    '🔹 Code craftsmanship reflects professional standards and pride.',
    '🔹 Technical debt management ensures future development velocity.',
    '🔹 Human creativity remains the driving force behind technological innovation.',
    '🔹 Your contributions have meaningful impact—continue advancing forward.',
    '🔹 Problem-solving requires both analytical thinking and creative insight.',
  ];

  /// Returns a random motivational message to support developer momentum
  static String get randomMessage {
    final random = Random();
    return messages[random.nextInt(messages.length)];
  }

  /// Provides contextual motivation based on development phase
  static String getContextualMessage({
    required DevelopmentPhase phase,
    bool isChallenging = false,
  }) {
    if (isChallenging) {
      return _challengeMessages[Random().nextInt(_challengeMessages.length)];
    }

    return phaseMessages[phase]?[Random().nextInt(
          phaseMessages[phase]!.length,
        )] ??
        randomMessage;
  }

  /// Phase-specific motivational messages
  static final Map<DevelopmentPhase, List<String>> phaseMessages = {
    DevelopmentPhase.planning: [
      '🔹 Thorough planning lays the foundation for successful execution.',
      '🔹 Clear requirements prevent future development obstacles.',
      '🔹 Architectural decisions impact long-term maintainability.',
    ],
    DevelopmentPhase.coding: [
      '🔹 Clean code today enables faster development tomorrow.',
      '🔹 Consistent coding standards improve team collaboration.',
      '🔹 Each function written brings the vision closer to reality.',
    ],
    DevelopmentPhase.debugging: [
      '🔹 Systematic debugging transforms obstacles into learning opportunities.',
      '🔹 Every resolved issue strengthens your troubleshooting methodology.',
      '🔹 Patience in problem-solving yields robust, reliable solutions.',
    ],
    DevelopmentPhase.refactoring: [
      '🔹 Code refinement demonstrates commitment to quality.',
      '🔹 Improved architecture enhances future development velocity.',
      '🔹 Technical investment today pays dividends tomorrow.',
    ],
  };

  /// Messages for particularly challenging situations
  static final List<String> _challengeMessages = [
    '🔹 Complex problems develop the most valuable engineering skills.',
    '🔹 Persistence through difficulty builds exceptional expertise.',
    '🔹 The most challenging solutions often provide the greatest learning.',
    '🔹 Breakthroughs frequently follow periods of intense focus.',
  ];
}

/// Development phases for contextual motivation
enum DevelopmentPhase {
  planning,
  coding,
  debugging,
  refactoring,
  testing,
  deployment,
}

/// Usage Examples:
/// 
/// Basic random motivation:
/// ```dart
/// print(DeveloperMotivation.randomMessage);
/// ```
/// 
/// Contextual motivation:
/// ```dart
/// print(DeveloperMotivation.getContextualMessage(
///   phase: DevelopmentPhase.debugging,
///   isChallenging: true,
/// ));
/// ```