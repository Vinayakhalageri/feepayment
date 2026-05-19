<%@ page import="java.util.*, com.model.FeePayment" %>

<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">

<title>Delete Fee Payment</title>

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

    padding:40px 15px;

    font-family:'Segoe UI',sans-serif;
}

/* MAIN BOX */

.container-box{

    background:rgba(255,255,255,0.97);

    border-radius:30px;

    padding:40px;

    max-width:1000px;

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

    color:#dc3545;

    margin-bottom:10px;
}

.sub-text{

    text-align:center;

    color:#6b7280;

    margin-bottom:30px;
}

/* SEARCH BOX */

.search-box{

    background:#f8fafc;

    padding:25px;

    border-radius:20px;

    margin-bottom:30px;

    box-shadow:
    0 5px 15px rgba(0,0,0,0.05);
}

/* INPUTS */

.form-control{

    border-radius:15px;

    padding:14px;

    border:1px solid #d1d5db;

    transition:0.3s;
}

.form-control:focus{

    border-color:#4f46e5;

    box-shadow:
    0 0 10px rgba(79,70,229,0.2);
}

/* BUTTON */

.search-btn{

    background:
    linear-gradient(
    135deg,
    #dc3545,
    #b91c1c);

    border:none;

    border-radius:15px;

    padding:13px;

    color:white;

    font-weight:700;

    transition:0.3s;
}

.search-btn:hover{

    transform:translateY(-2px);

    box-shadow:
    0 8px 20px rgba(220,53,69,0.35);
}

/* CARD */

.payment-card{

    background:white;

    border-radius:22px;

    padding:25px;

    margin-bottom:20px;

    border-left:6px solid #dc3545;

    box-shadow:
    0 5px 15px rgba(0,0,0,0.08);

    transition:0.3s;
}

.payment-card:hover{

    transform:translateY(-4px);
}

/* DETAILS */

.detail-box{

    background:#f8fafc;

    border-radius:15px;

    padding:12px;

    margin-bottom:12px;
}

.detail-title{

    font-size:13px;

    color:#6b7280;

    margin-bottom:4px;
}

.detail-value{

    font-weight:700;

    color:#111827;

    font-size:17px;
}

/* BADGE */

.status-badge{

    padding:8px 16px;

    border-radius:30px;

    font-weight:700;
}

/* DELETE BUTTON */

.delete-btn{

    background:
    linear-gradient(
    135deg,
    #dc3545,
    #991b1b);

    border:none;

    color:white;

    padding:12px 20px;

    border-radius:15px;

    width:100%;

    font-weight:700;

    transition:0.3s;
}

.delete-btn:hover{

    transform:translateY(-2px);

    box-shadow:
    0 8px 20px rgba(220,53,69,0.35);
}

/* BACK BUTTON */

.back-btn{

    border-radius:15px;

    padding:12px 20px;

    font-weight:700;
}

/* ALERT */

.alert{

    border-radius:18px;
}

/* RESPONSIVE */

@media(max-width:768px){

.page-title{

    font-size:2rem;
}

.container-box{

    padding:25px;
}

}

</style>
</head>

<body>

<div class="container">

<div class="container-box">

<!-- TITLE -->

<h1 class="page-title">

<i class="fas fa-trash-alt me-2"></i>

Delete Fee Payment

</h1>

<p class="sub-text">

Search Student ID and directly delete payment securely

</p>

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

<!-- SEARCH FORM -->

<div class="search-box">

<form method="post" action="deleteFeePayment">

<input type="hidden" name="action" value="search">

<div class="row g-3">

<div class="col-md-9">

<label class="form-label fw-bold">

<i class="fas fa-id-badge me-2"></i>

Enter Student ID

</label>

<input type="number"
name="studentId"
class="form-control"
placeholder="Enter Student ID"
required>

</div>

<div class="col-md-3 d-flex align-items-end">

<button type="submit"
class="search-btn w-100">

<i class="fas fa-search me-2"></i>

Search

</button>

</div>

</div>

</form>

</div>

<!-- PAYMENT DETAILS -->

<%

if(request.getAttribute("payments") != null){

List<FeePayment> payments =
(List<FeePayment>)
request.getAttribute("payments");

%>

<%

for(FeePayment payment : payments){

%>

<div class="payment-card">

<div class="row">

<!-- LEFT -->

<div class="col-md-8">

<div class="row">

<div class="col-md-6">

<div class="detail-box">

<div class="detail-title">

Payment ID

</div>

<div class="detail-value">

<%= payment.getPaymentId() %>

</div>

</div>

</div>

<div class="col-md-6">

<div class="detail-box">

<div class="detail-title">

Student ID

</div>

<div class="detail-value">

<%= payment.getStudentId() %>

</div>

</div>

</div>

<div class="col-md-6">

<div class="detail-box">

<div class="detail-title">

Student Name

</div>

<div class="detail-value">

<%= payment.getStudentName() %>

</div>

</div>

</div>

<div class="col-md-6">

<div class="detail-box">

<div class="detail-title">

Payment Date

</div>

<div class="detail-value">

<%= payment.getPaymentDate() %>

</div>

</div>

</div>

<div class="col-md-6">

<div class="detail-box">

<div class="detail-title">

Amount

</div>

<div class="detail-value">

Rs <%= String.format("%,.2f", payment.getAmount()) %>

</div>

</div>

</div>

<div class="col-md-6">

<div class="detail-box">

<div class="detail-title">

Status

</div>

<div class="detail-value">

<span class="status-badge 
<%= payment.getStatus().equals("Paid")
? "bg-success text-white"
: "bg-danger text-white" %>">

<%= payment.getStatus() %>

</span>

</div>

</div>

</div>

</div>

</div>

<!-- RIGHT -->

<div class="col-md-4 d-flex align-items-center">

<form method="post"
action="deleteFeePayment"
class="w-100"
onsubmit="return confirmDelete();">

<input type="hidden"
name="action"
value="delete">

<input type="hidden"
name="paymentId"
value="<%= payment.getPaymentId() %>">

<button type="submit"
class="delete-btn">

<i class="fas fa-trash-alt me-2"></i>

Delete Record

</button>

</form>

</div>

</div>

</div>

<%

}

}

%>

<!-- BACK -->

<div class="text-center mt-4">

<a href="index.jsp"
class="btn btn-secondary back-btn">

<i class="fas fa-home me-2"></i>

Back To Home

</a>

</div>

</div>

</div>

<!-- SCRIPT -->

<script>

function confirmDelete(){

    return confirm(
    "Are you sure you want to permanently delete this payment record?"
    );

}

</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>