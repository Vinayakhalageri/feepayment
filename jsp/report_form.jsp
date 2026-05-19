<%@ page import="java.util.*, com.dao.FeePaymentDAO" %>

<!DOCTYPE html>
<html lang="en">

<head>

<meta charset="UTF-8">

<meta name="viewport"
content="width=device-width, initial-scale=1.0">

<title>Reports - College Fee System</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
rel="stylesheet">

<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css"
rel="stylesheet">

<style>

*{
    margin:0;
    padding:0;
    box-sizing:border-box;
}

body{

    background:
    linear-gradient(
    135deg,
    #4f46e5 0%,
    #7c3aed 50%,
    #2563eb 100%);

    min-height:100vh;

    padding:40px 15px;

    font-family:'Segoe UI',sans-serif;
}

/* MAIN CONTAINER */

.report-container{

    background:
    rgba(255,255,255,0.97);

    border-radius:30px;

    overflow:hidden;

    box-shadow:
    0 15px 40px rgba(0,0,0,0.25);

    animation:fadeIn 0.8s ease;
}

/* ANIMATION */

@keyframes fadeIn{

from{
    opacity:0;
    transform:translateY(30px);
}

to{
    opacity:1;
    transform:translateY(0);
}

}

/* HEADER */

.report-header{

    background:
    linear-gradient(
    135deg,
    #4f46e5,
    #7c3aed);

    color:white;

    padding:40px 30px;

    text-align:center;
}

.report-header h1{

    font-size:2.7rem;

    font-weight:800;

    margin-bottom:10px;
}

.report-header p{

    opacity:0.9;

    font-size:16px;
}

/* BODY */

.report-body{

    padding:35px;
}

/* STATS */

.stat-box{

    background:
    linear-gradient(
    135deg,
    #eef2ff,
    #dbeafe);

    border-radius:20px;

    padding:25px;

    text-align:center;

    transition:0.3s;

    box-shadow:
    0 5px 15px rgba(0,0,0,0.08);
}

.stat-box:hover{

    transform:translateY(-5px);
}

.stat-icon{

    font-size:40px;

    margin-bottom:10px;
}

.stat-number{

    font-size:32px;

    font-weight:800;

    color:#4f46e5;
}

/* REPORT CARD */

.report-card{

    background:white;

    border-radius:25px;

    padding:25px;

    margin-bottom:25px;

    cursor:pointer;

    transition:0.3s;

    border:2px solid transparent;

    box-shadow:
    0 5px 15px rgba(0,0,0,0.08);
}

.report-card:hover{

    transform:translateY(-5px);

    border-color:#4f46e5;

    box-shadow:
    0 10px 25px rgba(0,0,0,0.15);
}

.report-icon{

    font-size:55px;
}

/* DATE FORM */

.date-range-form{

    display:none;

    background:#f8fafc;

    padding:25px;

    border-radius:20px;

    margin-top:15px;

    border:2px dashed #c7d2fe;
}

/* BUTTON */

.generate-btn{

    background:
    linear-gradient(
    135deg,
    #4f46e5,
    #7c3aed);

    border:none;

    color:white;

    font-weight:700;

    padding:12px;

    border-radius:15px;

    transition:0.3s;
}

.generate-btn:hover{

    transform:translateY(-2px);

    box-shadow:
    0 8px 18px rgba(79,70,229,0.3);
}

/* ALERT */

.info-alert{

    background:#eef2ff;

    border:none;

    border-left:5px solid #4f46e5;

    border-radius:15px;

    padding:18px;
}

/* RESPONSIVE */

@media(max-width:768px){

.report-header h1{

    font-size:2rem;
}

.report-body{

    padding:20px;
}

.report-card{

    text-align:center;
}

}

</style>

</head>

<body>

<%

FeePaymentDAO dao = new FeePaymentDAO();

int totalCount =
dao.getAllPayments().size();

int paidCount =
dao.getPaidPayments().size();

int overdueCount =
dao.getOverduePayments().size();

%>

<div class="container">

<div class="report-container">

<!-- HEADER -->

<div class="report-header">

<i class="fas fa-chart-line fa-4x mb-3"></i>

<h1>

Fee Payment Reports

</h1>

<p>

Generate payment reports and collection summaries

</p>

</div>

<!-- BODY -->

<div class="report-body">

<!-- ERROR -->

<%

if(request.getAttribute("error") != null){

%>

<div class="alert alert-danger">

<%= request.getAttribute("error") %>

</div>

<%

}

%>

<!-- STATS -->

<div class="row mb-4">

<div class="col-md-4 mb-3">

<div class="stat-box">

<div class="stat-icon text-primary">

<i class="fas fa-file-invoice"></i>

</div>

<div class="stat-number">

<%= totalCount %>

</div>

<div>

Total Payments

</div>

</div>

</div>

<div class="col-md-4 mb-3">

<div class="stat-box">

<div class="stat-icon text-success">

<i class="fas fa-check-circle"></i>

</div>

<div class="stat-number">

<%= paidCount %>

</div>

<div>

Paid Payments

</div>

</div>

</div>

<div class="col-md-4 mb-3">

<div class="stat-box">

<div class="stat-icon text-danger">

<i class="fas fa-exclamation-circle"></i>

</div>

<div class="stat-number">

<%= overdueCount %>

</div>

<div>

Overdue Payments

</div>

</div>

</div>

</div>

<!-- OVERDUE REPORT -->

<div class="report-card"
onclick="generateReport('overdue')">

<div class="row align-items-center">

<div class="col-md-2 text-center">

<div class="report-icon text-danger">

<i class="fas fa-exclamation-triangle"></i>

</div>

</div>

<div class="col-md-10">

<h3>

Overdue Payments Report

</h3>

<p class="text-muted mb-0">

Shows all overdue fee payment records with student details.

</p>

</div>

</div>

<form id="formOverdue"
action="reportCriteria"
method="post"
style="display:none;">

<input type="hidden"
name="reportType"
value="overdue">

</form>

</div>

<!-- PAID REPORT -->

<div class="report-card"
onclick="generateReport('paid')">

<div class="row align-items-center">

<div class="col-md-2 text-center">

<div class="report-icon text-success">

<i class="fas fa-check-circle"></i>

</div>

</div>

<div class="col-md-10">

<h3>

Paid Payments Report

</h3>

<p class="text-muted mb-0">

Displays all completed fee payments and collection history.

</p>

</div>

</div>

<form id="formPaid"
action="reportCriteria"
method="post"
style="display:none;">

<input type="hidden"
name="reportType"
value="paid">

</form>

</div>

<!-- DATE RANGE -->

<div class="report-card"
onclick="toggleDateRange()">

<div class="row align-items-center">

<div class="col-md-2 text-center">

<div class="report-icon text-primary">

<i class="fas fa-calendar-alt"></i>

</div>

</div>

<div class="col-md-10">

<h3>

Date Range Collection Report

</h3>

<p class="text-muted mb-0">

Generate collection report between selected dates.

</p>

</div>

</div>

</div>

<!-- DATE FORM -->

<div id="dateRangeForm"
class="date-range-form">

<form action="reportCriteria"
method="post"
onsubmit="return validateDates()">

<input type="hidden"
name="reportType"
value="dateRange">

<div class="row">

<div class="col-md-5 mb-3">

<label class="form-label">

<i class="fas fa-calendar-day me-2"></i>

Start Date

</label>

<input type="date"
name="startDate"
id="startDate"
class="form-control"
required>

</div>

<div class="col-md-5 mb-3">

<label class="form-label">

<i class="fas fa-calendar-check me-2"></i>

End Date

</label>

<input type="date"
name="endDate"
id="endDate"
class="form-control"
required>

</div>

<div class="col-md-2 mb-3 d-grid">

<label class="form-label">

&nbsp;

</label>

<button type="submit"
class="generate-btn">

<i class="fas fa-download me-1"></i>

Generate

</button>

</div>

</div>

</form>

</div>

<!-- INFO -->

<div class="info-alert mt-4">

<i class="fas fa-info-circle me-2"></i>

<strong>Instructions:</strong>

Click any report card to generate reports instantly.
For date range reports, select start and end dates.

</div>

<!-- HOME BUTTON -->

<div class="text-center mt-4">

<a href="index.jsp"
class="btn btn-secondary px-4 py-2 rounded-pill">

<i class="fas fa-home me-2"></i>

Back To Home

</a>

</div>

</div>

</div>

</div>

<script>

function generateReport(type){

    if(type === 'overdue'){

        document
        .getElementById('formOverdue')
        .submit();
    }

    if(type === 'paid'){

        document
        .getElementById('formPaid')
        .submit();
    }
}

function toggleDateRange(){

    var form =
    document.getElementById(
    'dateRangeForm');

    if(form.style.display === 'block'){

        form.style.display = 'none';

    }else{

        form.style.display = 'block';
    }
}

function validateDates(){

    var startDate =
    document.getElementById(
    'startDate').value;

    var endDate =
    document.getElementById(
    'endDate').value;

    if(startDate > endDate){

        alert(
        'Start date cannot be greater than end date');

        return false;
    }

    return true;
}

/* DEFAULT DATES */

var today = new Date();

var firstDay =
new Date(
today.getFullYear(),
today.getMonth(),
1);

function formatDate(date){

    var y = date.getFullYear();

    var m =
    String(date.getMonth()+1)
    .padStart(2,'0');

    var d =
    String(date.getDate())
    .padStart(2,'0');

    return y + '-' + m + '-' + d;
}

document.getElementById(
'startDate').value =
formatDate(firstDay);

document.getElementById(
'endDate').value =
formatDate(today);

</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>

</body>

</html>