<%@ page import="java.time.LocalDate" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<title>Add Fee Payment</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">

<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">

<style>

*{
    margin:0;
    padding:0;
    box-sizing:border-box;
}

body{
    min-height:100vh;
    background:
    linear-gradient(
    135deg,
    #4f46e5 0%,
    #7c3aed 50%,
    #2563eb 100%);
    
    font-family:'Segoe UI',sans-serif;
    padding:40px 15px;
}

/* MAIN CONTAINER */

.form-container{

    background:rgba(255,255,255,0.96);

    backdrop-filter:blur(12px);

    border-radius:30px;

    padding:40px;

    max-width:700px;

    margin:auto;

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

/* TITLE */

.page-title{

    text-align:center;

    font-size:2.5rem;

    font-weight:800;

    color:#4f46e5;

    margin-bottom:30px;
}

/* INFO BOX */

.info-box{

    background:
    linear-gradient(
    135deg,
    #eef2ff,
    #dbeafe);

    border-left:6px solid #4f46e5;

    padding:20px;

    border-radius:15px;

    margin-bottom:30px;

    box-shadow:
    0 5px 15px rgba(0,0,0,0.08);
}

.next-number{

    color:#16a34a;

    font-size:24px;

    font-weight:800;
}

/* LABEL */

.form-label{

    font-weight:700;

    color:#333;

    margin-bottom:8px;
}

/* INPUTS */

.form-control,
.form-select{

    border-radius:15px;

    padding:14px;

    border:1px solid #d1d5db;

    font-size:15px;

    transition:0.3s;
}

.form-control:focus,
.form-select:focus{

    border-color:#4f46e5;

    box-shadow:
    0 0 10px rgba(79,70,229,0.25);
}

/* READONLY */

.readonly-field{

    background:#e5e7eb !important;

    font-weight:700;

    color:#111827;

    cursor:not-allowed;
}

/* BUTTON */

.save-btn{

    background:
    linear-gradient(
    135deg,
    #4f46e5,
    #7c3aed);

    border:none;

    padding:14px;

    border-radius:18px;

    color:white;

    width:100%;

    font-size:18px;

    font-weight:700;

    transition:0.3s;
}

.save-btn:hover{

    transform:translateY(-3px);

    box-shadow:
    0 10px 20px rgba(79,70,229,0.4);
}

/* ALERTS */

.alert{

    border-radius:15px;

    padding:18px;

    font-weight:600;
}

/* SMALL TEXT */

small{

    color:#6b7280;
}

/* RESPONSIVE */

@media(max-width:768px){

.page-title{

    font-size:2rem;
}

.form-container{

    padding:25px;
}

}

</style>
</head>

<body>

<%

    Integer nextPaymentId =
        (Integer) request.getAttribute("nextPaymentId");

    Integer nextStudentId =
        (Integer) request.getAttribute("nextStudentId");

    String currentDate =
        (String) request.getAttribute("currentDate");

    if(currentDate == null){

        currentDate =
            LocalDate.now().toString();
    }

%>

<div class="container">

<div class="form-container">

<!-- TITLE -->

<h1 class="page-title">

<i class="fas fa-plus-circle text-success me-2"></i>

Add Fee Payment

</h1>

<!-- MESSAGE -->

<%

if(request.getAttribute("message") != null){

%>

<div class="alert alert-<%= request.getAttribute("messageType") %>">

<%= request.getAttribute("message") %>

</div>

<%

}

%>

<!-- SUCCESS BOX -->

<%

if(request.getAttribute("savedPayment") != null){

com.model.FeePayment p =
(com.model.FeePayment)
request.getAttribute("savedPayment");

%>

<div class="alert alert-success">

<i class="fas fa-check-circle me-2"></i>

Payment Added Successfully!

<hr>

Payment ID :
<strong>

<%= p.getPaymentId() %>

</strong>

<br>

Student ID :
<strong>

<%= p.getStudentId() %>

</strong>

<br>

Student Name :
<strong>

<%= p.getStudentName() %>

</strong>

</div>

<%

}

%>

<!-- INFO -->

<div class="info-box">

<h5 class="mb-3">

<i class="fas fa-database me-2"></i>

Latest IDs fetched directly from Database

</h5>

<div class="row">

<div class="col-md-6 mb-2">

Next Payment ID :

<br>

<span class="next-number">

<%= nextPaymentId %>

</span>

</div>

<div class="col-md-6 mb-2">

Next Student ID :

<br>

<span class="next-number">

<%= nextStudentId %>

</span>

</div>

</div>

</div>

<!-- FORM -->

<form action="addFeePayment" method="post">

<!-- PAYMENT ID -->

<div class="mb-4">

<label class="form-label">

<i class="fas fa-id-card me-2"></i>

Payment ID

</label>

<input type="text"
class="form-control readonly-field"
value="<%= nextPaymentId %>"
readonly>

<small>

Auto-generated from database

</small>

</div>

<!-- STUDENT ID -->

<div class="mb-4">

<label class="form-label">

<i class="fas fa-user-graduate me-2"></i>

Student ID

</label>

<input type="text"
class="form-control readonly-field"
value="<%= nextStudentId %>"
readonly>

<input type="hidden"
name="studentId"
value="<%= nextStudentId %>">

<small>

Auto-generated from database

</small>

</div>

<!-- NAME -->

<div class="mb-4">

<label class="form-label">

<i class="fas fa-user me-2"></i>

Student Name

</label>

<input type="text"
name="studentName"
class="form-control"
placeholder="Enter student full name"
required>

</div>

<!-- DATE -->

<div class="mb-4">

<label class="form-label">

<i class="fas fa-calendar-alt me-2"></i>

Payment Date

</label>

<input type="text"
class="form-control readonly-field"
value="<%= currentDate %>"
readonly>

<input type="hidden"
name="paymentDate"
value="<%= currentDate %>">

<small>

Current system date

</small>

</div>

<!-- AMOUNT -->

<div class="mb-4">

<label class="form-label">

<i class="fas fa-money-bill-wave me-2"></i>

Amount (Rs)

</label>

<input type="number"
step="0.01"
name="amount"
class="form-control"
placeholder="Enter payment amount"
required>

</div>

<!-- STATUS -->

<div class="mb-4">

<label class="form-label">

<i class="fas fa-tag me-2"></i>

Payment Status

</label>

<select name="status"
class="form-select">

<option value="Paid">

Paid

</option>

<option value="Overdue">

Overdue

</option>

</select>

</div>

<!-- BUTTON -->

<button type="submit"
class="save-btn">

<i class="fas fa-save me-2"></i>

Save Payment


</button>

<!-- BUTTONS -->

<div class="text-center mt-4">

<a href="index.jsp"
class="btn btn-secondary px-4 py-2 rounded-pill">

<i class="fas fa-arrow-left me-2"></i>

Back To Home

</a>

</div>


</form>


</div>

</div>

</body>
</html>