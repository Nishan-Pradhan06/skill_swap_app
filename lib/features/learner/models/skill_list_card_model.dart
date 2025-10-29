class SkillCardModel {
  final String userName;
  final String userProfileUrl;
  final String categoryTitle;
  final String skillTitle;
  final String skillDescription;
  final List<String> skillList;

  SkillCardModel({
    required this.userName,
    required this.userProfileUrl,
    required this.categoryTitle,
    required this.skillTitle,
    required this.skillDescription,
    required this.skillList,
  });

  // Optional: for converting from JSON
  factory SkillCardModel.fromJson(Map<String, dynamic> json) {
    return SkillCardModel(
      userName: json['userName'],
      userProfileUrl: json['userProfileUrl'],
      categoryTitle: json['categoryTitle'],
      skillTitle: json['skillTitle'],
      skillDescription: json['skillDescription'],
      skillList: List<String>.from(json['skillList']),
    );
  }

  // Optional: for converting to JSON
  Map<String, dynamic> toJson() {
    return {
      'userName': userName,
      'userProfileUrl': userProfileUrl,
      'categoryTitle': categoryTitle,
      'skillTitle': skillTitle,
      'skillDescription': skillDescription,
      'skillList': skillList,
    };
  }
}


final List<SkillCardModel> skillCards = [
  SkillCardModel(
    userName: 'Monkey D. Luffy',
    userProfileUrl: 'https://miro.medium.com/0*j7sVnq-dE0XWdS12.jpeg',
    categoryTitle: 'Programming & Tech',
    skillTitle: 'Graphics Design, Digital Arts, Arts',
    skillDescription:
        'I have been learning and practicing Graphics Design, Digital Arts, and Arts for a year, gaining hands-on experience with design tools and creative techniques.',
    skillList: [
      'Programming & Tech',
      'Coding',
      'Flutter',
      'SOLID',
      'Mobile App Dev',
    ],
  ),
  SkillCardModel(
    userName: 'Roronoa Zoro',
    userProfileUrl:
        'https://i.pinimg.com/736x/18/2a/84/182a847c5bfb51df4b9f92c188b8c8f9.jpg',
    categoryTitle: 'Fitness & Wellness',
    skillTitle: 'Martial Arts, Swordsmanship, Discipline',
    skillDescription:
        'I have trained in swordsmanship and physical fitness for several years, focusing on discipline and endurance. I can teach self-defense techniques and structured workout routines.',
    skillList: ['Fitness', 'Discipline', 'Focus', 'Training', 'Health'],
  ),
  SkillCardModel(
    userName: 'Nami',
    userProfileUrl:
        'https://i.pinimg.com/736x/9e/7b/63/9e7b63b2e0f2e7a52b3a4e6d911c49b3.jpg',
    categoryTitle: 'Business & Finance',
    skillTitle: 'Budgeting, Trading, Map Design',
    skillDescription:
        'I have experience managing trade routes and finances. I can help with financial planning, map visualization, and digital navigation systems.',
    skillList: ['Finance', 'Trading', 'Planning', 'Navigation', 'Management'],
  ),
  SkillCardModel(
    userName: 'Sanji',
    userProfileUrl:
        'https://i.pinimg.com/736x/d7/52/84/d75284b29ed59b41a4e83d09c08cc7e7.jpg',
    categoryTitle: 'Culinary Arts',
    skillTitle: 'Cooking, Nutrition, Food Presentation',
    skillDescription:
        'With years of experience as a chef, I specialize in creating healthy, visually appealing dishes. I can teach cooking basics, recipe design, and plating techniques.',
    skillList: ['Cooking', 'Nutrition', 'Presentation', 'Creativity', 'Health'],
  ),
  SkillCardModel(
    userName: 'Tony Tony Chopper',
    userProfileUrl:
        'https://i.pinimg.com/736x/ab/20/da/ab20dafb2c9dbb1eb2291474d2365f0d.jpg',
    categoryTitle: 'Health & Medicine',
    skillTitle: 'First Aid, Anatomy, Caregiving',
    skillDescription:
        'I have studied human and animal medicine and can provide guidance on first aid, wellness routines, and understanding the basics of anatomy and care.',
    skillList: ['Medicine', 'First Aid', 'Wellness', 'Anatomy', 'Biology'],
  ),
  SkillCardModel(
    userName: 'Nico Robin',
    userProfileUrl:
        'https://i.pinimg.com/736x/a1/3e/0b/a13e0bfa24e6cc03a01c9b009db9e20a.jpg',
    categoryTitle: 'Education & Research',
    skillTitle: 'History, Archaeology, Research',
    skillDescription:
        'I have deep knowledge in archaeology and ancient history. I can help with research techniques, documentation, and historical analysis skills.',
    skillList: [
      'Research',
      'History',
      'Education',
      'Documentation',
      'Analysis',
    ],
  ),
  SkillCardModel(
    userName: 'Franky',
    userProfileUrl:
        'https://i.pinimg.com/736x/8e/21/6a/8e216ac0f7f0b29b11a97a86b8f99b39.jpg',
    categoryTitle: 'Engineering & Robotics',
    skillTitle: 'Mechanical Design, Robotics, Innovation',
    skillDescription:
        'I build and modify mechanical systems and robots. I can teach basic mechanical engineering concepts, innovation, and creative construction.',
    skillList: ['Engineering', 'Robotics', 'Innovation', 'Design', 'Mechanics'],
  ),
  SkillCardModel(
    userName: 'Usopp',
    userProfileUrl:
        'https://i.pinimg.com/736x/bd/df/d5/bddfd5b1b2f4ff4a3f8129ab907a5bdb.jpg',
    categoryTitle: 'Arts & Crafts',
    skillTitle: 'Painting, Storytelling, Creativity',
    skillDescription:
        'As a creative artist and storyteller, I enjoy painting, model crafting, and narrating stories. I can help others express creativity through art.',
    skillList: ['Art', 'Storytelling', 'Creativity', 'Model Making', 'Design'],
  ),
  SkillCardModel(
    userName: 'Brook',
    userProfileUrl:
        'https://i.pinimg.com/736x/22/f3/4c/22f34cb9a78df88a99b5b99128e50a73.jpg',
    categoryTitle: 'Music & Performance',
    skillTitle: 'Music, Singing, Stage Performance',
    skillDescription:
        'I am passionate about music and live performance. I can guide others on stage presence, singing techniques, and musical composition.',
    skillList: ['Music', 'Singing', 'Performance', 'Creativity', 'Confidence'],
  ),
  SkillCardModel(
    userName: 'Jinbe',
    userProfileUrl:
        'https://i.pinimg.com/736x/3a/83/35/3a8335b5869a6ddf07dd60cf380e5f58.jpg',
    categoryTitle: 'Leadership & Mentorship',
    skillTitle: 'Teamwork, Mentorship, Conflict Resolution',
    skillDescription:
        'I have experience in guiding teams with respect and discipline. I can help others develop leadership, communication, and mentoring skills.',
    skillList: [
      'Leadership',
      'Mentorship',
      'Communication',
      'Discipline',
      'Teamwork',
    ],
  ),
];
