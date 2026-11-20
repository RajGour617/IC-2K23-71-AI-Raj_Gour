# 📚 Intelligent Library Recommendation System

## Watch my project demonstration video on YouTube

[![Project demonstration video](https://img.youtube.com/vi/wMq6_TDvgxE/hqdefault.jpg)](https://www.youtube.com/watch?v=wMq6_TDvgxE)

https://www.youtube.com/watch?v=wMq6_TDvgxE

An AI-based library recommendation system developed using **GNU Prolog 1.5.0**. The project uses a knowledge base, logical rules, and a scoring mechanism to recommend books based on a student's interests, preferred subjects, reading level, and previously read books.

The system demonstrates how **Artificial Intelligence and Logic Programming** can be used to build a simple personalized recommendation engine.

## 🎯 Project Objectives

- Build an intelligent book recommendation system using Prolog.
- Maintain a knowledge base containing book information.
- Recommend books according to student preferences.
- Avoid recommending books that the student has already read.
- Rank recommendations using a scoring mechanism.
- Provide explanations for every recommendation.
- Suggest alternative reading levels when exact-level matches are unavailable.

## ✨ Features

- **Knowledge Base:** Stores information about books, including title, category, subject, and difficulty level.
- **Personalized Recommendations:** Uses student interests and preferred subjects to identify relevant books.
- **Reading-Level Matching:** Prioritizes books matching the student's reading level.
- **Book Exclusion:** Prevents recommendations of previously read books.
- **Duplicate Prevention:** Ensures that the same book is not recommended more than once.
- **Ranking System:** Assigns scores to books and displays the highest-scoring recommendations first.
- **Recommendation Explanations:** Explains why each book was recommended.
- **Alternative Recommendations:** Suggests other difficulty levels if no exact reading-level match is available.
- **Top 3 Recommendations:** Displays up to three recommended books.

## 🛠️ Technologies Used

| Technology | Purpose |
| --- | --- |
| GNU Prolog 1.5.0 | Logic programming and recommendation engine |
| Prolog | Knowledge representation and inference |
| VS Code | Code editing |
| Terminal / Command Prompt | Program execution |

## 📂 Project Structure

```text
Intelligent-Library-Recommendation-System/
│
├── library.pro          # Main Prolog source code
├── README.md            # Project documentation
└── LICENSE              # Project license (optional)
```

## 🧠 How the System Works

The recommendation system follows a rule-based approach.

### 1. Knowledge Base

The system stores book information using the following predicate:

```prolog
book(Name, Category, Subject, Difficulty).
```

Example:

```prolog
book(introduction_to_ai, technology,
     artificial_intelligence, intermediate).

book(python_basics, programming,
     python, beginner).

book(data_structures_in_java, programming,
     java, intermediate).
```

The knowledge base contains at least 10 books across different categories, subjects, and difficulty levels.

### 2. Student Preferences

The system accepts the following information:

- Three areas of interest.
- Three preferred subjects.
- Reading level: `beginner`, `intermediate`, or `advanced`.
- Previously read books.

### 3. Recommendation Rules

The system applies logical rules to identify suitable books.

| Matching Condition | Score |
| --- | ---: |
| Matches student interest | +3 |
| Matches preferred subject | +3 |
| Matches reading level | +2 |
| Maximum score | **8** |

Books that have already been read are excluded.

### 4. Ranking and Selection

The system:

1. Finds books matching the student's preferences.
2. Excludes previously read books.
3. Calculates recommendation scores.
4. Removes duplicate recommendations.
5. Sorts books by score in descending order.
6. Displays up to three recommendations.

### 5. Alternative Recommendations

If no books match the student's exact reading level, the system searches for other suitable books at different difficulty levels.

If no eligible books are found, it displays an appropriate no-recommendations message.

### Step 5: Load the Program

```prolog
| ?- consult('library.pro').
```

### Step 6: Execute the Program

```prolog
| ?- main.
```

Follow the prompts and enter your preferences.

**Note:** GNU Prolog uses `read/1`, so enter Prolog atoms with a terminating period.

Example:

```prolog
artificial_intelligence.
java.
programming.
```

For no previously read books, enter:

```prolog
none.
```

## ▶️ Sample Execution

The following is an illustrative example of program execution.

**Input:**

```text
Enter your interests:
programming.
java.
technology.

Enter your preferred subjects:
java.
python.
artificial_intelligence.

Enter your reading level:
intermediate.

Enter already read books:
none.
```

**Output:**

```text
========================================
     INTELLIGENT LIBRARY RECOMMENDATION
========================================

Top recommended books:

1. data_structures_in_java
   Score: 8
   Category: programming
   Subject: java
   Difficulty: intermediate
   Reason: Matches your interest and preferred subject
           and reading level

2. machine_learning_fundamentals
   Score: 8
   Category: technology
   Subject: artificial_intelligence
   Difficulty: intermediate

3. database_management
   Score: 5
   Category: technology
   Subject: database
   Difficulty: intermediate

========================================
```

*Actual recommendations depend on the knowledge base and the preferences entered by the student.*

## 🧪 Testing Scenarios

The project can be tested using the following scenarios:

| Test Case | Input Condition | Expected Result |
| --- | --- | --- |
| Test 1 | Matching interests, subjects, and reading level | Highest-scoring books recommended |
| Test 2 | Previously read books provided | Read books excluded |
| Test 3 | No exact reading-level match | Alternative difficulty-level books suggested |
| Test 4 | No matching interests or subjects | No-recommendations message |
| Test 5 | Book matches multiple preferences | Book appears only once |

## 📖 Important Prolog Concepts Used

This project demonstrates the following concepts:

- **Facts:** Store book information in the knowledge base.
- **Rules:** Define conditions for recommending books.
- **Predicates:** Represent relationships and operations.
- **Unification:** Matches variables with facts.
- **Backtracking:** Searches for alternative matching books.
- **Recursion:** Processes recommendation lists.
- **`findall/3`:** Collects all matching recommendations.
- **`keysort/2`:** Sorts recommendations based on their scores.
- **Negation (`\\+`):** Excludes previously read books.
- **List Processing:** Manages interests, subjects, and recommendations.

## 🚀 Future Enhancements

- Add a larger book database.
- Integrate a graphical user interface.
- Store student profiles and reading history.
- Introduce machine-learning-based recommendations.
- Recommend books based on popularity and ratings.
- Connect the system to an online library database.
- Add more advanced recommendation algorithms.

## 🎓 Learning Outcomes

Through this project, we learned how to:

1. Represent real-world information using Prolog facts.
2. Develop intelligent systems using logical rules.
3. Apply inference and backtracking.
4. Implement a scoring-based recommendation mechanism.
5. Work with lists and recursion in Prolog.
6. Design a rule-based personalized recommendation system.

## 👨‍💻 Author

**Raj Gour**\
**Roll No: IC-2K23-71**

MCA Student  
International Institute of Professional Studies (IIPS)  
Devi Ahilya Vishwavidyalaya (DAVV), Indore

## 📜 License

This project is intended for academic and educational purposes. You may use and modify it for learning and experimentation.

---

⭐ If you find this project useful, consider giving this repository a star!
