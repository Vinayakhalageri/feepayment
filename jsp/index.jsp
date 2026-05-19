<%@ page import="java.util.*, com.dao.FeePaymentDAO, com.model.FeePayment, java.math.BigDecimal" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<title>College Fee Payment System</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">

<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">

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
    font-family:'Segoe UI',sans-serif;
    overflow-x:hidden;
}

/* NAVBAR */

.navbar{
    background:rgba(255,255,255,0.12);
    backdrop-filter:blur(12px);
    box-shadow:0 4px 20px rgba(0,0,0,0.2);
    padding:14px 0;
}

.navbar-brand{
    font-size:1.7rem;
    font-weight:800;
    color:white !important;
}

.nav-link{
    color:white !important;
    font-weight:500;
    margin:0 8px;
    transition:0.3s;
}

.nav-link:hover{
    transform:translateY(-2px);
    color:#ffd369 !important;
}

/* HERO */

.hero{
    padding:130px 0 90px;
    text-align:center;
    color:white;
}

.hero h1{
    font-size:4rem;
    font-weight:900;
    margin-bottom:20px;
    text-shadow:0 5px 15px rgba(0,0,0,0.3);
}

.hero p{
    font-size:1.25rem;
    opacity:0.95;
    max-width:750px;
    margin:auto;
}

.hero .btn{
    padding:12px 30px;
    border-radius:50px;
    font-weight:600;
    margin:10px;
    transition:0.3s;
}

.hero .btn:hover{
    transform:scale(1.05);
}

/* STATISTICS */

.stats-container{
    margin-top:-50px;
    margin-bottom:60px;
}

.stat-card{
    background:rgba(255,255,255,0.96);
    border-radius:25px;
    padding:30px;
    text-align:center;
    transition:0.4s;
    cursor:pointer;
    box-shadow:0 10px 30px rgba(0,0,0,0.2);
}

.stat-card:hover{
    transform:translateY(-12px) scale(1.02);
    box-shadow:0 20px 40px rgba(0,0,0,0.3);
}

.stat-icon{
    font-size:50px;
    margin-bottom:15px;
}

.stat-number{
    font-size:2.2rem;
    font-weight:800;
    color:#4f46e5;
}

.stat-label{
    color:#666;
    font-size:15px;
    margin-top:8px;
    font-weight:500;
}

/* SECTION TITLE */

.section-title{
    text-align:center;
    margin:70px 0 50px;
    color:white;
}

.section-title h2{
    font-size:3rem;
    font-weight:800;
}

.section-title p{
    font-size:1.1rem;
    opacity:0.9;
}

/* MODULE CARDS */

.module-card{
    background:rgba(255,255,255,0.97);
    border-radius:25px;
    padding:35px 25px;
    text-align:center;
    transition:0.4s;
    cursor:pointer;
    height:100%;
    box-shadow:0 10px 25px rgba(0,0,0,0.15);
    position:relative;
    overflow:hidden;
}

.module-card::before{
    content:'';
    position:absolute;
    top:0;
    left:0;
    width:100%;
    height:5px;
    background:linear-gradient(90deg,#4f46e5,#7c3aed);
}

.module-card:hover{
    transform:translateY(-12px);
    box-shadow:0 20px 45px rgba(0,0,0,0.25);
}

.module-icon{
    font-size:65px;
    margin-bottom:20px;
}

.module-title{
    font-size:1.6rem;
    font-weight:700;
    color:#222;
    margin-bottom:15px;
}

.module-desc{
    color:#666;
    font-size:15px;
    line-height:1.6;
    margin-bottom:25px;
}

.module-btn{
    background:linear-gradient(135deg,#4f46e5,#7c3aed);
    border:none;
    padding:12px 30px;
    border-radius:50px;
    color:white;
    font-weight:600;
    transition:0.3s;
}

.module-btn:hover{
    transform:scale(1.05);
    box-shadow:0 10px 20px rgba(79,70,229,0.4);
}

/* FOOTER */

.footer{
    background:#111827;
    color:white;
    padding:50px 0 20px;
    margin-top:80px;
}

.footer h5,
.footer h6{
    font-weight:700;
    margin-bottom:20px;
}

.footer a{
    color:#d1d5db;
    text-decoration:none;
    transition:0.3s;
}

.footer a:hover{
    color:#ffd369;
}

.footer ul li{
    margin-bottom:10px;
}

hr{
    border-color:rgba(255,255,255,0.2);
}

/* MOBILE */

@media(max-width:768px){

.hero h1{
    font-size:2.5rem;
}

.section-title h2{
    font-size:2rem;
}

.stat-number{
    font-size:1.8rem;
}

}

</style>
</head>

<body>

<%
    FeePaymentDAO dao = new FeePaymentDAO();

    List<FeePayment> allPayments =
            dao.getAllPayments();

    BigDecimal totalCollection =
            BigDecimal.ZERO;

    int paidCount = 0;
    int overdueCount = 0;

    Set<Integer> uniqueStudents =
            new HashSet<>();

    for(FeePayment p : allPayments){

        if("Paid".equals(p.getStatus())){

            totalCollection =
                    totalCollection.add(
                            p.getAmount());

            paidCount++;

        }else{

            overdueCount++;
        }

        uniqueStudents.add(
                p.getStudentId());
    }
%>

<!-- NAVBAR -->

<nav class="navbar navbar-expand-lg fixed-top">

<div class="container">

<a class="navbar-brand" href="index.jsp">

<i class="fas fa-university me-2"></i>

College Fee System

</a>

<button class="navbar-toggler bg-light"
type="button"
data-bs-toggle="collapse"
data-bs-target="#navbarNav">

<span class="navbar-toggler-icon"></span>

</button>

<div class="collapse navbar-collapse"
id="navbarNav">

<ul class="navbar-nav ms-auto">

<li class="nav-item">

<a class="nav-link active" href="index.jsp">

<i class="fas fa-home me-1"></i>

Home

</a>

</li>

<li class="nav-item">

<a class="nav-link" href="addFeePayment">

<i class="fas fa-plus-circle me-1"></i>

Add Payment

</a>

</li>

<li class="nav-item">

<a class="nav-link"
href="feepaymentupdate.jsp">

<i class="fas fa-edit me-1"></i>

Update

</a>

</li>

<li class="nav-item">

<a class="nav-link"
href="feepaymentdelete.jsp">

<i class="fas fa-trash me-1"></i>

Delete

</a>

</li>

<li class="nav-item">

<a class="nav-link"
href="feepaymentdisplay">

<i class="fas fa-eye me-1"></i>

View All

</a>

</li>

<li class="nav-item">

<a class="nav-link"
href="report_form.jsp">

<i class="fas fa-chart-line me-1"></i>

Reports

</a>

</li>

</ul>

</div>

</div>

</nav>

<!-- HERO SECTION -->

<div class="hero">

<div class="container">

<h1>

College Fee Payment System

</h1>

<p>

Efficiently manage student fee payments,
track collections and generate reports
with a modern management dashboard.

</p>

<div class="mt-4">

<a href="addFeePayment"
class="btn btn-light btn-lg">

<i class="fas fa-plus-circle me-2"></i>

Add Fee Payment

</a>

<a href="feepaymentdisplay"
class="btn btn-outline-light btn-lg">

<i class="fas fa-eye me-2"></i>

View Records

</a>

</div>

</div>

</div>

<!-- STATISTICS -->

<div class="container stats-container">

<div class="row g-4">

<!-- TOTAL COLLECTION -->

<div class="col-md-3 col-sm-6">

<div class="stat-card"
onclick="location.href='feepaymentdisplay'">

<div class="stat-icon">

<i class="fas fa-money-bill-wave"
style="color:#28a745;"></i>

</div>

<div class="stat-number">

Rs <%= String.format("%,.0f",
totalCollection) %>

</div>

<div class="stat-label">

Total Collection

</div>

</div>

</div>

<!-- TOTAL PAYMENTS -->

<div class="col-md-3 col-sm-6">

<div class="stat-card"
onclick="location.href='feepaymentdisplay'">

<div class="stat-icon">

<i class="fas fa-receipt"
style="color:#17a2b8;"></i>

</div>

<div class="stat-number">

<%= allPayments.size() %>

</div>

<div class="stat-label">

Total Payments

</div>

</div>

</div>

<!-- ACTIVE STUDENTS -->

<div class="col-md-3 col-sm-6">

<div class="stat-card"
onclick="location.href='feepaymentdisplay'">

<div class="stat-icon">

<i class="fas fa-users"
style="color:#ffc107;"></i>

</div>

<div class="stat-number">

<%= uniqueStudents.size() %>

</div>

<div class="stat-label">

Active Students

</div>

</div>

</div>

<!-- OVERDUE -->

<div class="col-md-3 col-sm-6">

<div class="stat-card"
onclick="location.href='report_form.jsp'">

<div class="stat-icon">

<i class="fas fa-exclamation-triangle"
style="color:#dc3545;"></i>

</div>

<div class="stat-number">

<%= overdueCount %>

</div>

<div class="stat-label">

Overdue Payments

</div>

</div>

</div>

</div>

</div>

<!-- MODULES -->

<div class="container">

<div class="section-title">

<h2>

Payment Management Modules

</h2>

<p>

Access all fee management features
from one place

</p>

</div>

<div class="row g-4">

<!-- ADD -->

<div class="col-md-4">

<div class="module-card"
onclick="location.href='addFeePayment'">

<div class="module-icon">

<i class="fas fa-plus-circle text-success"></i>

</div>

<h3 class="module-title">

Add Payment

</h3>

<p class="module-desc">

Record new fee payments with
automatic Payment ID and Student ID.

</p>

<button class="module-btn">

<i class="fas fa-plus"></i>

Add Payment

</button>

</div>

</div>

<!-- UPDATE -->

<div class="col-md-4">

<div class="module-card"
onclick="location.href='feepaymentupdate.jsp'">

<div class="module-icon">

<i class="fas fa-edit text-warning"></i>

</div>

<h3 class="module-title">

Update Payment

</h3>

<p class="module-desc">

Search and update payment details
using Student ID or Payment ID.

</p>

<button class="module-btn">

<i class="fas fa-pen"></i>

Update

</button>

</div>

</div>

<!-- DELETE -->

<div class="col-md-4">

<div class="module-card"
onclick="location.href='feepaymentdelete.jsp'">

<div class="module-icon">

<i class="fas fa-trash-alt text-danger"></i>

</div>

<h3 class="module-title">

Delete Payment

</h3>

<p class="module-desc">

Delete unwanted payment records
securely from the system.

</p>

<button class="module-btn">

<i class="fas fa-trash"></i>

Delete

</button>

</div>

</div>

<!-- VIEW -->

<div class="col-md-4">

<div class="module-card"
onclick="location.href='feepaymentdisplay'">

<div class="module-icon">

<i class="fas fa-table text-info"></i>

</div>

<h3 class="module-title">

View Payments

</h3>

<p class="module-desc">

View all payment records in a
professional table format.

</p>

<button class="module-btn">

<i class="fas fa-eye"></i>

View Records

</button>

</div>

</div>

<!-- REPORTS -->

<div class="col-md-4">

<div class="module-card"
onclick="location.href='report_form.jsp'">

<div class="module-icon">

<i class="fas fa-chart-line text-primary"></i>

</div>

<h3 class="module-title">

Reports

</h3>

<p class="module-desc">

Generate reports for overdue,
paid and collection details.

</p>

<button class="module-btn">

<i class="fas fa-chart-bar"></i>

Reports

</button>

</div>

</div>

<!-- DASHBOARD -->

<div class="col-md-4">

<div class="module-card"
onclick="location.href='index.jsp'">

<div class="module-icon">

<i class="fas fa-chart-pie text-secondary"></i>

</div>

<h3 class="module-title">

Dashboard

</h3>

<p class="module-desc">

View collection statistics and
complete payment summaries.

</p>

<button class="module-btn">

<i class="fas fa-tachometer-alt"></i>

Dashboard

</button>

</div>

</div>

</div>

</div>

<!-- FOOTER -->

<footer class="footer">

<div class="container">

<div class="row">

<div class="col-md-4 mb-4">

<h5>

<i class="fas fa-university me-2"></i>

College Fee System

</h5>

<p class="text-light">

Efficient fee management solution
for educational institutions.

</p>

</div>

<div class="col-md-4 mb-4">

<h6>

Quick Links

</h6>

<ul class="list-unstyled">

<li>

<a href="addFeePayment">

<i class="fas fa-angle-right me-2"></i>

Add Payment

</a>

</li>

<li>

<a href="feepaymentdisplay">

<i class="fas fa-angle-right me-2"></i>

View Payments

</a>

</li>

<li>

<a href="report_form.jsp">

<i class="fas fa-angle-right me-2"></i>

Reports

</a>

</li>

</ul>

</div>

<div class="col-md-4 mb-4">

<h6>

Contact

</h6>

<ul class="list-unstyled">

<li>

<i class="fas fa-envelope me-2"></i>

support@collegefeesystem.com

</li>

<li>

<i class="fas fa-phone me-2"></i>

+91 1234567890

</li>

</ul>

</div>

</div>

<hr>

<div class="text-center">

<p class="mb-0 text-light">

© 2026 College Fee Payment System.
All Rights Reserved.

</p>

</div>

</div>

</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>