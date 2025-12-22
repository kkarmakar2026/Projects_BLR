<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.quizportal.model.Question" %>
<%@ page import="com.quizportal.model.Quiz" %>
<%@ page import="com.quizportal.dao.QuizDAO" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Quiz Attempt - Quiz Portal</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">

    <style>
        body {
            background-color: #0d1b2a;
            color: #e0e1dd;
            padding-bottom: 80px;
            padding-top: 70px; /* Reduced padding since navbar is smaller now */
        }

        /* --- LOGO STYLE (REDUCED SIZE) --- */
        .navbar-logo {
            max-height: 45px; /* Reduced from 70px to 45px */
            width: auto;      
            object-fit: contain;
            margin-right: 10px;
        }

        /* TIMER STYLES */
        .timer-badge {
            position: fixed;
            top: 80px; /* Moved up slightly */
            right: 20px;
            background-color: rgba(13, 27, 42, 0.95);
            border: 2px solid #00d4ff;
            color: #00d4ff;
            padding: 8px 20px;
            border-radius: 50px;
            font-size: 1.2rem;
            font-weight: 800;
            font-family: 'Courier New', monospace;
            box-shadow: 0 0 15px rgba(0, 212, 255, 0.3);
            z-index: 1050;
            transition: all 0.3s ease;
            backdrop-filter: blur(5px);
        }

        .timer-warning {
            border-color: #ff3333;
            color: #ff3333;
            box-shadow: 0 0 15px rgba(255, 51, 51, 0.5);
            animation: pulse 1s infinite;
        }

        @keyframes pulse {
            0% { transform: scale(1); }
            50% { transform: scale(1.05); }
            100% { transform: scale(1); }
        }

        .question-card {
            background-color: #1b263b;
            border: 1px solid rgba(255, 255, 255, 0.05);
            border-radius: 15px;
            padding: 25px;
            margin-bottom: 25px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.2);
        }

        .question-number {
            font-size: 0.9rem;
            text-transform: uppercase;
            letter-spacing: 1px;
            color: #ff9100;
            margin-bottom: 10px;
            font-weight: bold;
        }

        .question-text {
            font-size: 1.25rem;
            font-weight: 600;
            color: #fff;
            margin-bottom: 20px;
        }

        .option-container { position: relative; margin-bottom: 12px; }
        .option-input { position: absolute; opacity: 0; cursor: pointer; height: 0; width: 0; }
        
        .option-label {
            display: flex; align-items: center;
            background-color: #0d1b2a;
            border: 1px solid #2c3e50;
            border-radius: 10px;
            padding: 15px 20px;
            cursor: pointer;
            transition: all 0.2s ease;
        }

        .option-label:hover { background-color: #25324b; border-color: #4b5d78; }

        .option-marker {
            width: 24px; height: 24px;
            border: 2px solid #6c757d; border-radius: 50%;
            margin-right: 15px;
            display: flex; align-items: center; justify-content: center;
        }

        .option-marker::after {
            content: ''; width: 12px; height: 12px;
            background-color: #00d4ff; border-radius: 50%;
            opacity: 0; transform: scale(0); transition: all 0.2s ease;
        }

        .option-input:checked + .option-label {
            background-color: rgba(0, 212, 255, 0.1);
            border-color: #00d4ff;
            box-shadow: 0 0 10px rgba(0, 212, 255, 0.1);
        }
        .option-input:checked + .option-label .option-marker { border-color: #00d4ff; }
        .option-input:checked + .option-label .option-marker::after { opacity: 1; transform: scale(1); }

        .quiz-footer {
            position: fixed; bottom: 0; left: 0; width: 100%;
            background-color: rgba(13, 27, 42, 0.95);
            border-top: 1px solid rgba(0, 212, 255, 0.2);
            padding: 15px 0; backdrop-filter: blur(10px); z-index: 1000;
        }
    </style>
</head>
<body>

<nav class="navbar navbar-dark fixed-top" style="background-color: rgba(13, 27, 42, 0.95); border-bottom: 1px solid rgba(0, 212, 255, 0.1);">
    <div class="container-fluid px-4">
        <a class="navbar-brand d-flex align-items-center" href="#">
            <img src="${pageContext.request.contextPath}/assets/images/logo.png" 
                 class="navbar-logo" 
                 alt="Quiz Portal">
            <span class="fw-bold fs-4">Quiz In Progress</span>
        </a>
    </div>
</nav>

<div id="quizTimer" class="timer-badge">
    <i class="bi bi-stopwatch me-2"></i><span id="timeText">--:--</span>
</div>

<div class="container mt-4">
    <div class="row justify-content-center">
        <div class="col-lg-8">

            <form id="quizForm" method="post" action="${pageContext.request.contextPath}/quiz/submit">
                
                <%
                    List<Question> questions = (List<Question>) request.getAttribute("questions");
                    Object quizIdObj = request.getAttribute("quizId");
                    Integer quizId = quizIdObj != null ? (Integer) quizIdObj : 0;

                    QuizDAO quizDAO = new QuizDAO();
                    Quiz currentQuiz = quizDAO.findById(quizId);
                    int timeLimitMinutes = (currentQuiz != null && currentQuiz.getTimeLimit() > 0) 
                                           ? currentQuiz.getTimeLimit() : 10;

                    if (questions != null && !questions.isEmpty()) {
                        int qNum = 1;
                        for (Question q : questions) {
                %>
                    <div class="question-card">
                        <div class="question-number">Question <%= qNum %></div>
                        <div class="question-text"><%= q.getText() %></div>

                        <% String[] options = {"A", "B", "C", "D"}; 
                           String[] optionTexts = {q.getOptionA(), q.getOptionB(), q.getOptionC(), q.getOptionD()};
                           
                           for(int i=0; i<4; i++) {
                        %>
                        <div class="option-container">
                            <input class="option-input" type="radio" 
                                   id="q<%= q.getId() %>_<%= options[i] %>" 
                                   name="question_<%= q.getId() %>" 
                                   value="<%= options[i] %>">
                            <label class="option-label" for="q<%= q.getId() %>_<%= options[i] %>">
                                <span class="option-marker"></span>
                                <span><%= optionTexts[i] %></span>
                            </label>
                        </div>
                        <% } %>
                    </div>
                <%
                        qNum++;
                        }
                    } else {
                %>
                    <div class="alert alert-warning text-center">
                        No questions available for this quiz.
                    </div>
                <%
                    }
                %>

                <% if (quizId != null) { %>
                    <input type="hidden" name="quizId" value="<%= quizId %>" />
                <% } %>

                <div class="quiz-footer">
                    <div class="container">
                        <div class="row justify-content-center">
                            <div class="col-lg-8 d-grid">
                                <button type="submit" class="btn btn-primary fw-bold py-2 fs-5" 
                                        style="background-color: #00d4ff; border:none; color: #0d1b2a;">
                                    Submit Quiz <i class="bi bi-send-fill ms-2"></i>
                                </button>
                            </div>
                        </div>
                    </div>
                </div>

            </form>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

<script>
    const minutesSet = <%= timeLimitMinutes %>;
    let timeLeft = minutesSet * 60; 

    const timerElement = document.getElementById('quizTimer');
    const timeText = document.getElementById('timeText');
    const quizForm = document.getElementById('quizForm');

    updateTimerDisplay();

    const countdown = setInterval(() => {
        timeLeft--;
        updateTimerDisplay();

        if (timeLeft <= 60) {
            timerElement.classList.add('timer-warning');
        }

        if (timeLeft <= 0) {
            clearInterval(countdown);
            timeText.innerText = "00:00";
            alert("Time's Up! Submitting your answers now.");
            quizForm.submit();
        }
    }, 1000);

    function updateTimerDisplay() {
        let minutes = Math.floor(timeLeft / 60);
        let seconds = timeLeft % 60;
        seconds = seconds < 10 ? '0' + seconds : seconds;
        minutes = minutes < 10 ? '0' + minutes : minutes;
        timeText.innerText = minutes + ":" + seconds;
    }
</script>

</body>
</html>