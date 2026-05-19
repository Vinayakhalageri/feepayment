<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">

<title>Payment Reports</title>

<meta name="viewport"
content="width=device-width, initial-scale=1.0">

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

    padding:50px 15px;

    font-family:'Segoe UI',sans-serif;
}

/* MAIN CONTAINER */

.report-container{

    background:rgba(255,255,255,0.97);

    border-radius:30px;

    padding:35px;

    max-width:900px;

    margin:auto;

    box-shadow:
    0 15px 40px rgba(0,0,0,0.25);

    animation:fadeIn 0.7s ease;
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

/* TITLE */

.page-title{

    text-align:center;

    font-size:2.5rem;

    font-weight:800;

    color:#4f46e5;

    margin-bottom:10px;
}

.page-subtitle{

    text-align:center;

    color:#6b7280;

    margin-bottom:35px;
}

/* REPORT CARDS */

.report-card{

    background:
    linear-gradient(
    135deg,
    #eef2ff,
    #dbeafe);

    border-radius:22px;

    padding:25px;

    margin-bottom:25px;

    cursor:pointer;

    transition:0.35s;

    border:2px solid transparent;
}

.report-card:hover{

    transform:translateY(-5px);

    border-color:#4f46e5;

    box-shadow:
    0 10px 25px rgba(0,0,0,0.12);
}

/* ICONS */

.report-icon{

    width:85px;
    height:85px;

    border-radius:50%;

    display:flex;

    align-items:center;

    justify-content:center;

    font-size:34px;

    color:white;

    margin:auto;
}

.icon-danger{

    background:
    linear-gradient(
    135deg,
    #dc2626,
    #ef4444);
}

.icon-success{

    background:
    linear-gradient(
    135deg,
    #16a34a,
    #22c55e);
}

.icon-primary{

    background:
    linear-gradient(
    135deg,
    #2563eb,
    #4f46e5);
}

/* CARD TEXT */

.report-title{

    font-size:1.4rem;

    font-weight:700;

    color:#111827;

    margin-bottom:8px;
}

.report-text{

    color:#6b7280;

    font-size:15px;

    margin-bottom:0;
}

/* DATE RANGE FORM */

.date-range{

    display:none;

    margin-top:20px;

    background:#f9fafb;

    border-radius:20px;

    padding:25px;

    border:1px solid #dbeafe;
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

    border-radius:12px;

    padding:12px;
}

.generate-btn:hover{

    transform:translateY(-2px);

    box-shadow:
    0 8px 18px rgba(79,70,229,0.3);
}

/* ALERT */

.custom-alert{

    border-radius:15px;

    font-weight:600;
}

/* INFO BOX */

.info-box{

    background:
    linear-gradient(
    135deg,
    #eef2ff,
    #dbeafe);

    padding:18px;

    border-radius:18px;

    margin-top:25px;

    color:#374151;
}

/* RESPONSIVE */

@media(max-width:768px){

.page-title{

    font-size:2rem;
}

.report-container{

    padding:20px;
}

.report-title{

    font-size:1.1rem;
}

.report-icon{

    width:70px;
    height:70px;

    font-size:28px;
}

}

</style>

</head>

<body>

<div class="container">

<div class="report-container">

<!-- TITLE -->

<h1 class="page-title">

<i class="fas fa-chart-bar me-2"></i>

Payment Reports

</h1>

<p class="page-subtitle">

Generate student payment reports quickly

</p>

<!-- ERROR -->

<%

if(request.getAttribute("error") != null){

%>

<div class="alert alert-danger custom-alert">

<i class="fas fa-exclamation-circle me-2"></i>

<%= request.getAttribute("error") %>

</div>

<%

}

%>

<!-- OVERDUE REPORT -->

<div class="report-card"
onclick="submitReport('overdue')">

<div class="row align-items-center">

<div class="col-md-2 text-center mb-3 mb-md-0">

<div class="report-icon icon-danger">

<i class="fas fa-exclamation-triangle"></i>

</div>

</div>

<div class="col-md-10">

<div class="report-title">

Overdue Payments Report

</div>

<p class="report-text">

View all overdue student fee payments.

</p>

</div>

</div>

<form id="formOverdue"
action="report"
method="post"
style="display:none;">

<input type="hidden"
name="reportType"
value="overdue">

</form>

</div>

<!-- PAID REPORT -->

<div class="report-card"
onclick="submitReport('paid')">

<div class="row align-items-center">

<div class="col-md-2 text-center mb-3 mb-md-0">

<div class="report-icon icon-success">

<i class="fas fa-check-circle"></i>

</div>

</div>

<div class="col-md-10">

<div class="report-title">

Paid Payments Report

</div>

<p class="report-text">

View all successful payment records.

</p>

</div>

</div>

<form id="formPaid"
action="report"
method="post"
style="display:none;">

<input type="hidden"
name="reportType"
value="paid">

</form>

</div>

<!-- DATE RANGE REPORT -->

<div class="report-card"
onclick="toggleDateRange()">

<div class="row align-items-center">

<div class="col-md-2 text-center mb-3 mb-md-0">

<div class="report-icon icon-primary">

<i class="fas fa-calendar-alt"></i>

</div>

</div>

<div class="col-md-10">

<div class="report-title">

Date Range Report

</div>

<p class="report-text">

Generate payment report between selected dates.

</p>

</div>

</div>

</div>

<!-- DATE RANGE FORM -->

<div id="dateRangeForm"
class="date-range">

<form action="report"
method="post"
onsubmit="return validateDates()">

<input type="hidden"
name="reportType"
value="dateRange">

<div class="row">

<div class="col-md-5 mb-3">

<label class="form-label fw-bold">

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

<label class="form-label fw-bold">

<i class="fas fa-calendar-check me-2"></i>

End Date

</label>

<input type="date"
name="endDate"
id="endDate"
class="form-control"
required>

</div>

<div class="col-md-2 mb-3">

<label class="form-label">

&nbsp;

</label>

<button type="submit"
class="btn generate-btn w-100">

<i class="fas fa-download me-2"></i>

Generate

</button>

</div>

</div>

</form>

</div>

<!-- INFO -->

<div class="info-box">

<i class="fas fa-info-circle me-2"></i>

Click any report card to generate report instantly.

</div>

</div>

</div>

<script>

function submitReport(type){

    if(type === 'overdue'){

        document
        .getElementById('formOverdue')
        .submit();

    }else if(type === 'paid'){

        document
        .getElementById('formPaid')
        .submit();
    }
}

function toggleDateRange(){

    let div =
    document.getElementById(
    'dateRangeForm');

    if(div.style.display === 'none'
    || div.style.display === ''){

        div.style.display = 'block';

    }else{

        div.style.display = 'none';
    }
}

function validateDates(){

    let startDate =
    document.getElementById(
    'startDate').value;

    let endDate =
    document.getElementById(
    'endDate').value;

    if(startDate > endDate){

        alert(
        'Start date cannot be greater than End date');

        return false;
    }

    return true;
}

/* DEFAULT DATES */

let today = new Date();

let firstDay =
new Date(
today.getFullYear(),
today.getMonth(),
1
);

function formatDate(date){

    let year =
    date.getFullYear();

    let month =
    String(
    date.getMonth() + 1)
    .padStart(2,'0');

    let day =
    String(
    date.getDate())
    .padStart(2,'0');

    return year + '-' + month + '-' + day;
}

document
.getElementById('startDate')
.value =
formatDate(firstDay);

document
.getElementById('endDate')
.value =
formatDate(today);

</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>