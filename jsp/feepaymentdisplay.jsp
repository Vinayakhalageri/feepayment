<%@ page import="java.util.*, com.model.FeePayment" %>

<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">

<title>View All Payments</title>

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

    padding:40px 15px;

    font-family:'Segoe UI',sans-serif;
}

/* MAIN CONTAINER */

.table-container{

    background:rgba(255,255,255,0.97);

    border-radius:30px;

    padding:35px;

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

    font-size:2.7rem;

    font-weight:800;

    color:#4f46e5;

    margin-bottom:10px;
}

.page-subtitle{

    text-align:center;

    color:#6b7280;

    margin-bottom:30px;

    font-size:16px;
}

/* SUMMARY */

.summary-box{

    background:
    linear-gradient(
    135deg,
    #eef2ff,
    #dbeafe);

    padding:22px;

    border-radius:20px;

    margin-bottom:30px;

    text-align:center;

    box-shadow:
    0 5px 15px rgba(0,0,0,0.08);
}

.summary-number{

    font-size:35px;

    font-weight:800;

    color:#4f46e5;
}

/* TABLE */

.table{

    border-radius:20px;

    overflow:hidden;
}

.table thead{

    background:
    linear-gradient(
    135deg,
    #4f46e5,
    #7c3aed);

    color:white;
}

.table thead th{

    padding:16px;

    text-align:center;

    border:none;

    font-size:15px;
}

.table tbody tr{

    transition:0.3s;
}

.table tbody tr:hover{

    background:#eef2ff;

    transform:scale(1.01);
}

.table tbody td{

    padding:15px;

    text-align:center;

    vertical-align:middle;

    font-weight:500;
}

/* STATUS */

.status-paid{

    background:#16a34a;

    color:white;

    padding:8px 18px;

    border-radius:30px;

    font-size:13px;

    font-weight:700;
}

.status-overdue{

    background:#dc2626;

    color:white;

    padding:8px 18px;

    border-radius:30px;

    font-size:13px;

    font-weight:700;
}

/* BUTTONS */

.action-btn{

    padding:12px 22px;

    border-radius:15px;

    font-weight:700;

    border:none;

    transition:0.3s;
}

.action-btn:hover{

    transform:translateY(-2px);
}

.home-btn{

    background:#6b7280;

    color:white;
}

.add-btn{

    background:
    linear-gradient(
    135deg,
    #4f46e5,
    #7c3aed);

    color:white;
}

/* EMPTY */

.empty-box{

    padding:40px;

    text-align:center;

    color:#6b7280;
}

/* RESPONSIVE */

@media(max-width:768px){

.page-title{

    font-size:2rem;
}

.table-container{

    padding:20px;
}

.table thead th,
.table tbody td{

    padding:10px;

    font-size:13px;
}

}

</style>

</head>

<body>

<div class="container">

<div class="table-container">

<!-- PAGE TITLE -->

<h1 class="page-title">

<i class="fas fa-list-alt me-2"></i>

All Payment Records

</h1>

<p class="page-subtitle">

View complete student fee payment details

</p>

<!-- ERROR MESSAGE -->

<%

if(request.getAttribute("error") != null){

%>

<div class="alert alert-danger text-center">

<%= request.getAttribute("error") %>

</div>

<%

}

%>

<!-- GET PAYMENTS -->

<%

List<FeePayment> payments =
(List<FeePayment>) request.getAttribute("payments");

/* SORT PAYMENT IDS IN ASCENDING ORDER */

if(payments != null){

Collections.sort(
payments,
new Comparator<FeePayment>(){

    public int compare(FeePayment p1,
                       FeePayment p2){

        return Integer.compare(
            p1.getPaymentId(),
            p2.getPaymentId()
        );
    }

});

}

%>

<!-- SUMMARY -->

<div class="summary-box">

<div class="summary-number">

<%= payments != null ? payments.size() : 0 %>

</div>

<div>

Total Payment Records

</div>

</div>

<!-- TABLE -->

<div class="table-responsive">

<table class="table table-hover align-middle">

<thead>

<tr>

<th>Payment ID</th>

<th>Student ID</th>

<th>Student Name</th>

<th>Payment Date</th>

<th>Amount (Rs)</th>

<th>Status</th>

</tr>

</thead>

<tbody>

<%

if(payments != null && !payments.isEmpty()){

for(FeePayment p : payments){

%>

<tr>

<td>

<strong>

<%= p.getPaymentId() %>

</strong>

</td>

<td>

<%= p.getStudentId() %>

</td>

<td>

<%= p.getStudentName() != null
? p.getStudentName()
: "" %>

</td>

<td>

<%= p.getPaymentDate() != null
? p.getPaymentDate()
: "" %>

</td>

<td>

<strong>

Rs <%= String.format("%,.2f", p.getAmount()) %>

</strong>

</td>

<td>

<span class="<%= "Paid".equals(p.getStatus())
? "status-paid"
: "status-overdue" %>">

<%= p.getStatus() != null
? p.getStatus()
: "" %>

</span>

</td>

</tr>

<%

}

}else{

%>

<tr>

<td colspan="6">

<div class="empty-box">

<i class="fas fa-inbox fa-3x mb-3"></i>

<h5>

No Payment Records Found

</h5>

<p>

Add new payments to display records here

</p>

</div>

</td>

</tr>

<%

}

%>

</tbody>

</table>

</div>

<!-- BUTTONS -->

<div class="text-center mt-4">

<a href="index.jsp"
class="btn action-btn home-btn me-2">

<i class="fas fa-home me-2"></i>

Back To Home

</a>

<a href="addFeePayment"
class="btn action-btn add-btn">

<i class="fas fa-plus me-2"></i>

Add New Payment

</a>

</div>

</div>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>