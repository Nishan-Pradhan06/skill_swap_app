class SkillCardModel {
  final String userName;
  final String userProfileUrl;
  final String categoryTitle;
  final String skillTitle;
  final String skillDescription;
  final String point;
  final List<String> skillList;

  SkillCardModel({
    required this.userName,
    required this.userProfileUrl,
    required this.categoryTitle,
    required this.skillTitle,
    required this.skillDescription,
    required this.skillList,
    required this.point,
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
      point: json['point'],
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
      'point': point,
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
    point: '30',
  ),
  SkillCardModel(
    userName: 'Roronoa Zoro',
    userProfileUrl:
        'https://static.wikia.nocookie.net/glad-you-came/images/a/a2/Zoro.png/revision/latest?cb=20230710081928',
    categoryTitle: 'Fitness & Wellness',
    skillTitle: 'Martial Arts, Swordsmanship, Discipline',
    skillDescription:
        'I have trained in swordsmanship and physical fitness for several years, focusing on discipline and endurance. I can teach self-defense techniques and structured workout routines.',
    skillList: ['Fitness', 'Discipline', 'Focus', 'Training', 'Health'],
    point: '40',
  ),
  SkillCardModel(
    userName: 'Nami',
    userProfileUrl:
        'https://static.wikia.nocookie.net/onepiece-fairytail/images/d/dd/Nami.png/revision/latest?cb=20160806203305',
    categoryTitle: 'Business & Finance',
    skillTitle: 'Budgeting, Trading, Map Design',
    skillDescription:
        'I have experience managing trade routes and finances. I can help with financial planning, map visualization, and digital navigation systems.',
    point: '20',
    skillList: ['Finance', 'Trading', 'Planning', 'Navigation', 'Management'],
  ),
  SkillCardModel(
    userName: 'Sanji',
    userProfileUrl:
        'https://imgs.search.brave.com/HrBitYrFQjQ33Pt6ks2Nby_BNR8F_Y1GGB4zmKtmdl8/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9hdmF0/YXJmaWxlcy5hbHBo/YWNvZGVycy5jb20v/MzI4L3RodW1iLTM1/MC0zMjg2ODgud2Vi/cA',
    categoryTitle: 'Culinary Arts',
    skillTitle: 'Cooking, Nutrition, Food Presentation',
    skillDescription:
        'With years of experience as a chef, I specialize in creating healthy, visually appealing dishes. I can teach cooking basics, recipe design, and plating techniques.',
    point: '15',
    skillList: ['Cooking', 'Nutrition', 'Presentation', 'Creativity', 'Health'],
  ),
  SkillCardModel(
    userName: 'Tony Tony Chopper',
    userProfileUrl:
        'https://imgs.search.brave.com/tc1WjJzzOLPd02_DQPlGqYHRme7vFMshMI3nl9Po5zI/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9wcmV2/aWV3LnJlZGQuaXQv/b25lLXBpZWNlLXNl/YXNvbi0yLWNob3Bw/ZXItZmlyc3QtbG9v/ay1uZXRmbGl4LXYw/LWIzZjZzNG13NTg0/ZjEuanBlZz93aWR0/aD03ODMmYXV0bz13/ZWJwJnM9Y2QyMTNm/ZWYxOWE4NmY0MTdh/ODE2N2QzNGNjYzUz/NWQ1NGRhMGY0Ng',
    categoryTitle: 'Health & Medicine',
    skillTitle: 'First Aid, Anatomy, Caregiving',
    skillDescription:
        'I have studied human and animal medicine and can provide guidance on first aid, wellness routines, and understanding the basics of anatomy and care.',
    point: '50',
    skillList: ['Medicine', 'First Aid', 'Wellness', 'Anatomy', 'Biology'],
  ),
  SkillCardModel(
    userName: 'Nico Robin',
    userProfileUrl:
        'https://imgs.search.brave.com/a8ALFS_xf8CWJ_xO9L83McRkoGf22jtx4Wl3vHPCjbI/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9wcmV2/aWV3LnJlZGQuaXQv/bmljby1yb2Jpbi1p/cy10aGUtbW9zdC1i/ZWF1dGlmdWwtZ2ly/bC1pbi1vbmUtcGll/Y2UtcHJvdmUtbWUt/djAtZGVraGN0bXIy/aDBmMS5qcGVnP3dp/ZHRoPTczNiZhdXRv/PXdlYnAmcz0zNmEy/NWRlODkzZWY2OTU1/ZDllNjNkNTBlMDMw/NGViNWQzZjNkYzdl',
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
    point: '20',
  ),
  SkillCardModel(
    userName: 'Franky',
    userProfileUrl:
        'https://imgs.search.brave.com/w-CXV1nMvD9LrOR7z00whMqCVfio-a0uzUDzU1FryD0/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9wcmV2/aWV3LnJlZGQuaXQv/YW55Ym9keS1lbHNl/LXRoaW5rcy1wb3N0/LXRpbWVza2lwLWZy/YW5reS1pcy1hLWJp/dC10b28tdjAtdmYy/emt6N2ZldmFlMS5w/bmc_d2lkdGg9MTA4/MCZhdXRvPXdlYnAm/cz0xNGZhZDk3ZGY2/MmE2NWY1ZWVjMTQx/M2IxOTIyMDRjNWNk/ODhiN2Mx',
    categoryTitle: 'Engineering & Robotics',
    skillTitle: 'Mechanical Design, Robotics, Innovation',
    skillDescription:
        'I build and modify mechanical systems and robots. I can teach basic mechanical engineering concepts, innovation, and creative construction.',
    point: '44',
    skillList: ['Engineering', 'Robotics', 'Innovation', 'Design', 'Mechanics'],
  ),
  SkillCardModel(
    userName: 'Usopp',
    userProfileUrl:
        'https://imgs.search.brave.com/c4CtTS7Jv1h2SBiG58kRdCNCehcsHLvwp_Ue2EZpsGI/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9zdGF0/aWNnLnNwb3J0c2tl/ZWRhLmNvbS9lZGl0/b3IvMjAyNS8wMy9j/NTgwZS0xNzQzNDEx/MjIyNDYzMy5wbmc',
    categoryTitle: 'Arts & Crafts',
    skillTitle: 'Painting, Storytelling, Creativity',
    skillDescription:
        'As a creative artist and storyteller, I enjoy painting, model crafting, and narrating stories. I can help others express creativity through art.',
    point: '45',
    skillList: ['Art', 'Storytelling', 'Creativity', 'Model Making', 'Design'],
  ),
  SkillCardModel(
    userName: 'Brook',
    userProfileUrl:
        'https://imgs.search.brave.com/W6ZCgk8xHnHokZp5WZ43Goh-ilxLtxmy5HzZSimbeb8/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9pLnBp/bmltZy5jb20vb3Jp/Z2luYWxzL2Y1LzAx/L2QxL2Y1MDFkMTYy/ZGEzYmM0NzY1N2Nl/YmU1ZmQ1ZTZjMDVi/LmpwZw',
    categoryTitle: 'Music & Performance',
    skillTitle: 'Music, Singing, Stage Performance',
    skillDescription:
        'I am passionate about music and live performance. I can guide others on stage presence, singing techniques, and musical composition.',
    point: '60',
    skillList: ['Music', 'Singing', 'Performance', 'Creativity', 'Confidence'],
  ),
  SkillCardModel(
    userName: 'Jinbe',
    userProfileUrl:
        'https://imgs.search.brave.com/3_K7-hg0xZw0fWA_dR8jKgZJDZpjbi2SGu5MXn1sK28/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9wcmV2/aWV3LnJlZGQuaXQv/amltYmUtYXBwcmVj/aWF0aW9uLXBvc3Qt/djAtNG04ZTE0dHJy/MnpkMS5qcGVnP3dp/ZHRoPTEzNDkmYXV0/bz13ZWJwJnM9MmQ0/ZDZhYTZiMTI3MWRj/MGI1MTM3OTI1ODlm/ZTg4Zjg5YTZlNzg2/OA',
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
    point: '50',
  ),
];
