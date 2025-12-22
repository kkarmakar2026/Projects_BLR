<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.quizportal.model.QuizResult" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%
    // Security Check
    if (session.getAttribute("USER_ID") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    
    // Get Data
    List<QuizResult> results = (List<QuizResult>) request.getAttribute("myResults");
    SimpleDateFormat sdf = new SimpleDateFormat("MMM dd, yyyy • hh:mm a");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>My Results - Quiz Portal</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    
    <style>
        body { background-color: #0d1b2a; color: white; font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; }
        
        /* Navbar */
        .custom-header { background: rgba(13, 27, 42, 0.95); border-bottom: 1px solid rgba(0, 212, 255, 0.1); padding: 0.8rem 2rem; position: sticky; top: 0; z-index: 1000; }
        .navbar-brand { color: white; font-weight: bold; text-decoration: none; display: flex; align-items: center; }
        
        /* Back Button */
        .back-btn { 
            color: #00d4ff; text-decoration: none; border: 1px solid rgba(0, 212, 255, 0.3); 
            padding: 5px 15px; border-radius: 20px; font-size: 0.9rem; transition: 0.3s; 
        }
        .back-btn:hover { background: #00d4ff; color: #0d1b2a; }

        /* Search Bar */
        .search-container { margin-bottom: 20px; position: relative; }
        .search-input {
            background-color: #1b263b; border: 1px solid rgba(255, 255, 255, 0.1);
            color: white; padding: 10px 40px 10px 15px; border-radius: 8px; width: 100%;
        }
        .search-input:focus { outline: none; border-color: #00d4ff; }
        .search-icon { position: absolute; right: 15px; top: 12px; color: #6c757d; }

        /* Result Card */
        .result-container { max-width: 900px; margin: 0 auto; }
        .result-card { background-color: #1b263b; border-radius: 15px; border: 1px solid rgba(0, 212, 255, 0.1); overflow: hidden; }
        
        /* Custom Dark Table */
        .table-custom { width: 100%; border-collapse: collapse; }
        .table-custom th { 
            text-align: left; padding: 15px; color: #00d4ff; text-transform: uppercase; 
            font-size: 0.85rem; border-bottom: 1px solid rgba(255,255,255,0.1); 
        }
        .table-custom td { padding: 15px; border-bottom: 1px solid rgba(255,255,255,0.05); color: #e0e1dd; vertical-align: middle; }
        .table-custom tr:last-child td { border-bottom: none; }
        
        /* Status Badges */
        .badge-pass { background: rgba(46, 204, 113, 0.2); color: #2ecc71; padding: 5px 12px; border-radius: 20px; font-size: 0.8rem; font-weight: bold; }
        .badge-fail { background: rgba(231, 76, 60, 0.2); color: #e74c3c; padding: 5px 12px; border-radius: 20px; font-size: 0.8rem; font-weight: bold; }
        
        /* Score Styling */
        .score-val { font-weight: 800; font-size: 1.2rem; color: #fff; } /* BOLD MARKS */
        .score-total { color: #6c757d; font-size: 0.9rem; }
        
        .no-results { display: none; text-align: center; padding: 20px; color: #6c757d; }
    </style>
</head>
<body>

<header class="custom-header d-flex justify-content-between align-items-center">
    <a href="${pageContext.request.contextPath}/" class="navbar-brand">
        <img src="${pageContext.request.contextPath}/assets/images/logo.png" style="height: 35px; margin-right: 10px;">
        QUIZ PORTAL
    </a>
    <a href="${pageContext.request.contextPath}/quizzes" class="back-btn">
        <i class="bi bi-arrow-left"></i> Back to Quizzes
    </a>
</header>

<div class="container py-5">
    <div class="result-container">
        
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2 class="fw-bold text-white mb-0">My Performance History</h2>
        </div>

        <div class="search-container">
            <input type="text" id="resultSearch" class="search-input" placeholder="Search by quiz name...">
            <i class="bi bi-search search-icon"></i>
        </div>

        <div class="result-card p-0">
            <% if (results == null || results.isEmpty()) { %>
                <div class="text-center py-5">
                    <i class="bi bi-clipboard-x" style="font-size: 3rem; color: #6c757d;"></i>
                    <h5 class="mt-3 text-secondary">No quizzes attempted yet.</h5>
                    <a href="${pageContext.request.contextPath}/quizzes" class="btn btn-sm btn-outline-info mt-2">Take a Quiz</a>
                </div>
            <% } else { %>
                <div class="table-responsive">
                    <table class="table-custom" id="resultsTable">
                        <thead>
                            <tr>
                                <th>Quiz Name</th>
                                <th>Date & Time</th>
                                <th>Score Obtained</th> <th>Percentage</th>     <th>Result</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% for (QuizResult r : results) { 
                                double pct = r.getPercentage();
                                boolean isPass = pct >= 40; 
                            %>
                            <tr class="result-row">
                                <td class="fw-bold text-white quiz-name-cell">
                                    <i class="bi bi-mortarboard-fill text-secondary me-2"></i>
                                    <%= r.getQuizName() %>
                                </td>
                                <td class="text-secondary small">
                                    <%= sdf.format(r.getAttemptTime()) %>
                                </td>
                                <td>
                                    <span class="score-val"><%= (int)r.getScore() %></span>
                                    <span class="score-total">/ <%= (int)r.getTotalMarks() %></span>
                                </td>
                                <td class="fw-bold text-info">
                                    <%= String.format("%.1f", pct) %>%
                                </td>
                                <td>
                                    <% if (isPass) { %>
                                        <span class="badge-pass">PASS</span>
                                    <% } else { %>
                                        <span class="badge-fail">FAIL</span>
                                    <% } %>
                                </td>
                            </tr>
                            <% } %>
                        </tbody>
                    </table>
                    <div id="noMatchMsg" class="no-results">No results found matching your search.</div>
                </div>
            <% } %>
        </div>
    </div>
</div>

<script>
    const searchInput = document.getElementById('resultSearch');
    const tableRows = document.querySelectorAll('.result-row');
    const noMatchMsg = document.getElementById('noMatchMsg');

    searchInput.addEventListener('keyup', function() {
        const query = searchInput.value.toLowerCase();
        let visibleCount = 0;

        tableRows.forEach(row => {
            const quizName = row.querySelector('.quiz-name-cell').innerText.toLowerCase();
            
            // Simple check if query is in quiz name
            if (quizName.includes(query)) {
                row.style.display = ''; // Show row (default for table-row)
                visibleCount++;
            } else {
                row.style.display = 'none'; // Hide row
            }
        });

        // Toggle "No Match" message
        if (visibleCount === 0) {
            noMatchMsg.style.display = 'block';
        } else {
            noMatchMsg.style.display = 'none';
        }
    });
</script>

</body>
</html>