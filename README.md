# ResumeRank – Intelligent Resume Screening System

> **Tagline:** Match the Right Resume with the Right Job.

---

## 📌 Problem Statement

Organizations often receive a large number of resumes for a single job opening. Manually comparing each resume with the corresponding Job Description (JD) is time-consuming, labor-intensive, and prone to human error. As the number of applications increases, recruiters may overlook qualified candidates or spend excessive time reviewing resumes that do not meet the required qualifications.

Additionally, many existing resume screening tools are costly, require internet connectivity, or depend on complex software frameworks, making them less accessible for small organizations and educational purposes. Therefore, there is a need for a simple, efficient, and reliable method to evaluate resumes against job requirements and assist recruiters in identifying the most relevant candidates in a shorter time.

**ResumeRank** solves this by providing a privacy-focused, offline-capable resume screening application that processes resumes and performs comparisons using **only the built-in features of the programming language**, without relying on external packages, libraries, or third-party APIs.

---

## 🛡️ Critical Rules & Constraints Compliance

ResumeRank strictly adheres to all mandatory project constraints:

- **Rule 1 – No External Packages:** Zero external packages used.
- **Rule 2 – No External Libraries:** No third-party NLP, parsing, text analysis, matching, scoring, or ranking libraries.
- **Rule 3 – No Third-Party APIs:** No OpenAI, Gemini, Claude, or external cloud APIs.
- **Rule 4 – Built-in Features Only:** All resume processing, skill extraction, matching, scoring, ranking, and rendering are implemented using standard ECMAScript / JavaScript built-in methods (`RegExp`, `String`, `Array`, `Math`, `Map`, `Set`, `FileReader`).
- **Rule 5 – Offline Processing:** Performs all analysis completely offline in local memory.
- **Rule 6 – Plain Text Format (.txt):** Handles resumes as plain `.txt` files.
- **Rule 7 – No Fake AI:** Presented as an intelligent, transparent rule-based screening and matching system.
- **Rule 8 – Complete Source Code:** Fully modular and suitable for GitHub upload.

---

## ✨ Key Features

1. **Job Description Input & Analysis:** Custom parser extracts Job Title, Required Skills, Preferred Skills, Education level, Experience requirements, and key terms.
2. **Resume Parsing Engine:** Custom rule-based extractor identifies candidate Name, Contact Info, Education level, Experience years, Skills set, and Project highlights.
3. **Custom Matching Engine:** Evaluates:
   - **Required Skills Match:** Matched vs missing skills count & ratio.
   - **Education Level Match:** Tier evaluation (Ph.D > Master > Bachelor > Diploma > High School).
   - **Experience Match:** Required years vs candidate years.
   - **Relevant Keywords:** Term frequency intersection between JD and Resume.
4. **Transparent Scoring System (0–100%):** Weighted formula:
   - **Required Skills:** `40%`
   - **Education:** `20%`
   - **Experience:** `20%`
   - **Relevant Keywords:** `20%`
5. **Candidate Ranking Engine:** Automatically ranks candidates from Rank 1 (highest matching score) downwards.
6. **Rule-Based Recommendations:**
   - `90–100%`: **Excellent Match**
   - `75–89%`: **Strong Match**
   - `60–74%`: **Moderate Match**
   - `40–59%`: **Weak Match**
   - `0–39%`: **Poor Match**
7. **Recruiter Dashboard & Visuals:** Summary cards (Total Resumes, Top Match %, Avg Score %, Qualified Count), progress bar score fills, and circular SVG gauges (no external chart libraries).
8. **Candidate Detail View Modal:** Complete breakdown of matched skills (`✓`), missing skills (`✗`), education/experience verification, and keyword pills.
9. **Candidate Side-by-Side Comparison:** Compares 2 candidates side-by-side with metric highlights and winner badge (🏆).
10. **Search, Filter & Sort:** Filter candidates by recommendation tier, search by name, and sort by highest/lowest score or candidate name.

---

## 🏗️ System Architecture & Workflow

```
START
  │
  ├─► Recruiter Dashboard
  │
  ├─► Create New Screening
  │     ├─► Enter Job Description Text
  │     └─► Add / Drop Resume Text Files (.txt)
  │
  ├─► Analyze Job Description (JobDescription.js)
  │
  ├─► Parse Resumes (ResumeParser.js)
  │
  ├─► Custom Resume vs JD Matching Engine (MatchingEngine.js)
  │
  ├─► Calculate Candidate Scores (ScoreCalculator.js - 40/20/20/20)
  │
  ├─► Candidate Ranking & Tier Assignment (RankingEngine.js & CandidateResult.js)
  │
  ├─► Display Dashboard & Ranking Table
  │
  └─► View Detailed Report & Candidate Comparison
```

---

## 📁 Directory Structure

```
ResumeRank/
├── index.html                # Semantic HTML5 User Interface
├── styles.css                # Glassmorphism Dark Mode Styling (Pure CSS3)
├── src/
│   ├── JobDescription.js     # JD Parser & Model
│   ├── Resume.js             # Candidate Resume Model
│   ├── ResumeParser.js       # Rule-Based Resume Parsing Engine
│   ├── MatchingEngine.js     # Resume vs JD Matching Engine
│   ├── ScoreCalculator.js    # Weighted Score Calculator (0-100)
│   ├── CandidateResult.js    # Result Formatter & Recommendation Tiers
│   ├── RankingEngine.js      # Sorting, Searching & Filtering Engine
│   └── Main.js               # UI Controller & State Manager
├── job/
│   └── job.txt               # Sample Job Description
├── resumes/
│   ├── resume1.txt           # Sample Resume 1 (Arun Kumar - Top Match)
│   ├── resume2.txt           # Sample Resume 2 (Priya S - Strong Match)
│   ├── resume3.txt           # Sample Resume 3 (Karthik R - Moderate Match)
│   ├── resume4.txt           # Sample Resume 4 (Divya M - Weak Match)
│   └── resume5.txt           # Sample Resume 5 (Suresh V - Poor Match)
├── demo/
│   └── demo_guide.md         # Demo Recording Guide
└── README.md                 # Documentation
```

---

## 🚀 How to Run the Project

No setup, installation, or server configuration is required!

1. **Option 1: Direct Open in Web Browser**
   - Double-click `index.html` or open it with any modern web browser (Edge, Chrome, Firefox, Safari).

2. **Option 2: Local Web Server (Optional)**
   - Run standard built-in python HTTP server in workspace root:
     ```bash
     python -m http.server 8000
     ```
   - Open `http://localhost:8000` in your web browser.

---

## 🎥 Demo Walkthrough Instructions

1. Open `index.html` in your browser.
2. Click **⚡ Load Sample Data** on the top dashboard.
3. Switch to **New Screening** tab to inspect the pre-filled Job Description and sample `.txt` resumes.
4. Click **🚀 Run Intelligent Screening Analysis**.
5. Observe candidate ranking in **Results & Ranking** tab (Rank 1: Arun Kumar at 94%, Rank 2: Priya S at 87%, etc.).
6. Click **View Details** on any candidate to inspect the breakdown modal (matched skills `✓`, missing skills `✗`, score breakdown).
7. Select checkboxes next to two candidates (e.g., Arun Kumar and Priya S) and click **Compare Candidates (2/2)** to open the side-by-side comparison view.
8. Test searching by name and filtering by match tier.
