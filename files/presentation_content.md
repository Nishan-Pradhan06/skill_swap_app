# SkillSwap Project Defense Presentation Content

This document contains the slide-by-slide content for the SkillSwap project defense.

---

## Slide 1: Title Slide
**Main Title**: SkillSwap: A Peer-to-Peer Skill Sharing Platform
**Subtitle**: Bridging the Knowledge Gap through a Points-Based Mentorship Economy
**Team Members**: [Enter Names Here]
**Department**: Computer Science & Engineering
**Degree**: 6th Semester Project Defense

---

## Slide 2: Introduction & Motivation
**Heading**: Introduction
- **The Problem**: Access to high-quality, personalized mentorship is often expensive and geographically limited.
- **The Concept**: SkillSwap creates a decentralized community where knowledge is the primary currency.
- **Motivation**: To empower individuals to teach what they know and learn what they need without financial barriers.

---

## Slide 3: Problem Statement
**Heading**: Problem Statement
- **Fragmented Learning**: Learners struggle to find mentors for specific, niche skills.
- **High Entry Barriers**: Traditional platforms prioritize paid certifications over practical skill exchange.
- **Lack of Trust**: Difficulty in verifying the expertise of peer mentors.
- **Stale Content**: Static courses often fail to keep up with industry trends compared to live peer sessions.

---

## Slide 4: Project Objectives
**Heading**: Objectives
- **Platform Development**: Create a responsive mobile application using Flutter.
- **Points-Based Economy**: Implement a secure system for earning, holding, and trading points.
- **Scheduling Ecosystem**: Build a robust availability and booking system for live sessions.
- **Real-Time Interaction**: Ensure seamless communication through push notifications and meeting links.

---

## Slide 5: Literature Review & Gap Analysis
**Heading**: Literature Review
- **Udemy/Coursera**: High quality but lacks peer interaction and is often purely transactional.
- **LinkedIn Learning**: Corporate-focused; lacks a community-driven exchange model.
- **The Gap**: SkillSwap fills the gap by providing a **Peer-to-Peer (P2P)** exchange where users play dual roles (Learner and Mentor) within a social economy.

---

## Slide 6: System Architecture
**Heading**: System Architecture
- **Frontend**: Flutter (Mobile-first, Cross-platform).
- **Backend**: Django REST Framework (Scalable, Secure APIs).
- **Database**: MySQL (Reliable relational data storage).
- **Cloud Services**: Firebase (Authentication and Real-time Notifications).
- **Payment**: Khalti Integration for point top-ups.

---

## Slide 7: Database Design (ER Model)
**Heading**: Database Schema & ER Diagram
- **Core Entities**:
    - **User/Profile**: Handles identity, roles, and points balance.
    - **SkillSwapPost**: The central offer from a mentor.
    - **MentorAvailability**: Manages time slots tied to posts.
    - **Session**: Tracks the actual scheduled meeting and its status.
    - **SkillSwapRequest**: Manages the negotiation/swap phase.

---

## Slide 8: Key Feature - Points Economy
**Heading**: Points & Transaction Logic
- **Earning**: Daily Login Rewards (+10 pts), Signup Bonus (+100 pts), Teaching (+Cost pts).
- **Escrow System**: Points are moved to `held_points` during booking to ensure the mentor gets paid upon completion.
- **Verification**: Dual confirmation from both Learner and Mentor before final point release.

---

## Slide 9: Key Feature - Availability & Booking
**Heading**: Availability & Scheduling
- **Dynamic Filtering**: Learners see slots that are currently active or ending soon.
- **Real-Time Booking**: Preventing double-booking through atomic database transactions.
- **Slot Management**: Mentors can define multiple duration-based slots for a single post.

---

## Slide 10: Technical Implementation details
**Heading**: Implementation Highlights
- **State Management**: Using BLoC for business logic and Cubit for UI-local states.
- **Clean Architecture**: Repository pattern for data abstraction.
- **Automated Cleanup**: Django management commands to handle stale sessions (Auto-confirm/Auto-cancel).
- **Secure Storage**: JWT for API auth and Flutter Secure Storage for tokens.

---

## Slide 11: Testing & Results
**Heading**: Testing and Validation
- **Unit Testing**: Validating points logic and status transitions.
- **Integration Testing**: End-to-end flow from booking to point release.
- **User Interface**: Verified responsive designs across different device sizes.
- **Notifications**: Successfully verified Push Notifications via Firebase FCM.

---

## Slide 12: Conclusion & Future Work
**Heading**: Future Scope
- **AI Matching**: Implementing recommendation algorithms for skills.
- **Video Integration**: Built-in video conferencing instead of external links.
- **Community Features**: Groups, forums, and skill-based challenges.
- **Final Verdict**: SkillSwap successfully establishes a sustainable P2P learning ecosystem.
